Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8A5C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 12:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30D42073D
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 12:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LVKCFza6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLJMDq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:03:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33261 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727398AbfLJMDq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 07:03:46 -0500
X-UUID: 42ddcc08682a4bf1b96141fa4e928936-20191210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2INHnv89DngP2q6S6QSycxepChudtOI9fx0i3gt9NlY=;
        b=LVKCFza6ucdjA7jR+uQLT74Cl22YZro8IyNdueS+2CZEtspmhrN/HJWgSWUwZ+xzH8K9xGP2+0ylpfMJNxcR23vKSf2tGPoo7gQic62mQJVB3qjIYt3wE2estBHW2OJYLN+FXa7hOACaK0ETs/rDUKBnErmM3rdDMEiUbH17BNA=;
X-UUID: 42ddcc08682a4bf1b96141fa4e928936-20191210
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1116796004; Tue, 10 Dec 2019 20:03:41 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs07n1.mediatek.inc
 (172.21.101.16) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 10 Dec
 2019 20:03:32 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Dec 2019 20:03:29 +0800
Message-ID: <1575979419.7714.1.camel@mhfsdcap03>
Subject: Re: [PATCH] mmc: mediatek: fix CMD_TA to 2 for MT8173 HS200/HS400
 mode
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, <hsinyi@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 10 Dec 2019 20:03:39 +0800
In-Reply-To: <CAPDyKFo9Z2yj7zC5VOS-iX_LyavPp1A4n73eAp7VD-Q+dpoqpw@mail.gmail.com>
References: <20191204071958.18553-1-chaotian.jing@mediatek.com>
         <CAPDyKFo9Z2yj7zC5VOS-iX_LyavPp1A4n73eAp7VD-Q+dpoqpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTEwIGF0IDEwOjUxICswMTAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gV2VkLCA0IERlYyAyMDE5IGF0IDA4OjIwLCBDaGFvdGlhbiBKaW5nIDxjaGFvdGlhbi5qaW5n
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiB0aGVyZSBpcyBhIGNoYW5jZSB0aGF0IGFs
d2F5cyBnZXQgcmVzcG9uc2UgQ1JDIGVycm9yIGFmdGVyIEhTMjAwIHR1bmluZywNCj4gPiB0aGUg
cmVhc29uIGlzIHRoYXQgbmVlZCBzZXQgQ01EX1RBIHRvIDIuIHRoaXMgbW9kaWZpY2F0aW9uIGlz
IG9ubHkgZm9yDQo+ID4gTVQ4MTczLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hhb3RpYW4g
SmluZyA8Y2hhb3RpYW4uamluZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBJIGhhdmUgYXBwbGllZCB0
aGlzIGZvciBmaXhlcywgaG93ZXZlciBpdCBzZWVtcyBsaWtlIHRoaXMgc2hvdWxkIGFsc28NCj4g
YmUgdGFnZ2VkIGZvciBzdGFibGUsIHJpZ2h0Pw0KPiBZZXMhIHNob3VsZCBiZSB0YWdnZWQgZm9y
IHN0YWJsZS4NCj4gSXMgdGhlcmUgYSBzcGVjaWZpYyBjb21taXQgdGhpcyBmaXhlcyBvciBzaG91
bGQgd2UganVzdCBmaW5kIHRoZQ0KPiB2ZXJzaW9uIGl0IGFwcGxpZXMgdG8/DQo+IA0KIHRoaXMg
cGF0Y2ggc2hvdWxkIGJlIGEgZml4IHRvIGNvbW1pdDoNCjFlZGU1Y2I4OGEyOWJiYTFhYWQxYjY4
OTY1YzVmYzhlMDBiMjBlZDkNCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCj4gDQo+IA0KPiANCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDIgKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ID4gaW5kZXgg
MTg5ZTQyNjc0ZDg1Li4wMTBmZTI5YTQ4ODggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMv
aG9zdC9tdGstc2QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiBA
QCAtMjI4LDYgKzIyOCw3IEBADQo+ID4gICNkZWZpbmUgTVNEQ19QQVRDSF9CSVRfU1BDUFVTSCAg
ICAoMHgxIDw8IDI5KSAgLyogUlcgKi8NCj4gPiAgI2RlZmluZSBNU0RDX1BBVENIX0JJVF9ERUNS
Q1RNTyAgICgweDEgPDwgMzApICAvKiBSVyAqLw0KPiA+DQo+ID4gKyNkZWZpbmUgTVNEQ19QQVRD
SF9CSVQxX0NNRFRBICAgICAoMHg3IDw8IDMpICAgIC8qIFJXICovDQo+ID4gICNkZWZpbmUgTVNE
Q19QQVRDSF9CSVQxX1NUT1BfRExZICAoMHhmIDw8IDgpICAgIC8qIFJXICovDQo+ID4NCj4gPiAg
I2RlZmluZSBNU0RDX1BBVENIX0JJVDJfQ0ZHUkVTUCAgICgweDEgPDwgMTUpICAgLyogUlcgKi8N
Cj4gPiBAQCAtMTg4MSw2ICsxODgyLDcgQEAgc3RhdGljIGludCBoczQwMF90dW5lX3Jlc3BvbnNl
KHN0cnVjdCBtbWNfaG9zdCAqbW1jLCB1MzIgb3Bjb2RlKQ0KPiA+DQo+ID4gICAgICAgICAvKiBz
ZWxlY3QgRU1NQzUwIFBBRCBDTUQgdHVuZSAqLw0KPiA+ICAgICAgICAgc2RyX3NldF9iaXRzKGhv
c3QtPmJhc2UgKyBQQURfQ01EX1RVTkUsIEJJVCgwKSk7DQo+ID4gKyAgICAgICBzZHJfc2V0X2Zp
ZWxkKGhvc3QtPmJhc2UgKyBNU0RDX1BBVENIX0JJVDEsIE1TRENfUEFUQ0hfQklUMV9DTURUQSwg
Mik7DQo+ID4NCj4gPiAgICAgICAgIGlmIChtbWMtPmlvcy50aW1pbmcgPT0gTU1DX1RJTUlOR19N
TUNfSFMyMDAgfHwNCj4gPiAgICAgICAgICAgICBtbWMtPmlvcy50aW1pbmcgPT0gTU1DX1RJTUlO
R19VSFNfU0RSMTA0KQ0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+IA0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5n
IGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

