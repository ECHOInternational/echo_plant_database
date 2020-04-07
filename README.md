ECHO<sup>®</sup> Open Plant Database
========================

The ECHO Open Plant Database is an open-source, open-access database and API for interacting with plant/crop data collected by ECHO and its network members.

Access:
-------
This database is maintained by ECHO and contains both public and private records. Read access to public information is available to all. Records marked as private are available only to the record owner and governing organizations.

**HELP WANTED:** A license for this project need to be chosen and intellectual property policies and declarations need to be written. If you have expertise in these areas please contact ICT@echonet.org.


Some tools based on this database and API include:
--------------------------------------------------
- The ECHO Green Manure and Cover Crop Selection Tool
- ECHO Plant Information Sheets
- ECHO germplasm catalogs and ordering systems
- Plant sign generators


Project Status:
---------------
We are currently in the process of relocating the database and API to this standalone tool. This open-source project is the foundation for the second iteration of the database and encompasses these requirements:

**Full Localization**
- All text fields shall be translatable
- All data fields shall be populated in SI Units
- Each request shall specify the desired locale
- Responses indicate available locales when requested

**Record Ownership**
- All records shall have ownership
- All records shall have version tracking
- All records shall use UUIDs for unique identifiers

### API

**Standardized Access**
- Read/Write: JSON:api
- Read Only: GraphQL

**Versioned**
- All changes to records shall have trackable histories

### How-To

#### Upload a file
The example given here is for an image, other kinds of uploaded material are planned but not yet implemented.

1) Retrieve the credentials necessary to upload

    `GET /v1/images/upload`

    **Response:** 

    ```JSON
    {
        "data": {
            "id": "dbe8c9b4-e899-4ff0-8ef9-a1fa8d02522d",
            "type": "uploads",
            "links": {
                "post_url": "http://localhost:3000/v1/images"
            },
            "attributes": {
                "form_data": {
                    "action": "https://s3.amazonaws.com/images-us-east-1.echocommunity.org",
                    "method": "post",
                    "enctype": "multipart/form-data",
                    "fields": {
                        "hidden": {
                            "key": "dbe8c9b4-e899-4ff0-8ef9-a1fa8d02522d/${filename}",
                            "success_action_status": "201",
                            "policy": "eyJleHBpcmF0aW9uIjoi ... NDQxWiJ9XX0=",
                            "x-amz-credential": "AKIAVSHBJIBUTNRG3HEO/20191011/us-east-1/s3/aws4_request",
                            "x-amz-algorithm": "AWS4-HMAC-SHA256",
                            "x-amz-date": "20191011T131441Z",
                            "x-amz-signature": "207ee8ec75cf13c112bec72b87fbc51aa90722f2d4fd08d73b7d8ec07b7bb9ab"
                        },
                        "file": {
                            "file": null
                        }
                    }
                },
                "expiration": "2019-10-11T14:14:41.588Z"
            }
        }
    }
    ```

    You will need the `id` value amd the `post_url` link when creating the image resource in step 4.

2) Upload image

    Build a form (or simulate one) that uses the indicated method, encoding type, and action returned in the `form_data` attribute.

    This form submission should include ALL of the fields indicated by the fields attribute. Fields are grouped by type, field names are the keys.

3) Process response from s3
    
    Upon a successful upload you will get a 201 response from the server with an XML document.

    ```XML
    <?xml version="1.0" encoding="UTF-8"?>
    <PostResponse>
        <Location>https://s3.amazonaws.com/link-to-the-file</Location>
        <Bucket>s3-bucket</Bucket>
        <Key>dbe8c9b4-e899-4ff0-8ef9-a1fa8d02522d/image.jpg</Key>
        <ETag>"32-bit-tag"</ETag>
    </PostResponse>
    ```

    You will need the `Bucket` and `Key` values when creating the image resource in the next step.

4) Create the containing resource

    Create a resource using the `post_url` supplied in step 1. In this case it is /v1/images but for other kinds of uploads this URL will indicate where new resources should be created.

    `POST /v1/images`

    **Post-Body:**
    
    ```JSON
    {
        "data": {
            "id": "dbe8c9b4-e899-4ff0-8ef9-a1fa8d02522d",
            "type": "images",
            "attributes": {
                "name": "An Image Name (Required)",
                "description": "The Description (Optional)",
                "attribution": "Non translated owner of work (Optional)",
                "s3_bucket": "Bucket value returned in step 3 (Required)",
                "s3_key": "Key value returned in step 3 (Required)"
            },
            "relationships": {
                "imageable": {
                    "data": { "type": "categories", "id": "PUT THE ID HERE"}
                }
            }
        }
    }
    ```
    
    Note that the `id` here is supplied (it is required) and matches the one from the original upload request.

    In order to relate the image to a specific resource at the time of creation specify it as an `imageable` relationship. We're relating it to a category in the example.

    You do not have to create the relationship immediately, it can be created later, if for instance an image is being uploaded for a resource that has not yet been persited to the database.

    **Example:**
    `POST /v1/categories/1c5e5f4d-4d38-4406-a84d-3819cccaf215/relationships/images`
    
    ```JSON
    
    {
        "data": [
            {"type": "images", "id": "12179f17-96c6-4dd8-b1da-de236d11a69b"}
        ]
    }
    ```

    **IMPORTANT NOTE**
    Orphaned uploads may be swept from the database if they are not related to a resources in a timely manner.