VKDemo
======

##### Example app which is showing how a developer can use Spark.Framework with vk.com API.

---------
The app gets statuses for friends list and shows them. The app saves data from server into local database using Spark.Framework and the app can load data from local database.

The application displays a list of users that are don't have empty statuses

---------

- Open **'Vendor/code/Framework/Frontend/Spark.xcworkspace'** and build **'FrameworkBuildScript'** for **iOS Device** 
- Copy the **Spark.framework** folder from **'Vendor/code/Framework/Frontend/Spark/Products'** to **'VKDemo/VKDemo/Spark.framework'**

---------

If when you build the application, you have the error ".../VKDemo/Vendor/PreprocessorAttributeParser: Permission denied", run the following command in Terminal.app:

	chmod +x <app directory>/VKDemo/PreprocessorAttributeParser

where **&lt;app directory>** is directory where the file of project (**VKDemo.xcodeproj**) is located.

---------
brief note: project depends on gitmodules