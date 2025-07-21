Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31511DACA7
	for <linux-mmc@vger.kernel.org>; Mon, 21 Jul 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078419; cv=none; b=Dk7jF6jxST/iYJiY68WIqj5IupxUbaWYM/QwnbJ/nkwOrRXkne6WCVl+0SALhG0y4oj2Ta1EXEaeMSI8SGe4D6LrWU79yV/qYb/RPgD3EJw9Tf/Ap+oeMT5Ak3qJRPlJd8zArAWUJdMAFnAep3+KrbMCj/eGi8aVh3Yum3IGGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078419; c=relaxed/simple;
	bh=93bm0mhDfAFetEnbzr/Cc+eF6AcKEqH/6ILIcsg5AQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dg7Eh7TACpu94IKryQcM2/Gwucl2IkbsZ2Lz7YIDpPC8+/DdTAwE/x0O3JaNxrNVWR6cWEjzz8ig1uU0ks8RMvZhIhnwBT9EslkqAlVgY3w0VDZ1fjUuN/nSdeKOkeKL/HP4ImAaSwgx6IPTdj4QLpfYgtIeoO+BexuWzRFjt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nqH8EqFC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nqH8EqFC"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56L6DMEH02126467, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753078402; bh=93bm0mhDfAFetEnbzr/Cc+eF6AcKEqH/6ILIcsg5AQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nqH8EqFCAb1kC9hFucjnIcQ0n4pzm6R/++O1vSWTOE2S1Ym6XkulmjTncvwpHy81W
	 pPd1u88Np19hzNuzA5OuoinBiWkyJoh4VE/6nF9YvkD0bdaTNkABAVoCyDttKNj0Wa
	 T4uBty4cp+Sp1cadlOBgx0zqy5PIg1Aj5octVUGyd7Ub4nWDje8q7DKjMbvYxTGVjT
	 P/GoC90IKv6b+O87r/NMlbYmBJnJETjnQB1nFc42IsUitfE0LApAKy5EJ3ESnXZJEE
	 OYkSNhuWgpWHQymstslZV71bd8SrouSmW2hXsHEnqKr5c054kAaWnp/Jsr+96TtkHp
	 dCjC7fPgi2hdQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56L6DMEH02126467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 14:13:22 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Jul 2025 14:13:22 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 21 Jul 2025 14:13:22 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Mon, 21 Jul 2025 14:13:22 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Gavin Li <gfl3162@gmail.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        Gavin Li <git@thegavinli.com>
Subject: RE: [PATCH v1] mmc: rtsx_usb_sdmmc: add parameter to always poll for card presence
Thread-Topic: [PATCH v1] mmc: rtsx_usb_sdmmc: add parameter to always poll for
 card presence
Thread-Index: AQHbyLRLEO85hY+bKkSWaK7QQ1CcTrPgop2AgAVrbQCAAU/bUIBUWcgAgADCLyA=
Date: Mon, 21 Jul 2025 06:13:22 +0000
Message-ID: <95020c4ba28c42119995b9131f5d4954@realtek.com>
References: <20250510031945.1004129-1-git@thegavinli.com>
 <CAPDyKFq8evHyh_0QacZq=d36vXfrs3vFPsAuCyFdv3BKh0SP2A@mail.gmail.com>
 <CA+GxvY4ByPW4HVJfww2v674f-y5kuqKmY=EB8mD5jnRcy+HmPg@mail.gmail.com>
 <CAPDyKFrXnVkOatAF_adg67LxfU7YOqeR_49_u2mOQLntQcCBfg@mail.gmail.com>
 <b843b011bebd4dc18f9b9da290958ded@realtek.com>
 <CA+GxvY4=sSrhdPCsp9nUDVwNKH=FnH_fCPe8fv06pP+bVpQD9w@mail.gmail.com>
In-Reply-To: <CA+GxvY4=sSrhdPCsp9nUDVwNKH=FnH_fCPe8fv06pP+bVpQD9w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

PiBIaSBSaWNreSwNCj4gDQo+IFRoaXMgaXNzdWUgYXBwZWFycyB3aXRoIHRoZSBTRCBjYXJkIHJl
YWRlciBvbiB0aGUgSUJNIExlbm92bw0KPiBUaGlua0NlbnRyZSBNOTJ6LCB3aGljaCB1c2VzIHRo
ZSBSVFM1MTc5Lg0KPiANCj4gQXNzdW1lIHRoYXQgdGhlIHJ0c3hfdXNiIGFuZCBydHN4X3VzYl9z
ZG1tYyBtb2R1bGVzIGFyZSBsb2FkZWQgYXQgYm9vdA0KPiB0aW1lLg0KPiANCg0KVGhpbmsgeW91
IGZvciB5b3VyIHRlc3RpbmcuLi4NCkkgdGhpbmsgSSBuZWVkIHRvIGZvdW5kIHRoZSBwbGF0Zm9y
bShJQk0gTGVub3ZvIFRoaW5rQ2VudHJlIE05MnopIGZpcnN0LA0KQmVjYXVzZSBJIGNhbid0IHJl
cHJvZHVjZSB0aGlzIGlzc3VlIG9uIG15IGhhbmQsIEkgdGhpbmsgdGhpcyBpc3N1ZSBpcyBub3Qg
YSBnZW5lcmFsbHkgaXNzdWUgIA0KDQoNCj4gSWYgdGhlIHN5c3RlbSBib290cyB3aXRoIHRoZSBT
RCBjYXJkIGluc2VydGVkLCB0aGUgU0QgY2FyZCBpcyBkZXRlY3RlZA0KPiBjb3JyZWN0bHkuDQo+
IA0KPiBpZiB0aGUgc3lzdGVtIGJvb3RzIHdpdGggdGhlIFNEIGNhcmQgX25vdF8gaW5zZXJ0ZWQs
IHRoZW4gdGhlIFNEIGNhcmQNCj4gaXMgaW5zZXJ0ZWQgYWZ0ZXIgdGhlIG1vZHVsZXMgYXJlIGxv
YWRlZCwgdGhlbiB0aGUgU0QgY2FyZCBpcyBub3QNCj4gZGV0ZWN0ZWQuIElmIEkgdGhlbiBydW4g
YHJtbW9kIHJ0c3hfdXNiX3NkbW1jICYmIG1vZHByb2JlDQo+IHJ0c3hfdXNiX3NkbW1jYCwgdGhl
IFNEIGNhcmQgZ2V0cyBkZXRlY3RlZCBhZnRlciB0aGUgbW9kdWxlIHJlbG9hZC4NCj4gDQo+IEFk
ZGl0aW9uYWxseSwgaWYgSSByZW1vdmUgdGhlIFNEIGNhcmQgYW5kIGluc2VydCBpdCBhZ2Fpbiwg
aXQgaXMgbm90DQo+IGRldGVjdGVkIHVudGlsIEkgcGVyZm9ybSB0aGUgbW9kdWxlIHJlbG9hZC4N
Cj4gDQo+IFNldHRpbmcgYWx3YXlzX3BvbGw9MSBmaXhlcyBhbGwgb2YgdGhlIGlzc3VlcyBhYm92
ZS4NCj4gDQo+IEJlc3QsDQo+IEdhdmluDQo+IA0KPiBPbiBUdWUsIE1heSAyNywgMjAyNSBhdCAx
MToxMOKAr1BNIFJpY2t5IFdVIDxyaWNreV93dUByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiA+IE9uIFNhdCwgMjQgTWF5IDIwMjUgYXQgMDU6MzcsIEdhdmluIExpIDxnZmwzMTYyQGdtYWls
LmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1vbiwgTWF5IDE5LCAyMDI1IGF0IDc6
NTDigK9BTSBVbGYgSGFuc3Nvbg0KPiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gPiA+IHdy
b3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IE1vdmluZyB0aGlzIHByb2JsZW0gdG8gdXNlcnNwYWNl
IHNlZW1zIHdyb25nIHRvIG1lLiBXZSBzaG91bGQgYmUNCj4gPiA+ID4gPiBhYmxlIHRvIGRvIHRo
ZSByaWdodCB0aGluZyBpbiB0aGUga2VybmVsLg0KPiA+ID4gPg0KPiA+ID4gPiBVbmZvcnR1bmF0
ZWx5LCBJIGRvbid0IGhhdmUgYWNjZXNzIHRvIHRoZSBkYXRhc2hlZXQgZm9yIHRoZSBSVFM1MTc5
IG9yDQo+ID4gPiA+IHJlbGF0ZWQgY2hpcHMuIFRoaXMgaXMgd2hhdCBJIGNvdWxkIGRvIHRvIGdl
dCBteSBvd24gaGFyZHdhcmUgd29ya2luZywNCj4gPiA+ID4gYW5kIGl0IGRvZXNuJ3QgbWFrZSBz
ZW5zZSB0byByZXZlcnQgdG8gcG9sbGluZyBtb2RlIGZvciBhbGwgdXNlcnMgaWYNCj4gPiA+ID4g
dGhlIGludGVycnVwdCBtb2RlIGRldGVjdGlvbiB3b3JrcyBhbmQgcmVkdWNlcyBwb3dlciBjb25z
dW1wdGlvbi4NCj4gPiA+DQo+ID4gPiBBZ3JlZSENCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4g
V2Ugc2hvdWxkIGJlIGFibGUgdG8gZGV0ZWN0IGlmIHdlIGFyZSBydW5uaW5nIHRoZSBicm9rZW4g
SFcgYW5kIGluDQo+ID4gPiA+ID4gdGhhdCBjYXNlLCBzZXQgdGhlIGZsYWcgYmFzZWQgb24gdGhh
dCwgcmlnaHQ/DQo+ID4gPiA+DQo+ID4gPiA+IEkgZG9uJ3Qga25vdyBvZiBhIHdheSB0byBkbyBz
bywgZXNwZWNpYWxseSBzaW5jZSBJIGRvbid0IGhhdmUNCj4gPiA+ID4gbm9uLWJyb2tlbiBIVyBp
biBteSBwb3NzZXNzaW9uLiBPbiBteSBoYXJkd2FyZSwgb25jZSB0aGUgZGV2aWNlDQo+IGVudGVy
cw0KPiA+ID4gPiBhdXRvc3VzcGVuZCwgaW5zZXJ0aW5nIGEgY2FyZCBkb2VzIG5vdCB0cmlnZ2Vy
IGEgd2FrZXVwLiBJJ20gaG9waW5nDQo+ID4gPiA+IHRoYXQgdGhlcmUncyBhIHdheSB0byBkZXRl
Y3QgdGhlIGJyb2tlbiBIVyB2aWEgYSBoYXJkd2FyZSByZXZpc2lvbg0KPiByZWdpc3Rlcg0KPiA+
ID4gb3Igc29tZXRoaW5nIHNpbWlsYXIuDQo+ID4gPg0KPiA+ID4gWWVzLCBzb21ldGhpbmcgYWxv
bmcgdGhvc2UgbGluZXMgd291bGQgbWFrZSBzZW5zZS4gTGV0J3Mgc2VlIGlmIFJpY2t5IGNhbg0K
PiA+ID4gYWR2aXNlIHVzIG9uIGhvdyB0byBtb3ZlIGZvcndhcmQuDQo+ID4gPg0KPiA+DQo+ID4g
SGkgR2F2aW4sDQo+ID4NCj4gPiBJ4oCZbSBub3QgZW50aXJlbHkgY2xlYXIgb24gd2hhdCB0aGUg
YWN0dWFsIGlzc3VlIGlzIGF0IHRoaXMgcG9pbnQuIEluaXRpYWxseSwgdGhlcmUNCj4gd2FzIG1l
bnRpb24gb2Yg4oCcc29tZSBSVFM1MTc54oCm4oCdIGFuZCBsYXRlciwNCj4gPiDigJxicm9rZW4g
aGFyZHdhcmXigKbigJ0gd2FzIGJyb3VnaHQgdXAuDQo+ID4gQ291bGQgeW91IHBsZWFzZSBjbGFy
aWZ5IOKAlCBpcyB0aGlzIHByb2JsZW0gaGFwcGVuaW5nIG9ubHkgb24gY2VydGFpbg0KPiBwbGF0
Zm9ybXM/IE9yIGlzIGl0IHNvbWV0aGluZyBlbHNlPw0KPiA+DQo+ID4gSEkgVWlmLA0KPiA+DQo+
ID4gSXMgaXQgZ2VuZXJhbGx5IHRydWU/IFRoYXQgZGV2aWNlcyB1c2luZyB0aGUgTU1DX0NBUF9O
RUVEU19QT0xMIGZsYWcgbWF5DQo+IG5vdCBmdWxseSBzdXBwb3J0IHJ1bnRpbWVfc3VzcGVuZCwN
Cj4gPiBTaW5jZSB0aGV5IHJlbHkgb24gcG9sbGluZyByYXRoZXIgdGhhbiBpbnRlcnJ1cHRzLg0K
PiA+IFRoaXMgY2FuIHByZXZlbnQgdGhlIGRlY2ljZXMgb3IgaG9zdCBjb250cm9sbGVyIGZyb20g
cmVhY2hpbmcgZGVlcGVyDQo+IHBvd2VyLXNhdmluZyBzdGF0ZXMuDQo+ID4NCj4gPg0KPiA+ID4g
S2luZCByZWdhcmRzDQo+ID4gPiBVZmZlDQo=
