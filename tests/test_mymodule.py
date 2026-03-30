"""Unit tests for mymodule."""

from mymodule import add


def test_add() -> None:
    assert add(2, 3) == 5


def test_add_negative_numbers() -> None:
    assert add(-1, -2) == -3
