Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768B20D4FC
	for <linux-mmc@vger.kernel.org>; Wed, 10 Sep 2025 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532258; cv=pass; b=ceQtivIFXkJGVu0ohJWrHDRotP9ThkKt0oB/vY+U0em7bHq2xgZhaAuETAKEI0otgXBh6WExRVTtB7+NC3H/kt6sTaPIDEu4Y2S/7ZDMtMYh/5Th5KMsGZwQkb2zwtzrpbcsutkPtbFLiajIFFrw5mDplNmtHiwAQsGDoNhedGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532258; c=relaxed/simple;
	bh=QD7FCNIL/a4fX3ktT7h3kQl46FBtF0N/z/TIpN/SuXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g2Mk8GTAQrObIz6tB14KJi72gj2jQDrD8iVkSNhqjT2+4YMuJb9He895SbrK8cSW9q8kieovEM3duXozsrGUxtAhkQLe/yVugllhrVGQ75yvxZM5a+lj8RJbXr7SA8mdpkTjn8Cgv63bFjcb39LJiNNZlVy2D89k7Le0iakxKMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=T9u6Zt+J; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=gNadfN/J; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="T9u6Zt+J";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="gNadfN/J"
ARC-Seal: i=1; a=rsa-sha256; t=1757532240; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=B4m+ejXwlKO6zqXuPzp8zVlp/USBbr4QPD2h0byzsssAvMaZAb4CJoj0Ch+92LyteH
    7hpegqE+SgutebMlbYd8IkJxLXcDKA5BMiWKIPu5uUwslKOM3R8JV9xQ4xSmjepwyayj
    Js64jE48q9Dv3sctzv+itGMdjJKVyx49vq5XhyEfsesAtv7LRDtHKpwZrt1oDT50zBpV
    IEA73pU5XdC8NLEeIGdv4/y3cgoLye5FpoBECHFIYCIX7tS0aPqg8rBaptvHs2V+jcn9
    gsNS9VjhCg0xdtejxohhJ+fF0PNnSHvgpKubxc89cQXEC/FZ7+i/cH8H9Mf8fRzGp+Bk
    w5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757532240;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QD7FCNIL/a4fX3ktT7h3kQl46FBtF0N/z/TIpN/SuXE=;
    b=pU8D3kY4+SdDQrka750BOYRFdqITTaVhCS/tLHr0Gt1vn71CCMx+QSuiS5lEPgMFaF
    NPMQon0VdQTC/31o9izGz+95YySfmRN2YalNArt7sIzuqDWtC1Qh4ypRSh5jNMWMYx86
    qT0TgUevYRPxVyVwYyJ6e/0eG0zvmAsPn+fP6UVtKwMI8z4DedPZ3nA0dkv+2gMh3y+f
    8oYiyH8QdupXTMUwaooSW1BXhN87fvseTkeJIdMGgXoGtnaeHsHPBmUxBEnpBVcO9TKs
    RzV3F4h/76DCZOGh01qVdDOShfZldsk3D5F8JtsmMk6kODXW1882KUPWxDOqxWY09JqO
    75Ww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757532240;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QD7FCNIL/a4fX3ktT7h3kQl46FBtF0N/z/TIpN/SuXE=;
    b=T9u6Zt+JFMQ/qlKnxRu+4WynYFCQ0XvEVwUxz5spbMJymjzoIRHNYyaUGwnOHm5Mmu
    /sJ2vfg4yUoJCBXeq7PZ+RW8doe5UO9Kwomnil+qjuFWsfwsir3sM/MO0gxGVGO5VMyE
    4vEPixDF+TwKMA/DYy6n9PaSFMU1HSYVnfxCPKgEA9ATqfchBfInezs1CErO4YBmtHwv
    LScIz4+H833Z1pAetc61m0fatKady565ATiPND99awas5recJL9tdFriXRX0JQxYBw9u
    FlXa3myh1SgeOHW/J40ITuDd65S0yxGiiA3NklHPas72o6xHxybQ3YVgIZjASVA9uE6Q
    GT0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757532240;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QD7FCNIL/a4fX3ktT7h3kQl46FBtF0N/z/TIpN/SuXE=;
    b=gNadfN/JbThwD76rTZm7mt1tfAcHW7aRWKUyOsokWd7UJnIluPEJA5Ek8WD5cUsMtF
    xz5xN7tuNd/yukZ21kCQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0zNriHg+YfT0rGXGpI/mNGbgRCYDpM5B+4ZihQ5uW4JDhP36UtM="
Received: from p200300c5871f6acc946a666b51a4f26d.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c918AJNxc1Q
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Sep 2025 21:23:59 +0200 (CEST)
Message-ID: <f6e512e657bfa12ac88f2ae153edcad960dfb2c4.camel@iokpp.de>
Subject: Re: [PATCH v1 2/2] mmc: core: Improve RPMB frame handling code
From: Bean Huo <beanhuo@iokpp.de>
To: Avri Altman <Avri.Altman@sandisk.com>, "ulf.hansson@linaro.org"
	 <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	 <linux-mmc@vger.kernel.org>, "jens.wiklander@linaro.org"
	 <jens.wiklander@linaro.org>
Cc: Bean Huo <beanhuo@micron.com>
Date: Wed, 10 Sep 2025 21:23:59 +0200
In-Reply-To: <PH7PR16MB61967841097FC4DC0CA94330E50EA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250909211316.1857198-1-beanhuo@iokpp.de>
	 <20250909211316.1857198-3-beanhuo@iokpp.de>
	 <PH7PR16MB61967841097FC4DC0CA94330E50EA@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI1LTA5LTEwIGF0IDA3OjE2ICswMDAwLCBBdnJpIEFsdG1hbiB3cm90ZToKPiA+
IEZyb206IEJlYW4gSHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+Cj4gPiAKPiA+IFNpbXBsaWZ5IHRo
ZSBzd2l0Y2ggc3RhdGVtZW50IGJ5IGNvbWJpbmluZyBSUE1CX1BST0dSQU1fS0VZIGFuZAo+ID4g
UlBNQl9HRVRfV1JJVEVfQ09VTlRFUgo+ID4gY2FzZXMgd2hpY2ggaGF2ZSBpZGVudGljYWwgdmFs
aWRhdGlvbiBsb2dpYy4gQWRkIFJQTUJfRlJBTUVfU0laRSBtYWNybwo+ID4gYW5kIHJlcGxhY2Ug
YWxsCj4gPiBzaXplb2Yoc3RydWN0IHJwbWJfZnJhbWUpIG9jY3VycmVuY2VzIGZvciBiZXR0ZXIg
bWFpbnRhaW5hYmlsaXR5IGFuZAo+ID4gcmVhZGFiaWxpdHkuCj4gPiAKPiA+IFNpZ25lZC1vZmYt
Ynk6IEJlYW4gSHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+Cj4gPiAtLS0KPiA+IMKgIGRyaXZlcnMv
bW1jL2NvcmUvYmxvY2suYyB8IDM1ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0p
Cj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgYi9kcml2ZXJz
L21tYy9jb3JlL2Jsb2NrLmMKPiA+IGluZGV4IGRkNmNmZmMwZGY3Mi4uN2ZlOWU4Y2MxY2U0IDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jCj4gPiArKysgYi9kcml2ZXJz
L21tYy9jb3JlL2Jsb2NrLmMKPiA+IEBAIC0xMjEsNiArMTIxLDggQEAgc3RydWN0IHJwbWJfZnJh
bWUgewo+ID4gwqAgI2RlZmluZSBSUE1CX1JFQURfREFUQcKgwqDCoMKgwqDCoMKgwqAgMHg0wqDC
oMKgIC8qIFJlYWQgZGF0YSBmcm9tIFJQTUIgcGFydGl0aW9uICovCj4gPiDCoCAjZGVmaW5lIFJQ
TUJfUkVTVUxUX1JFQUTCoMKgwqDCoMKgwqAgMHg1wqDCoMKgIC8qIFJlYWQgcmVzdWx0IHJlcXVl
c3TCoCAoSW50ZXJuYWwpICovCj4gPiAKPiA+ICsjZGVmaW5lIFJQTUJfRlJBTUVfU0laRcKgwqDC
oMKgwqDCoMKgIHNpemVvZihzdHJ1Y3QgcnBtYl9mcmFtZSkKPiBTaW5jZSB5b3Ugb25seSBjaGVj
ayAhPSBhbmQgYWxpZ25tZW50LCBtYXliZSB5b3UgY291bGQgZnVydGhlciBnZW5lcmFsaXplIGl0
IGJ5IHVzaW5nOgo+ICNkZWZpbmUgQ0hFQ0tfU0laRV9ORVEodmFsKSAoKHZhbCkgIT0gc2l6ZW9m
KHN0cnVjdCBycG1iX2ZyYW1lKSkKPiAjZGVmaW5lIENIRUNLX1NJWkVfQUxJR05FRCh2YWwpIElT
X0FMSUdORUQoKHZhbCksIHNpemVvZihzdHJ1Y3QgcnBtYl9mcmFtZSkpCj4gCj4gPiDCoCBzdGF0
aWMgREVGSU5FX01VVEVYKGJsb2NrX211dGV4KTsKPiA+IAo+ID4gwqAgLyoKPiA+IEBAIC0yODY0
LDEyICsyODY2LDEyIEBAIHN0YXRpYyB2b2lkIHNldF9pZGF0YShzdHJ1Y3QgbW1jX2Jsa19pb2Nf
ZGF0YQo+ID4gKmlkYXRhLCB1MzIgb3Bjb2RlLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgICogVGhl
IHNpemUgb2YgYW4gUlBNQiBmcmFtZSBtdXN0IG1hdGNoIHdoYXQncyBleHBlY3RlZCBieSB0aGUK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIGhhcmR3YXJlLgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
ICovCj4gPiAtwqDCoMKgwqDCoMKgIEJVSUxEX0JVR19PTihzaXplb2Yoc3RydWN0IHJwbWJfZnJh
bWUpICE9IDUxMik7Cj4gPiArwqDCoMKgwqDCoMKgIEJVSUxEX0JVR19PTihSUE1CX0ZSQU1FX1NJ
WkUgIT0gNTEyKTsKPiBNYXliZSB3aGlsZSBhdCBpdCBjaGFuZ2UgdGhpcyB0byBzdGF0aWNfYXNz
ZXJ0KCkgPwo+IAo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgIGlkYXRhLT5pYy5vcGNvZGUgPSBv
cGNvZGU7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGlkYXRhLT5pYy5mbGFncyA9IE1NQ19SU1BfUjEg
fCBNTUNfQ01EX0FEVEM7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGlkYXRhLT5pYy53cml0ZV9mbGFn
ID0gd3JpdGVfZmxhZzsKPiA+IC3CoMKgwqDCoMKgwqAgaWRhdGEtPmljLmJsa3N6ID0gc2l6ZW9m
KHN0cnVjdCBycG1iX2ZyYW1lKTsKPiA+ICvCoMKgwqDCoMKgwqAgaWRhdGEtPmljLmJsa3N6ID0g
UlBNQl9GUkFNRV9TSVpFOwo+ID4gwqDCoMKgwqDCoMKgwqDCoCBpZGF0YS0+aWMuYmxvY2tzID0g
YnVmX2J5dGVzIC/CoCBpZGF0YS0+aWMuYmxrc3o7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGlkYXRh
LT5idWYgPSBidWY7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGlkYXRhLT5idWZfYnl0ZXMgPSBidWZf
Ynl0ZXM7Cj4gPiBAQCAtMjg5MywzMiArMjg5NSwyNyBAQCBzdGF0aWMgaW50IG1tY19yb3V0ZV9y
cG1iX2ZyYW1lcyhzdHJ1Y3QgZGV2aWNlCj4gPiAqZGV2LCB1OCAqcmVxLAo+ID4gwqDCoMKgwqDC
oMKgwqDCoCBpZiAoSVNfRVJSKG1kLT5xdWV1ZS5jYXJkKSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKG1kLT5xdWV1ZS5jYXJkKTsKPiA+IAo+ID4g
LcKgwqDCoMKgwqDCoCBpZiAocmVxX2xlbiA8IHNpemVvZigqZnJtKSkKPiA+ICvCoMKgwqDCoMKg
wqAgaWYgKHJlcV9sZW4gPCBSUE1CX0ZSQU1FX1NJWkUpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoCBy
ZXFfdHlwZSA9IGJlMTZfdG9fY3B1KGZybS0+cmVxX3Jlc3ApOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oCBzd2l0Y2ggKHJlcV90eXBlKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgUlBNQl9QUk9H
UkFNX0tFWToKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXFfbGVuICE9
IHNpemVvZihzdHJ1Y3QgcnBtYl9mcmFtZSkgfHwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVzcF9sZW4gIT0gc2l6ZW9mKHN0cnVjdCBycG1iX2ZyYW1lKSkKPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJ
TlZBTDsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdyaXRlID0gdHJ1ZTsKPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oCBjYXNlIFJQTUJfR0VUX1dSSVRFX0NPVU5URVI6Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAocmVxX2xlbiAhPSBzaXplb2Yoc3RydWN0IHJwbWJfZnJhbWUpIHx8Cj4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlc3BfbGVuICE9IHNpemVvZihz
dHJ1Y3QgcnBtYl9mcmFtZSkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
cmVxX2xlbiAhPSBSUE1CX0ZSQU1FX1NJWkUgfHwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVzcF9sZW4gIT0gUlBNQl9GUkFNRV9TSVpFKQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGUgPSBmYWxzZTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdyaXRlID0gKHJlcV90eXBlID09IFJQTUJfUFJPR1JB
TV9LRVkpOwo+IEEgbGl0dGxlIGJpdCBhd2t3YXJkP8KgIE1heWJlIGxlYXZlIHRoaXMgZm9yIG5v
dz8KCkF2cmksIAoKdGhhbmsgeW91IGZvciByZXZpZXdpbmcuIEnigJlsbCBpbmNvcnBvcmF0ZSB5
b3VyIHN1Z2dlc3Rpb25zIGluIHRoZSBuZXh0IHZlcnNpb24uCgpLaW5kIHJlZ2FyZHMsCkJlYW4K


