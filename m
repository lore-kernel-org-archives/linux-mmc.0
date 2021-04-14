Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E786C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F1761179
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 08:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhDNIEp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:04:45 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:35027 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349874AbhDNIDl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 04:03:41 -0400
X-UUID: 45493331e40a4b0a8e1b529b5d487ff1-20210414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Hpwqjcm1M1fUszYBmuKA6AHdWJpWu3Z0WvE7fIJhTIA=;
        b=MPN+rL3ClT6i5cJhfIELyUjYHAlU50hjdGXJpf2+sPGSzQWhgVaQqaVGzLtjHt6pz7j2Wnm1bkmijXRz2kp5VY2VVb0YrwisKeEEhI8HLOb8ZmWJUAVsAHHV8cJPxNE6dYS4ckH9nSe8zDipkQXDaSI77kQrYRzh9qdAd42ZJHc=;
X-UUID: 45493331e40a4b0a8e1b529b5d487ff1-20210414
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2036787193; Wed, 14 Apr 2021 16:03:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS32N2.mediatek.inc (172.27.4.72) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 16:03:09 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 16:03:08 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        <devicetree@vger.kernel.org>, Peng Zhou <Peng.Zhou@mediatek.com>
Subject: [PATCH 1/3] [PATCH v3 1/3] mmc: Mediatek: add Inline Crypto Engine support
Date:   Wed, 14 Apr 2021 15:50:58 +0800
Message-ID: <20210414075059.3086-2-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210414075059.3086-1-peng.zhou@mediatek.com>
References: <20210414075059.3086-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-SNTS-SMTP: C3F0783E2B42DF35CBD2D413A6FCF0CEDFA4980034D8178B59E62E82DDA7EBDC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogUGVuZyBaaG91IDxQZW5nLlpob3VAbWVkaWF0ZWsuY29tPg0KDQoxLiBhZGQgY3J5cHRv
IGNsb2NrIGNvbnRyb2wgYW5kIHVuZ2F0ZSBpdCBiZWZvcmUgQ1FIQ0kgaW5pdA0KMi4gc2V0IE1N
Q19DQVAyX0NSWVBUTyBwcm9wZXJ0eSBvZiBlTU1DDQoNCkNoYW5nZS1JZDogSWNkYzQxNTMyZDM4
M2YwOTU1YTNiMmI3OThhMGRjZTU4NzBjZWI4NTkNClNpZ25lZC1vZmYtYnk6IFBlbmcgWmhvdSA8
UGVuZy5aaG91QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMg
fCAxNSArKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyBi
L2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCmluZGV4IDg5OGVkMWIwMjNkZi4uMWM5MDM2MGQ2
Y2YyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYw0KQEAgLTQ0Miw2ICs0NDIsNyBAQCBzdHJ1Y3QgbXNkY19ob3N0
IHsNCiAJc3RydWN0IGNsayAqc3JjX2Nsa19jZzsgLyogbXNkYyBzb3VyY2UgY2xvY2sgY29udHJv
bCBnYXRlICovDQogCXN0cnVjdCBjbGsgKnN5c19jbGtfY2c7CS8qIG1zZGMgc3Vic3lzIGNsb2Nr
IGNvbnRyb2wgZ2F0ZSAqLw0KIAlzdHJ1Y3QgY2xrX2J1bGtfZGF0YSBidWxrX2Nsa3NbTVNEQ19O
Ul9DTE9DS1NdOw0KKwlzdHJ1Y3QgY2xrICpjcnlwdG9fY2xrOyAvKiBtc2RjIGNyeXB0byBjbG9j
ayAqLw0KIAl1MzIgbWNsazsJCS8qIG1tYyBzdWJzeXN0ZW0gY2xvY2sgZnJlcXVlbmN5ICovDQog
CXUzMiBzcmNfY2xrX2ZyZXE7CS8qIHNvdXJjZSBjbG9jayBmcmVxdWVuY3kgKi8NCiAJdW5zaWdu
ZWQgY2hhciB0aW1pbmc7DQpAQCAtODAyLDYgKzgwMyw3IEBAIHN0YXRpYyB2b2lkIG1zZGNfc2V0
X2J1c3lfdGltZW91dChzdHJ1Y3QgbXNkY19ob3N0ICpob3N0LCB1NjQgbnMsIHU2NCBjbGtzKQ0K
IA0KIHN0YXRpYyB2b2lkIG1zZGNfZ2F0ZV9jbG9jayhzdHJ1Y3QgbXNkY19ob3N0ICpob3N0KQ0K
IHsNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhvc3QtPmNyeXB0b19jbGspOw0KIAljbGtfYnVs
a19kaXNhYmxlX3VucHJlcGFyZShNU0RDX05SX0NMT0NLUywgaG9zdC0+YnVsa19jbGtzKTsNCiAJ
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhvc3QtPnNyY19jbGtfY2cpOw0KIAljbGtfZGlzYWJsZV91
bnByZXBhcmUoaG9zdC0+c3JjX2Nsayk7DQpAQCAtODIyLDYgKzgyNCw3IEBAIHN0YXRpYyB2b2lk
IG1zZGNfdW5nYXRlX2Nsb2NrKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QpDQogCQlkZXZfZXJyKGhv
c3QtPmRldiwgIkNhbm5vdCBlbmFibGUgcGNsay9heGkvYWhiIGNsb2NrIGdhdGVzXG4iKTsNCiAJ
CXJldHVybjsNCiAJfQ0KKwljbGtfcHJlcGFyZV9lbmFibGUoaG9zdC0+Y3J5cHRvX2Nsayk7DQog
DQogCXdoaWxlICghKHJlYWRsKGhvc3QtPmJhc2UgKyBNU0RDX0NGRykgJiBNU0RDX0NGR19DS1NU
QikpDQogCQljcHVfcmVsYXgoKTsNCkBAIC0yNTEyLDYgKzI1MTUsMTUgQEAgc3RhdGljIGludCBt
c2RjX2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJZ290byBob3N0
X2ZyZWU7DQogCX0NCiANCisJLyogb25seSBlTU1DIGhhcyBjcnlwdG8gcHJvcGVydHkgKi8NCisJ
aWYgKChtbWMtPmNhcHMyICYgTU1DX0NBUDJfTk9fU0QpICYmIChtbWMtPmNhcHMyICYgTU1DX0NB
UDJfTk9fU0RJTykpIHsNCisJCWhvc3QtPmNyeXB0b19jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYt
PmRldiwgImNyeXB0byIpOw0KKwkJaWYgKElTX0VSUihob3N0LT5jcnlwdG9fY2xrKSkNCisJCQlo
b3N0LT5jcnlwdG9fY2xrID0gTlVMTDsNCisJCWVsc2UNCisJCQltbWMtPmNhcHMyIHw9IE1NQ19D
QVAyX0NSWVBUTzsNCisJfQ0KKw0KIAlob3N0LT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYs
IDApOw0KIAlpZiAoaG9zdC0+aXJxIDwgMCkgew0KIAkJcmV0ID0gLUVJTlZBTDsNCkBAIC0yNTgy
LDYgKzI1OTQsOCBAQCBzdGF0aWMgaW50IG1zZGNfZHJ2X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogCQlob3N0LT5kbWFfbWFzayA9IERNQV9CSVRfTUFTSygzMik7DQogCW1t
Y19kZXYobW1jKS0+ZG1hX21hc2sgPSAmaG9zdC0+ZG1hX21hc2s7DQogDQorCS8qIGhlcmUgdW5n
YXRlIGR1ZSB0byBjcWhjaSBpbml0IHdpbGwgYWNjZXNzIHJlZ2lzdGVycyAqLw0KKwltc2RjX3Vu
Z2F0ZV9jbG9jayhob3N0KTsNCiAJaWYgKG1tYy0+Y2FwczIgJiBNTUNfQ0FQMl9DUUUpIHsNCiAJ
CWhvc3QtPmNxX2hvc3QgPSBkZXZtX2t6YWxsb2MobW1jLT5wYXJlbnQsDQogCQkJCQkgICAgIHNp
emVvZigqaG9zdC0+Y3FfaG9zdCksDQpAQCAtMjYxOCw3ICsyNjMyLDYgQEAgc3RhdGljIGludCBt
c2RjX2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlzcGluX2xvY2tf
aW5pdCgmaG9zdC0+bG9jayk7DQogDQogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIG1tYyk7
DQotCW1zZGNfdW5nYXRlX2Nsb2NrKGhvc3QpOw0KIAltc2RjX2luaXRfaHcoaG9zdCk7DQogDQog
CXJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaG9zdC0+aXJxLCBtc2RjX2lycSwN
Ci0tIA0KMi4xOC4wDQo=

