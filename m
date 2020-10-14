Return-Path: <SRS0=DFdp=DV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E9C433E7
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 03:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA4D21D81
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 03:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gGqZRKrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgJNDJw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 23:09:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41053 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbgJNDJw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2020 23:09:52 -0400
X-UUID: ebca25e1420f410ebd1de631ff12b6d9-20201014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8TGwcbxTFH3HJEaSJa1xM5BQ/ArhorBGt3HRCC6d8QM=;
        b=gGqZRKrPBITdw7wt0Ay/hMtUa261QACqbT7PNO0Ksqn1H9LqysPCMeKxNAZ27+Y8lNSNWwXn9N26RMKQ/ApG06jqB3VoNif2bswPR5cxtGGqMAU0V+qxEXLp8dKjk9EWfLfIgr8izItUAlRaw5ak/I/gol1jthwUxWzUHn/sJWk=;
X-UUID: ebca25e1420f410ebd1de631ff12b6d9-20201014
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1301275765; Wed, 14 Oct 2020 11:09:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Oct 2020 11:08:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Oct 2020 11:08:51 +0800
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
Subject: [PATCH v7 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
Date:   Wed, 14 Oct 2020 11:08:46 +0800
Message-ID: <20201014030846.12428-5-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201014030846.12428-1-wenbin.mei@mediatek.com>
References: <20201014030846.12428-1-wenbin.mei@mediatek.com>
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
DQpSZXZpZXdlZC1ieTogTmljb2xhcyBCb2ljaGF0IDxkcmlua2NhdEBjaHJvbWl1bS5vcmc+DQot
LS0NCiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNzQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDE4
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyBi
L2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCmluZGV4IGE3MDQ3NDVlNTg4Mi4uYzdkZjc1MTBm
MTIwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYw0KQEAgLTM1LDYgKzM1LDcgQEANCiAjaW5jbHVkZSAiY3FoY2ku
aCINCiANCiAjZGVmaW5lIE1BWF9CRF9OVU0gICAgICAgICAgMTAyNA0KKyNkZWZpbmUgTVNEQ19O
Ul9DTE9DS1MgICAgICAzDQogDQogLyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovDQogLyogQ29tbW9uIERl
ZmluaXRpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICovDQpAQCAtNDI1LDYgKzQyNiw4IEBAIHN0cnVjdCBtc2RjX2hvc3Qgew0KIAlzdHJ1
Y3QgY2xrICpoX2NsazsgICAgICAvKiBtc2RjIGhfY2xrICovDQogCXN0cnVjdCBjbGsgKmJ1c19j
bGs7CS8qIGJ1cyBjbG9jayB3aGljaCB1c2VkIHRvIGFjY2VzcyByZWdpc3RlciAqLw0KIAlzdHJ1
Y3QgY2xrICpzcmNfY2xrX2NnOyAvKiBtc2RjIHNvdXJjZSBjbG9jayBjb250cm9sIGdhdGUgKi8N
CisJc3RydWN0IGNsayAqc3lzX2Nsa19jZzsJLyogbXNkYyBzdWJzeXMgY2xvY2sgY29udHJvbCBn
YXRlICovDQorCXN0cnVjdCBjbGtfYnVsa19kYXRhIGJ1bGtfY2xrc1tNU0RDX05SX0NMT0NLU107
DQogCXUzMiBtY2xrOwkJLyogbW1jIHN1YnN5c3RlbSBjbG9jayBmcmVxdWVuY3kgKi8NCiAJdTMy
IHNyY19jbGtfZnJlcTsJLyogc291cmNlIGNsb2NrIGZyZXF1ZW5jeSAqLw0KIAl1bnNpZ25lZCBj
aGFyIHRpbWluZzsNCkBAIC03ODQsNiArNzg3LDcgQEAgc3RhdGljIHZvaWQgbXNkY19zZXRfYnVz
eV90aW1lb3V0KHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QsIHU2NCBucywgdTY0IGNsa3MpDQogDQog
c3RhdGljIHZvaWQgbXNkY19nYXRlX2Nsb2NrKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QpDQogew0K
KwljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShNU0RDX05SX0NMT0NLUywgaG9zdC0+YnVsa19j
bGtzKTsNCiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhvc3QtPnNyY19jbGtfY2cpOw0KIAljbGtf
ZGlzYWJsZV91bnByZXBhcmUoaG9zdC0+c3JjX2Nsayk7DQogCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShob3N0LT5idXNfY2xrKTsNCkBAIC03OTIsMTAgKzc5NiwxOCBAQCBzdGF0aWMgdm9pZCBtc2Rj
X2dhdGVfY2xvY2soc3RydWN0IG1zZGNfaG9zdCAqaG9zdCkNCiANCiBzdGF0aWMgdm9pZCBtc2Rj
X3VuZ2F0ZV9jbG9jayhzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0KIHsNCisJaW50IHJldDsNCisN
CiAJY2xrX3ByZXBhcmVfZW5hYmxlKGhvc3QtPmhfY2xrKTsNCiAJY2xrX3ByZXBhcmVfZW5hYmxl
KGhvc3QtPmJ1c19jbGspOw0KIAljbGtfcHJlcGFyZV9lbmFibGUoaG9zdC0+c3JjX2Nsayk7DQog
CWNsa19wcmVwYXJlX2VuYWJsZShob3N0LT5zcmNfY2xrX2NnKTsNCisJcmV0ID0gY2xrX2J1bGtf
cHJlcGFyZV9lbmFibGUoTVNEQ19OUl9DTE9DS1MsIGhvc3QtPmJ1bGtfY2xrcyk7DQorCWlmIChy
ZXQpIHsNCisJCWRldl9lcnIoaG9zdC0+ZGV2LCAiQ2Fubm90IGVuYWJsZSBwY2xrL2F4aS9haGIg
Y2xvY2sgZ2F0ZXNcbiIpOw0KKwkJcmV0dXJuOw0KKwl9DQorDQogCXdoaWxlICghKHJlYWRsKGhv
c3QtPmJhc2UgKyBNU0RDX0NGRykgJiBNU0RDX0NGR19DS1NUQikpDQogCQljcHVfcmVsYXgoKTsN
CiB9DQpAQCAtMjM2Niw2ICsyMzc4LDQ4IEBAIHN0YXRpYyB2b2lkIG1zZGNfb2ZfcHJvcGVydHlf
cGFyc2Uoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAJCWhvc3QtPmNxaGNpID0gZmFs
c2U7DQogfQ0KIA0KK3N0YXRpYyBpbnQgbXNkY19vZl9jbG9ja19wYXJzZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2LA0KKwkJCSAgICAgICBzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0KK3sN
CisJaW50IHJldDsNCisNCisJaG9zdC0+c3JjX2NsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2
LCAic291cmNlIik7DQorCWlmIChJU19FUlIoaG9zdC0+c3JjX2NsaykpDQorCQlyZXR1cm4gUFRS
X0VSUihob3N0LT5zcmNfY2xrKTsNCisNCisJaG9zdC0+aF9jbGsgPSBkZXZtX2Nsa19nZXQoJnBk
ZXYtPmRldiwgImhjbGsiKTsNCisJaWYgKElTX0VSUihob3N0LT5oX2NsaykpDQorCQlyZXR1cm4g
UFRSX0VSUihob3N0LT5oX2Nsayk7DQorDQorCWhvc3QtPmJ1c19jbGsgPSBkZXZtX2Nsa19nZXRf
b3B0aW9uYWwoJnBkZXYtPmRldiwgImJ1c19jbGsiKTsNCisJaWYgKElTX0VSUihob3N0LT5idXNf
Y2xrKSkNCisJCWhvc3QtPmJ1c19jbGsgPSBOVUxMOw0KKw0KKwkvKnNvdXJjZSBjbG9jayBjb250
cm9sIGdhdGUgaXMgb3B0aW9uYWwgY2xvY2sqLw0KKwlob3N0LT5zcmNfY2xrX2NnID0gZGV2bV9j
bGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJzb3VyY2VfY2ciKTsNCisJaWYgKElTX0VSUiho
b3N0LT5zcmNfY2xrX2NnKSkNCisJCWhvc3QtPnNyY19jbGtfY2cgPSBOVUxMOw0KKw0KKwlob3N0
LT5zeXNfY2xrX2NnID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJzeXNfY2ci
KTsNCisJaWYgKElTX0VSUihob3N0LT5zeXNfY2xrX2NnKSkNCisJCWhvc3QtPnN5c19jbGtfY2cg
PSBOVUxMOw0KKw0KKwkvKiBJZiBwcmVzZW50LCBhbHdheXMgZW5hYmxlIGZvciB0aGlzIGNsb2Nr
IGdhdGUgKi8NCisJY2xrX3ByZXBhcmVfZW5hYmxlKGhvc3QtPnN5c19jbGtfY2cpOw0KKw0KKwlo
b3N0LT5idWxrX2Nsa3NbMF0uaWQgPSAicGNsa19jZyI7DQorCWhvc3QtPmJ1bGtfY2xrc1sxXS5p
ZCA9ICJheGlfY2ciOw0KKwlob3N0LT5idWxrX2Nsa3NbMl0uaWQgPSAiYWhiX2NnIjsNCisJcmV0
ID0gZGV2bV9jbGtfYnVsa19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgTVNEQ19OUl9DTE9DS1Ms
DQorCQkJCQkgaG9zdC0+YnVsa19jbGtzKTsNCisJaWYgKHJldCkgew0KKwkJZGV2X2VycigmcGRl
di0+ZGV2LCAiQ2Fubm90IGdldCBwY2xrL2F4aS9haGIgY2xvY2sgZ2F0ZXNcbiIpOw0KKwkJcmV0
dXJuIHJldDsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGludCBtc2RjX2Ry
dl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCiAJc3RydWN0IG1tY19o
b3N0ICptbWM7DQpAQCAtMjQwNSwyNSArMjQ1OSw5IEBAIHN0YXRpYyBpbnQgbXNkY19kcnZfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKHJldCkNCiAJCWdvdG8gaG9z
dF9mcmVlOw0KIA0KLQlob3N0LT5zcmNfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJz
b3VyY2UiKTsNCi0JaWYgKElTX0VSUihob3N0LT5zcmNfY2xrKSkgew0KLQkJcmV0ID0gUFRSX0VS
Uihob3N0LT5zcmNfY2xrKTsNCi0JCWdvdG8gaG9zdF9mcmVlOw0KLQl9DQotDQotCWhvc3QtPmhf
Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJoY2xrIik7DQotCWlmIChJU19FUlIoaG9z
dC0+aF9jbGspKSB7DQotCQlyZXQgPSBQVFJfRVJSKGhvc3QtPmhfY2xrKTsNCisJcmV0ID0gbXNk
Y19vZl9jbG9ja19wYXJzZShwZGV2LCBob3N0KTsNCisJaWYgKHJldCkNCiAJCWdvdG8gaG9zdF9m
cmVlOw0KLQl9DQotDQotCWhvc3QtPmJ1c19jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwg
ImJ1c19jbGsiKTsNCi0JaWYgKElTX0VSUihob3N0LT5idXNfY2xrKSkNCi0JCWhvc3QtPmJ1c19j
bGsgPSBOVUxMOw0KLQkvKnNvdXJjZSBjbG9jayBjb250cm9sIGdhdGUgaXMgb3B0aW9uYWwgY2xv
Y2sqLw0KLQlob3N0LT5zcmNfY2xrX2NnID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJzb3Vy
Y2VfY2ciKTsNCi0JaWYgKElTX0VSUihob3N0LT5zcmNfY2xrX2NnKSkNCi0JCWhvc3QtPnNyY19j
bGtfY2cgPSBOVUxMOw0KIA0KIAlob3N0LT5yZXNldCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRf
b3B0aW9uYWxfZXhjbHVzaXZlKCZwZGV2LT5kZXYsDQogCQkJCQkJCQkiaHJzdCIpOw0KLS0gDQoy
LjE4LjANCg==

