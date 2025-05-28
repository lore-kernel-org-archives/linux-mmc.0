Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFEB2DCC0C
	for <linux-mmc@vger.kernel.org>; Wed, 28 May 2025 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748401862; cv=none; b=nZcMRV1+xeHmDFJ26/WsYEadwrjZb14q/3dn77XJHHWjvZlMp6yTMMq42DqxU+rHwz/DNktFo7nH5Lngh+WyQnPoMbaO5I5MMvXmZ1cNXqp4jqdmnD9uXcRTnI55QFuoGQCl2LgCnl31+DZ3XImddYpM5+XxXZ7+zmfn6rkIFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748401862; c=relaxed/simple;
	bh=lmYjRBpfYj/b7ClN2tldw2CVutBgJh3WPJv4h0gS33U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fq/9lTroH4+uolo2yTFqbwFoLGEwzzctsdQ2AruUX6xDK5anzSQiDSFzvNx4lhZXm8Vdba+FOT6vYS76CML8fmMYXn2UzNyPSja8UdHaUO0qP/tcz7RmFDpLBrhPY3ERJOh9awieldEKJrShuG45AhC9EdFKqOonKqA7zz+nhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=permerror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SYKuFeqS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SYKuFeqS"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54S3AdNT23101357, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748401840; bh=lmYjRBpfYj/b7ClN2tldw2CVutBgJh3WPJv4h0gS33U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SYKuFeqSyIasHawGaHrXFpWt6M2j00aI1BlIDwVvnnG+zYdhWdYcP+NrqcHzH7S0P
	 NdIzjkwDNCfNS0U5/gNY8S3/FyJ8P4pDekyBZPACH8Y4EbzTvR/1EmesAvMQ/fRfuA
	 VZBXujJgmhWtt6dahXhygP9sxgCV2kTgV1Fq/UMSCvgWzcgY0nUgMqBamttwb9rQ9l
	 3FKeXtPkI8/n1hJI8/Aco0F3TH7guxSa0j3RXVo21ooZyZg2FNQHHoK9RZWTcGQvrX
	 Xv6QjLVaOE7L6kyoV0VCbfi+H9IQrw6mCOB/DJvN8AU0nRi/UYLBdmO2GhK0/5ObCY
	 OGyvK5+cYo8XQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54S3AdNT23101357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 11:10:39 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 May 2025 11:10:38 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 May 2025 11:10:38 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Wed, 28 May 2025 11:10:38 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Gavin Li <gfl3162@gmail.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Gavin Li
	<git@thegavinli.com>
Subject: RE: [PATCH v1] mmc: rtsx_usb_sdmmc: add parameter to always poll for card presence
Thread-Topic: [PATCH v1] mmc: rtsx_usb_sdmmc: add parameter to always poll for
 card presence
Thread-Index: AQHbyLRLEO85hY+bKkSWaK7QQ1CcTrPgop2AgAVrbQCAAU/bUA==
Date: Wed, 28 May 2025 03:10:38 +0000
Message-ID: <b843b011bebd4dc18f9b9da290958ded@realtek.com>
References: <20250510031945.1004129-1-git@thegavinli.com>
 <CAPDyKFq8evHyh_0QacZq=d36vXfrs3vFPsAuCyFdv3BKh0SP2A@mail.gmail.com>
 <CA+GxvY4ByPW4HVJfww2v674f-y5kuqKmY=EB8mD5jnRcy+HmPg@mail.gmail.com>
 <CAPDyKFrXnVkOatAF_adg67LxfU7YOqeR_49_u2mOQLntQcCBfg@mail.gmail.com>
In-Reply-To: <CAPDyKFrXnVkOatAF_adg67LxfU7YOqeR_49_u2mOQLntQcCBfg@mail.gmail.com>
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

PiBPbiBTYXQsIDI0IE1heSAyMDI1IGF0IDA1OjM3LCBHYXZpbiBMaSA8Z2ZsMzE2MkBnbWFpbC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBNYXkgMTksIDIwMjUgYXQgNzo1MOKAr0FNIFVs
ZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiB3cm90ZToNCj4gPg0KPiA+ID4g
TW92aW5nIHRoaXMgcHJvYmxlbSB0byB1c2Vyc3BhY2Ugc2VlbXMgd3JvbmcgdG8gbWUuIFdlIHNo
b3VsZCBiZQ0KPiA+ID4gYWJsZSB0byBkbyB0aGUgcmlnaHQgdGhpbmcgaW4gdGhlIGtlcm5lbC4N
Cj4gPg0KPiA+IFVuZm9ydHVuYXRlbHksIEkgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gdGhlIGRhdGFz
aGVldCBmb3IgdGhlIFJUUzUxNzkgb3INCj4gPiByZWxhdGVkIGNoaXBzLiBUaGlzIGlzIHdoYXQg
SSBjb3VsZCBkbyB0byBnZXQgbXkgb3duIGhhcmR3YXJlIHdvcmtpbmcsDQo+ID4gYW5kIGl0IGRv
ZXNuJ3QgbWFrZSBzZW5zZSB0byByZXZlcnQgdG8gcG9sbGluZyBtb2RlIGZvciBhbGwgdXNlcnMg
aWYNCj4gPiB0aGUgaW50ZXJydXB0IG1vZGUgZGV0ZWN0aW9uIHdvcmtzIGFuZCByZWR1Y2VzIHBv
d2VyIGNvbnN1bXB0aW9uLg0KPiANCj4gQWdyZWUhDQo+IA0KPiA+DQo+ID4gPiBXZSBzaG91bGQg
YmUgYWJsZSB0byBkZXRlY3QgaWYgd2UgYXJlIHJ1bm5pbmcgdGhlIGJyb2tlbiBIVyBhbmQgaW4N
Cj4gPiA+IHRoYXQgY2FzZSwgc2V0IHRoZSBmbGFnIGJhc2VkIG9uIHRoYXQsIHJpZ2h0Pw0KPiA+
DQo+ID4gSSBkb24ndCBrbm93IG9mIGEgd2F5IHRvIGRvIHNvLCBlc3BlY2lhbGx5IHNpbmNlIEkg
ZG9uJ3QgaGF2ZQ0KPiA+IG5vbi1icm9rZW4gSFcgaW4gbXkgcG9zc2Vzc2lvbi4gT24gbXkgaGFy
ZHdhcmUsIG9uY2UgdGhlIGRldmljZSBlbnRlcnMNCj4gPiBhdXRvc3VzcGVuZCwgaW5zZXJ0aW5n
IGEgY2FyZCBkb2VzIG5vdCB0cmlnZ2VyIGEgd2FrZXVwLiBJJ20gaG9waW5nDQo+ID4gdGhhdCB0
aGVyZSdzIGEgd2F5IHRvIGRldGVjdCB0aGUgYnJva2VuIEhXIHZpYSBhIGhhcmR3YXJlIHJldmlz
aW9uIHJlZ2lzdGVyDQo+IG9yIHNvbWV0aGluZyBzaW1pbGFyLg0KPiANCj4gWWVzLCBzb21ldGhp
bmcgYWxvbmcgdGhvc2UgbGluZXMgd291bGQgbWFrZSBzZW5zZS4gTGV0J3Mgc2VlIGlmIFJpY2t5
IGNhbg0KPiBhZHZpc2UgdXMgb24gaG93IHRvIG1vdmUgZm9yd2FyZC4NCj4gDQoNCkhpIEdhdmlu
LA0KDQpJ4oCZbSBub3QgZW50aXJlbHkgY2xlYXIgb24gd2hhdCB0aGUgYWN0dWFsIGlzc3VlIGlz
IGF0IHRoaXMgcG9pbnQuIEluaXRpYWxseSwgdGhlcmUgd2FzIG1lbnRpb24gb2Yg4oCcc29tZSBS
VFM1MTc54oCm4oCdIGFuZCBsYXRlciwgDQrigJxicm9rZW4gaGFyZHdhcmXigKbigJ0gd2FzIGJy
b3VnaHQgdXAuDQpDb3VsZCB5b3UgcGxlYXNlIGNsYXJpZnkg4oCUIGlzIHRoaXMgcHJvYmxlbSBo
YXBwZW5pbmcgb25seSBvbiBjZXJ0YWluIHBsYXRmb3Jtcz8gT3IgaXMgaXQgc29tZXRoaW5nIGVs
c2U/DQoNCkhJIFVpZiwNCg0KSXMgaXQgZ2VuZXJhbGx5IHRydWU/IFRoYXQgZGV2aWNlcyB1c2lu
ZyB0aGUgTU1DX0NBUF9ORUVEU19QT0xMIGZsYWcgbWF5IG5vdCBmdWxseSBzdXBwb3J0IHJ1bnRp
bWVfc3VzcGVuZCwNClNpbmNlIHRoZXkgcmVseSBvbiBwb2xsaW5nIHJhdGhlciB0aGFuIGludGVy
cnVwdHMuDQpUaGlzIGNhbiBwcmV2ZW50IHRoZSBkZWNpY2VzIG9yIGhvc3QgY29udHJvbGxlciBm
cm9tIHJlYWNoaW5nIGRlZXBlciBwb3dlci1zYXZpbmcgc3RhdGVzLg0KDQoNCj4gS2luZCByZWdh
cmRzDQo+IFVmZmUNCg==
