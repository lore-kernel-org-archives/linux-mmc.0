Return-Path: <SRS0=/DC9=DS=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1802BC43457
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Oct 2020 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5186207FB
	for <linux-mmc@archiver.kernel.org>; Sun, 11 Oct 2020 09:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cQ+zX7uY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgJKJKs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Oct 2020 05:10:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36151 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729501AbgJKJKk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Oct 2020 05:10:40 -0400
X-UUID: 2d867613a92e4017b69f507552c7cdda-20201011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GoereX3z4yLccDhPMr3wMI58d0RbqsyXBZGN1gaGVb0=;
        b=cQ+zX7uYW2ROUQNrFlKspwBntJrwfdP97dV9IsTz5NDxcJIwkI4fd2TN4qo+rd2OkqOX2Dbo3GmGRlDeqcvM8/GRdVGak6H++PHqAQ6TQneGBlsGMyn8TlMyBuCvIcb20DRNXaiKlIPoiyqKOvPCRsBXLuZ3SRjjGry0tQWDyqo=;
X-UUID: 2d867613a92e4017b69f507552c7cdda-20201011
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 325027978; Sun, 11 Oct 2020 17:10:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 11 Oct 2020 17:10:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 11 Oct 2020 17:10:35 +0800
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
Subject: [PATCH v4 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
Date:   Sun, 11 Oct 2020 17:10:30 +0800
Message-ID: <20201011091030.28547-5-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201011091030.28547-1-wenbin.mei@mediatek.com>
References: <20201011091030.28547-1-wenbin.mei@mediatek.com>
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
LS0NCiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgODAgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKyksIDE4
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyBi
L2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCmluZGV4IGE3MDQ3NDVlNTg4Mi4uMzUwZTQ1NDMy
ZTIxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYw0KQEAgLTQyNSw2ICs0MjUsOCBAQCBzdHJ1Y3QgbXNkY19ob3N0
IHsNCiAJc3RydWN0IGNsayAqaF9jbGs7ICAgICAgLyogbXNkYyBoX2NsayAqLw0KIAlzdHJ1Y3Qg
Y2xrICpidXNfY2xrOwkvKiBidXMgY2xvY2sgd2hpY2ggdXNlZCB0byBhY2Nlc3MgcmVnaXN0ZXIg
Ki8NCiAJc3RydWN0IGNsayAqc3JjX2Nsa19jZzsgLyogbXNkYyBzb3VyY2UgY2xvY2sgY29udHJv
bCBnYXRlICovDQorCXN0cnVjdCBjbGsgKnN5c19jbGtfY2c7CS8qIG1zZGMgc3Vic3lzIGNsb2Nr
IGNvbnRyb2wgZ2F0ZSAqLw0KKwlzdHJ1Y3QgY2xrX2J1bGtfZGF0YSBidWxrX2Nsa3NbM107CS8q
IHBjbGssIGF4aSwgYWhiIGNsb2NrIGNvbnRyb2wgZ2F0ZSAqLw0KIAl1MzIgbWNsazsJCS8qIG1t
YyBzdWJzeXN0ZW0gY2xvY2sgZnJlcXVlbmN5ICovDQogCXUzMiBzcmNfY2xrX2ZyZXE7CS8qIHNv
dXJjZSBjbG9jayBmcmVxdWVuY3kgKi8NCiAJdW5zaWduZWQgY2hhciB0aW1pbmc7DQpAQCAtNzg0
LDYgKzc4Niw4IEBAIHN0YXRpYyB2b2lkIG1zZGNfc2V0X2J1c3lfdGltZW91dChzdHJ1Y3QgbXNk
Y19ob3N0ICpob3N0LCB1NjQgbnMsIHU2NCBjbGtzKQ0KIA0KIHN0YXRpYyB2b2lkIG1zZGNfZ2F0
ZV9jbG9jayhzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0KIHsNCisJY2xrX2J1bGtfZGlzYWJsZV91
bnByZXBhcmUoQVJSQVlfU0laRShob3N0LT5idWxrX2Nsa3MpLA0KKwkJCQkgICBob3N0LT5idWxr
X2Nsa3MpOw0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoaG9zdC0+c3JjX2Nsa19jZyk7DQogCWNs
a19kaXNhYmxlX3VucHJlcGFyZShob3N0LT5zcmNfY2xrKTsNCiAJY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKGhvc3QtPmJ1c19jbGspOw0KQEAgLTc5MiwxMCArNzk2LDE5IEBAIHN0YXRpYyB2b2lkIG1z
ZGNfZ2F0ZV9jbG9jayhzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0KIA0KIHN0YXRpYyB2b2lkIG1z
ZGNfdW5nYXRlX2Nsb2NrKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QpDQogew0KKwlpbnQgcmV0Ow0K
Kw0KIAljbGtfcHJlcGFyZV9lbmFibGUoaG9zdC0+aF9jbGspOw0KIAljbGtfcHJlcGFyZV9lbmFi
bGUoaG9zdC0+YnVzX2Nsayk7DQogCWNsa19wcmVwYXJlX2VuYWJsZShob3N0LT5zcmNfY2xrKTsN
CiAJY2xrX3ByZXBhcmVfZW5hYmxlKGhvc3QtPnNyY19jbGtfY2cpOw0KKwlyZXQgPSBjbGtfYnVs
a19wcmVwYXJlX2VuYWJsZShBUlJBWV9TSVpFKGhvc3QtPmJ1bGtfY2xrcyksDQorCQkJCSAgICAg
IGhvc3QtPmJ1bGtfY2xrcyk7DQorCWlmIChyZXQpIHsNCisJCWRldl9lcnIoaG9zdC0+ZGV2LCAi
ZW5hYmxlIGNsa3MgZmFpbGVkIVxuIik7DQorCQlyZXR1cm47DQorCX0NCisNCiAJd2hpbGUgKCEo
cmVhZGwoaG9zdC0+YmFzZSArIE1TRENfQ0ZHKSAmIE1TRENfQ0ZHX0NLU1RCKSkNCiAJCWNwdV9y
ZWxheCgpOw0KIH0NCkBAIC0yMzY2LDYgKzIzNzksNTMgQEAgc3RhdGljIHZvaWQgbXNkY19vZl9w
cm9wZXJ0eV9wYXJzZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkJaG9zdC0+Y3Fo
Y2kgPSBmYWxzZTsNCiB9DQogDQorc3RhdGljIGludCBtc2RjX29mX2Nsb2NrX3BhcnNlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQorCQkJICAgICAgIHN0cnVjdCBtc2RjX2hvc3QgKmhv
c3QpDQorew0KKwlzdHJ1Y3QgY2xrICpjbGs7DQorDQorCWhvc3QtPnNyY19jbGsgPSBkZXZtX2Ns
a19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgInNvdXJjZSIpOw0KKwlpZiAoSVNfRVJSKGhvc3Qt
PnNyY19jbGspKQ0KKwkJcmV0dXJuIFBUUl9FUlIoaG9zdC0+c3JjX2Nsayk7DQorDQorCWhvc3Qt
PmhfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJoY2xrIik7DQorCWlm
IChJU19FUlIoaG9zdC0+aF9jbGspKQ0KKwkJcmV0dXJuIFBUUl9FUlIoaG9zdC0+aF9jbGspOw0K
Kw0KKwlob3N0LT5idXNfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJi
dXNfY2xrIik7DQorCWlmIChJU19FUlIoaG9zdC0+YnVzX2NsaykpDQorCQlob3N0LT5idXNfY2xr
ID0gTlVMTDsNCisNCisJLypzb3VyY2UgY2xvY2sgY29udHJvbCBnYXRlIGlzIG9wdGlvbmFsIGNs
b2NrKi8NCisJaG9zdC0+c3JjX2Nsa19jZyA9IGRldm1fY2xrX2dldF9vcHRpb25hbCgmcGRldi0+
ZGV2LCAic291cmNlX2NnIik7DQorCWlmIChJU19FUlIoaG9zdC0+c3JjX2Nsa19jZykpDQorCQlo
b3N0LT5zcmNfY2xrX2NnID0gTlVMTDsNCisNCisJaG9zdC0+c3lzX2Nsa19jZyA9IGRldm1fY2xr
X2dldF9vcHRpb25hbCgmcGRldi0+ZGV2LCAic3lzX2NnIik7DQorCWlmIChJU19FUlIoaG9zdC0+
c3lzX2Nsa19jZykpDQorCQlob3N0LT5zeXNfY2xrX2NnID0gTlVMTDsNCisNCisJLyogSWYgcHJl
c2VudCwgYWx3YXlzIGVuYWJsZSBmb3IgdGhpcyBjbG9jayBnYXRlICovDQorCWNsa19wcmVwYXJl
X2VuYWJsZShob3N0LT5zeXNfY2xrX2NnKTsNCisNCisJY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlv
bmFsKCZwZGV2LT5kZXYsICJwY2xrX2NnIik7DQorCWlmIChJU19FUlIoY2xrKSkNCisJCWNsayA9
IE5VTEw7DQorCWhvc3QtPmJ1bGtfY2xrc1swXS5jbGsgPSBjbGs7DQorDQorCWNsayA9IGRldm1f
Y2xrX2dldF9vcHRpb25hbCgmcGRldi0+ZGV2LCAiYXhpX2NnIik7DQorCWlmIChJU19FUlIoY2xr
KSkNCisJCWNsayA9IE5VTEw7DQorCWhvc3QtPmJ1bGtfY2xrc1sxXS5jbGsgPSBjbGs7DQorDQor
CWNsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbCgmcGRldi0+ZGV2LCAiYWhiX2NnIik7DQorCWlm
IChJU19FUlIoY2xrKSkNCisJCWNsayA9IE5VTEw7DQorCWhvc3QtPmJ1bGtfY2xrc1syXS5jbGsg
PSBjbGs7DQorDQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMgaW50IG1zZGNfZHJ2X3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgbW1jX2hvc3QgKm1t
YzsNCkBAIC0yNDA1LDI1ICsyNDY1LDkgQEAgc3RhdGljIGludCBtc2RjX2Rydl9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAocmV0KQ0KIAkJZ290byBob3N0X2ZyZWU7
DQogDQotCWhvc3QtPnNyY19jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgInNvdXJjZSIp
Ow0KLQlpZiAoSVNfRVJSKGhvc3QtPnNyY19jbGspKSB7DQotCQlyZXQgPSBQVFJfRVJSKGhvc3Qt
PnNyY19jbGspOw0KLQkJZ290byBob3N0X2ZyZWU7DQotCX0NCi0NCi0JaG9zdC0+aF9jbGsgPSBk
ZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImhjbGsiKTsNCi0JaWYgKElTX0VSUihob3N0LT5oX2Ns
aykpIHsNCi0JCXJldCA9IFBUUl9FUlIoaG9zdC0+aF9jbGspOw0KKwlyZXQgPSBtc2RjX29mX2Ns
b2NrX3BhcnNlKHBkZXYsIGhvc3QpOw0KKwlpZiAocmV0KQ0KIAkJZ290byBob3N0X2ZyZWU7DQot
CX0NCi0NCi0JaG9zdC0+YnVzX2NsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiYnVzX2Ns
ayIpOw0KLQlpZiAoSVNfRVJSKGhvc3QtPmJ1c19jbGspKQ0KLQkJaG9zdC0+YnVzX2NsayA9IE5V
TEw7DQotCS8qc291cmNlIGNsb2NrIGNvbnRyb2wgZ2F0ZSBpcyBvcHRpb25hbCBjbG9jayovDQot
CWhvc3QtPnNyY19jbGtfY2cgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgInNvdXJjZV9jZyIp
Ow0KLQlpZiAoSVNfRVJSKGhvc3QtPnNyY19jbGtfY2cpKQ0KLQkJaG9zdC0+c3JjX2Nsa19jZyA9
IE5VTEw7DQogDQogCWhvc3QtPnJlc2V0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25h
bF9leGNsdXNpdmUoJnBkZXYtPmRldiwNCiAJCQkJCQkJCSJocnN0Iik7DQotLSANCjIuMTguMA0K

