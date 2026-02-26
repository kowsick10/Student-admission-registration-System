@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZSTUDENT_ADM'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_STUDENT_ADM
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_STUDENT_ADM
  association [1..1] to ZR_STUDENT_ADM as _BaseEntity on $projection.ADMISSIONID = _BaseEntity.ADMISSIONID
{
  key AdmissionID,
  FirstName,
  LastName,
  DateOfBirth,
  CourseID,
  Status,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
