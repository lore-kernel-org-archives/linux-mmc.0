Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261381362;
	Wed, 18 Jun 2025 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214998; cv=none; b=pBb10C+yazJTRQmNl/WscSIb5px5g5E+oLirb1Wr56OK4ZdDYT7uq/6mA6xXfdlXQWVAQED0Ddo0HY8mwp0soZKd8X3ZqjrB2OoiK3iwQ5mPFXGJTMec+yJY2r/dfM8vWXbI2DCkRubS3D/GdoUZcGLh/qjKCgf8oB2N8ZCun6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214998; c=relaxed/simple;
	bh=ak6kVTFoArwDV/4ozE74qsjM9VnnJ3y5qUizMDA0RPU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlaCZedeF+DV4tEOVJy9JdKOkq3eaQBumacIA+OMoEdy2RntqRQb3zWxACIFIO6pgZoRm8RBgkQ6WH66WCXdr6GZeifV/iXo2yiKttpwX4hfmUwcU6GZgQef2d8vdgr2+gSJimzsh5Oqs1osQgpllZCpFlUt0/naG91nZHt/17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=V9brWjey; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="V9brWjey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750214994;
	bh=ak6kVTFoArwDV/4ozE74qsjM9VnnJ3y5qUizMDA0RPU=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=V9brWjey/MQ5R9FzjHwP+8hFRC5Mdjc/FSFzXPmZ4bW3XdyAi3jeUYRsYyelmm8Oz
	 ay2Q8J3o0HY7OkQZ3nLmavnSPmqHsYUfVYTM3DjuLDHiyDbB8/EBsu14iI1Glum0zG
	 qccbl7kenLfdTpkU4AftytDU3lh2KeEuA+pk+hVyGYFQtgK2u+oJmGv7EWTs7xXNv1
	 MhL5N5AdesyHk0KhzFAKr030S/HIvLMlUk4AQYqylDX5d2Tgh4+km5byPtslY6XR6J
	 nOfUaYl0bbKXxQBF3RXA1yOxOxnYCaPYmnSQCgjePQTmHe2AtkStmf50nANOBhCZV6
	 M8q8+sIn2pvYg==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 00565640A0;
	Wed, 18 Jun 2025 10:49:53 +0800 (AWST)
Message-ID: <4e6fd85cc8ed6c4261844842bc2e5e54e5db04e6.camel@codeconstruct.com.au>
Subject: Re: [PATCH 5/8] mmc: sdhci-of-aspeed: Fix null pointer
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cool Lee <cool_lee@aspeedtech.com>, adrian.hunter@intel.com, 
	ulf.hansson@linaro.org, joel@jms.id.au, p.zabel@pengutronix.de, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2025 12:19:53 +0930
In-Reply-To: <20250615035803.3752235-6-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-6-cool_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU3VuLCAyMDI1LTA2LTE1IGF0IDExOjU4ICswODAwLCBDb29sIExlZSB3cm90ZToKPiBQbGF0
Zm9ybSBkYXRhIG1pZ2h0IGJlIG51bGwuCgpDdXJyZW50bHkgaXQgY2FuJ3QgYmU6CgpodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5n
aXQvdHJlZS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFzcGVlZC5jP2g9djYuMTYtcmMyI24z
NzUKCkFyZSB0aGVyZSBmdXR1cmUgY2lyY3Vtc3RhbmNlcyB3aGVyZSBpdCBtYXkgYmUgTlVMTD8K
CkknbSBhbGwgZm9yIHJlZHVjaW5nIHRoZSByZWFzb25pbmcgZnJvbSBnbG9iYWwgdG8gbG9jYWws
IGJ1dCBJIHRoaW5rCnNvbWUgZGlzY3Vzc2lvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugd291bGQg
YmUgZ29vZC4KCj4gCj4gU2lnbmVkLW9mZi1ieTogQ29vbCBMZWUgPGNvb2xfbGVlQGFzcGVlZHRl
Y2guY29tPgo+IC0tLQo+IMKgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hc3BlZWQuYyB8IDcg
KysrKystLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hc3BlZWQuYwo+
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hc3BlZWQuYwo+IGluZGV4IDJiZGQ5M2EzZjkx
Zi4uMjJkZGU5MTVlNTFiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2Yt
YXNwZWVkLmMKPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFzcGVlZC5jCj4gQEAg
LTI0MSw3ICsyNDEsNyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc2RoY2lfc2V0X2Nsb2NrKHN0cnVj
dAo+IHNkaGNpX2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCBjbG9jaykKPiDCoMKgwqDCoMKgwqDC
oMKgc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hvc3Q7Cj4gwqDCoMKgwqDCoMKgwqDC
oHVuc2lnbmVkIGxvbmcgcGFyZW50LCBidXM7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBhc3Bl
ZWRfc2RoY2kgKnNkaGNpOwo+IC3CoMKgwqDCoMKgwqDCoGludCBkaXY7Cj4gK8KgwqDCoMKgwqDC
oMKgaW50IGRpdiA9IDE7Cj4gwqDCoMKgwqDCoMKgwqDCoHUxNiBjbGs7Cj4gwqAKPiDCoMKgwqDC
oMKgwqDCoMKgcGx0Zm1faG9zdCA9IHNkaGNpX3ByaXYoaG9zdCk7Cj4gQEAgLTI1Nyw2ICsyNTcs
OSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc2RoY2lfc2V0X2Nsb2NrKHN0cnVjdAo+IHNkaGNpX2hv
c3QgKmhvc3QsIHVuc2lnbmVkIGludCBjbG9jaykKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKFdBUk5f
T04oY2xvY2sgPiBob3N0LT5tYXhfY2xrKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGNsb2NrID0gaG9zdC0+bWF4X2NsazsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoGlmIChzZGhj
aS0+cGRhdGEpCgpHaXZlbiB0aGlzIHNob3VsZG4ndCBiZSB0aGUgY2FzZSwgcGVyaGFwcyBwcmVj
ZWRlIGl0IHdpdGggYQpXQVJOX09OQ0UoIXNkaGNpLT5wZGF0YSk/CgpBbmRyZXcKCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRpdiA9IHNkaGNpLT5wZGF0YS0+Y2xrX2Rpdl9zdGFy
dDsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoC8qCj4gwqDCoMKgwqDCoMKgwqDCoCAqIFJlZ2FyZGlu
ZyB0aGUgQVNUMjYwMDoKPiDCoMKgwqDCoMKgwqDCoMKgICoKPiBAQCAtMjczLDcgKzI3Niw3IEBA
IHN0YXRpYyB2b2lkIGFzcGVlZF9zZGhjaV9zZXRfY2xvY2soc3RydWN0Cj4gc2RoY2lfaG9zdCAq
aG9zdCwgdW5zaWduZWQgaW50IGNsb2NrKQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBzdXBwb3J0aW5n
IHRoZSB2YWx1ZSAwIGluIChFTU1DMTJDWzc6Nl0sIEVNTUMxMkNbMTU6OF0pLAo+IGFuZCBjYXB0
dXJlCj4gwqDCoMKgwqDCoMKgwqDCoCAqIHRoZSAwLXZhbHVlIGNhcGFiaWxpdHkgaW4gY2xrX2Rp
dl9zdGFydC4KPiDCoMKgwqDCoMKgwqDCoMKgICovCj4gLcKgwqDCoMKgwqDCoMKgZm9yIChkaXYg
PSBzZGhjaS0+cGRhdGEtPmNsa19kaXZfc3RhcnQ7IGRpdiA8IDI1NjsgZGl2ICo9IDIpCj4gewo+
ICvCoMKgwqDCoMKgwqDCoGZvciAoOyBkaXYgPCAyNTY7IGRpdiAqPSAyKSB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidXMgPSBwYXJlbnQgLyBkaXY7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoYnVzIDw9IGNsb2NrKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwoK

