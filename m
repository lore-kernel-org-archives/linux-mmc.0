Return-Path: <SRS0=rM9+=DT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602A8C43457
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 02:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2209B20776
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 02:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oOah5gkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgJLCnz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Oct 2020 22:43:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50793 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726072AbgJLCny (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Oct 2020 22:43:54 -0400
X-UUID: 3c83308a4338417a8ab3fffc90641077-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=A6xD0Mo62vGlwuFlxmjazlsP6yE3Rybdje/WR5P5OAg=;
        b=oOah5gkPEfc94Zo9O1Mk8mlr6f87zH2P2D/rAZrx9BW6tb5ZfYKPaSUDZGolhWCd44/eE/LcVKHwlTGDiNnfFu0HGnmtRLSvo0HOSz06fxja+CxCE/fJLjY3VBLxd1jEmOubBYLo8yxCzC2kkA3izwrPvK5IDchi7RNTDduFs+A=;
X-UUID: 3c83308a4338417a8ab3fffc90641077-20201012
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 668517189; Mon, 12 Oct 2020 10:43:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Oct 2020 10:43:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 10:43:50 +0800
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
Subject: [PATCH v5 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
Date:   Mon, 12 Oct 2020 10:43:45 +0800
Message-ID: <20201012024345.8361-5-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012024345.8361-1-wenbin.mei@mediatek.com>
References: <20201012024345.8361-1-wenbin.mei@mediatek.com>
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
DQotLS0NCiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNzQgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyks
IDE4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2Qu
YyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCmluZGV4IGE3MDQ3NDVlNTg4Mi4uNDE3MDNl
NmQ2YjE3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KKysrIGIvZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYw0KQEAgLTM1LDYgKzM1LDcgQEANCiAjaW5jbHVkZSAiY3Fo
Y2kuaCINCiANCiAjZGVmaW5lIE1BWF9CRF9OVU0gICAgICAgICAgMTAyNA0KKyNkZWZpbmUgTVNE
Q19OUl9DTE9DS1MgICAgICAzDQogDQogLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovDQogLyogQ29tbW9u
IERlZmluaXRpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICovDQpAQCAtNDI1LDYgKzQyNiw4IEBAIHN0cnVjdCBtc2RjX2hvc3Qgew0KIAlz
dHJ1Y3QgY2xrICpoX2NsazsgICAgICAvKiBtc2RjIGhfY2xrICovDQogCXN0cnVjdCBjbGsgKmJ1
c19jbGs7CS8qIGJ1cyBjbG9jayB3aGljaCB1c2VkIHRvIGFjY2VzcyByZWdpc3RlciAqLw0KIAlz
dHJ1Y3QgY2xrICpzcmNfY2xrX2NnOyAvKiBtc2RjIHNvdXJjZSBjbG9jayBjb250cm9sIGdhdGUg
Ki8NCisJc3RydWN0IGNsayAqc3lzX2Nsa19jZzsJLyogbXNkYyBzdWJzeXMgY2xvY2sgY29udHJv
bCBnYXRlICovDQorCXN0cnVjdCBjbGtfYnVsa19kYXRhIGJ1bGtfY2xrc1tNU0RDX05SX0NMT0NL
U107DQogCXUzMiBtY2xrOwkJLyogbW1jIHN1YnN5c3RlbSBjbG9jayBmcmVxdWVuY3kgKi8NCiAJ
dTMyIHNyY19jbGtfZnJlcTsJLyogc291cmNlIGNsb2NrIGZyZXF1ZW5jeSAqLw0KIAl1bnNpZ25l
ZCBjaGFyIHRpbWluZzsNCkBAIC03ODQsNiArNzg3LDcgQEAgc3RhdGljIHZvaWQgbXNkY19zZXRf
YnVzeV90aW1lb3V0KHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QsIHU2NCBucywgdTY0IGNsa3MpDQog
DQogc3RhdGljIHZvaWQgbXNkY19nYXRlX2Nsb2NrKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QpDQog
ew0KKwljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShNU0RDX05SX0NMT0NLUywgaG9zdC0+YnVs
a19jbGtzKTsNCiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhvc3QtPnNyY19jbGtfY2cpOw0KIAlj
bGtfZGlzYWJsZV91bnByZXBhcmUoaG9zdC0+c3JjX2Nsayk7DQogCWNsa19kaXNhYmxlX3VucHJl
cGFyZShob3N0LT5idXNfY2xrKTsNCkBAIC03OTIsMTAgKzc5NiwxOCBAQCBzdGF0aWMgdm9pZCBt
c2RjX2dhdGVfY2xvY2soc3RydWN0IG1zZGNfaG9zdCAqaG9zdCkNCiANCiBzdGF0aWMgdm9pZCBt
c2RjX3VuZ2F0ZV9jbG9jayhzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0KIHsNCisJaW50IHJldDsN
CisNCiAJY2xrX3ByZXBhcmVfZW5hYmxlKGhvc3QtPmhfY2xrKTsNCiAJY2xrX3ByZXBhcmVfZW5h
YmxlKGhvc3QtPmJ1c19jbGspOw0KIAljbGtfcHJlcGFyZV9lbmFibGUoaG9zdC0+c3JjX2Nsayk7
DQogCWNsa19wcmVwYXJlX2VuYWJsZShob3N0LT5zcmNfY2xrX2NnKTsNCisJcmV0ID0gY2xrX2J1
bGtfcHJlcGFyZV9lbmFibGUoTVNEQ19OUl9DTE9DS1MsIGhvc3QtPmJ1bGtfY2xrcyk7DQorCWlm
IChyZXQpIHsNCisJCWRldl9lcnIoaG9zdC0+ZGV2LCAiQ2Fubm90IGVuYWJsZSBwY2xrL2F4aS9h
aGIgY2xvY2sgZ2F0ZXNcbiIpOw0KKwkJcmV0dXJuOw0KKwl9DQorDQogCXdoaWxlICghKHJlYWRs
KGhvc3QtPmJhc2UgKyBNU0RDX0NGRykgJiBNU0RDX0NGR19DS1NUQikpDQogCQljcHVfcmVsYXgo
KTsNCiB9DQpAQCAtMjM2Niw2ICsyMzc4LDQ4IEBAIHN0YXRpYyB2b2lkIG1zZGNfb2ZfcHJvcGVy
dHlfcGFyc2Uoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAJCWhvc3QtPmNxaGNpID0g
ZmFsc2U7DQogfQ0KIA0KK3N0YXRpYyBpbnQgbXNkY19vZl9jbG9ja19wYXJzZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2LA0KKwkJCSAgICAgICBzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0K
K3sNCisJaW50IHJldDsNCisNCisJaG9zdC0+c3JjX2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25h
bCgmcGRldi0+ZGV2LCAic291cmNlIik7DQorCWlmIChJU19FUlIoaG9zdC0+c3JjX2NsaykpDQor
CQlyZXR1cm4gUFRSX0VSUihob3N0LT5zcmNfY2xrKTsNCisNCisJaG9zdC0+aF9jbGsgPSBkZXZt
X2Nsa19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgImhjbGsiKTsNCisJaWYgKElTX0VSUihob3N0
LT5oX2NsaykpDQorCQlyZXR1cm4gUFRSX0VSUihob3N0LT5oX2Nsayk7DQorDQorCWhvc3QtPmJ1
c19jbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgImJ1c19jbGsiKTsNCisJ
aWYgKElTX0VSUihob3N0LT5idXNfY2xrKSkNCisJCWhvc3QtPmJ1c19jbGsgPSBOVUxMOw0KKw0K
KwkvKnNvdXJjZSBjbG9jayBjb250cm9sIGdhdGUgaXMgb3B0aW9uYWwgY2xvY2sqLw0KKwlob3N0
LT5zcmNfY2xrX2NnID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJzb3VyY2Vf
Y2ciKTsNCisJaWYgKElTX0VSUihob3N0LT5zcmNfY2xrX2NnKSkNCisJCWhvc3QtPnNyY19jbGtf
Y2cgPSBOVUxMOw0KKw0KKwlob3N0LT5zeXNfY2xrX2NnID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFs
KCZwZGV2LT5kZXYsICJzeXNfY2ciKTsNCisJaWYgKElTX0VSUihob3N0LT5zeXNfY2xrX2NnKSkN
CisJCWhvc3QtPnN5c19jbGtfY2cgPSBOVUxMOw0KKw0KKwkvKiBJZiBwcmVzZW50LCBhbHdheXMg
ZW5hYmxlIGZvciB0aGlzIGNsb2NrIGdhdGUgKi8NCisJY2xrX3ByZXBhcmVfZW5hYmxlKGhvc3Qt
PnN5c19jbGtfY2cpOw0KKw0KKwlob3N0LT5idWxrX2Nsa3NbMF0uaWQgPSAicGNsa19jZyI7DQor
CWhvc3QtPmJ1bGtfY2xrc1sxXS5pZCA9ICJheGlfY2ciOw0KKwlob3N0LT5idWxrX2Nsa3NbMl0u
aWQgPSAiYWhiX2NnIjsNCisJcmV0ID0gZGV2bV9jbGtfYnVsa19nZXRfb3B0aW9uYWwoJnBkZXYt
PmRldiwgTVNEQ19OUl9DTE9DS1MsDQorCQkJCQkgaG9zdC0+YnVsa19jbGtzKTsNCisJaWYgKHJl
dCkgew0KKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ2Fubm90IGdldCBwY2xrL2F4aS9haGIgY2xv
Y2sgZ2F0ZXNcbiIpOw0KKwkJcmV0dXJuIHJldDsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9DQor
DQogc3RhdGljIGludCBtc2RjX2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KIHsNCiAJc3RydWN0IG1tY19ob3N0ICptbWM7DQpAQCAtMjQwNSwyNSArMjQ1OSw5IEBAIHN0
YXRpYyBpbnQgbXNkY19kcnZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJ
aWYgKHJldCkNCiAJCWdvdG8gaG9zdF9mcmVlOw0KIA0KLQlob3N0LT5zcmNfY2xrID0gZGV2bV9j
bGtfZ2V0KCZwZGV2LT5kZXYsICJzb3VyY2UiKTsNCi0JaWYgKElTX0VSUihob3N0LT5zcmNfY2xr
KSkgew0KLQkJcmV0ID0gUFRSX0VSUihob3N0LT5zcmNfY2xrKTsNCi0JCWdvdG8gaG9zdF9mcmVl
Ow0KLQl9DQotDQotCWhvc3QtPmhfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJoY2xr
Iik7DQotCWlmIChJU19FUlIoaG9zdC0+aF9jbGspKSB7DQotCQlyZXQgPSBQVFJfRVJSKGhvc3Qt
PmhfY2xrKTsNCisJcmV0ID0gbXNkY19vZl9jbG9ja19wYXJzZShwZGV2LCBob3N0KTsNCisJaWYg
KHJldCkNCiAJCWdvdG8gaG9zdF9mcmVlOw0KLQl9DQotDQotCWhvc3QtPmJ1c19jbGsgPSBkZXZt
X2Nsa19nZXQoJnBkZXYtPmRldiwgImJ1c19jbGsiKTsNCi0JaWYgKElTX0VSUihob3N0LT5idXNf
Y2xrKSkNCi0JCWhvc3QtPmJ1c19jbGsgPSBOVUxMOw0KLQkvKnNvdXJjZSBjbG9jayBjb250cm9s
IGdhdGUgaXMgb3B0aW9uYWwgY2xvY2sqLw0KLQlob3N0LT5zcmNfY2xrX2NnID0gZGV2bV9jbGtf
Z2V0KCZwZGV2LT5kZXYsICJzb3VyY2VfY2ciKTsNCi0JaWYgKElTX0VSUihob3N0LT5zcmNfY2xr
X2NnKSkNCi0JCWhvc3QtPnNyY19jbGtfY2cgPSBOVUxMOw0KIA0KIAlob3N0LT5yZXNldCA9IGRl
dm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKCZwZGV2LT5kZXYsDQogCQkJ
CQkJCQkiaHJzdCIpOw0KLS0gDQoyLjE4LjANCg==

