Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955753770B
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077976; cv=none; b=hNx0H1d3p2r6GBfjDbfLaivM7L2WRmWkoBRMovqV5E7APHuWBAQ03hbTD234icIUO09ITfzi9QwqXFtY6W1qBaREBdKEoR9QHpTnZGylRwxnHedamxPHdPTggAi0ZEUepabEBXzVwXZBKvtG81DGqhXORXmbUiKCK2dUX9x4E4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077976; c=relaxed/simple;
	bh=xhAsizw0KL9TOlyjKHfynyAEVI1vBc9HaSgWvnRqZKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k39Dm0OeIaTK+DX0H1SGtJRNw1q/xPJaDhhuy2G4ICHCt8ePDHmH25A6Z46KDz1Lc9VOCvgTn648L5ALHEpP/I1DqTm/4GqVFNw8VVgrMia2qiXhhn1v/waXEj/BVefo/OnQbBtmUzDnYAN6NvwBV8/Dw2MujIxoMlU8XfKzpGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBffW0v0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBffW0v0"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b737c6c13e1so458460466b.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 05:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764077973; x=1764682773; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xhAsizw0KL9TOlyjKHfynyAEVI1vBc9HaSgWvnRqZKw=;
        b=EBffW0v0b8k9H+cjDDA55eUGDclNgJZ6VqAjuHTS1BMEvKY4yZWxUsL4TeSLVU+aZ6
         iLsbn1FRRCHA0Z9teSHeILwnlUFaMl1ZpnY3OUN7rhU99jJrtYi6zJzqOU6Zh35r9HxJ
         OS6bJi1mNTM/aISBIbX8Uosu6oTln/ICcZS3a1J34YuS/nHH1rfrNFtS7rsFCIpDslxu
         vOmT6v9OxYBhJtgrnfSCuqoxCWb7SKipBGPsSvazLx2CT7UXdRuC6Oa/SN//qkjhR/tJ
         CAsWzfbbVHygHqQFTtyl4gxo2SzqrqEKALK7datDgANwVBKalKKvehgn9j9wbxBS4ofc
         RVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764077973; x=1764682773;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhAsizw0KL9TOlyjKHfynyAEVI1vBc9HaSgWvnRqZKw=;
        b=UWqn+WeKW5tioshV+joS4MBwMpPJA8Ip1cFpd5R1ueNpjQPpQAfGM+2ekiARblYUWB
         IvXT/k3Mg5DaHbzrmMzcDjiSm6BfWW6bEyV5AlJKKOo8Vcp8IUD5axYcQ/5HxpUCrOUj
         aPQZIPOp6ing9inA5QKCA1No2lHSr8lF6aUr/VR5ScHeR8vyQwqYnQAL1q7dOvjT4Ri0
         ZJBeh18SjJx8eK9whShUAHfKXEJHePlE67DoHQlxIiBLnMYb481RB9t4PM/3w9ZGUIpL
         HZf72W3LDDD8O20qAnrAkeG44tjC9wgPekgOAUSgkbVGG1wlL3tq9VCr9Ta2wApdsL5I
         Ip4A==
X-Forwarded-Encrypted: i=1; AJvYcCU7UGcu++PSmW9QwI4vvf/tpgMQR6QX2Oqpm1fguG55GFgzXlLjOenrJbE3hbEZUmb/XY9wEmW81Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxou7X7hWc7oSVUeUC67wYgoY80nJ3LEjbPk3I7nX2QbMNZTCOI
	6KSexXwV731G2FprBZeY5Xpg9VYhB0CN7DrUlLYZ2eCgwrtOOdgyU7CH
X-Gm-Gg: ASbGncvAwVWSVE0vRXFb5B55m8mrhUxn/ucPWRoVkls/Wb6K3PcYJuM90ug2vNjDb+f
	d9hcAIn0vIqr7wEFI0sn6UjBG3VVqNJ/iAB5qCBalaa+UElgZpkN9n1ybNvkkN/mQRYM5oI7EfT
	H5tg4YY22cWqg0PHCGFQ6Mgq3BrnujHkpQH3jG8ek+kBtPTPak5A6qSIB7E1qmnD/0eekVLY2X9
	rSpl0WmQu2OcO6uzSY3kG909gudKfxP0SpgcObbLesU4OD2EW0Dk0fD4x/w4XkLF3X4Do4GjJV7
	WcESGM5BL1wDU2oW0HYYYz7Ylanu0ihd8Axc4RCNQkuVyyveDeH3umw6lNHDZRRZI7dhlGXmtNv
	xYdAScms4Yl8A1i9NEUqizp0sy6h6qThxryCGGok6rfSfBWCicnOzcHzhTPqDNHGthfkty94Khe
	zABmGGAa6kv/RgBw==
X-Google-Smtp-Source: AGHT+IFKdtbtXkD8+64SstNoM+b5qwKDxuBue6K95YTTT+4Zet+Kw98HXFpGQkOXDBmDPf0lYbNcDA==
X-Received: by 2002:a17:906:c108:b0:b72:6383:4c57 with SMTP id a640c23a62f3a-b76c566d315mr321360366b.55.1764077972747;
        Tue, 25 Nov 2025 05:39:32 -0800 (PST)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd60csm1595699466b.3.2025.11.25.05.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 05:39:31 -0800 (PST)
Message-ID: <4a9236e8a4172437874291da221ef8b82d4a1126.camel@gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@gmail.com>, Ulf Hansson
 <ulf.hansson@linaro.org>,  linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Date: Tue, 25 Nov 2025 14:39:30 +0100
In-Reply-To: <20251122070442.111690-3-avri.altman@sandisk.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
	 <20251122070442.111690-3-avri.altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

QXZyaSwgCgpXZeKAmXJlIGF3YXJlIG9mIHRoaXMgaXNzdWUgYW5kIGFwcHJlY2lhdGUgeW91ciBh
dHRlbnRpb24gdG8gaXQuIEhlcmUgYXJlIHR3bwpjb21tZW50cyByZWdhcmRpbmcgdGhlIGNoYW5n
ZToKCj4gwqBkcml2ZXJzL21tYy9jb3JlL2NhcmQuaMKgwqAgfCA1ICsrKysrCj4gwqBkcml2ZXJz
L21tYy9jb3JlL21tYy5jwqDCoMKgIHwgNyArKysrKystCj4gwqBkcml2ZXJzL21tYy9jb3JlL3F1
aXJrcy5oIHwgMyArKysKPiDCoGluY2x1ZGUvbGludXgvbW1jL2NhcmQuaMKgIHwgMSArCj4gwqA0
IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9jYXJkLmggYi9kcml2ZXJzL21tYy9jb3JlL2NhcmQu
aAo+IGluZGV4IDEyMDA5NTFiYWIwOC4uMGQxOTA0ZDg3YTM5IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvbW1jL2NvcmUvY2FyZC5oCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9jYXJkLmgKPiBAQCAt
MzA1LDQgKzMwNSw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IG1tY19jYXJkX25vX3Voc19kZHI1MF90
dW5pbmcoY29uc3QKPiBzdHJ1Y3QgbW1jX2NhcmQgKmMpCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVy
biBjLT5xdWlya3MgJiBNTUNfUVVJUktfTk9fVUhTX0REUjUwX1RVTklORzsKPiDCoH0KPiDCoAo+
ICtzdGF0aWMgaW5saW5lIGludCBtbWNfY2FyZF9icm9rZW5fbWR0KGNvbnN0IHN0cnVjdCBtbWNf
Y2FyZCAqYykKPiArewo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBjLT5xdWlya3MgJiBNTUNfUVVJ
UktfQlJPS0VOX01EVDsKPiArfQo+ICsKPiDCoCNlbmRpZgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9tbWMvY29yZS9tbWMuYwo+IGluZGV4IDRjMzYwMjli
MjhhMy4uNTY0YTVmYjRkZDk2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMK
PiArKysgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jCj4gQEAgLTY3Niw3ICs2NzYsMTIgQEAgc3Rh
dGljIGludCBtbWNfZGVjb2RlX2V4dF9jc2Qoc3RydWN0IG1tY19jYXJkICpjYXJkLCB1OAo+ICpl
eHRfY3NkKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogQWRqdXN0IHByb2R1Y3Rpb24gZGF0ZSBhcyBwZXIgSkVERUMgSkM2NC4xICovCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY2FyZC0+Y2lkLnll
YXIgPCAyMDIzKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNhcmQtPmNpZC55ZWFyICs9IDE2Owo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ug
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEhh
bmRsZSB2ZW5kb3JzIHdpdGggYnJva2VuIE1EVCByZXBvcnRpbmcgKi8KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobW1jX2NhcmRfYnJva2VuX21k
dChjYXJkKSAmJiBjYXJkLT5jaWQueWVhciA+PQo+IDIwMTAKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICYmIGNhcmQtPmNpZC55ZWFyIDw9
IDIwMTIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNhcmQtPmNpZC55ZWFyICs9IDE2OwoKVGhpcyBvbmx5IGFwcGxpZXMg
dG8gdGhlIGVNTUMgd2l0aCBFWFRfQ1NEIHZlcnNpb24gOD8KCmlmIChjYXJkLT5leHRfY3NkLnJl
diA9PSA4KSB7CglpZiAobW1jX2NhcmRfYnJva2VuX21kdChjYXJkKSAmJgoKCgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDCoG91
dDoKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaCBiL2RyaXZlcnMvbW1j
L2NvcmUvcXVpcmtzLmgKPiBpbmRleCBjNDE3ZWQzNGMwNTcuLjdiZmQwN2FkM2Q3ZCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oCj4gKysrIGIvZHJpdmVycy9tbWMvY29y
ZS9xdWlya3MuaAo+IEBAIC0xNTMsNiArMTUzLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtbWNf
Zml4dXAgX19tYXliZV91bnVzZWQKPiBtbWNfYmxrX2ZpeHVwc1tdID0gewo+IMKgwqDCoMKgwqDC
oMKgwqBNTUNfRklYVVAoIk02MjcwNCIsIENJRF9NQU5GSURfS0lOR1NUT04sIDB4MDEwMCwgYWRk
X3F1aXJrX21tYywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1NQ19RVUlS
S19UUklNX0JST0tFTiksCj4gwqAKPiArwqDCoMKgwqDCoMKgwqAgTU1DX0ZJWFVQKENJRF9OQU1F
X0FOWSwgQ0lEX01BTkZJRF9TQU5ESVNLLCBDSURfT0VNSURfQU5ZLAo+IGFkZF9xdWlya19tbWMs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1NQ19RVUlSS19CUk9LRU5fTURU
KSwKClRoZSBxdWlyayBpcyBhZGRlZCB0byBtbWNfYmxrX2ZpeHVwc1tdLCBidXQgaXQgbmVlZHMg
dG8gYmUgaW4KbW1jX2V4dF9jc2RfZml4dXBzW10gaW5zdGVhZD8gCgoKS2luZCByZWdhcmRzLCAK
QmVhbgoK

