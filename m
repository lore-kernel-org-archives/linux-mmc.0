Return-Path: <SRS0=xq36=CY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1092C43461
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92406206B2
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Sep 2020 06:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rf3D9BAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIOGAw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Sep 2020 02:00:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25925 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726160AbgIOGAu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2020 02:00:50 -0400
X-UUID: 6ef852b35dc84e11b5cdebce7c4c8b55-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XLnueKG77zqgGlKTvOF9hBmcnot7DeiZK4sccS5sVaQ=;
        b=rf3D9BAhp6OnVW1G5JmgW99R7rzaHdHQtWTV0Flaali3AmB9EfWCWfpaLsUlrmjYV+8/pjBd2wYX0tWTAp9+6Gmmp9NiYALu9L1d2NIpW1ehyf25EJUDa4DtjtBxb7yPcNnun8bYmSCa4/jir9AVK9R3rh/cpOoZ0Ix2JkR8MjI=;
X-UUID: 6ef852b35dc84e11b5cdebce7c4c8b55-20200915
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1275839344; Tue, 15 Sep 2020 14:00:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Sep 2020 14:00:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 14:00:45 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH 3/3] mmc: mediatek: Add subsys clock control for MT8192 msdc
Date:   Tue, 15 Sep 2020 13:58:35 +0800
Message-ID: <20200915055835.25590-4-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200915055835.25590-1-wenbin.mei@mediatek.com>
References: <20200915055835.25590-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-mmc-owner@vger.kernel.org
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
YyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCmluZGV4IGVkMmIyNDY5MWI0Zi4uZjMxMTE5
MmM4ZDA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KKysrIGIvZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYw0KQEAgLTQyNiw2ICs0MjYsOCBAQCBzdHJ1Y3QgbXNkY19o
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
LTIzNjEsNiArMjM3Miw1MiBAQCBzdGF0aWMgdm9pZCBtc2RjX29mX3Byb3BlcnR5X3BhcnNlKHN0
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
ICpwZGV2KQ0KIHsNCiAJc3RydWN0IG1tY19ob3N0ICptbWM7DQpAQCAtMjQwMCwyNSArMjQ1Nyw5
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

