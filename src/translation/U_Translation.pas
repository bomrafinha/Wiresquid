unit U_Translation;

interface

uses U_Portuguese;

type
  TTranslation<TLanguage> = class(TInterfacedObject)
  private
    class var
      fLanguage : TLanguage;

  public
    class property Language : TLanguage read fLanguage write fLanguage;

  end;

implementation


end.
