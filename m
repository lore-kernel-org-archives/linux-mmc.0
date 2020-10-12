Return-Path: <SRS0=rM9+=DT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA52C43457
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A0720776
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 12:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IwLSev0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgJLMqC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Oct 2020 08:46:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46519 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729701AbgJLMqA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2020 08:46:00 -0400
X-UUID: 6ac210b394314070bef31344bcb4cf19-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fX8ByFn/yQTAJ8dBMdeWDIfLG8p3QqLiCAE8ZcVQ75s=;
        b=IwLSev0SI1ha1/JcGMAhFh53gtNSjDN5c8OOw3NBIL/snYxwmD1jxaFAamfT+f3ff218926sNtzs0RqF3WywR4ZLSSXC812a6/ZwIoKTKYmWNgrLQhiSXghNrc/sipGLKMg8UHBYKC8sZPN4tfPYoEBibCoDHoGSt53nwu9tGdg=;
X-UUID: 6ac210b394314070bef31344bcb4cf19-20201012
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1702155387; Mon, 12 Oct 2020 20:45:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Oct 2020 20:45:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 20:45:51 +0800
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
Subject: [PATCH v6 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
Date:   Mon, 12 Oct 2020 20:45:47 +0800
Message-ID: <20201012124547.16649-5-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012124547.16649-1-wenbin.mei@mediatek.com>
References: <20201012124547.16649-1-wenbin.mei@mediatek.com>
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
YyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCmluZGV4IGE3MDQ3NDVlNTg4Mi4uYzdkZjc1
MTBmMTIwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KKysrIGIvZHJp
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
K3sNCisJaW50IHJldDsNCisNCisJaG9zdC0+c3JjX2NsayA9IGRldm1fY2xrX2dldCgmcGRldi0+
ZGV2LCAic291cmNlIik7DQorCWlmIChJU19FUlIoaG9zdC0+c3JjX2NsaykpDQorCQlyZXR1cm4g
UFRSX0VSUihob3N0LT5zcmNfY2xrKTsNCisNCisJaG9zdC0+aF9jbGsgPSBkZXZtX2Nsa19nZXQo
JnBkZXYtPmRldiwgImhjbGsiKTsNCisJaWYgKElTX0VSUihob3N0LT5oX2NsaykpDQorCQlyZXR1
cm4gUFRSX0VSUihob3N0LT5oX2Nsayk7DQorDQorCWhvc3QtPmJ1c19jbGsgPSBkZXZtX2Nsa19n
ZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgImJ1c19jbGsiKTsNCisJaWYgKElTX0VSUihob3N0LT5i
dXNfY2xrKSkNCisJCWhvc3QtPmJ1c19jbGsgPSBOVUxMOw0KKw0KKwkvKnNvdXJjZSBjbG9jayBj
b250cm9sIGdhdGUgaXMgb3B0aW9uYWwgY2xvY2sqLw0KKwlob3N0LT5zcmNfY2xrX2NnID0gZGV2
bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJzb3VyY2VfY2ciKTsNCisJaWYgKElTX0VS
Uihob3N0LT5zcmNfY2xrX2NnKSkNCisJCWhvc3QtPnNyY19jbGtfY2cgPSBOVUxMOw0KKw0KKwlo
b3N0LT5zeXNfY2xrX2NnID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJzeXNf
Y2ciKTsNCisJaWYgKElTX0VSUihob3N0LT5zeXNfY2xrX2NnKSkNCisJCWhvc3QtPnN5c19jbGtf
Y2cgPSBOVUxMOw0KKw0KKwkvKiBJZiBwcmVzZW50LCBhbHdheXMgZW5hYmxlIGZvciB0aGlzIGNs
b2NrIGdhdGUgKi8NCisJY2xrX3ByZXBhcmVfZW5hYmxlKGhvc3QtPnN5c19jbGtfY2cpOw0KKw0K
Kwlob3N0LT5idWxrX2Nsa3NbMF0uaWQgPSAicGNsa19jZyI7DQorCWhvc3QtPmJ1bGtfY2xrc1sx
XS5pZCA9ICJheGlfY2ciOw0KKwlob3N0LT5idWxrX2Nsa3NbMl0uaWQgPSAiYWhiX2NnIjsNCisJ
cmV0ID0gZGV2bV9jbGtfYnVsa19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgTVNEQ19OUl9DTE9D
S1MsDQorCQkJCQkgaG9zdC0+YnVsa19jbGtzKTsNCisJaWYgKHJldCkgew0KKwkJZGV2X2Vycigm
cGRldi0+ZGV2LCAiQ2Fubm90IGdldCBwY2xrL2F4aS9haGIgY2xvY2sgZ2F0ZXNcbiIpOw0KKwkJ
cmV0dXJuIHJldDsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGludCBtc2Rj
X2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCiAJc3RydWN0IG1t
Y19ob3N0ICptbWM7DQpAQCAtMjQwNSwyNSArMjQ1OSw5IEBAIHN0YXRpYyBpbnQgbXNkY19kcnZf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKHJldCkNCiAJCWdvdG8g
aG9zdF9mcmVlOw0KIA0KLQlob3N0LT5zcmNfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYs
ICJzb3VyY2UiKTsNCi0JaWYgKElTX0VSUihob3N0LT5zcmNfY2xrKSkgew0KLQkJcmV0ID0gUFRS
X0VSUihob3N0LT5zcmNfY2xrKTsNCi0JCWdvdG8gaG9zdF9mcmVlOw0KLQl9DQotDQotCWhvc3Qt
PmhfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJoY2xrIik7DQotCWlmIChJU19FUlIo
aG9zdC0+aF9jbGspKSB7DQotCQlyZXQgPSBQVFJfRVJSKGhvc3QtPmhfY2xrKTsNCisJcmV0ID0g
bXNkY19vZl9jbG9ja19wYXJzZShwZGV2LCBob3N0KTsNCisJaWYgKHJldCkNCiAJCWdvdG8gaG9z
dF9mcmVlOw0KLQl9DQotDQotCWhvc3QtPmJ1c19jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRl
diwgImJ1c19jbGsiKTsNCi0JaWYgKElTX0VSUihob3N0LT5idXNfY2xrKSkNCi0JCWhvc3QtPmJ1
c19jbGsgPSBOVUxMOw0KLQkvKnNvdXJjZSBjbG9jayBjb250cm9sIGdhdGUgaXMgb3B0aW9uYWwg
Y2xvY2sqLw0KLQlob3N0LT5zcmNfY2xrX2NnID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJz
b3VyY2VfY2ciKTsNCi0JaWYgKElTX0VSUihob3N0LT5zcmNfY2xrX2NnKSkNCi0JCWhvc3QtPnNy
Y19jbGtfY2cgPSBOVUxMOw0KIA0KIAlob3N0LT5yZXNldCA9IGRldm1fcmVzZXRfY29udHJvbF9n
ZXRfb3B0aW9uYWxfZXhjbHVzaXZlKCZwZGV2LT5kZXYsDQogCQkJCQkJCQkiaHJzdCIpOw0KLS0g
DQoyLjE4LjANCg==

