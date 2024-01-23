#!/usr/bin/env python3
"""
9-insert_school module
"""


def insert_school(mongo_collection, **kwargs):
    """Inserts new document into collection based on kwargs."""
    new_school = kwargs
    result = mongo_collection.insert_one(new_school)
    return result.inserted_id
