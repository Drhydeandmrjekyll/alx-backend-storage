#!/usr/bin/env python3
"""
Module to interact with Redis
"""
import redis
import uuid
from typing import Union, Optional, Callable
from functools import wraps


class Cache:
    """
    Cache class for storing and retrieving data in Redis
    """
    def __init__(self):
        """
        Initialize the Cache instance with a Redis client
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    @staticmethod
    def count_calls(method: Callable) -> Callable:
        """
        Decorator to count the number of calls to a method and store in Redis

        Args:
            method: The method to be decorated

        Returns:
            Callable: The decorated method
        """
        @wraps(method)
        def wrapper(self, *args, **kwargs):
            key = method.__qualname__
            self._redis.incr(key)
            return method(self, *args, **kwargs)

        return wrapper

    @count_calls
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        Store the input data in Redis using a random key and return the key

        Args:
            data: The data to be stored (str, bytes, int, or float)

        Returns:
            str: The generated random key
        """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Optional[Callable] = None) -> Union[str, bytes, int, None]:
        """
        Retrieve data from Redis using the provided key and
        apply the optional conversion function

        Args:
            key: The key used to retrieve data from Redis
            fn: Optional conversion function to apply on the retrieved data

        Returns:
            Union[str, bytes, int, None]: The retrieved data
        """
        data = self._redis.get(key)
        if data is None:
            return None

        return fn(data) if fn else data

    def get_str(self, key: str) -> Union[str, None]:
        """
        Retrieve and convert data from Redis to string

        Args:
            key: The key used to retrieve data from Redis

        Returns:
            Union[str, None]: The retrieved data as string
        """
        return self.get(key, fn=lambda d: d.decode("utf-8"))

    def get_int(self, key: str) -> Union[int, None]:
        """
        Retrieve and convert data from Redis to integer

        Args:
            key: The key used to retrieve data from Redis

        Returns:
            Union[int, None]: The retrieved data as integer
        """
        return self.get(key, fn=int)


# Test cases
if __name__ == "__main__":
    cache = Cache()

    cache.store(b"first")
    print(cache.get(cache.store.__qualname__))

    cache.store(b"second")
    cache.store(b"third")
    print(cache.get(cache.store.__qualname__))
