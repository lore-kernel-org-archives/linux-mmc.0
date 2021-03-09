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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D97C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6540565279
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 02:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhCICGV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 21:06:21 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:34275 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229589AbhCICFz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 21:05:55 -0500
X-UUID: 342e29057a7b41cf9ea0c6426665079a-20210309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=doRoKT02YmY9yqkI9WdPTo7R96qFnA9sunseZ8/VHqs=;
        b=pHmY/QvbKDhP+TJPzicfKjNWc6HzwpLw2EpCBkksBkkXVq2mIo1cKNwIYwhaYWp7cSmfybefoRKOsXeyvSgFAsnhic8zphaEXUUXtvFJwZhMbVfbmJdb0ur/W/i1JU0ANym/tB8XBiBH0VxvCVeorK3t1lRP5EVYzb0cLO3ZSSs=;
X-UUID: 342e29057a7b41cf9ea0c6426665079a-20210309
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 833173208; Tue, 09 Mar 2021 10:05:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS32N1.mediatek.inc (172.27.4.71) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 10:05:47 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Mar 2021 10:05:46 +0800
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
Subject: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
Date:   Tue, 9 Mar 2021 09:57:51 +0800
Message-ID: <20210309015750.6283-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5ED153600B6D794E3DDF85777173329FED72E2B9C6542A1C7C67AE0CBB0AA6132000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VXNlIFNNQyBjYWxsIGVuYWJsZSBoYXJkd2FyZSBjcnlwdG8gZW5naW5lDQpkdWUgdG8gaXQgb25s
eSBiZSBjaGFuZ2VkIGluIEFURihFTDMpLg0KDQpTaWduZWQtb2ZmLWJ5OiBQZW5nIFpob3UgPHBl
bmcuemhvdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwg
MjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2
ZXJzL21tYy9ob3N0L210ay1zZC5jDQppbmRleCAxYzkwMzYwZDZjZjIuLjIyNWVmNTUxOTE2MSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCisrKyBiL2RyaXZlcnMvbW1j
L2hvc3QvbXRrLXNkLmMNCkBAIC00LDYgKzQsNyBAQA0KICAqIEF1dGhvcjogQ2hhb3RpYW4uSmlu
ZyA8Y2hhb3RpYW4uamluZ0BtZWRpYXRlay5jb20+DQogICovDQogDQorI2luY2x1ZGUgPGxpbnV4
L2FybS1zbWNjYy5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvY2xrLmg+DQogI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQpAQCAtMjAsNiArMjEsNyBAQA0K
ICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQogI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRv
ci9jb25zdW1lci5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQorI2luY2x1ZGUgPGxpbnV4
L3NvYy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5oPg0KICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5o
Pg0KICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCiAjaW5jbHVkZSA8bGludXgvcmVzZXQu
aD4NCkBAIC0zMTksNiArMzIxLDEyIEBADQogI2RlZmluZSBERUZBVUxUX0RFQk9VTkNFCSg4KQkv
KiA4IGN5Y2xlcyBDRCBkZWJvdW5jZSAqLw0KIA0KICNkZWZpbmUgUEFEX0RFTEFZX01BWAkzMiAv
KiBQQUQgZGVsYXkgY2VsbHMgKi8NCisNCisvKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8NCisvKiBTaVAg
Y29tbWFuZHMgd2hpY2ggdXNlZCBmb3IgY3J5cHRvICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKi8NCisvKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8NCisjZGVmaW5lIE1US19TSVBf
TU1DX0NPTlRST0wgICAgICAgICAgICAgICBNVEtfU0lQX1NNQ19DTUQoMHgyNzMpDQorDQogLyot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSovDQogLyogRGVzY3JpcHRvciBTdHJ1Y3R1cmUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQogLyotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSovDQpAQCAtMjQ2Nyw2ICsyNDc1LDcgQEAgc3RhdGljIGludCBtc2RjX29mX2Nsb2Nr
X3BhcnNlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogDQogc3RhdGljIGludCBtc2Rj
X2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCisJc3RydWN0IGFy
bV9zbWNjY19yZXMgc21jY2NfcmVzOw0KIAlzdHJ1Y3QgbW1jX2hvc3QgKm1tYzsNCiAJc3RydWN0
IG1zZGNfaG9zdCAqaG9zdDsNCiAJc3RydWN0IHJlc291cmNlICpyZXM7DQpAQCAtMjYxNiw2ICsy
NjI1LDE1IEBAIHN0YXRpYyBpbnQgbXNkY19kcnZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCiAJCW1tYy0+bWF4X3NlZ19zaXplID0gNjQgKiAxMDI0Ow0KIAl9DQogDQorCS8q
DQorCSAqIDE6IE1TRENfQUVTX0NUTF9JTklUDQorCSAqIDQ6IGNhcF9pZCwgbm8tbWVhbmluZyBu
b3cNCisJICogMTogY2ZnX2lkLCB3ZSBjaG9vc2UgdGhlIHNlY29uZCBjZmcgZ3JvdXANCisJICov
DQorCWlmIChtbWMtPmNhcHMyICYgTU1DX0NBUDJfQ1JZUFRPKQ0KKwkJYXJtX3NtY2NjX3NtYyhN
VEtfU0lQX01NQ19DT05UUk9MLA0KKwkJCSAgICAgIDEsIDQsIDEsIDAsIDAsIDAsIDAsICZzbWNj
Y19yZXMpOw0KKw0KIAlob3N0LT50aW1lb3V0X2Nsa3MgPSAzICogMTA0ODU3NjsNCiAJaG9zdC0+
ZG1hLmdwZCA9IGRtYV9hbGxvY19jb2hlcmVudCgmcGRldi0+ZGV2LA0KIAkJCQkyICogc2l6ZW9m
KHN0cnVjdCBtdF9ncGRtYV9kZXNjKSwNCkBAIC0yNzcwLDkgKzI3ODgsMTggQEAgc3RhdGljIGlu
dCBfX21heWJlX3VudXNlZCBtc2RjX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikN
CiB7DQogCXN0cnVjdCBtbWNfaG9zdCAqbW1jID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogCXN0
cnVjdCBtc2RjX2hvc3QgKmhvc3QgPSBtbWNfcHJpdihtbWMpOw0KKwlzdHJ1Y3QgYXJtX3NtY2Nj
X3JlcyBzbWNjY19yZXM7DQogDQogCW1zZGNfdW5nYXRlX2Nsb2NrKGhvc3QpOw0KIAltc2RjX3Jl
c3RvcmVfcmVnKGhvc3QpOw0KKwkvKg0KKwkgKiAxOiBNU0RDX0FFU19DVExfSU5JVA0KKwkgKiA0
OiBjYXBfaWQsIG5vLW1lYW5pbmcgbm93DQorCSAqIDE6IGNmZ19pZCwgd2UgY2hvb3NlIHRoZSBz
ZWNvbmQgY2ZnIGdyb3VwDQorCSAqLw0KKwlpZiAobW1jLT5jYXBzMiAmIE1NQ19DQVAyX0NSWVBU
TykNCisJCWFybV9zbWNjY19zbWMoTVRLX1NJUF9NTUNfQ09OVFJPTCwNCisJCQkgICAgICAxLCA0
LCAxLCAwLCAwLCAwLCAwLCAmc21jY2NfcmVzKTsNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLS0gDQoy
LjE4LjANCg==

