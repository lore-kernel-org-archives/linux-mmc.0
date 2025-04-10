Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FB1A9B3E;
	Thu, 10 Apr 2025 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267026; cv=none; b=lF4shmSz3Tgp48HyCkYYmzzGE9yEzcjTXWxIMdTHWjh6AzJna9Qqa1OuJEE1y8s3We3k0VN+qZ8L5ZUxTaIEf5QZxbyKsLAGvWjQvrJvEj/I0P7dslSak/VW3cjZoLEKmCbxmWQLsqZQkHdr4INSvqR3JWRyWvTowu4cQPnGFuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267026; c=relaxed/simple;
	bh=ANitbIeqB7CjA0+NS5rjVnO0iVQxflREFoyLFwYI2+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBddwtjkP7fnkfVTHpWGdohU348p/LoHNc+g4MCbwrOVHdbkUkdFxW6/gakE+Y46m53Y2ADnsHlfyRCURErUHL5hxUbb4GwXn/IaXXQqDBMKZ8GCP2u36k2WHKNLcNxOa2qjUeDZ9o2blDbp5U9me81RM7jzX29qrtNFpAluFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qg4iBhvr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qg4iBhvr"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53A6auQV32994461, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744267017; bh=ANitbIeqB7CjA0+NS5rjVnO0iVQxflREFoyLFwYI2+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qg4iBhvrsJYdf4wFgmlUGTCVbnc5IibT2rjfJQejBd1L7Hyk8n7g+6FTYPUcu9WGP
	 qnUDjpbWybMeNXw7qzUrlYeAsJo7RqYX//1OOdvvPXFFLgTrMoYyxWO7WniGAo/Gji
	 /D6Kp9qO6dManWC7zQkDld4AfMgn7hfn2EZDD9T2mbdMiJwaKYi6gxqdJ+tfD0rdZb
	 NWxyb2z2l95KbOsmlD/Aems0Je4GhyWZYg/RVyyMpapnzw+oOs53VyBDOAx+X3L9Md
	 l7PqvyW5K/iz1JRX2lGxE3KVNo6WYUaDrLY/7FACG0rIKggtLROweUoz/KviMSzD/g
	 S2mofgR0bAcoQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53A6auQV32994461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 14:36:57 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Apr 2025 14:36:57 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 10 Apr 2025 14:36:57 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Thu, 10 Apr 2025 14:36:57 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] mmc: rtsx: usb add 74 clocks in poweron flow
Thread-Topic: [PATCH] mmc: rtsx: usb add 74 clocks in poweron flow
Thread-Index: AQHborD2846vsF6F3E6a08GwR4gCjrOa1GaAgAFzDHA=
Date: Thu, 10 Apr 2025 06:36:56 +0000
Message-ID: <1fde0217fa544560888c3e6f4f5963f9@realtek.com>
References: <20250401025123.895307-1-ricky_wu@realtek.com>
 <CAPDyKFpn5xB50eTomNM=4LbFDX4r154iY2Qk8GBiYb+vor0kbA@mail.gmail.com>
In-Reply-To: <CAPDyKFpn5xB50eTomNM=4LbFDX4r154iY2Qk8GBiYb+vor0kbA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiA+DQo+ID4gU0Qgc3BlYyBkZWZpbml0aW9uOg0KPiA+ICJIb3N0IHByb3ZpZGVzIGF0IGxlYXN0
IDc0IENsb2NrcyBiZWZvcmUgaXNzdWluZyBmaXJzdCBjb21tYW5kIg0KPiA+IEFmdGVyIDFtcyBm
b3IgdGhlIHZvbHRhZ2Ugc3RhYmxlIHRoZW4gc3RhcnQgaXNzdWluZyB0aGUgQ2xvY2sgc2lnbmFs
cw0KPiA+DQo+ID4gYWRkIGlmIHN0YXRlbWVudCB0byBpc3N1ZS9zdG9wIHRoZSBjbG9jayBzaWdu
YWwgdG8gY2FyZDoNCj4gPiBUaGUgcG93ZXIgc3RhdGUgZnJvbSBQT1dFUl9PRkYgdG8gUE9XRVJf
VVAgaXNzdWUgdGhlIHNpZ25hbCB0byBjYXJkLA0KPiA+IFBPV0VSX1VQIHRvIFBPV0VSX09OIHN0
b3AgdGhlIHNpZ25hbA0KPiA+DQo+ID4gYWRkIDEwMG1zIGRlbGF5IGluIHBvd2VyX29uIHRvIG1h
a2Ugc3VyZSB0aGUgcG93ZXIgY3ljbGUgY29tcGxldGUNCj4gDQo+IFdoeSAxMDBtcz8gVGhhdCBz
b3VuZHMgYSBsb3QgdG8gbWU/DQo+IA0KSGkgVWxmLA0KDQpUaGlzIDEwMG1zIGRlbGF5IGlzIHRv
IGVuc3VyZSB0aGUgdm9sdGFnZSBpcyBiZWxvdyAwLjVWIGJlZm9yZSBwb3dlciBvbiBkdXJpbmcg
YSBwb3dlciBjeWNsZSwNClRoZSBkZWxheXMgaW4gdGhlIG1tYyBjb3JlIGlzIG5vdCBzdWZmaWNp
ZW50IGZvciB0aGUgcnRzeCB1c2IgZGV2aWNlLiANCkJlY2F1c2UgZHVyaW5nIHRoZSBjYXJkIHJl
Y29nbml0aW9uIHByb2Nlc3MsIHRoZSBjYXJkIHBvd2VyIHdpbGwgYmUgdG9nZ2xlZCBvbmNlIGlu
IDFtcy4NCklmIHRoZSBjYXJkIHBvd2VyIGlzIG5vdCBmdWxseSBkaXNjaGFyZ2VkIHdpdGhpbiB0
aGF0IDFtcyBiZWZvcmUgYmVpbmcgdHVybmVkIG9uIGFnYWluLCANCkl0IG1heSBhZmZlY3QgdGhl
IGNhcmQgcmVjb2duaXRpb24gDQoNCj4gSXMgdGhpcyBmaXhpbmcgYSByZWFsIHByb2JsZW0gb3Ig
aXMganVzdCB0cnlpbmcgdG8gYmV0dGVyIGZvbGxvdyB0aGUgc3BlYz8NCj4gDQoNCldlIGZvdW5k
IHNvbWUgY2FyZHMgbm90IGJlIHJlY29nbml6ZWQgaWYgbm90IGlzc3VlIHRoaXMgNzQgY2xvY2tz
DQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2t5IFd1IDxyaWNreV93dUByZWFsdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9ydHN4X3VzYl9zZG1tYy5jIHwgMjgN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjUg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9ob3N0L3J0c3hfdXNiX3NkbW1jLmMNCj4gPiBiL2RyaXZlcnMvbW1jL2hvc3QvcnRz
eF91c2Jfc2RtbWMuYw0KPiA+IGluZGV4IGQyMjljMmI4M2VhOS4uZTU4MjBiMmJiMzgwIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvcnRzeF91c2Jfc2RtbWMuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbW1jL2hvc3QvcnRzeF91c2Jfc2RtbWMuYw0KPiA+IEBAIC00OCw3ICs0OCw3IEBA
IHN0cnVjdCBydHN4X3VzYl9zZG1tYyB7DQo+ID4gICAgICAgICBib29sICAgICAgICAgICAgICAg
ICAgICBkZHJfbW9kZTsNCj4gPg0KPiA+ICAgICAgICAgdW5zaWduZWQgY2hhciAgICAgICAgICAg
cG93ZXJfbW9kZTsNCj4gPiAtDQo+ID4gKyAgICAgICB1bnNpZ25lZCBjaGFyICAgICAgICAgICBw
cmV2X3Bvd2VyX21vZGU7DQo+ID4gICNpZmRlZiBSVFNYX1VTQl9VU0VfTEVEU19DTEFTUw0KPiA+
ICAgICAgICAgc3RydWN0IGxlZF9jbGFzc2RldiAgICAgbGVkOw0KPiA+ICAgICAgICAgY2hhciAg
ICAgICAgICAgICAgICAgICAgbGVkX25hbWVbMzJdOw0KPiA+IEBAIC05NTIsNiArOTUyLDggQEAg
c3RhdGljIGludCBzZF9wb3dlcl9vbihzdHJ1Y3QgcnRzeF91c2Jfc2RtbWMNCj4gKmhvc3QpDQo+
ID4gICAgICAgICBzdHJ1Y3QgcnRzeF91Y3IgKnVjciA9IGhvc3QtPnVjcjsNCj4gPiAgICAgICAg
IGludCBlcnI7DQo+ID4NCj4gPiArICAgICAgIG1zbGVlcCgxMDApOw0KPiA+ICsNCj4gPiAgICAg
ICAgIGRldl9kYmcoc2RtbWNfZGV2KGhvc3QpLCAiJXNcbiIsIF9fZnVuY19fKTsNCj4gPiAgICAg
ICAgIHJ0c3hfdXNiX2luaXRfY21kKHVjcik7DQo+ID4gICAgICAgICBydHN4X3VzYl9hZGRfY21k
KHVjciwgV1JJVEVfUkVHX0NNRCwgQ0FSRF9TRUxFQ1QsIDB4MDcsDQo+ID4gU0RfTU9EX1NFTCk7
IEBAIC0xMDE0LDYgKzEwMTYsMTYgQEAgc3RhdGljIGludA0KPiBzZF9zZXRfcG93ZXJfbW9kZShz
dHJ1Y3QgcnRzeF91c2Jfc2RtbWMgKmhvc3QsDQo+ID4gICAgICAgICAgICAgICAgIHVuc2lnbmVk
IGNoYXIgcG93ZXJfbW9kZSkgIHsNCj4gPiAgICAgICAgIGludCBlcnI7DQo+ID4gKyAgICAgICBp
bnQgcG93ZXJfbW9kZV90ZW1wOw0KPiA+ICsgICAgICAgc3RydWN0IHJ0c3hfdWNyICp1Y3IgPSBo
b3N0LT51Y3I7DQo+ID4gKw0KPiA+ICsgICAgICAgcG93ZXJfbW9kZV90ZW1wID0gcG93ZXJfbW9k
ZTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoKHBvd2VyX21vZGUgPT0gTU1DX1BPV0VSX09OKSAm
JiAoaG9zdC0+cG93ZXJfbW9kZQ0KPiA9PSBNTUNfUE9XRVJfT04pICYmDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgKGhvc3QtPnByZXZfcG93ZXJfbW9kZSA9PQ0KPiBNTUNfUE9XRVJfVVAp
KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGhvc3QtPnByZXZfcG93ZXJfbW9kZSA9IE1NQ19QT1dF
Ul9PTjsNCj4gPiArICAgICAgICAgICAgICAgcnRzeF91c2Jfd3JpdGVfcmVnaXN0ZXIodWNyLCBT
RF9CVVNfU1RBVCwNCj4gU0RfQ0xLX1RPR0dMRV9FTiwgMHgwMCk7DQo+ID4gKyAgICAgICB9DQo+
ID4NCj4gPiAgICAgICAgIGlmIChwb3dlcl9tb2RlICE9IE1NQ19QT1dFUl9PRkYpDQo+ID4gICAg
ICAgICAgICAgICAgIHBvd2VyX21vZGUgPSBNTUNfUE9XRVJfT047IEBAIC0xMDI5LDkNCj4gKzEw
NDEsMTggQEANCj4gPiBzdGF0aWMgaW50IHNkX3NldF9wb3dlcl9tb2RlKHN0cnVjdCBydHN4X3Vz
Yl9zZG1tYyAqaG9zdCwNCj4gPiAgICAgICAgICAgICAgICAgZXJyID0gc2RfcG93ZXJfb24oaG9z
dCk7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIGlmICghZXJyKQ0KPiA+IC0gICAg
ICAgICAgICAgICBob3N0LT5wb3dlcl9tb2RlID0gcG93ZXJfbW9kZTsNCj4gPiArICAgICAgIGlm
ICghZXJyKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICgocG93ZXJfbW9kZV90ZW1wID09IE1N
Q19QT1dFUl9VUCkgJiYNCj4gKGhvc3QtPnBvd2VyX21vZGUgPT0gTU1DX1BPV0VSX09GRikpIHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBob3N0LT5wcmV2X3Bvd2VyX21vZGUgPSBNTUNf
UE9XRVJfVVA7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcnRzeF91c2Jfd3JpdGVfcmVn
aXN0ZXIodWNyLCBTRF9CVVNfU1RBVCwNCj4gU0RfQ0xLX1RPR0dMRV9FTiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0RfQ0xLX1RPR0dMRV9FTik7DQo+ID4g
KyAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmICgocG93ZXJf
bW9kZV90ZW1wID09IE1NQ19QT1dFUl9PRkYpICYmDQo+IChob3N0LT5wb3dlcl9tb2RlID09IE1N
Q19QT1dFUl9PTikpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaG9zdC0+cHJldl9wb3dl
cl9tb2RlID0gTU1DX1BPV0VSX09GRjsNCj4gPg0KPiA+ICsgICAgICAgICAgICAgICBob3N0LT5w
b3dlcl9tb2RlID0gcG93ZXJfbW9kZTsNCj4gPiArICAgICAgIH0NCj4gPiAgICAgICAgIHJldHVy
biBlcnI7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC0xMzE2LDYgKzEzMzcsNyBAQCBzdGF0aWMgdm9p
ZCBydHN4X3VzYl9pbml0X2hvc3Qoc3RydWN0DQo+IHJ0c3hfdXNiX3NkbW1jICpob3N0KQ0KPiA+
ICAgICAgICAgbW1jLT5tYXhfcmVxX3NpemUgPSA1MjQyODg7DQo+ID4NCj4gPiAgICAgICAgIGhv
c3QtPnBvd2VyX21vZGUgPSBNTUNfUE9XRVJfT0ZGOw0KPiA+ICsgICAgICAgaG9zdC0+cHJldl9w
b3dlcl9tb2RlID0gTU1DX1BPV0VSX09GRjsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQg
cnRzeF91c2Jfc2RtbWNfZHJ2X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
