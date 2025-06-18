Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A2E7DA6D;
	Wed, 18 Jun 2025 02:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214906; cv=none; b=c7/z1yF7cFJsBdDWS4+b/dyh7gy5XBMu4110Bn0Q5afkKwOgK7ESqk1vGGYrX2RTQwJIXL6ifqrFVLsBjxkq7lHoFCwlDlygsunOLTUBlK59q2Uhqqj7hbwWYJmqkObEJB3lIJtpPovgX2DUJ1Ih5nFPzYPSBQqIW0INAgG+SsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214906; c=relaxed/simple;
	bh=MmG86US1i5lVu0QKL5KZj9VJGyCU6VYH01ff5apDY8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qtCOoFnuIwQs9vQAx4eTRCC6LjDH0vJhsLZy/VVDAxuorPlOXTdSAoUNYPVYISlwtIvWdNXQb/bTTnH+BBITffQqyaSjTpoHWM+1sODJYx7xqy7mk49OTf3i70c+T1HQanLkpGwJUwvOEcXRG5B7xjGBmhcoU1g0KjvJj1ilwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pxbgGIu1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pxbgGIu1"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55I2mI4y93466503, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750214898; bh=MmG86US1i5lVu0QKL5KZj9VJGyCU6VYH01ff5apDY8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pxbgGIu1AoaZZqsTOn9s/YzjAvT22fjrtepnNwACpmc5WDSoxBdy4LZwV2UOGupiN
	 IWBaKnBNQzUWFeNNSSzV12RnOQ8gwvewZVzYmHP4Cuif8oTq3OziQSwSMHwWUrEO+K
	 KGG6JrGqPnIuBrE8kSfFWHUocdGJq7JtYtjv9bc7sE1RpvaLx+D9hO36qEMGKUA32C
	 Q8dXFA4Iq+kZjXLdR94WflVV/vP4uvm6Z3TPDlvKIrEw69JLAoqFpfLSD/09+ayw5O
	 eo+zF0nJZmnzpxsTb3LyIhxAfD09r4OcYMMLuvDsaDI/6IfuSdeEXSeJFtCjzayX2W
	 b0eZi/FWE/3aA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55I2mI4y93466503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 10:48:18 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Jun 2025 10:48:24 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 18 Jun 2025 10:48:24 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Wed, 18 Jun 2025 10:48:24 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] mmc: rtsx_usb_sdmmc: Improve sd_set_power_mode()
Thread-Topic: [PATCH 0/4] mmc: rtsx_usb_sdmmc: Improve sd_set_power_mode()
Thread-Index: AQHb2fkpc9tL27IUrEi8V1hOvXeHv7QG5RoAgAFcnqA=
Date: Wed, 18 Jun 2025 02:48:24 +0000
Message-ID: <20cf2c65afc342aaa0b07c938bd41171@realtek.com>
References: <20250610111633.504366-1-ulf.hansson@linaro.org>
 <CAPDyKFpWrBDQjUdGkhnRVxrYGLMfqmyd9U8Kv44aRZWwhqTG3A@mail.gmail.com>
In-Reply-To: <CAPDyKFpWrBDQjUdGkhnRVxrYGLMfqmyd9U8Kv44aRZWwhqTG3A@mail.gmail.com>
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

PiBPbiBUdWUsIDEwIEp1biAyMDI1IGF0IDEzOjE2LCBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25A
bGluYXJvLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgY29kZSBpbiBzZF9zZXRfcG93ZXJfbW9k
ZSgpIGlzIGEgYml0IG9iZnVzY2F0ZWQgYW5kIGFsc28gaGFzIHNvbWUNCj4gPiBtaW5vciBpc3N1
ZSBpbiBpdHMgZXJyb3ItcGF0aC4gVGhpcyBzbWFsbCBzZXJpZXMgYWRkcmVzc2VzIHRoZXNlIHBy
b2JsZW1zLg0KPiA+DQo+ID4gVWxmIEhhbnNzb24gKDQpOg0KPiA+ICAgbW1jOiBydHN4X3VzYl9z
ZG1tYzogRml4IGVycm9yLXBhdGggaW4gc2Rfc2V0X3Bvd2VyX21vZGUoKQ0KPiA+ICAgbW1jOiBy
dHN4X3VzYl9zZG1tYzogUHJpbnQgZGVidWctbWVzc2FnZXMgYXQgcG93ZXItb24vb2ZmIGVycm9y
cw0KPiA+ICAgbW1jOiBydHN4X3VzYl9zZG1tYzogQ29udmVydCBzZF9zZXRfcG93ZXJfbW9kZSgp
IGludG8gdm9pZA0KPiA+ICAgbW1jOiBydHN4X3VzYl9zZG1tYzogUmUtd29yayB0aGUgY29kZSBp
biBzZF9zZXRfcG93ZXJfbW9kZSgpDQo+ID4NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9ydHN4X3Vz
Yl9zZG1tYy5jIHwgMzENCj4gPiArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCj4gDQo+IFJpY2t5LCBJIHdvdWxkIGFwcHJlY2lhdGUg
eW91ciBmZWVkYmFjayBvbiB0aGVzZSB0b28uIE9yIGF0IGxlYXN0IGFuIGFjay4NCg0KSGkgVWxm
LA0KU29ycnksIEkgZm9yZ290IHRvIHJlcGx5IHRoaXMgcGF0Y2gsDQpUaGlzIHBhdGNoIGlzIGZp
bmUgZm9yIG1lLCBhbmQgdGhpcyBhbHNvIHdvcmsgd2VsbA0KVGhhbmsgeW91DQoNCg0KPiANCj4g
S2luZCByZWdhcmRzDQo+IFVmZmUNCg==
