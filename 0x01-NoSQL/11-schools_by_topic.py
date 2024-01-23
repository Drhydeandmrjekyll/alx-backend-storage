#!/usr/bin/env python3
"""
11-schools_by_topic module
"""


def schools_by_topic(mongo_collection, topic):
    """Returns list of schools having specific topic."""
    filter_query = {"topics": {"$in": [topic]}}
    schools = list(mongo_collection.find(filter_query))
    return schools
