from etl.pipeline import transform_data


def test_transform_data():

    sample_data = [
        {
            "id": 1,
            "name": "John Doe",
            "username": "john",
            "email": "john@gmail.com"
        }
    ]

    result = transform_data(sample_data)

    assert result.iloc[0]["name"] == "JOHN DOE"


def test_transform_columns():

    sample_data = [
        {
            "id": 1,
            "name": "John Doe",
            "username": "john",
            "email": "john@gmail.com"
        }
    ]

    result = transform_data(sample_data)

    expected_columns = ["id", "name", "username", "email"]

    assert list(result.columns) == expected_columns