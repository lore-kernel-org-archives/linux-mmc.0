Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6735B130;
	Fri, 24 Oct 2025 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276008; cv=none; b=Vgjc8/7ZYSi7mp1qdOeabTj56gXaiiSg7/c3rYIW+SMFzOETj7zgSmPHX1sC6Ce47c2jMtpZrYf/VqCn0jduaUiS6nPiRWXUYu5c6bEajEMWdYomG7bH/K9Z0v5UIKk2/tdHf0i8wxagM1tqtTxL+tZ6MqfeE1maV6dS8z2k39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276008; c=relaxed/simple;
	bh=SPueU73YSGLkFIRRtlw1lCypIuUFZRrmVNQv9cnSPVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NBuL3koapcxheyW+XTUTmlMhtxUhPsn9Fk0o+yzfDdNLLKrqIHFHiWiAHVIgFk32LXc+pDqXIopGkBfa+zF7oIufyaPqVRWz67ZzboEofJyu7AsqiJGhA5SNBXz1hhzY9O/VgsJUF0Jj/xJ76eoAl1Ir8xxeIXawLJFIHZPXj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from hehuan1$eswincomputing.com ( [10.12.96.103] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 24 Oct 2025 11:19:52 +0800 (GMT+08:00)
Date: Fri, 24 Oct 2025 11:19:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5L2V5qyi?= <hehuan1@eswincomputing.com>
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com, luyulin@eswincomputing.com,
	dongxuyang@eswincomputing.com, zhangsenchuan@eswincomputing.com,
	weishangjuan@eswincomputing.com, lizhi2@eswincomputing.com,
	caohang@eswincomputing.com,
	=?UTF-8?B?5L2V5qyi?= <hehuan1@eswincomputing.com>
Subject: Re: Re: [PATCH v5 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin
 EIC7700
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <9b744e60-a0d7-48c7-b1fb-66df91b839e5@intel.com>
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
 <20251019115316.337-1-hehuan1@eswincomputing.com>
 <9b744e60-a0d7-48c7-b1fb-66df91b839e5@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4dddefe2.63d.19a143ad883.Coremail.hehuan1@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDHZpVY8PpoEgUvAQ--.28428W
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/1tbiAQEFCmj6WH4NSwAA
	s9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgQWRyaWFuLAoKVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBBY2tlZC1ieSBhbmQgdGhl
IHJldmlldyEKCj4gT24gMTkvMTAvMjAyNSAxNDo1MywgaGVodWFuMUBlc3dpbmNvbXB1dGluZy5j
b20gd3JvdGU6Cj4gPiBGcm9tOiBIdWFuIEhlIDxoZWh1YW4xQGVzd2luY29tcHV0aW5nLmNvbT4K
PiA+IAo+ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBtbWMgY29udHJvbGxlciBpbiB0aGUgRXN3aW4g
RUlDNzcwMCB3aXRoIHRoZSBuZXcKPiA+IGNvbXBhdGlibGUgImVzd2luLGVpYzc3MDAtZHdjbXNo
YyIuIEltcGxlbWVudCBjdXN0b20gc2RoY2lfb3BzIGZvcgo+ID4gc2V0X2Nsb2NrLCByZXNldCwg
c2V0X3Voc19zaWduYWxpbmcsIHBsYXRmb3JtX2V4ZWN1dGVfdHVuaW5nLgo+ID4gCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBIdWFuIEhlIDxoZWh1YW4xQGVzd2luY29tcHV0aW5nLmNvbT4KPiAKPiBOb3Rp
bmcgdGhhdCB0aGUgZHQtYmluZGluZ3MgcGF0Y2ggc3RpbGwgc2VlbXMgdG8gaGF2ZSBpc3N1ZXMs
Cj4gZm9yIHRoaXMgcGF0Y2gsIGFueXdheToKPiAKPiBBY2tlZC1ieTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+CgpJIHJlY2lldmVkIGFuIGR0X2JpbmRpbmdfY2hlY2sg
ZXJyb3IgcmVwb3J0OgpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMTc2MDk2MDExMzgwLjIy
OTE3LjE5ODg2NzkzMjEwOTYwNzY1MjIucm9iaEBrZXJuZWwub3JnLwoKSXQgc2VlbXMgdGhlIGVy
cm9yIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggTU1DLCBidXQgaXMgcmVsYXRlZCB0byB0aGUKRXRo
ZXJuZXQgYmluZGluZyAoZXN3aW4sZWljNzcwMC1ldGgueWFtbCksIHRoYXQgd2FzIHB1c2hlZCBi
eSB1cyBhbmQKYXBwbGllZCByZWNlbnRseSwgbGluazoKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldC1uZXh0LmdpdC9jb21taXQvP2lkPTg4
OGJkMGVjYTkzYwoKV2UncmUgZml4aW5nIHRoaXMgaXNzdWUgZm9yIHRoZSBFdGhlcm5ldC4gVGhl
IEV0aGVybmV0IHBhdGNoIHdpdGgKdGhpcyBidWcgZml4IHdpbGwgYmUgc2VudCBvdXQgbGF0ZXIu
CgpJIHdvdWxkIGJlIGdyYXRlZnVsIGZvciB5b3VyIHJlcGx5LgoKUmVnYXJkcywKSHVhbiBIZQo=

