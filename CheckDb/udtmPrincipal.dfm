object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 229
  Width = 328
  object UniConnection: TUniConnection
    ProviderName = 'sql Server'
    Database = 'master'
    Username = 'sa'
    Server = '.\GSOFT'
    Connected = True
    LoginPrompt = False
    Left = 104
    Top = 56
    EncryptedPassword = 
      'BFFFB8FF8CFF9DFF8DFF9EFF8CFF96FF93FFCEFFCDFFCFFFCEFFCFFFCAFFC6FF' +
      'CFFF'
  end
  object SQLServerUniProvider: TSQLServerUniProvider
    Left = 56
    Top = 104
  end
  object qryCreateDataBase: TUniQuery
    Connection = UniConnection
    Left = 160
    Top = 152
  end
  object qryVersion: TUniQuery
    Connection = UniConnection
    SQL.Strings = (
      'SELECT @@version')
    Left = 128
    Top = 96
  end
  object UniSQLMonitor: TUniSQLMonitor
    Left = 216
    Top = 24
  end
  object qrySQL: TUniQuery
    Connection = UniConnection
    Left = 208
    Top = 96
  end
  object qryScript: TUniScript
    SQL.Strings = (
      'select @@version'
      'GO')
    Delimiter = '@@@@--'
    Connection = UniConnection
    Left = 56
    Top = 160
  end
  object qryScript3: TUniSQL
    Connection = UniConnection
    Left = 240
    Top = 152
  end
end
