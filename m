Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9511C7013
	for <linux-mmc@vger.kernel.org>; Fri,  1 Aug 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043852; cv=none; b=qbb0UB88SOARFHBgvOsUoXDNf3I38QSDBDp6r5K5VrN7+7q7MVVgpnuc6f0KKVPKmR7Z7nfcb8RDOaekpPDLfjciOOgr2Oalp1SmTfLScLlD7bovCtMj0CXZbwIdKuI3aHesHhoBvZVtT7PavYOcHcTsD42Jnil+21hi+jfgEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043852; c=relaxed/simple;
	bh=vKCSw0E2ePFsj0DRcEy+IILC2vV4loJjGETUqoJyinQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWUiPwrE8bWb9a6/vyJVa+2EYmHFiGLyPBXeFHx0p0qYYFEr5YXMbBdtiLfDi0eJ+bv0HCzyn484VW/uXbcLoZ96m1I3WcGFwRFdtk9M6i8zkh8cna7c5m+o4R9BRz0W9ee9fIapjObHZh2oO72Ow4uoXwu6UfvN52T5MzYP6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bA3z4UI5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bA3z4UI5"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 571ANr3oA2766057, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754043833; bh=vKCSw0E2ePFsj0DRcEy+IILC2vV4loJjGETUqoJyinQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bA3z4UI5jlAWIHDHRiT/qvkhND/vnFRJlUUXM4hCwO6aa6Jy0QHELdC6lLUqg2Edt
	 wuCMh+51nuv10mtM3D78p5htCTjS0rHhchXkfWm0B8ibxuf9Vk4IlUbwULq/9l+wz5
	 NTRM2UtmyQToNNXxCP9DAgm1v0sCqXAtr4png+UbqBAh73Y5Bd8IgxFEmwkqxuWi3V
	 S2CEVJ1rB/C69ztHA6wp6Ae5XVqKB6X6d6Auq7Yo6SI97tCdxUkVOI/75UukcDWM34
	 ySMqTj0hts0tycnHRoaatpQspgd3XKCcOhiSEqOAUZGa/qZp4Y/xdxDrY8x9mhm3u4
	 VW8T82A0JEPAw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 571ANr3oA2766057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 18:23:53 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 18:23:54 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Aug 2025 18:23:53 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Fri, 1 Aug 2025 18:23:53 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Laurent Bigonville via Bugspray Bot
	<bugbot@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: rtsx_pci driver is blocking s2idle
Thread-Topic: rtsx_pci driver is blocking s2idle
Thread-Index: AQHcATpU+K0+nCzNvE+e3eB6tfVwZ7RNl5dg
Date: Fri, 1 Aug 2025 10:23:53 +0000
Message-ID: <220fe444bef94ace80c8518bafa0746b@realtek.com>
References: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
 <CAPDyKFp-4zmeitLD7hp6SvkokEZE9e8-JvPBOowRHQ0CADY3Nw@mail.gmail.com>
In-Reply-To: <CAPDyKFp-4zmeitLD7hp6SvkokEZE9e8-JvPBOowRHQ0CADY3Nw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAzMCwgMjAyNSA2
OjExIFBNDQo+IFRvOiBMYXVyZW50IEJpZ29udmlsbGUgdmlhIEJ1Z3NwcmF5IEJvdCA8YnVnYm90
QGtlcm5lbC5vcmc+OyBSaWNreSBXVQ0KPiA8cmlja3lfd3VAcmVhbHRlay5jb20+DQo+IENjOiBs
aW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBydHN4X3BjaSBkcml2ZXIg
aXMgYmxvY2tpbmcgczJpZGxlDQo+IA0KPiANCj4gRXh0ZXJuYWwgbWFpbCA6IFRoaXMgZW1haWwg
b3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90DQo+IHJlcGx5
LCBjbGljayBsaW5rcywgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0
aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+
ICsgUmlja3kNCj4gDQo+IE9uIFdlZCwgMjMgSnVsIDIwMjUgYXQgMTU6MDksIExhdXJlbnQgQmln
b252aWxsZSB2aWEgQnVnc3ByYXkgQm90DQo+IDxidWdib3RAa2VybmVsLm9yZz4gd3JvdGU6DQo+
ID4NCj4gPiBMYXVyZW50IEJpZ29udmlsbGUgYWRkZWQgYW4gYXR0YWNobWVudCBvbiBLZXJuZWwu
b3JnIEJ1Z3ppbGxhOg0KPiA+DQo+ID4gQ3JlYXRlZCBhdHRhY2htZW50IDMwODQwNA0KPiA+IHMw
aXgtc2VsZnRlc3QtdG9vbCAtcyBvdXRwdXQNCj4gPg0KPiA+IEhlbGxvLA0KPiA+DQo+ID4gSSd2
ZSBhIERlbGwgbGF0aXR1ZGUgNTUzMCB0aGF0IGhhcyBubyBTMyBzdXNwZW5kLCBpdCBvbmx5IGhh
cyBzMmlkbGUNCj4gPg0KPiA+IEkgaW5pdGlhbGx5IG9wZW5lZCBidWcgIzIxODUwMCByZWdhcmRp
bmcgdGhlIGxhY2sgb2Ygc3VwcG9ydCBmb3IgUzMuDQo+ID4gV2hpbGUgdHJ5aW5nIHRvIGRlYnVn
IHRoaXMsIEkgc3RhcnQgdXNpbmcgczBpeC1zZWxmdGVzdC10b29sIGFuZCBJDQo+ID4gcmVhbGl6
ZWQgdGhhdCB0aGUgZHJpdmVyIGZvciBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQuIFJU
UzUyNUENCj4gPiBQQ0kgRXhwcmVzcyBDYXJkIFJlYWRlciB3YXMgYmxvY2tpbmcgdGhlIHN1c3Bl
bmQgKHJ0c3hfcGNpKF9zZG1tYykgaXMNCj4gPiB0aGVuIG5vdCBsb2FkZWQpDQo+ID4NCj4gPiBJ
ZiBJIGRpc2FibGUgdGhlIFNEIGNhcmQgcmVhZGVyIGluIHRoZSBCaW9zLCB0aGUgc2NyaXB0IGlz
IG1vcmUgaGFwcHkNCj4gPiAoaXQgYWxzbyBjb21wbGFpbnMgYWJvdXQgdGhlIFJhaWQvaW50ZWwg
UlNUIHRoaW5nLCBidXQgSSBndWVzcyB0aGF0J3MNCj4gPiBhbiBvdGhlciBpc3N1ZSkNCj4gPg0K
PiA+IElzIHRoZXJlIGEgYnVnIGluIHJ0c3hfcGNpKF9zZG1tYyk/DQo+ID4NCg0KSGkgTGF1cmVu
dCwNCg0KQ2FuIHlvdSBoZWxwIHRvIGdldCBQQ0kgY29uZmlndXJhdGlvbiBzcGFjZT8NClR5cGlu
ZyBjbWQgKEI6RDpGIGlzIG91ciBwY2kgcmVhZGVyIHBjaSBhZGRyZXNzKToNCnN1ZG8gbHNwY2kg
LXMgQjpEOkYgLXh4eHggDQoNCldlIG5lZWQgdG8gY2hlY2sgdGhlIHBjaSBzZXR0aW5nIGZyb20g
QklPUyBvbiB5b3VyIE5CDQoNClRoYW5rIHlvdQ0KDQo+ID4gRmlsZTogMjAyNTA3MjItMTYtMjct
czBpeC1vdXRwdXQubG9nICh0ZXh0L3BsYWluKQ0KPiA+IFNpemU6IDEuODUgS2lCDQo+ID4gTGlu
azogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL2F0dGFjaG1lbnQuY2dpP2lkPTMwODQwNA0K
PiA+IC0tLQ0KPiA+IHMwaXgtc2VsZnRlc3QtdG9vbCAtcyBvdXRwdXQNCj4gPg0KPiA+IFlvdSBj
YW4gcmVwbHkgdG8gdGhpcyBtZXNzYWdlIHRvIGpvaW4gdGhlIGRpc2N1c3Npb24uDQo+ID4gLS0N
Cj4gPiBEZWV0LWRvb3QtZG90LCBJIGFtIGEgYm90Lg0KPiA+IEtlcm5lbC5vcmcgQnVnemlsbGEg
KGJ1Z3NwcmF5IDAuMS1kZXYpDQo+ID4NCj4gDQo+IFRoYW5rcyBmb3IgcmVwb3J0aW5nIQ0KPiAN
Cj4gSSBoYXZlIGxvb3BlZCBpbiBSaWNreSB0byBzZWUgaWYgaGUgbWF5IGhhdmUgc29tZSB0aG91
Z2h0cyBhcm91bmQgdGhpcw0KPiBwcm9ibGVtLg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUN
Cg==
