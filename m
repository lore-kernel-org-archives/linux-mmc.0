Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC7350A13;
	Fri,  9 Jan 2026 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947720; cv=none; b=g6eijMAFuSZuYfXuEYOshGRIElrSl+HSwY8grj2nEwZPI51153nJNOJgs2pCwimv32j6PeN4nCniXuYEU6r7ctYNN3K2Wk1jxHgUw3TkYR5Dfxv//G8gZXvgZOmhgvyWDVnJ/d4I6zDviq5K4U1SB7/m3hv1xJpXtf6fagA6/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947720; c=relaxed/simple;
	bh=Wghj4OlmJ2195DJjTDCPF4ybE2QI40FhH7B1YqJCmR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=JLUvzQ7YHjYD1EmW874lrQ7dRDRvMzE4hwMnlz0Vwmek4hRUob1CFBa60Dac+ik7NWr2DP4CEhU/FJ7/6GMvEqkFYIoFs86Wphy43ZvP+Qa8jUZkWTgRQfO93pvpNy2myX+SoRlcUcj7P8bmr19tSnuA4SGWth4xBXGxk5uFBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from hehuan1$eswincomputing.com ( [10.12.96.103] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 9 Jan 2026 16:35:10 +0800 (GMT+08:00)
Date: Fri, 9 Jan 2026 16:35:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Huan He" <hehuan1@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com
Subject: Re: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: fix init for AXI clock
 and DMA 128MB boundary
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <4ae22253-455e-44ef-8774-47dfae3c4674@kernel.org>
References: <20260109032810.204-1-hehuan1@eswincomputing.com>
 <4ae22253-455e-44ef-8774-47dfae3c4674@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3684f310.2189.19ba1e52e5f.Coremail.hehuan1@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDnK6++vWBpbm+SAA--.6482W
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/1tbiAQECCmlf3AoYdwAB
	sG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IAo+ID4gMS5BY2Nlc3NpbmcgdGhlIEhpZ2gtU3BlZWQgcmVnaXN0ZXJzIHJlcXVpcmVzIHRo
ZSBBWEkgY2xvY2sgdG8gYmUgZW5hYmxlZC4KPiA+IDIuVGhpcyBEV0MgTVNIQyBoYXMgYSAxMjhN
QiBsaW1pdGF0aW9uIHdoZXJlIHRoZSBkYXRhIGJ1ZmZlciBzaXplIGFuZAo+ID4gICBzdGFydCBh
ZGRyZXNzIG11c3Qgbm90IGV4Y2VlZCB0aGUgMTI4TUIgYm91bmRhcnkuIFJlZ2lzdGVyaW5nIHRo
ZQo+ID4gICBtaXNzaW5nICdhZG1hX3dyaXRlX2Rlc2MnIGNhbGxiYWNrIGZ1bmN0aW9uLgo+ID4g
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIdWFuIEhlIDxoZWh1YW4xQGVzd2luY29tcHV0aW5nLmNvbT4K
PiA+IC0tLQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jIHwgNyArKysr
KysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLW9mLWR3Y21zaGMuYwo+ID4gaW5kZXggNTE5NDljZGUwOTU4Li4xNDdmODA0Njcw
N2YgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYwo+
ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMKPiA+IEBAIC0xNTg4
LDYgKzE1ODgsNyBAQCBzdGF0aWMgaW50IGVpYzc3MDBfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCBzdHJ1Y3QgZHdjbQo+ID4gIHsKPiA+ICAJdTMyIGVt
bWNfY2FwcyA9IE1NQ19DQVAyX05PX1NEIHwgTU1DX0NBUDJfTk9fU0RJTzsKPiA+ICAJdW5zaWdu
ZWQgaW50IHZhbCwgaHNwX2ludF9zdGF0dXMsIGhzcF9wd3JfY3RybDsKPiA+ICsJc3RhdGljIGNv
bnN0IGNoYXIgKiBjb25zdCBjbGtfaWRzW10gPSB7ImF4aSJ9Owo+ID4gIAlzdHJ1Y3Qgb2ZfcGhh
bmRsZV9hcmdzIGFyZ3M7Cj4gPiAgCXN0cnVjdCBlaWM3NzAwX3ByaXYgKnByaXY7Cj4gPiAgCXN0
cnVjdCByZWdtYXAgKmhzcF9yZWdtYXA7Cj4gPiBAQCAtMTYwNSw2ICsxNjA2LDExIEBAIHN0YXRp
YyBpbnQgZWljNzcwMF9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHNkaGNpX2hvc3Qg
Kmhvc3QsIHN0cnVjdCBkd2NtCj4gPiAgCQlyZXR1cm4gcmV0Owo+ID4gIAl9Cj4gPiAgCj4gPiAr
CXJldCA9IGR3Y21zaGNfZ2V0X2VuYWJsZV9vdGhlcl9jbGtzKG1tY19kZXYoaG9zdC0+bW1jKSwg
ZHdjX3ByaXYsCj4gPiArCQkJCQkgICAgQVJSQVlfU0laRShjbGtfaWRzKSwgY2xrX2lkcyk7Cj4g
Cj4gSXMgdGhpcyBjbG9jayAoQUJJKSBhbHJlYWR5IGRvY3VtZW50ZWQ/CgpZZXMsIHRoaXMgY2xv
Y2sgKEFYSSBjbG9jaykgaXMgYWxyZWFkeSBkb2N1bWVudGVkIGluIHRoZSBEZXZpY2UgVHJlZQpi
aW5kaW5nIHNwZWNpZmljYXRpb24uCkluIHRoZSBzbnBzLGR3Y21zaGMtc2RoY2kueWFtbCBiaW5k
aW5nIGRvY3VtZW50LCB0aGUgQVhJIGNsb2NrIGlzIGluY2x1ZGVkCmluIHRoZSBjbG9jayBkZWZp
bml0aW9uczoKCnByb3BlcnRpZXM6CsKgIGNsb2NrczoKwqAgwqAgbWluSXRlbXM6IDEKwqAgwqAg
aXRlbXM6CsKgIMKgIMKgIC0gZGVzY3JpcHRpb246IGNvcmUgY2xvY2sKwqAgwqAgwqAgLSBkZXNj
cmlwdGlvbjogYnVzIGNsb2NrIGZvciBvcHRpb25hbArCoCDCoCDCoCAtIGRlc2NyaXB0aW9uOiBh
eGkgY2xvY2sgZm9yIHJvY2tjaGlwIHNwZWNpZmllZArCoCDCoCDCoCAtIGRlc2NyaXB0aW9uOiBi
bG9jayBjbG9jayBmb3Igcm9ja2NoaXAgc3BlY2lmaWVkCsKgIMKgIMKgIC0gZGVzY3JpcHRpb246
IHRpbWVyIGNsb2NrIGZvciByb2NrY2hpcCBzcGVjaWZpZWQKwqAgY2xvY2stbmFtZXM6CsKgIMKg
IG1pbkl0ZW1zOiAxCsKgIMKgIGl0ZW1zOgrCoCDCoCDCoCAtIGNvbnN0OiBjb3JlCsKgIMKgIMKg
IC0gY29uc3Q6IGJ1cwrCoCDCoCDCoCAtIGNvbnN0OiBheGkKwqAgwqAgwqAgLSBjb25zdDogYmxv
Y2sKwqAgwqAgwqAgLSBjb25zdDogdGltZXIKCkJlc3QgcmVnYXJkcywKSHVhbiBIZQoK
