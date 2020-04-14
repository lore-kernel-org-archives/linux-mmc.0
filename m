Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680D9C2BB85
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 03:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C7A206C0
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 03:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qMawx4L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404885AbgDNDk7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:40:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9307 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404876AbgDNDk7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Apr 2020 23:40:59 -0400
X-UUID: b47fd18de3554a16b50955e8fdc3d0e0-20200414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JsY5/5MxfWy5R02rcWXL2W12h0vpsAqE2P25DGsOcwQ=;
        b=qMawx4L1R/SjXIumd+N18jT98mhib9GBHE/6xKN4SzsESCYRKHzRFy2RFV/S12IkcmRMtOP8nuA40Yr4WSdE1IqQrgFlKhNQXzUB0F78b2+qDR+6rcKIBXyD4YvKtI9zOZ1r+tTLDm5AIXe9awqXheBy1WtQ/Qr88X2Bb4VKYGQ=;
X-UUID: b47fd18de3554a16b50955e8fdc3d0e0-20200414
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 903558651; Tue, 14 Apr 2020 11:40:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Apr 2020 11:40:55 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Apr 2020 11:40:49 +0800
From:   Yong Mao <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        yong mao <yong.mao@mediatek.com>
Subject: [PATCH 2/3] mmc: core: rocr verification
Date:   Tue, 14 Apr 2020 11:40:10 +0800
Message-ID: <1586835611-13857-3-git-send-email-yong.mao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogeW9uZyBtYW8gPHlvbmcubWFvQG1lZGlhdGVrLmNvbT4NCg0KU29tZSBVSFMgU0RJTyBk
ZXZpY2VzIGNhbid0IGVudGVyIHRvIHN0YWJsZSBzdGF0ZSBhZnRlciBjaGFuZ2luZyB0aGUNCnZv
bHRhZ2UgZnJvbSAxLjh2IHRvIDMuM3YgZXZlbiBhZnRlciBhIHBvd2VyIGN5Y2xlLg0KVmVyaWZ5
aW5nIHRoZSByb2NyIGFuZCB0aGUgcmVzdWx0IG9mIG1tY19zZXRfc2lnbmFsX3ZvbHRhZ2UsIGlm
IGl0DQppcyBub3QgZXhwZWN0ZWQsIHBvd2VyIGN5Y2xlIFNESU8gZGV2aWNlIGFuZCByZS1pbml0
aWFsaXplIGl0IGFnYWluLg0KVGh1cyB3aWxsIHJlLWluaXRpYWxpemUgdGhlIFNESU8gZGV2aWNl
IHN1Y2Nlc3NmdWxseS4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBNYW8gPHlvbmcubWFvQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbW1jL2NvcmUvc2Rpby5jICB8IDE0ICsrKysrKysrKysr
KystDQogaW5jbHVkZS9saW51eC9tbWMvc2Rpby5oIHwgIDIgKysNCiAyIGZpbGVzIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bW1jL2NvcmUvc2Rpby5jIGIvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMNCmluZGV4IGFkYTBhODAu
LmYxNzNjYWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21tYy9jb3JlL3NkaW8uYw0KKysrIGIvZHJp
dmVycy9tbWMvY29yZS9zZGlvLmMNCkBAIC01NTMsNiArNTUzLDEyIEBAIHN0YXRpYyB2b2lkIG1t
Y19zZGlvX3Jlc2VuZF9pZl9jb25kKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwNCiAJbW1jX3JlbW92
ZV9jYXJkKGNhcmQpOw0KIH0NCiANCitzdGF0aWMgYm9vbCBtbWNfc2Rpb192YWxpZF9yb2NyKHUz
MiByb2NyKQ0KK3sNCisJcmV0dXJuIChyb2NyICYgTU1DX0NBUkRfQlVTWSkgJiYgUjRfT0NSKHJv
Y3IpICYmDQorCQlSNF9GVU5DVElPTl9OVU1CRVIocm9jcik7DQorfQ0KKw0KIC8qDQogICogSGFu
ZGxlIHRoZSBkZXRlY3Rpb24gYW5kIGluaXRpYWxpc2F0aW9uIG9mIGEgY2FyZC4NCiAgKg0KQEAg
LTYwNSw2ICs2MTEsMTIgQEAgc3RhdGljIGludCBtbWNfc2Rpb19pbml0X2NhcmQoc3RydWN0IG1t
Y19ob3N0ICpob3N0LCB1MzIgb2NyLA0KIAkJZ290byBlcnI7DQogCX0NCiANCisJaWYgKCFtbWNf
c2Rpb192YWxpZF9yb2NyKHJvY3IpKSB7DQorCQltbWNfc2Rpb19yZXNlbmRfaWZfY29uZChob3N0
LCBjYXJkKTsNCisJCXJldHJpZXMtLTsNCisJCWdvdG8gdHJ5X2FnYWluOw0KKwl9DQorDQogCWlm
ICgocm9jciAmIFI0X01FTU9SWV9QUkVTRU5UKSAmJg0KIAkgICAgbW1jX3NkX2dldF9jaWQoaG9z
dCwgb2NyICYgcm9jciwgY2FyZC0+cmF3X2NpZCwgTlVMTCkgPT0gMCkgew0KIAkJY2FyZC0+dHlw
ZSA9IE1NQ19UWVBFX1NEX0NPTUJPOw0KQEAgLTY0Niw3ICs2NTgsNyBAQCBzdGF0aWMgaW50IG1t
Y19zZGlvX2luaXRfY2FyZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHUzMiBvY3IsDQogCSAqLw0K
IAlpZiAocm9jciAmIG9jciAmIFI0XzE4Vl9QUkVTRU5UKSB7DQogCQllcnIgPSBtbWNfc2V0X3Vo
c192b2x0YWdlKGhvc3QsIG9jcl9jYXJkKTsNCi0JCWlmIChlcnIgPT0gLUVBR0FJTikgew0KKwkJ
aWYgKGVyciA9PSAtRUFHQUlOIHx8IGVyciA9PSAtRUlMU0VRKSB7DQogCQkJbW1jX3NkaW9fcmVz
ZW5kX2lmX2NvbmQoaG9zdCwgY2FyZCk7DQogCQkJcmV0cmllcy0tOw0KIAkJCWdvdG8gdHJ5X2Fn
YWluOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1jL3NkaW8uaCBiL2luY2x1ZGUvbGlu
dXgvbW1jL3NkaW8uaA0KaW5kZXggZTI4NzY5OS4uMDNlMjNlYyAxMDA2NDQNCi0tLSBhL2luY2x1
ZGUvbGludXgvbW1jL3NkaW8uaA0KKysrIGIvaW5jbHVkZS9saW51eC9tbWMvc2Rpby5oDQpAQCAt
MzYsNiArMzYsOCBAQA0KIA0KICNkZWZpbmUgUjRfMThWX1BSRVNFTlQgKDE8PDI0KQ0KICNkZWZp
bmUgUjRfTUVNT1JZX1BSRVNFTlQgKDEgPDwgMjcpDQorI2RlZmluZSBSNF9PQ1IoeCkJCSgoeCkg
JiAweEZGRkZGRikNCisjZGVmaW5lIFI0X0ZVTkNUSU9OX05VTUJFUih4KQkoKCh4KSAmIDB4NzAw
MDAwMDApID4+IDI4KQ0KIA0KIC8qDQogICBTRElPIHN0YXR1cyBpbiBSNQ0KLS0gDQoxLjkuMQ0K

