Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF22260C
	for <linux-mmc@vger.kernel.org>; Wed, 14 May 2025 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747193131; cv=none; b=TNjwDJvi0BllUWPg0Ar07AMf1mkFJ4PvtQis29BKgeNEy2oPqamKuXm0eU0jwp2leIiAvUNLo8bG8G6stsCDNrmSn1H4yhHc7GEMuP7IZm2Ro2hDCsmg3cMP749SAQM700HuzCFnYvMdrLCPLsEqrF24+Bxi51DsC1QftPEZWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747193131; c=relaxed/simple;
	bh=Mc9mXQgSwcQPbjOT+Qs3Pe85a+0ySdSOvWXwnq2Tp80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UG8kvth+ResQmB5Jlg2ZPwONBOuoC3jORMVJCG1TGGixKOoleTFGvKiv0VPJ4ji7RnFGMfzoNFjAjl0NV6ofiD0MJ6uejy+IGSpxbB9jXaUBcFy+PaWv54KJIRuSJzqR7rs2QELyes1npbXzpjyktgKeYytHMv0rTlLJwlmbJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OPgRfYwB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OPgRfYwB"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54E3PICz81139837, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747193119; bh=Mc9mXQgSwcQPbjOT+Qs3Pe85a+0ySdSOvWXwnq2Tp80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OPgRfYwBsFzcDkv+A+xokMxzbxxykSBRrMF1zeT1MDw1u9rmW3yNoYuvM2EYd2EQf
	 4G0RMcz2towuL+fq3AuMmdDmWHhfj9Hw1s9DyB07LQyyxKu1XT5X4lojS//1E+WXj7
	 vJP2z3TOgREk8ii7kVUG7MA09ocbfbVJ7ZaVY6vZwzoM4BhhOiBbXEHqypuuvNi01/
	 Dw+0y8cmPmee7a+xtSgNfueMLifLmk1oWNtzkpGPuUYEaJDg1jJQB0OPSsSaT0bj/v
	 pq0uDDmbpdlKIvp1UoL0AWYwTClqVzHoYe0w5ic7Jf96KtySOUTWwJybarB7wp/CX0
	 szCm+ikCITF6g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54E3PICz81139837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 11:25:19 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 May 2025 11:25:18 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 May 2025 11:25:18 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Wed, 14 May 2025 11:25:18 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "Matwey V. Kornilov"
	<matwey.kornilov@gmail.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: mmc_test framework: failures at rtsx_usb
Thread-Topic: mmc_test framework: failures at rtsx_usb
Thread-Index: AQHbwA8P98EWcfpcGk2ALwHWbNlL+rPRfZiw
Date: Wed, 14 May 2025 03:25:18 +0000
Message-ID: <44f8111b468d4f438991d04d951dc06d@realtek.com>
References: <CAJs94Ebmyf_5BWNvSRa2O+3oEcwnYFN4Zs-BP5_fPqxQsxKvzw@mail.gmail.com>
 <CAPDyKFo-NDg74vVEk_jU6T8vXqigVzhYuVNYjqJ=Ye9nnjE67Q@mail.gmail.com>
In-Reply-To: <CAPDyKFo-NDg74vVEk_jU6T8vXqigVzhYuVNYjqJ=Ye9nnjE67Q@mail.gmail.com>
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

PiBPbiBNb24sIDUgTWF5IDIwMjUgYXQgMjA6NTYsIE1hdHdleSBWLiBLb3JuaWxvdg0KPiA8bWF0
d2V5Lmtvcm5pbG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIZWxsbywNCj4gPg0KPiA+
DQo+ID4gSSd2ZSBqdXN0IHJ1biBtbWNfdGVzdCBzdWl0ZSBvbiBydHN4X3VzYiBtbWMgaG9zdCBj
b250cm9sbGVyIG1vZHVsZQ0KPiA+IHdpdGggUlRTNTE3MCBoYXJkd2FyZSBhdHRhY2hlZC4NCj4g
PiBLZXJuZWwgdmVyc2lvbiBpcyA2LjE0LjAuIFRoZSBmb2xsb3dpbmcgZm91ciB0ZXN0IGhhcyBi
ZWVuIGZhaWxlZDoNCj4gPg0KPiA+IE1heSAwNSAyMTowNjo0NyBsb2NhbGhvc3QubG9jYWxkb21h
aW4ga2VybmVsOiBtbWMwOiBUZXN0IGNhc2UgMTUuDQo+ID4gUHJvcGVyIHhmZXJfc2l6ZSBhdCB3
cml0ZSAoc3RhcnQgZmFpbHVyZSkuLi4NCj4gPiBNYXkgMDUgMjE6MDY6NDcgbG9jYWxob3N0Lmxv
Y2FsZG9tYWluIGtlcm5lbDogbW1jMDogUmVzdWx0OiBGQUlMRUQgTWF5DQo+ID4gMDUgMjE6MDY6
NDcgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogbW1jMDogVGVzdCBjYXNlIDE2Lg0KPiA+
IFByb3BlciB4ZmVyX3NpemUgYXQgcmVhZCAoc3RhcnQgZmFpbHVyZSkuLi4NCj4gPiBNYXkgMDUg
MjE6MDY6NTcgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogbW1jMDogUmVzdWx0OiBGQUlM
RUQgTWF5DQo+ID4gMDUgMjE6MDY6NTcgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogbW1j
MDogVGVzdCBjYXNlIDE3Lg0KPiA+IFByb3BlciB4ZmVyX3NpemUgYXQgd3JpdGUgKG1pZHdheSBm
YWlsdXJlKS4uLg0KPiA+IE1heSAwNSAyMTowNjo1NyBsb2NhbGhvc3QubG9jYWxkb21haW4ga2Vy
bmVsOiBtbWMwOiBSZXN1bHQ6IEZBSUxFRCBNYXkNCj4gPiAwNSAyMTowNjo1NyBsb2NhbGhvc3Qu
bG9jYWxkb21haW4ga2VybmVsOiBtbWMwOiBUZXN0IGNhc2UgMTguDQo+ID4gUHJvcGVyIHhmZXJf
c2l6ZSBhdCByZWFkIChtaWR3YXkgZmFpbHVyZSkuLi4NCj4gPiBNYXkgMDUgMjE6MDc6MDggbG9j
YWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogbW1jMDogUmVzdWx0OiBGQUlMRUQNCj4gPg0KPiA+
IFNob3VsZCBJIG5vcm1hbGx5IHJlcG9ydCBpdCBvciBpdCBpcyBrbm93biBub3QgdG8gd29yaz8N
Cj4gPg0KDQpIaSBNYXR3ZXksDQoNCkkgaGF2ZSBub3QgdXNlZCB0aGUgbW1jX3Rlc3Qgc3VpdGUg
YmVmb3JlLiANCkNvdWxkIHlvdSBwcm92aWRlIG1lIHdpdGggeW91ciBleHBlcmltZW50YWwgcHJv
Y2VkdXJlIGFuZCBzdGVwcz8NCg0KUmlja3kNCg0KPiANCj4gSSBoYXZlIGxvb3BlZCBpbiBSaWNr
eSBXdSBmcm9tIFJlYWx0ZWssIGxldCdzIHNlZSBpZiBoZSBoYXMgc29tZSBjb21tZW50cyB0bw0K
PiB0aGlzLg0KPiANCj4gSSBwZXJzb25hbGx5IGhhdmVuJ3QgdXNlZCBtbWNfdGVzdCBmb3IgcnRz
eF91c2IsIHNvIEkgY2FuJ3QgdGVsbCBpZiB0aGVzZSBhcmUgcmVhbA0KPiBwcm9ibGVtcy4NCj4g
DQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
