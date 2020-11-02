Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007F5C388F2
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 09:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D992225E
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 09:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A8tcWOiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgKBJ3z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:29:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41002 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728377AbgKBJ3y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 04:29:54 -0500
X-UUID: 94a4f3ffa002441dba8aa6a5243e7931-20201102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C5PzwEDrXq2uJ9flwu0b/suH13npBpu+DCWJz4q7t2Y=;
        b=A8tcWOiwfj21CPpl9YnqzwYTtPQVBdCUx97Ge7RZmyyf6Lo9m+IesAlxe5NKw+7ilo+rHO7oEZQ+9TFzwODRwLH47LZTZT14BJOuQJToCU0BDHMlJkOhJsHE4bqkVUS+hbuq0S3jCSmcsEoXUOCa4WEimUQ43azU15x5UZuR86o=;
X-UUID: 94a4f3ffa002441dba8aa6a5243e7931-20201102
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1154021043; Mon, 02 Nov 2020 17:28:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Nov 2020 17:28:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 2 Nov 2020 17:28:24 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH v1 1/1] mmc: mediatek: add HS400 enhanced strobe support
Date:   Mon, 2 Nov 2020 17:28:22 +0800
Message-ID: <20201102092822.5301-2-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201102092822.5301-1-wenbin.mei@mediatek.com>
References: <20201102092822.5301-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

QWRkIHN1cHBvcnQgZm9yIEhTNDAwRVMgbW9kZSB0byBNZWRpYVRlayBNTUMgQ2FyZCBEcml2ZXIu
DQoNClNpZ25lZC1vZmYtYnk6IFdlbmJpbiBNZWkgPHdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0K
LS0tDQogZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDQwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9tbWMvaG9z
dC9tdGstc2QuYw0KaW5kZXggZjdmNjg2MjNmZWZjLi5mYzVlZTVkZjkxYWQgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQorKysgYi9kcml2ZXJzL21tYy9ob3N0L210ay1z
ZC5jDQpAQCAtNzgsOSArNzgsMTIgQEANCiAjZGVmaW5lIE1TRENfUEFEX1RVTkUwICAgMHhmMA0K
ICNkZWZpbmUgUEFEX0RTX1RVTkUgICAgICAweDE4OA0KICNkZWZpbmUgUEFEX0NNRF9UVU5FICAg
ICAweDE4Yw0KKyNkZWZpbmUgRU1NQzUxX0NGRzAJIDB4MjA0DQogI2RlZmluZSBFTU1DNTBfQ0ZH
MCAgICAgIDB4MjA4DQorI2RlZmluZSBFTU1DNTBfQ0ZHMSAgICAgIDB4MjBjDQogI2RlZmluZSBF
TU1DNTBfQ0ZHMyAgICAgIDB4MjIwDQogI2RlZmluZSBTRENfRklGT19DRkcgICAgIDB4MjI4DQor
I2RlZmluZSBDUUhDSV9TRVRUSU5HCSAweDdmYw0KIA0KIC8qLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLw0K
IC8qIFRvcCBQYWQgUmVnaXN0ZXIgT2Zmc2V0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAqLw0KQEAgLTI2MSwxNSArMjY0LDI2IEBADQogDQogI2RlZmlu
ZSBQQURfQ01EX1RVTkVfUlhfRExZMwkgICgweDFmIDw8IDEpICAvKiBSVyAqLw0KIA0KKy8qIEVN
TUM1MV9DRkcwIG1hc2sgKi8NCisjZGVmaW5lIENNRFFfUkRBVF9DTlQJCSAgKDB4M2ZmIDw8IDEy
KQkvKiBSVyAqLw0KKw0KICNkZWZpbmUgRU1NQzUwX0NGR19QQURDTURfTEFUQ0hDSyAoMHgxIDw8
IDApICAgLyogUlcgKi8NCiAjZGVmaW5lIEVNTUM1MF9DRkdfQ1JDU1RTX0VER0UgICAgKDB4MSA8
PCAzKSAgIC8qIFJXICovDQogI2RlZmluZSBFTU1DNTBfQ0ZHX0NGQ1NUU19TRUwgICAgICgweDEg
PDwgNCkgICAvKiBSVyAqLw0KKyNkZWZpbmUgRU1NQzUwX0NGR19DTURfUkVTUF9TRUwgICAoMHgx
IDw8IDkpICAgLyogUlcgKi8NCisNCisvKiBFTU1DNTBfQ0ZHMSBtYXNrICovDQorI2RlZmluZSBF
TU1DNTBfQ0ZHMV9EU19DRkcgICAgICAgICgweDEgPDwgMjgpICAvKiBSVyAqLw0KIA0KICNkZWZp
bmUgRU1NQzUwX0NGRzNfT1VUU19XUiAgICAgICAoMHgxZiA8PCAwKSAgLyogUlcgKi8NCiANCiAj
ZGVmaW5lIFNEQ19GSUZPX0NGR19XUlZBTElEU0VMICAgKDB4MSA8PCAyNCkgIC8qIFJXICovDQog
I2RlZmluZSBTRENfRklGT19DRkdfUkRWQUxJRFNFTCAgICgweDEgPDwgMjUpICAvKiBSVyAqLw0K
IA0KKy8qIENRSENJX1NFVFRJTkcgKi8NCisjZGVmaW5lIENRSENJX1JEX0NNRF9XTkRfU0VMCSAg
KDB4MSA8PCAxNCkgLyogUlcgKi8NCisjZGVmaW5lIENRSENJX1dSX0NNRF9XTkRfU0VMCSAgKDB4
MSA8PCAxNSkgLyogUlcgKi8NCisNCiAvKiBFTU1DX1RPUF9DT05UUk9MIG1hc2sgKi8NCiAjZGVm
aW5lIFBBRF9SWERMWV9TRUwgICAgICAgICAgICgweDEgPDwgMCkgICAgICAvKiBSVyAqLw0KICNk
ZWZpbmUgREVMQVlfRU4gICAgICAgICAgICAgICAgKDB4MSA8PCAxKSAgICAgIC8qIFJXICovDQpA
QCAtMjI3Niw2ICsyMjkwLDMxIEBAIHN0YXRpYyBpbnQgbXNkY19nZXRfY2Qoc3RydWN0IG1tY19o
b3N0ICptbWMpDQogCQlyZXR1cm4gIXZhbDsNCiB9DQogDQorc3RhdGljIHZvaWQgbXNkY19oczQw
MF9lbmhhbmNlZF9zdHJvYmUoc3RydWN0IG1tY19ob3N0ICptbWMsDQorCQkJCSAgICAgICBzdHJ1
Y3QgbW1jX2lvcyAqaW9zKQ0KK3sNCisJc3RydWN0IG1zZGNfaG9zdCAqaG9zdCA9IG1tY19wcml2
KG1tYyk7DQorDQorCWlmIChpb3MtPmVuaGFuY2VkX3N0cm9iZSkgew0KKwkJbXNkY19wcmVwYXJl
X2hzNDAwX3R1bmluZyhtbWMsIGlvcyk7DQorCQlzZHJfc2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBF
TU1DNTBfQ0ZHMCwgRU1NQzUwX0NGR19QQURDTURfTEFUQ0hDSywgMSk7DQorCQlzZHJfc2V0X2Zp
ZWxkKGhvc3QtPmJhc2UgKyBFTU1DNTBfQ0ZHMCwgRU1NQzUwX0NGR19DTURfUkVTUF9TRUwsIDEp
Ow0KKwkJc2RyX3NldF9maWVsZChob3N0LT5iYXNlICsgRU1NQzUwX0NGRzEsIEVNTUM1MF9DRkcx
X0RTX0NGRywgMSk7DQorDQorCQlzZHJfY2xyX2JpdHMoaG9zdC0+YmFzZSArIENRSENJX1NFVFRJ
TkcsIENRSENJX1JEX0NNRF9XTkRfU0VMKTsNCisJCXNkcl9jbHJfYml0cyhob3N0LT5iYXNlICsg
Q1FIQ0lfU0VUVElORywgQ1FIQ0lfV1JfQ01EX1dORF9TRUwpOw0KKwkJc2RyX2Nscl9iaXRzKGhv
c3QtPmJhc2UgKyBFTU1DNTFfQ0ZHMCwgQ01EUV9SREFUX0NOVCk7DQorCX0gZWxzZSB7DQorCQlz
ZHJfc2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBFTU1DNTBfQ0ZHMCwgRU1NQzUwX0NGR19QQURDTURf
TEFUQ0hDSywgMCk7DQorCQlzZHJfc2V0X2ZpZWxkKGhvc3QtPmJhc2UgKyBFTU1DNTBfQ0ZHMCwg
RU1NQzUwX0NGR19DTURfUkVTUF9TRUwsIDApOw0KKwkJc2RyX3NldF9maWVsZChob3N0LT5iYXNl
ICsgRU1NQzUwX0NGRzEsIEVNTUM1MF9DRkcxX0RTX0NGRywgMCk7DQorDQorCQlzZHJfc2V0X2Jp
dHMoaG9zdC0+YmFzZSArIENRSENJX1NFVFRJTkcsIENRSENJX1JEX0NNRF9XTkRfU0VMKTsNCisJ
CXNkcl9zZXRfYml0cyhob3N0LT5iYXNlICsgQ1FIQ0lfU0VUVElORywgQ1FIQ0lfV1JfQ01EX1dO
RF9TRUwpOw0KKwkJc2RyX3NldF9maWVsZChob3N0LT5iYXNlICsgRU1NQzUxX0NGRzAsIENNRFFf
UkRBVF9DTlQsIDB4YjQpOw0KKwl9DQorfQ0KKw0KIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2VuYWJs
ZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYykNCiB7DQogCXN0cnVjdCBtc2RjX2hvc3QgKmhvc3QgPSBt
bWNfcHJpdihtbWMpOw0KQEAgLTIzMzMsNiArMjM3Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bW1jX2hvc3Rfb3BzIG10X21zZGNfb3BzID0gew0KIAkuc2V0X2lvcyA9IG1zZGNfb3BzX3NldF9p
b3MsDQogCS5nZXRfcm8gPSBtbWNfZ3Bpb19nZXRfcm8sDQogCS5nZXRfY2QgPSBtc2RjX2dldF9j
ZCwNCisJLmhzNDAwX2VuaGFuY2VkX3N0cm9iZSA9IG1zZGNfaHM0MDBfZW5oYW5jZWRfc3Ryb2Jl
LA0KIAkuZW5hYmxlX3NkaW9faXJxID0gbXNkY19lbmFibGVfc2Rpb19pcnEsDQogCS5hY2tfc2Rp
b19pcnEgPSBtc2RjX2Fja19zZGlvX2lycSwNCiAJLnN0YXJ0X3NpZ25hbF92b2x0YWdlX3N3aXRj
aCA9IG1zZGNfb3BzX3N3aXRjaF92b2x0LA0KLS0gDQoyLjE4LjANCg==

