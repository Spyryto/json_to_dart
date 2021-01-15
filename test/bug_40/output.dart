class BugForty {
  int sessionExpire;
  int stayLoggedInTime;
  int stayLoggedInDeviceType;
  bool canShareAsNews;
  int newsFeedSummaryLength;
  List<int> applicationLanguageAccess;
  String gAAccount;
  int fileUploadLimit;
  FileTypeExtensions fileTypeExtensions;
  CurrentVersion currentVersion;
  int numberOfDaysTillNextUpgrade;
  String userIPAddress;
  List<String> senders;
  String currentCulture;
  int userApplicationLanguageType;
  bool showStayLoggedIn;
  bool isRequestAccessAvailable;
  String supportPhoneNumber;
  String supportEmailAddress;
  int customerId;
  String customerName;
  String mobileAppName;
  int defaultApplicationLanguageType;
  Null adConfigs;
  List<String> customButtons;
  CustomerSettings customerSettings;
  Null upcomingVersion;
  bool checklistPresenceEnabled;
  String storageDomain;
  List<ApplicationSettingAccessTypes> applicationSettingAccessTypes;
  List<ContentLanguages> contentLanguages;

  BugForty(
      {this.sessionExpire,
      this.stayLoggedInTime,
      this.stayLoggedInDeviceType,
      this.canShareAsNews,
      this.newsFeedSummaryLength,
      this.applicationLanguageAccess,
      this.gAAccount,
      this.fileUploadLimit,
      this.fileTypeExtensions,
      this.currentVersion,
      this.numberOfDaysTillNextUpgrade,
      this.userIPAddress,
      this.senders,
      this.currentCulture,
      this.userApplicationLanguageType,
      this.showStayLoggedIn,
      this.isRequestAccessAvailable,
      this.supportPhoneNumber,
      this.supportEmailAddress,
      this.customerId,
      this.customerName,
      this.mobileAppName,
      this.defaultApplicationLanguageType,
      this.adConfigs,
      this.customButtons,
      this.customerSettings,
      this.upcomingVersion,
      this.checklistPresenceEnabled,
      this.storageDomain,
      this.applicationSettingAccessTypes,
      this.contentLanguages});

  BugForty.fromJson(Map<String, dynamic> json) {
    sessionExpire = json['SessionExpire'];
    stayLoggedInTime = json['StayLoggedInTime'];
    stayLoggedInDeviceType = json['StayLoggedInDeviceType'];
    canShareAsNews = json['CanShareAsNews'];
    newsFeedSummaryLength = json['NewsFeedSummaryLength'];
    applicationLanguageAccess = json['ApplicationLanguageAccess'].cast<int>();
    gAAccount = json['GAAccount'];
    fileUploadLimit = json['FileUploadLimit'];
    fileTypeExtensions = json['FileTypeExtensions'] != null
        ? FileTypeExtensions.fromJson(json['FileTypeExtensions'])
        : null;
    currentVersion = json['CurrentVersion'] != null
        ? CurrentVersion.fromJson(json['CurrentVersion'])
        : null;
    numberOfDaysTillNextUpgrade = json['NumberOfDaysTillNextUpgrade'];
    userIPAddress = json['UserIPAddress'];
    senders = json['Senders'].cast<String>();
    currentCulture = json['CurrentCulture'];
    userApplicationLanguageType = json['UserApplicationLanguageType'];
    showStayLoggedIn = json['ShowStayLoggedIn'];
    isRequestAccessAvailable = json['IsRequestAccessAvailable'];
    supportPhoneNumber = json['SupportPhoneNumber'];
    supportEmailAddress = json['SupportEmailAddress'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    mobileAppName = json['MobileAppName'];
    defaultApplicationLanguageType = json['DefaultApplicationLanguageType'];
    adConfigs = json['AdConfigs'];
    customButtons = json['CustomButtons'].cast<String>();
    customerSettings = json['CustomerSettings'] != null
        ? CustomerSettings.fromJson(json['CustomerSettings'])
        : null;
    upcomingVersion = json['UpcomingVersion'];
    checklistPresenceEnabled = json['ChecklistPresenceEnabled'];
    storageDomain = json['StorageDomain'];
    if (json['ApplicationSettingAccessTypes'] != null) {
      applicationSettingAccessTypes = <ApplicationSettingAccessTypes>[];
      json['ApplicationSettingAccessTypes'].forEach((v) {
        applicationSettingAccessTypes
            .add(ApplicationSettingAccessTypes.fromJson(v));
      });
    }
    if (json['ContentLanguages'] != null) {
      contentLanguages = <ContentLanguages>[];
      json['ContentLanguages'].forEach((v) {
        contentLanguages.add(ContentLanguages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['SessionExpire'] = sessionExpire;
    data['StayLoggedInTime'] = stayLoggedInTime;
    data['StayLoggedInDeviceType'] = stayLoggedInDeviceType;
    data['CanShareAsNews'] = canShareAsNews;
    data['NewsFeedSummaryLength'] = newsFeedSummaryLength;
    data['ApplicationLanguageAccess'] = applicationLanguageAccess;
    data['GAAccount'] = gAAccount;
    data['FileUploadLimit'] = fileUploadLimit;
    if (fileTypeExtensions != null) {
      data['FileTypeExtensions'] = fileTypeExtensions.toJson();
    }
    if (currentVersion != null) {
      data['CurrentVersion'] = currentVersion.toJson();
    }
    data['NumberOfDaysTillNextUpgrade'] = numberOfDaysTillNextUpgrade;
    data['UserIPAddress'] = userIPAddress;
    data['Senders'] = senders;
    data['CurrentCulture'] = currentCulture;
    data['UserApplicationLanguageType'] = userApplicationLanguageType;
    data['ShowStayLoggedIn'] = showStayLoggedIn;
    data['IsRequestAccessAvailable'] = isRequestAccessAvailable;
    data['SupportPhoneNumber'] = supportPhoneNumber;
    data['SupportEmailAddress'] = supportEmailAddress;
    data['CustomerId'] = customerId;
    data['CustomerName'] = customerName;
    data['MobileAppName'] = mobileAppName;
    data['DefaultApplicationLanguageType'] = defaultApplicationLanguageType;
    data['AdConfigs'] = adConfigs;
    data['CustomButtons'] = customButtons;
    if (customerSettings != null) {
      data['CustomerSettings'] = customerSettings.toJson();
    }
    data['UpcomingVersion'] = upcomingVersion;
    data['ChecklistPresenceEnabled'] = checklistPresenceEnabled;
    data['StorageDomain'] = storageDomain;
    if (applicationSettingAccessTypes != null) {
      data['ApplicationSettingAccessTypes'] =
          applicationSettingAccessTypes.map((v) => v.toJson()).toList();
    }
    if (contentLanguages != null) {
      data['ContentLanguages'] =
          contentLanguages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FileTypeExtensions {
  int xPM;
  int jP2;
  int hTML;

  FileTypeExtensions({this.xPM, this.jP2, this.hTML});

  FileTypeExtensions.fromJson(Map<String, dynamic> json) {
    xPM = json['.XPM'];
    jP2 = json['.JP2'];
    hTML = json['.HTML'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['.XPM'] = xPM;
    data['.JP2'] = jP2;
    data['.HTML'] = hTML;
    return data;
  }
}

class CurrentVersion {
  int id;
  int versionMajor;
  int versionMinor;
  String upgradeOn;
  String upgradeEndTime;
  int upgradeVersionType;
  Null internalDescription;
  String customerInformation;
  String versionNumberText;
  int upgradeStatusType;
  int secondsUntilUpgradeStart;
  int createdByUserId;
  String createdOn;
  int changedByUserId;
  String changedOn;
  String createdByUserName;
  String changedByUserName;

  CurrentVersion(
      {this.id,
      this.versionMajor,
      this.versionMinor,
      this.upgradeOn,
      this.upgradeEndTime,
      this.upgradeVersionType,
      this.internalDescription,
      this.customerInformation,
      this.versionNumberText,
      this.upgradeStatusType,
      this.secondsUntilUpgradeStart,
      this.createdByUserId,
      this.createdOn,
      this.changedByUserId,
      this.changedOn,
      this.createdByUserName,
      this.changedByUserName});

  CurrentVersion.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    versionMajor = json['VersionMajor'];
    versionMinor = json['VersionMinor'];
    upgradeOn = json['UpgradeOn'];
    upgradeEndTime = json['UpgradeEndTime'];
    upgradeVersionType = json['UpgradeVersionType'];
    internalDescription = json['InternalDescription'];
    customerInformation = json['CustomerInformation'];
    versionNumberText = json['VersionNumberText'];
    upgradeStatusType = json['UpgradeStatusType'];
    secondsUntilUpgradeStart = json['SecondsUntilUpgradeStart'];
    createdByUserId = json['CreatedByUserId'];
    createdOn = json['CreatedOn'];
    changedByUserId = json['ChangedByUserId'];
    changedOn = json['ChangedOn'];
    createdByUserName = json['CreatedByUserName'];
    changedByUserName = json['ChangedByUserName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = id;
    data['VersionMajor'] = versionMajor;
    data['VersionMinor'] = versionMinor;
    data['UpgradeOn'] = upgradeOn;
    data['UpgradeEndTime'] = upgradeEndTime;
    data['UpgradeVersionType'] = upgradeVersionType;
    data['InternalDescription'] = internalDescription;
    data['CustomerInformation'] = customerInformation;
    data['VersionNumberText'] = versionNumberText;
    data['UpgradeStatusType'] = upgradeStatusType;
    data['SecondsUntilUpgradeStart'] = secondsUntilUpgradeStart;
    data['CreatedByUserId'] = createdByUserId;
    data['CreatedOn'] = createdOn;
    data['ChangedByUserId'] = changedByUserId;
    data['ChangedOn'] = changedOn;
    data['CreatedByUserName'] = createdByUserName;
    data['ChangedByUserName'] = changedByUserName;
    return data;
  }
}

class CustomerSettings {
  int id;
  String brandingColor;
  LogoReference logoReference;
  LogoReference landscapeReference;
  LogoReference portraitReference;

  CustomerSettings(
      {this.id,
      this.brandingColor,
      this.logoReference,
      this.landscapeReference,
      this.portraitReference});

  CustomerSettings.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    brandingColor = json['BrandingColor'];
    logoReference = json['LogoReference'] != null
        ? LogoReference.fromJson(json['LogoReference'])
        : null;
    landscapeReference = json['LandscapeReference'] != null
        ? LogoReference.fromJson(json['LandscapeReference'])
        : null;
    portraitReference = json['PortraitReference'] != null
        ? LogoReference.fromJson(json['PortraitReference'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = id;
    data['BrandingColor'] = brandingColor;
    if (logoReference != null) {
      data['LogoReference'] = logoReference.toJson();
    }
    if (landscapeReference != null) {
      data['LandscapeReference'] = landscapeReference.toJson();
    }
    if (portraitReference != null) {
      data['PortraitReference'] = portraitReference.toJson();
    }
    return data;
  }
}

class LogoReference {
  int id;
  int objectId;
  int mediaBankFileId;
  int objectType;
  bool isDirectUpload;
  String physicalFileName;
  String extension;
  String name;
  int fileType;
  int width;
  int height;
  String createdOn;
  int createdByUserId;
  String createdByUserName;
  String createdByMediaBankPhysicalFileName;
  String contentType;
  int referenceType;

  LogoReference(
      {this.id,
      this.objectId,
      this.mediaBankFileId,
      this.objectType,
      this.isDirectUpload,
      this.physicalFileName,
      this.extension,
      this.name,
      this.fileType,
      this.width,
      this.height,
      this.createdOn,
      this.createdByUserId,
      this.createdByUserName,
      this.createdByMediaBankPhysicalFileName,
      this.contentType,
      this.referenceType});

  LogoReference.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    objectId = json['ObjectId'];
    mediaBankFileId = json['MediaBankFileId'];
    objectType = json['ObjectType'];
    isDirectUpload = json['IsDirectUpload'];
    physicalFileName = json['PhysicalFileName'];
    extension = json['Extension'];
    name = json['Name'];
    fileType = json['FileType'];
    width = json['Width'];
    height = json['Height'];
    createdOn = json['CreatedOn'];
    createdByUserId = json['CreatedByUserId'];
    createdByUserName = json['CreatedByUserName'];
    createdByMediaBankPhysicalFileName =
        json['CreatedByMediaBankPhysicalFileName'];
    contentType = json['ContentType'];
    referenceType = json['ReferenceType'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = id;
    data['ObjectId'] = objectId;
    data['MediaBankFileId'] = mediaBankFileId;
    data['ObjectType'] = objectType;
    data['IsDirectUpload'] = isDirectUpload;
    data['PhysicalFileName'] = physicalFileName;
    data['Extension'] = extension;
    data['Name'] = name;
    data['FileType'] = fileType;
    data['Width'] = width;
    data['Height'] = height;
    data['CreatedOn'] = createdOn;
    data['CreatedByUserId'] = createdByUserId;
    data['CreatedByUserName'] = createdByUserName;
    data['CreatedByMediaBankPhysicalFileName'] =
        createdByMediaBankPhysicalFileName;
    data['ContentType'] = contentType;
    data['ReferenceType'] = referenceType;
    return data;
  }
}

class ApplicationSettingAccessTypes {
  int applicationSettingType;
  List<int> accessRightTypes;

  ApplicationSettingAccessTypes(
      {this.applicationSettingType, this.accessRightTypes});

  ApplicationSettingAccessTypes.fromJson(Map<String, dynamic> json) {
    applicationSettingType = json['ApplicationSettingType'];
    accessRightTypes = json['AccessRightTypes'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ApplicationSettingType'] = applicationSettingType;
    data['AccessRightTypes'] = accessRightTypes;
    return data;
  }
}

class ContentLanguages {
  int id;
  bool isDefaultLanguage;

  ContentLanguages({this.id, this.isDefaultLanguage});

  ContentLanguages.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    isDefaultLanguage = json['IsDefaultLanguage'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = id;
    data['IsDefaultLanguage'] = isDefaultLanguage;
    return data;
  }
}
