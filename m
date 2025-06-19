Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAF225401;
	Thu, 19 Jun 2025 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300045; cv=none; b=oT3jfPbaGewbpQP2kmXd0HhtQGsQz4+2Z5fuFlEEBRLBzzBCaAOHtfZq2MWQjjeyEUQ0IGcfvAFegwMUjEoKTU9ebunAU1gSW+Z8h+VMgQ1U7DoSPnTti/8PHBtwolCD1zh4l/boBEfJ+x+3PHd2TFVwDfDca8Nu9WUxO5gOZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300045; c=relaxed/simple;
	bh=CmO0V4MhiwijdnI2vixOA/rCiUTamPcYrYaezBRsFKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=lj/dpJFHsrfZYz8I5XPy6ru2FI3j2bHMUbbB9Ge8vKBo2XuOwAa33JmnEcpsE0J4khCc5UqFcbSS7hKqhD7SPjwnIDd1SJB4SH95I02RfY19RdLy+qDwTRKWJCnaKids91FMY79fzwLyCGTR8pwz3FaCj4DU2YFFIAUf8LRnMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=puwLqr/g; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="puwLqr/g"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55J2RG9l81041051, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750300036; bh=CmO0V4MhiwijdnI2vixOA/rCiUTamPcYrYaezBRsFKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=puwLqr/gVEyuG98GRNwKKt+GnGupgHlVY91TUyMjZ9YhIm3+l5QaNmpiuW4sFjb24
	 7jiQ9TUIMF6L89utE1G9NzQ+2yrJAr5kBelFzGVFUtcY/pKNxuqFCbxKzBn+Ls9Yex
	 6GDXmZH8jMJchKCETlJsqBW9cluPfpPP8YXzTBXHgjEMn0ge0/29GoRSOr1NB8DR/H
	 UFH3icsq9jcf65gfz2WgH9FFS/pvA87CD4Bjdk2ztvvcjApLZu9AviisF0PVr5EWQr
	 qExINbDyB9RUgUCSjjwtNfijDnBhi3RC3ImgPonpfUExkX8bLcXt0EXhiGgukxiZtU
	 IBQOwEeIfgRwA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55J2RG9l81041051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 10:27:16 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Jun 2025 10:27:24 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Jun 2025 10:27:23 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Thu, 19 Jun 2025 10:27:23 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] mmc: rtsx_usb_sdmmc: Improve sd_set_power_mode()
Thread-Topic: [PATCH 0/4] mmc: rtsx_usb_sdmmc: Improve sd_set_power_mode()
Thread-Index: AQHb2fkpc9tL27IUrEi8V1hOvXeHv7QG5RoAgAFcnqCAAYvzEA==
Date: Thu, 19 Jun 2025 02:27:23 +0000
Message-ID: <4273aceac8104c6a95bcf94be2a6e567@realtek.com>
References: <20250610111633.504366-1-ulf.hansson@linaro.org>
 <CAPDyKFpWrBDQjUdGkhnRVxrYGLMfqmyd9U8Kv44aRZWwhqTG3A@mail.gmail.com> 
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmlja3kgV1UNCj4gU2Vu
dDogV2VkbmVzZGF5LCBKdW5lIDE4LCAyMDI1IDEwOjQ4IEFNDQo+IFRvOiAnVWxmIEhhbnNzb24n
IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDAv
NF0gbW1jOiBydHN4X3VzYl9zZG1tYzogSW1wcm92ZQ0KPiBzZF9zZXRfcG93ZXJfbW9kZSgpDQo+
IA0KPiA+IE9uIFR1ZSwgMTAgSnVuIDIwMjUgYXQgMTM6MTYsIFVsZiBIYW5zc29uIDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBUaGUgY29kZSBpbiBzZF9zZXRf
cG93ZXJfbW9kZSgpIGlzIGEgYml0IG9iZnVzY2F0ZWQgYW5kIGFsc28gaGFzDQo+ID4gPiBzb21l
IG1pbm9yIGlzc3VlIGluIGl0cyBlcnJvci1wYXRoLiBUaGlzIHNtYWxsIHNlcmllcyBhZGRyZXNz
ZXMgdGhlc2UNCj4gcHJvYmxlbXMuDQo+ID4gPg0KPiA+ID4gVWxmIEhhbnNzb24gKDQpOg0KPiA+
ID4gICBtbWM6IHJ0c3hfdXNiX3NkbW1jOiBGaXggZXJyb3ItcGF0aCBpbiBzZF9zZXRfcG93ZXJf
bW9kZSgpDQo+ID4gPiAgIG1tYzogcnRzeF91c2Jfc2RtbWM6IFByaW50IGRlYnVnLW1lc3NhZ2Vz
IGF0IHBvd2VyLW9uL29mZiBlcnJvcnMNCj4gPiA+ICAgbW1jOiBydHN4X3VzYl9zZG1tYzogQ29u
dmVydCBzZF9zZXRfcG93ZXJfbW9kZSgpIGludG8gdm9pZA0KPiA+ID4gICBtbWM6IHJ0c3hfdXNi
X3NkbW1jOiBSZS13b3JrIHRoZSBjb2RlIGluIHNkX3NldF9wb3dlcl9tb2RlKCkNCj4gPiA+DQo+
ID4gPiAgZHJpdmVycy9tbWMvaG9zdC9ydHN4X3VzYl9zZG1tYy5jIHwgMzENCj4gPiA+ICsrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5z
ZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IDIuNDMu
MA0KPiA+ID4NCj4gPg0KPiA+IFJpY2t5LCBJIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBmZWVkYmFj
ayBvbiB0aGVzZSB0b28uIE9yIGF0IGxlYXN0IGFuIGFjay4NCj4gDQo+IEhpIFVsZiwNCj4gU29y
cnksIEkgZm9yZ290IHRvIHJlcGx5IHRoaXMgcGF0Y2gsDQo+IFRoaXMgcGF0Y2ggaXMgZmluZSBm
b3IgbWUsIGFuZCB0aGlzIGFsc28gd29yayB3ZWxsIFRoYW5rIHlvdQ0KPiANCkFja2VkLWJ5OiBS
aWNreSBXdSA8cmlja3lfd3VAcmVhbHRlay5jb20+DQo+IA0KPiA+DQo+ID4gS2luZCByZWdhcmRz
DQo+ID4gVWZmZQ0K
