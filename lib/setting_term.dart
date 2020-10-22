import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:flutter_app_kazee5/utils/value.dart';
import 'package:http/http.dart' as http;

class Term extends StatefulWidget {
  Term({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Term createState() => _Term();
}
class _Term extends State<Term>with AutomaticKeepAliveClientMixin<Term> {
  @override
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color black2 = Color(0xFFbcbcbc);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Text("Term and Condition",style:TextStyle(fontWeight:FontWeight.bold,fontSize: size.width/22)),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [
          ],
        ),
        body:SingleChildScrollView(
            child: Padding( padding: const EdgeInsets.all(20),child:new Text("Welcome to IAM.ID! Please read the following T&C carefully \n\nDokumen ini dimaksudkan untuk memberikan informasi dan pedoman umum. Beberapa ketentuan bisa disesuaikan kembali sesuai kesepakatan bersama Influencer, dan tergantung kampanye promosi yang sedang dijalani. Hal ini akan dianalisa berdasarkan kasus per kasus.\n\nAdapun beberapa ketentuan yang harus dipahami Influencer diantaranya sebagai berikut:\n\n1. Influencer berperan dalam mempromosikan / menawarkan / menjual produk Pengiklan melalui akun media sosial Instagram. Dengan kata lain, Pengiklan menunjuk Influencer sebagai wakilnya untuk mendukung dan mempromosikan layanannya kepada target audiens Influencer.\n\n2. Perjanjian ini akan memiliki jangka waktu satu tahun dan akan diperpanjang secara otomatis untuk jangka waktu satu tahun setelahnya, kecuali jika salah satu pihak memberikan pemberitahuan terlebih dahulu tentang niatnya untuk tidak memperpanjang.\n\n3. Influencer bersedia menampilkan profil Instagram mereka di platform IAM.ID maupun media sosial Instagram IAM.ID yaitu: @iamidofficial\n\n4. Mencantumkan Part of @iamidofficial di biodata Instagram influencer dan Akun Instagram di jadikan Bussines Account (Tidak di Private)\n\n5. Influencer diperkenankan menerima ajakan kolaborasi agensi lain maupun brand yang secara langsung menghubungi Influencer, selama Influencer tidak sedang melakukan kampanye yang merupakan kompetitor dari brand tersebut.\n\n6. Dengan pertimbangan penuh atas kinerja Influencer, rate yang dicantumkan pada form data diri dapat berubah, disesuaikan dengan analisis perhitungan Engagement Rate dari Tim IAM.ID\n\n7. Konten yang diposting oleh Influencer merupakan konten berdasarkan guideline yang disiapkan oleh Pengiklan.\n\n 8. Influencer setuju untuk tidak menyebutkan nama pesaing (brand competitor) sesuai yang diminta oleh Pengiklan di dalam konten yang digunakan untuk kampanye.\n\n9. Influencer memahami bahwa semua kegiatan kampanye yang dilakukan merupakan bagian dari perjanjian bersama dengan Pengiklan. Untuk itu, Influencer memikul semua tanggung jawab untuk memverifikasi bahwa materi kampanye yang digunakan telah memenuhi persetujuan Pengiklan.\n\n10.Selama masa kerjasama antara Influencer dan Pengiklan, Influencer mungkin akan menerima atau memiliki akses terhadap dokumen, catatan, maupun informasi yang bersifat rahasia yang merupakan milik dari Pengiklan. Untuk itu, Influencer mengakui dan menyetujui bahwa informasi tersebut adalah aset Pengiklan yang umumnya tidak diketahui oleh perdagangan, bersifat rahasia sehingga harus dijaga kerahasiaannya dan digunakan secara ketat.\n\n 11. Invoice akan di proses ketika Influencer sudah selesai melaksanakan kewajiban posting yang sudah disetujui dan mengirimkan bukti tayang post di Instagram.\n\n 12. Pembayaran dapat dilakukan dengan menggunakan Bank Transfer ke nomer rekening yang telah diberikan oleh Influencer. Pembayaran akan dilakukan dalam waktu paling lambat 30 hari setelah Influencer menyelesaikan tugasnya. Untuk beberapa kasus tertentu tempo pembayaran bisa disesuaikan, dengan catatan hal ini telah disepakati sebelumnya oleh Influencer dan Pengiklan.\n\n13. Jika salah satu pihak tidak dapat melakukan kewajibannya dengan alasan yang bisa dimaklumi dan di luar kendali seperti: kecelakaan, kebakaran, sakit keras, meninggal, maka pihak tersebut harus dibebaskan dari kewajiban tersebut.\n\n14. Berkelakuan baik dan tidak pernah dihukum penjara karena melakukan tindak pidana kejahatan dan/atau tidak sedang dalam menjalani proses hukum pidana. \n\n15. Kedua pihak sepakat untuk saling menjaga nama baik satu sama lain. Hal ini ditunjukkan dengan menyampaikan keluhan dan kritik secara personal dan bukan secara publik, jika salah satu pihak merasa dirugikan oleh pihak lain.\n\n16. Influencer yang tergabung di dalam group Whatsapp IAM.ID tidak diperkenankan promosi atau menyebarkan informasi yg diluar IAM.ID atau yang tidak ada kaitannya dengan IAM.ID di dalam group Whatsapp IAM.ID\n\n17. Perjanjian ini akan ditafsirkan dan ditegakkan sesuai dengan hukum dan keputusan yang berlaku di Negara.", overflow: TextOverflow.ellipsis,
                maxLines: 300,style:TextStyle(height: 1.5,fontSize:17,color: Colors.black45)),
            ))
    );
  }

}
