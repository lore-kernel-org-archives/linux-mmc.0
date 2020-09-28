Return-Path: <SRS0=Afy4=DF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5334CC2D0A8
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9C421D7F
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 13:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VD5J220J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgI1NMT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Sep 2020 09:12:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42437 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726442AbgI1NMI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 09:12:08 -0400
X-UUID: 4dc5b46fa54a469c9b2dbc40d5451ce9-20200928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ua3qzbbELhDUqHL6B2hkJ3+GoeysnJWSTXOlUV9J9SY=;
        b=VD5J220JdtKLL5f1yyu+I2+A7KTPP32G54xpreMnNxR5lmnWa0FxcE6gWmm/RIRRyzdgwuwKel2RtFReXZ8BGfrRrME1M2VCUqMtiiiov6ax48PgOMJAg+k+c4XuNcW/Qx/rMP8EbvcCgREbzX15Bk9OZMC4Gg7TvPOf+9pnA3I=;
X-UUID: 4dc5b46fa54a469c9b2dbc40d5451ce9-20200928
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 745945591; Mon, 28 Sep 2020 21:12:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Sep 2020 21:12:01 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Sep 2020 21:12:00 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH v2 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
Date:   Mon, 28 Sep 2020 21:09:18 +0800
Message-ID: <20200928130918.32326-5-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200928130918.32326-1-wenbin.mei@mediatek.com>
References: <20200928130918.32326-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

TVQ4MTkyIG1zZGMgaXMgYW4gaW5kZXBlbmRlbnQgc3ViIHN5c3RlbSwgd2UgbmVlZCBjb250cm9s
IG1vcmUgYnVzDQpjbG9ja3MgZm9yIGl0Lg0KQWRkIHN1cHBvcnQgZm9yIHRoZSBhZGRpdGlvbmFs
IHN1YnN5cyBjbG9ja3MgdG8gYWxsb3cgaXQgdG8gYmUNCmNvbmZpZ3VyZWQgYXBwcm9wcmlhdGVs
eS4NCg0KU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNzcgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyks
IDE4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2Qu
YyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCmluZGV4IGE3MDQ3NDVlNTg4Mi4uOWExNDIy
OTU1NTkzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KKysrIGIvZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYw0KQEAgLTQyNSw2ICs0MjUsOCBAQCBzdHJ1Y3QgbXNkY19o
b3N0IHsNCiAJc3RydWN0IGNsayAqaF9jbGs7ICAgICAgLyogbXNkYyBoX2NsayAqLw0KIAlzdHJ1
Y3QgY2xrICpidXNfY2xrOwkvKiBidXMgY2xvY2sgd2hpY2ggdXNlZCB0byBhY2Nlc3MgcmVnaXN0
ZXIgKi8NCiAJc3RydWN0IGNsayAqc3JjX2Nsa19jZzsgLyogbXNkYyBzb3VyY2UgY2xvY2sgY29u
dHJvbCBnYXRlICovDQorCXN0cnVjdCBjbGsgKnN5c19jbGtfY2c7CS8qIG1zZGMgc3Vic3lzIGNs
b2NrIGNvbnRyb2wgZ2F0ZSAqLw0KKwlzdHJ1Y3QgY2xrX2J1bGtfZGF0YSBidWxrX2Nsa3NbM107
CS8qIHBjbGssIGF4aSwgYWhiIGNsb2NrIGNvbnRyb2wgZ2F0ZSAqLw0KIAl1MzIgbWNsazsJCS8q
IG1tYyBzdWJzeXN0ZW0gY2xvY2sgZnJlcXVlbmN5ICovDQogCXUzMiBzcmNfY2xrX2ZyZXE7CS8q
IHNvdXJjZSBjbG9jayBmcmVxdWVuY3kgKi8NCiAJdW5zaWduZWQgY2hhciB0aW1pbmc7DQpAQCAt
Nzg0LDYgKzc4Niw4IEBAIHN0YXRpYyB2b2lkIG1zZGNfc2V0X2J1c3lfdGltZW91dChzdHJ1Y3Qg
bXNkY19ob3N0ICpob3N0LCB1NjQgbnMsIHU2NCBjbGtzKQ0KIA0KIHN0YXRpYyB2b2lkIG1zZGNf
Z2F0ZV9jbG9jayhzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0KIHsNCisJY2xrX2J1bGtfZGlzYWJs
ZV91bnByZXBhcmUoQVJSQVlfU0laRShob3N0LT5idWxrX2Nsa3MpLA0KKwkJCQkgICBob3N0LT5i
dWxrX2Nsa3MpOw0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoaG9zdC0+c3JjX2Nsa19jZyk7DQog
CWNsa19kaXNhYmxlX3VucHJlcGFyZShob3N0LT5zcmNfY2xrKTsNCiAJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKGhvc3QtPmJ1c19jbGspOw0KQEAgLTc5MiwxMCArNzk2LDE3IEBAIHN0YXRpYyB2b2lk
IG1zZGNfZ2F0ZV9jbG9jayhzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0KIA0KIHN0YXRpYyB2b2lk
IG1zZGNfdW5nYXRlX2Nsb2NrKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QpDQogew0KKwlpbnQgcmV0
Ow0KKw0KIAljbGtfcHJlcGFyZV9lbmFibGUoaG9zdC0+aF9jbGspOw0KIAljbGtfcHJlcGFyZV9l
bmFibGUoaG9zdC0+YnVzX2Nsayk7DQogCWNsa19wcmVwYXJlX2VuYWJsZShob3N0LT5zcmNfY2xr
KTsNCiAJY2xrX3ByZXBhcmVfZW5hYmxlKGhvc3QtPnNyY19jbGtfY2cpOw0KKwlyZXQgPSBjbGtf
YnVsa19wcmVwYXJlX2VuYWJsZShBUlJBWV9TSVpFKGhvc3QtPmJ1bGtfY2xrcyksDQorCQkJCSAg
ICAgIGhvc3QtPmJ1bGtfY2xrcyk7DQorCWlmIChyZXQpDQorCQlkZXZfZGJnKGhvc3QtPmRldiwg
ImVuYWJsZSBjbGtzIGZhaWxlZCFcbiIpOw0KKw0KIAl3aGlsZSAoIShyZWFkbChob3N0LT5iYXNl
ICsgTVNEQ19DRkcpICYgTVNEQ19DRkdfQ0tTVEIpKQ0KIAkJY3B1X3JlbGF4KCk7DQogfQ0KQEAg
LTIzNjYsNiArMjM3Nyw1MiBAQCBzdGF0aWMgdm9pZCBtc2RjX29mX3Byb3BlcnR5X3BhcnNlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCQlob3N0LT5jcWhjaSA9IGZhbHNlOw0KIH0N
CiANCitzdGF0aWMgaW50IG1zZGNfb2ZfY2xvY2tfcGFyc2Uoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldiwNCisJCQkgICAgICAgc3RydWN0IG1zZGNfaG9zdCAqaG9zdCkNCit7DQorCXN0cnVj
dCBjbGsgKmNsazsNCisNCisJaG9zdC0+c3JjX2NsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2
LCAic291cmNlIik7DQorCWlmIChJU19FUlIoaG9zdC0+c3JjX2NsaykpDQorCQlyZXR1cm4gUFRS
X0VSUihob3N0LT5zcmNfY2xrKTsNCisNCisJaG9zdC0+aF9jbGsgPSBkZXZtX2Nsa19nZXQoJnBk
ZXYtPmRldiwgImhjbGsiKTsNCisJaWYgKElTX0VSUihob3N0LT5oX2NsaykpDQorCQlyZXR1cm4g
UFRSX0VSUihob3N0LT5oX2Nsayk7DQorDQorCWhvc3QtPmJ1c19jbGsgPSBkZXZtX2Nsa19nZXQo
JnBkZXYtPmRldiwgImJ1c19jbGsiKTsNCisJaWYgKElTX0VSUihob3N0LT5idXNfY2xrKSkNCisJ
CWhvc3QtPmJ1c19jbGsgPSBOVUxMOw0KKw0KKwkvKnNvdXJjZSBjbG9jayBjb250cm9sIGdhdGUg
aXMgb3B0aW9uYWwgY2xvY2sqLw0KKwlob3N0LT5zcmNfY2xrX2NnID0gZGV2bV9jbGtfZ2V0KCZw
ZGV2LT5kZXYsICJzb3VyY2VfY2ciKTsNCisJaWYgKElTX0VSUihob3N0LT5zcmNfY2xrX2NnKSkN
CisJCWhvc3QtPnNyY19jbGtfY2cgPSBOVUxMOw0KKw0KKwlob3N0LT5zeXNfY2xrX2NnID0gZGV2
bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJzeXNfY2ciKTsNCisJaWYgKElTX0VSUihob3N0LT5zeXNf
Y2xrX2NnKSkNCisJCWhvc3QtPnN5c19jbGtfY2cgPSBOVUxMOw0KKwllbHNlDQorCQljbGtfcHJl
cGFyZV9lbmFibGUoaG9zdC0+c3lzX2Nsa19jZyk7DQorDQorCWNsayA9IGRldm1fY2xrX2dldCgm
cGRldi0+ZGV2LCAicGNsa19jZyIpOw0KKwlpZiAoSVNfRVJSKGNsaykpDQorCQljbGsgPSBOVUxM
Ow0KKwlob3N0LT5idWxrX2Nsa3NbMF0uY2xrID0gY2xrOw0KKw0KKwljbGsgPSBkZXZtX2Nsa19n
ZXQoJnBkZXYtPmRldiwgImF4aV9jZyIpOw0KKwlpZiAoSVNfRVJSKGNsaykpDQorCQljbGsgPSBO
VUxMOw0KKwlob3N0LT5idWxrX2Nsa3NbMV0uY2xrID0gY2xrOw0KKw0KKwljbGsgPSBkZXZtX2Ns
a19nZXQoJnBkZXYtPmRldiwgImFoYl9jZyIpOw0KKwlpZiAoSVNfRVJSKGNsaykpDQorCQljbGsg
PSBOVUxMOw0KKwlob3N0LT5idWxrX2Nsa3NbMl0uY2xrID0gY2xrOw0KKw0KKwlyZXR1cm4gMDsN
Cit9DQorDQogc3RhdGljIGludCBtc2RjX2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIHsNCiAJc3RydWN0IG1tY19ob3N0ICptbWM7DQpAQCAtMjQwNSwyNSArMjQ2Miw5
IEBAIHN0YXRpYyBpbnQgbXNkY19kcnZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCiAJaWYgKHJldCkNCiAJCWdvdG8gaG9zdF9mcmVlOw0KIA0KLQlob3N0LT5zcmNfY2xrID0g
ZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJzb3VyY2UiKTsNCi0JaWYgKElTX0VSUihob3N0LT5z
cmNfY2xrKSkgew0KLQkJcmV0ID0gUFRSX0VSUihob3N0LT5zcmNfY2xrKTsNCi0JCWdvdG8gaG9z
dF9mcmVlOw0KLQl9DQotDQotCWhvc3QtPmhfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYs
ICJoY2xrIik7DQotCWlmIChJU19FUlIoaG9zdC0+aF9jbGspKSB7DQotCQlyZXQgPSBQVFJfRVJS
KGhvc3QtPmhfY2xrKTsNCisJcmV0ID0gbXNkY19vZl9jbG9ja19wYXJzZShwZGV2LCBob3N0KTsN
CisJaWYgKHJldCkNCiAJCWdvdG8gaG9zdF9mcmVlOw0KLQl9DQotDQotCWhvc3QtPmJ1c19jbGsg
PSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImJ1c19jbGsiKTsNCi0JaWYgKElTX0VSUihob3N0
LT5idXNfY2xrKSkNCi0JCWhvc3QtPmJ1c19jbGsgPSBOVUxMOw0KLQkvKnNvdXJjZSBjbG9jayBj
b250cm9sIGdhdGUgaXMgb3B0aW9uYWwgY2xvY2sqLw0KLQlob3N0LT5zcmNfY2xrX2NnID0gZGV2
bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJzb3VyY2VfY2ciKTsNCi0JaWYgKElTX0VSUihob3N0LT5z
cmNfY2xrX2NnKSkNCi0JCWhvc3QtPnNyY19jbGtfY2cgPSBOVUxMOw0KIA0KIAlob3N0LT5yZXNl
dCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKCZwZGV2LT5kZXYs
DQogCQkJCQkJCQkiaHJzdCIpOw0KLS0gDQoyLjE4LjANCg==

