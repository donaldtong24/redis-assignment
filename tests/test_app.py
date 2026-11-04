from unittest.mock import patch

import redis
from fastapi.testclient import TestClient

import app as app_module

client = TestClient(app_module.app)


def test_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "FastAPI is working!!!"}


def test_health_ok():
    with patch.object(app_module.r, "ping", return_value=True):
        response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_health_redis_down():
    with patch.object(app_module.r, "ping", side_effect=redis.RedisError("boom")):
        response = client.get("/health")
    assert response.status_code == 503


def test_cache_round_trip():
    with patch.object(app_module.r, "set", return_value=True), \
         patch.object(app_module.r, "get", return_value=b"bar"):
        post_response = client.post("/cache", params={"key": "foo", "value": "bar"})
        get_response = client.get("/cache", params={"key": "foo"})

    assert post_response.status_code == 200
    assert get_response.status_code == 200
    assert get_response.json() == {"key": "foo", "value": "bar"}


def test_cache_missing_key():
    with patch.object(app_module.r, "get", return_value=None):
        response = client.get("/cache", params={"key": "nope"})
    assert response.status_code == 404
