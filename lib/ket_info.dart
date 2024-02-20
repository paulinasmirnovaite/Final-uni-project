import 'package:flutter/material.dart';
import 'main.dart';
const Color sageColor = Color(0xFF8FBF8F);

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kognityvinė elgesio terapija'),
        backgroundColor: sageColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildBookButton(context, 'Kognityvinė elgesio terapija', screen1()),
            const SizedBox(height: 10),
            buildBookButton(context, 'Kognityviniai iškraipymai', screen2()),
            const SizedBox(height: 10),
            buildBookButton(context, 'Automatinės mintys', screen3()),
          ],
        ),
      ),
    );
  }

  Widget buildBookButton(BuildContext context, String text, Widget screen) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.grey[700], fontSize: 18),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[700], size: 18),
        ],
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(16),
      ),
    );
  }


  Widget screen1() {

  List<Map<String, dynamic>> section1 = [
    {
      'title': 'Istorija',
      'title2': '1960 -1970 m. prasidėjo kognityvinė revoliucija. Kognityvinės terapijos pionieriais laikomi Aaron Beck ir Albert Ellis.',
      'content': 'Kognityvinė elgesio terapija, KET - viena iš psichoterapijos rūšių, aiškinanti, kaip žmogaus mintys, emocijos ir elgesys yra susiję ir kokią įtaką žmogaus sprendimams daro jo kertiniai įsitikinimai. Kognityvinė elgesio terapija jungia dvi psichoterapijos rūšis, kurias derinant galima sumažinti ir pašalinti psichologinio diskomforto problemas, palengvinti gyvenimą. Šios dvi terapijos rūšys - elgesio terapija, kurios pagalba yra silpninami ryšiai tarp stresą keliančios situacijos ir tokių žmogaus reakcijų kaip baimė, savidestrukcinis elgesys bei stiprinami savireguliacijos įgūdžiai, konstruktyvus mąstymas, ir kognityvinė terapija, kuri tiria žmogaus suvokimo ir pažinimo procesus. ',
      'isExpanded': false,
    },
    {
      'title': 'Taikymas',
      'title2': 'KET pagalba gali būti gydomi įvairūs sutrikimai: depresija, nerimas, baimė, įvairios fobijos, potrauminio streso sutrikimas ir kt.',
      'content': ' Ši terapija veiksminga ne tik gydant sutrikimus, bet ir stengiantis pašalinti įvairias psichologines problemas: nepasitikėjimą savimi, drovumą, bendravimo sunkumus. Jos efektyvumas įrodytas klinikiniais tyrimais daugumos psichikos ir elgesio sutrikimų gydymui. Naujausi moksliniai tyrimai rodo, kad, pavyzdžiui, gydant depresiją antidepresantais ir kartu taikant kognityvinę elgesio terapiją, gydymo rezultatai yra veiksmingesni, o atkryčio rizika būna daug mažesnė nei gydant vien vaistais.',
      'isExpanded': false,
    },
    {
      'title': 'Kognityvinis modelis',
      'title2': 'Kognityviniu psichologijos modeliu siekiama nustatyti, kaip individo mintys ir įsitikinimai daro įtaką jo jausmams ir elgesiui. ',
      'content': 'Pagal kognityvinį modelį racionalūs įsitikinimai lemia gerai sureguliuotą psichikos sveikatą, o neracionalios mintys ir įsitikinimai - psichikos sveikatos problemas.',
      'isExpanded': false,
    },
    {
      'title': 'Tikslai',
      'title2': 'Pagrindinis KET tikslas yra padėti žmogui įgyti naudingų žinių ir įgūdžių, kurie leistų geriau pažinti save, išmokti keisti savo mintis ir emocijas.',
      'content': 'KET dėmesio centre yra ryšys tarp įsitikinimų (to, kas galvojama), emocijų (to, kas jaučiama), elgesio (to, kas daroma). KET tikslai apima elgesio įgūdžių formavimą, geresnį savęs pažinimą, savikontrolės gerinimą, kenksmingų minčių ir įsitikinimų atpažinimą.',
      'isExpanded': false,
    },
    {
      'title': 'Elementai',
      'title2': 'Pagrindiniai terapijos elementai yra psichologinė edukacija, kognicijų stebėjimas, kognityvinių iškraipymų ir deficitų atpažinimas. ',
      'content': 'Ne mažiau svarbūs terapijos elementai yra minčių vertinimas ir alternatyvaus mąstymo vystymas, kognityvinių įgūdžių ugdymas (dėmesio atitraukimas, pasekmių numatymas, problemų sprendimas), emocijų pažinimas, stebėjimas, valdymas, ekspozicija, elgesio eksperimentai ir kt.',
      'isExpanded': false,
    },
  ];

  return Scaffold(
    appBar: AppBar(
      title: Text(''),
      backgroundColor: sageColor,
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kognityvinė elgesio terapija',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Kognityvinė elgesio terapija remiasi trimis prielaidomis: mąstymas veikia elgesį, mąstymo turinys ir procesai gali būti stebimi ir keičiami, emocijų ir elgesio pokyčiai gali būti pasiekiami per mąstymo pokyčius.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ...section1.map((section) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section['title'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ExpansionTile(
                    title: Text(
                      section['title2'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          section['content'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
          ],
        ),
      ),
    ),
  );
  }

  Widget screen2() {
    List<Map<String, String>> sections = [
      {
        'title': 'Dichotominis mąstymas (viskas arba nieko)',
        'content': 'Asmeninės savybės ir situacija vertinama tiktai „juoda arba balta“ kategorijomis, be tarpinių atspalvių. Pavyzdžiui, jeigu ką nors atliekate netobulai, jaučiatės esantis nevykėliu.',
      },
      {
        'title': 'Proto filtras',
        'content': 'Susitelkiama į vieną neigiamą smulkmeną ir ignoruojamas bendras vaizdas.',
      },
      {
        'title': 'Perdėtas apibendrinimas',
        'content': 'Manoma, kad jeigu nemalonus įvykis nutiko vieną kartą, tai jis pasikartos daugybę kartų ateityje. Iš vienos situacijos daromos neigiamos išvados apie visą asmenybę.',
      },
      {
        'title': 'Teigiamų dalykų nuvertinimas',
        'content': 'Teigiami išgyvenimai, geri darbai ar savybės atmetamos tvirtinant, kad jos „nieko nereiškia“ ar dėl kokių nors priežasčių „nesiskaito“.',
      },
      {
        'title': 'Skubotas išvadų darymas',
        'content': 'Neigiama išvada padaroma nesant akivaizdžių ją pagrindžiančių faktų. Pavyzdžiui, minčių skaitymas - manote, kad apie Jus kažkas galvoja neigiamai, neatsižvelgdami į labiau tikėtinas galimybes. Ateities numatymas - ateitis matoma kaip neigiama, laukiama nelaimės ir nesvarstomi labiau tikėtini variantai.',
      },
      {
        'title': 'Sureikšminimas ir sumenkinimas',
        'content': 'Pervertinama arba nepelnytai nureikšminama dalykų svarba, nepagrįstai padidinami neigiami dalykai ir sumažinami teigiami.',
      },
      {
        'title': 'Etikečių klijavimas bei klaidingas įvardinimas',
        'content': 'Sau ar kitam žmogui „priklijuojama“ apibendrinanti etiketė, neatsižvelgiant į kitus faktus, įvykių apibūdinimas sunkiais ir emocinį krūvį turinčiais žodžiais.',
      },
      {
        'title': 'Emocinis mąstymas',
        'content': 'Manoma, kad neigiamos emocijos atspindi realybę - tam tikros mintys laikomos tiesa vien dėl to, kad taip jaučiama, ignoruojami tam prieštaraujantys faktai.',
      },
      {
        'title': 'Turėjimas bei privalėjimas',
        'content': 'Žodžiai „turiu“, „privalau“ ir „reikia“ vartojami vertinant, kad kitaip pasielgus bus blogai. Jie taikomi tiek sau, tiek kitiems žmonėms.',
      },
      {
        'title': 'Suasmeninimas',
        'content': 'Manote, kad už neigiamą įvykį turite prisiimti atsakomybę, nors tiesiogiai nesate su juo susijęs. Galvojate, kad kitų žmonių neigiamas elgesys susijęs su jumis ir neapsvarstote kitų galimybių.',
      },
      {
        'title': '„Tunelinis“ matymas',
        'content': 'Matomi tik neigiami situacijos aspektai.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: sageColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kognityviniai iškraipymai',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Kognityvinė elgesio terapija remiasi trimis prielaidomis: mąstymas veikia elgesį, mąstymo turinys ir procesai gali būti stebimi ir keičiami, emocijų ir elgesio pokyčiai gali būti pasiekiami per mąstymo pokyčius.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              const SizedBox(height: 16),
              ...sections.map((section) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section['title'],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      section['content'],
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget screen3() {

    List<Map<String, String>> sections3 = [
      {
        'title': 'Kokie įrodymai gali patvirtinti šią mintį?',
      'content': '',
      },
      {
        'title': 'Kokie įrodymai gali paneigti šią mintį?',
        'content': '',
      },
      {
        'title': 'Ar yra alternatyvus paaiškinimas?',
        'content': '',
      },
      {
        'title': 'Kas blogiausio galėtų nutikti? Kaip galėčiau tai išgyventi?',
        'content': '',
      },
      {
        'title': 'Kas geriausio galėtų nutikti?',
        'content': '',
      },
      {
        'title': 'Kokia šios situacijos baigtis yra labiausiai tikėtina ir realistiškiausia?',
        'content': '',
      },
      {
        'title': 'Kokios yra mano tikėjimo šia automatine mintimi pasekmės?',
        'content': '',
      },
      {
        'title': 'Kas būtų, jeigu pakeisčiau savo mąstymą?',
        'content': '',
      },
      {
        'title': 'Ką pasakyčiau artimam žmogui, esančiam šioje situacijoje ir susidūrusiam su tokia mintimi?',
        'content': '',
      },
      {
        'title': 'Ką turėčiau daryti?',
        'content': '',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: sageColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Automatinės mintys',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Automatinės mintys - tai savaime įvairiose situacijose kylančios mintys, kurių kartais galime nė nepastebėti. Naudokitės šiais klausimais pildant minčių žurnalo skiltį "Adaptyvus atsakas". Šie klausimai padės jums suformuluoti alternatyvų (adaptyvų) atsaką.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              const SizedBox(height: 16),
              ...sections3.map((section) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section['title'],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      section['content'],
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

}
