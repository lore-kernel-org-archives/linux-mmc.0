Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578F3C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2859C65275
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCICDh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 21:03:37 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12553 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229599AbhCICDP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 21:03:15 -0500
X-UUID: f1a1631979494e4a9c3ff725eac0047c-20210309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GHimRaOC71RSNbGuagso1lszaY2rAEKkA2iWwga1OUA=;
        b=DkbLBx62p+DUmfZjd9unLVU9Eoivsd2ccjrbs1kJhLkwMmSsVTRW9Y7pvYUqvyjVx74f2hgffEo8PbNEDfyCFXrWx9+BWxjZuWmyiwdEybqAjWcw1xdrMFXQH6262C0In+J5GkjTjlBWghHtyyLRFLWdQQxhkdXacew33yJ2TK8=;
X-UUID: f1a1631979494e4a9c3ff725eac0047c-20210309
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1053870782; Tue, 09 Mar 2021 10:03:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS32N1.mediatek.inc (172.27.4.71) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 10:03:07 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Mar 2021 10:03:07 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>
Subject: [PATCH v2 1/4] mmc: Mediatek: add Inline Crypto Engine support
Date:   Tue, 9 Mar 2021 09:56:31 +0800
Message-ID: <20210309015630.19545-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 72253740D4C894CDB5A5941B85B082B1A76D6075D1C986720227B05D1B8E5AA52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

MS4gYWRkIGNyeXB0byBjbG9jayBjb250cm9sIGFuZCB1bmdhdGUgaXQgYmVmb3JlIENRSENJIGlu
aXQNCg0KMi4gc2V0IE1NQ19DQVAyX0NSWVBUTyBwcm9wZXJ0eSBvZiBlTU1DDQoNClNpZ25lZC1v
ZmYtYnk6IFBlbmcgWmhvdSA8cGVuZy56aG91QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
bW1jL2hvc3QvbXRrLXNkLmMgfCAxNSArKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9tdGstc2QuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCmluZGV4IDg5OGVk
MWIwMjNkZi4uMWM5MDM2MGQ2Y2YyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGst
c2QuYw0KKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KQEAgLTQ0Miw2ICs0NDIsNyBA
QCBzdHJ1Y3QgbXNkY19ob3N0IHsNCiAJc3RydWN0IGNsayAqc3JjX2Nsa19jZzsgLyogbXNkYyBz
b3VyY2UgY2xvY2sgY29udHJvbCBnYXRlICovDQogCXN0cnVjdCBjbGsgKnN5c19jbGtfY2c7CS8q
IG1zZGMgc3Vic3lzIGNsb2NrIGNvbnRyb2wgZ2F0ZSAqLw0KIAlzdHJ1Y3QgY2xrX2J1bGtfZGF0
YSBidWxrX2Nsa3NbTVNEQ19OUl9DTE9DS1NdOw0KKwlzdHJ1Y3QgY2xrICpjcnlwdG9fY2xrOyAv
KiBtc2RjIGNyeXB0byBjbG9jayAqLw0KIAl1MzIgbWNsazsJCS8qIG1tYyBzdWJzeXN0ZW0gY2xv
Y2sgZnJlcXVlbmN5ICovDQogCXUzMiBzcmNfY2xrX2ZyZXE7CS8qIHNvdXJjZSBjbG9jayBmcmVx
dWVuY3kgKi8NCiAJdW5zaWduZWQgY2hhciB0aW1pbmc7DQpAQCAtODAyLDYgKzgwMyw3IEBAIHN0
YXRpYyB2b2lkIG1zZGNfc2V0X2J1c3lfdGltZW91dChzdHJ1Y3QgbXNkY19ob3N0ICpob3N0LCB1
NjQgbnMsIHU2NCBjbGtzKQ0KIA0KIHN0YXRpYyB2b2lkIG1zZGNfZ2F0ZV9jbG9jayhzdHJ1Y3Qg
bXNkY19ob3N0ICpob3N0KQ0KIHsNCisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhvc3QtPmNyeXB0
b19jbGspOw0KIAljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShNU0RDX05SX0NMT0NLUywgaG9z
dC0+YnVsa19jbGtzKTsNCiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhvc3QtPnNyY19jbGtfY2cp
Ow0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoaG9zdC0+c3JjX2Nsayk7DQpAQCAtODIyLDYgKzgy
NCw3IEBAIHN0YXRpYyB2b2lkIG1zZGNfdW5nYXRlX2Nsb2NrKHN0cnVjdCBtc2RjX2hvc3QgKmhv
c3QpDQogCQlkZXZfZXJyKGhvc3QtPmRldiwgIkNhbm5vdCBlbmFibGUgcGNsay9heGkvYWhiIGNs
b2NrIGdhdGVzXG4iKTsNCiAJCXJldHVybjsNCiAJfQ0KKwljbGtfcHJlcGFyZV9lbmFibGUoaG9z
dC0+Y3J5cHRvX2Nsayk7DQogDQogCXdoaWxlICghKHJlYWRsKGhvc3QtPmJhc2UgKyBNU0RDX0NG
RykgJiBNU0RDX0NGR19DS1NUQikpDQogCQljcHVfcmVsYXgoKTsNCkBAIC0yNTEyLDYgKzI1MTUs
MTUgQEAgc3RhdGljIGludCBtc2RjX2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIAkJZ290byBob3N0X2ZyZWU7DQogCX0NCiANCisJLyogb25seSBlTU1DIGhhcyBjcnlw
dG8gcHJvcGVydHkgKi8NCisJaWYgKChtbWMtPmNhcHMyICYgTU1DX0NBUDJfTk9fU0QpICYmICht
bWMtPmNhcHMyICYgTU1DX0NBUDJfTk9fU0RJTykpIHsNCisJCWhvc3QtPmNyeXB0b19jbGsgPSBk
ZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImNyeXB0byIpOw0KKwkJaWYgKElTX0VSUihob3N0LT5j
cnlwdG9fY2xrKSkNCisJCQlob3N0LT5jcnlwdG9fY2xrID0gTlVMTDsNCisJCWVsc2UNCisJCQlt
bWMtPmNhcHMyIHw9IE1NQ19DQVAyX0NSWVBUTzsNCisJfQ0KKw0KIAlob3N0LT5pcnEgPSBwbGF0
Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KIAlpZiAoaG9zdC0+aXJxIDwgMCkgew0KIAkJcmV0ID0g
LUVJTlZBTDsNCkBAIC0yNTgyLDYgKzI1OTQsOCBAQCBzdGF0aWMgaW50IG1zZGNfZHJ2X3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlob3N0LT5kbWFfbWFzayA9IERNQV9C
SVRfTUFTSygzMik7DQogCW1tY19kZXYobW1jKS0+ZG1hX21hc2sgPSAmaG9zdC0+ZG1hX21hc2s7
DQogDQorCS8qIGhlcmUgdW5nYXRlIGR1ZSB0byBjcWhjaSBpbml0IHdpbGwgYWNjZXNzIHJlZ2lz
dGVycyAqLw0KKwltc2RjX3VuZ2F0ZV9jbG9jayhob3N0KTsNCiAJaWYgKG1tYy0+Y2FwczIgJiBN
TUNfQ0FQMl9DUUUpIHsNCiAJCWhvc3QtPmNxX2hvc3QgPSBkZXZtX2t6YWxsb2MobW1jLT5wYXJl
bnQsDQogCQkJCQkgICAgIHNpemVvZigqaG9zdC0+Y3FfaG9zdCksDQpAQCAtMjYxOCw3ICsyNjMy
LDYgQEAgc3RhdGljIGludCBtc2RjX2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIAlzcGluX2xvY2tfaW5pdCgmaG9zdC0+bG9jayk7DQogDQogCXBsYXRmb3JtX3NldF9k
cnZkYXRhKHBkZXYsIG1tYyk7DQotCW1zZGNfdW5nYXRlX2Nsb2NrKGhvc3QpOw0KIAltc2RjX2lu
aXRfaHcoaG9zdCk7DQogDQogCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaG9z
dC0+aXJxLCBtc2RjX2lycSwNCi0tIA0KMi4xOC4wDQo=

