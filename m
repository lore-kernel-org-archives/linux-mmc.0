Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8663EBF2C;
	Thu, 12 Feb 2026 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770881882; cv=none; b=uKgXILbtxRhwJBlnWBiqFnhpoEs01NYLnfabAXfJeElx3OeP+jcXAs80sctW6MRAEddo2fDNOM+8nOxT1vyyS5lIfd5LBI9XGNwrC9NAxsurpkJpaoiy6nMPmZ70/RAJ1r4ar5aBYPB2ifvN82dl2UrLohjDsIsZhR/R5r+upiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770881882; c=relaxed/simple;
	bh=C3SWlHAr67G4cpV6SeO9/o6ehdzk7TarAGvyOicXcs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Oy9K6ShLzAtYEMN0oKnsSUZDIxEyzh9MVobzpwH/LV41ccyLc14wmu2vmQHuuGtdtzyc7zbwUJsbsf4JDys83Nb9kLnvZzNWH4b5VAX3sbBvq2/1c7dfo2EFmaJkB59g8Dv2ETSmgDEr/sSW4tdGtLagAsvIN/wDf9xeKuh5Agg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from hehuan1$eswincomputing.com ( [10.12.96.103] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 12 Feb 2026 15:37:39 +0800 (GMT+08:00)
Date: Thu, 12 Feb 2026 15:37:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Huan He" <hehuan1@eswincomputing.com>
To: "Rob Herring" <robh@kernel.org>
Cc: ulf.hansson@linaro.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jszhang@kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com,
	"Pritesh Patel" <pritesh.patel@einfochips.com>
Subject: Re: Re: [PATCH v1] dt-bindings: mmc: dwcmshc-sdhci: Fix resets
 array validation
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260211221017.GA3976151-robh@kernel.org>
References: <20260211094736.88-1-hehuan1@eswincomputing.com>
 <20260211221017.GA3976151-robh@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b0805c4.368e.19c50c8c197.Coremail.hehuan1@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDH3aBEg41prQoAAA--.40W
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/1tbiAgEQCmmMr4QP9AAB
	st
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IFRoZSBiaW5kaW5nIGRlZmluZXMgdHVwbGUtc3R5bGUgcmVzZXQtbmFtZXMgaXRlbXMgZm9y
IHNvbWUKPiA+IGNvbXBhdGlibGVzLCB3aGljaCBpbXBsaWNpdGx5IGVuZm9yY2VzIGEgZml4ZWQg
YXJyYXkgbGVuZ3RoCj4gPiB2aWEgSlNPTiBTY2hlbWEuCj4gPiAKPiA+IERlZmluaW5nIGdsb2Jh
bCBtYXhJdGVtcyBmb3IgcmVzZXRzIGFuZCByZXNldC1uYW1lcyBjYXVzZXMgdGhlc2UKPiA+IGNv
bnN0cmFpbnRzIHRvIGJlIGludGVyc2VjdGVkIHZpYSBhbGxPZiwgcmVzdWx0aW5nIGluIGFuIGVm
ZmVjdGl2ZQo+ID4gbWluSXRlbXMgZXF1YWwgdG8gdGhlIGdsb2JhbCBtYXhJdGVtcy4gVGhpcyBs
ZWFkcyB0byBkdGJzX2NoZWNrCj4gPiBmYWlsdXJlcyByZXBvcnRpbmcgcmVzZXQgYXJyYXlzIGFz
IHRvbyBzaG9ydCwgZXZlbiB3aGVuIHRoZSBEVFMKPiA+IHByb3ZpZGVzIHRoZSBjb3JyZWN0IG51
bWJlciBvZiBlbnRyaWVzLgo+ID4gCj4gPiBSZW1vdmUgdGhlIGdsb2JhbCBtYXhJdGVtcyBjb25z
dHJhaW50cyBhbmQgbGV0IHRoZSBwZXItY29tcGF0aWJsZQo+ID4gc2NoZW1hIGJyYW5jaGVzIGRl
ZmluZSB0aGUgcmVxdWlyZWQgcmVzZXQgYXJyYXkgc2l6ZXMgZXhwbGljaXRseS4KPiA+IAo+ID4g
Rml4ZXM6IDMwMDA5YTIxZjI1NyAoImR0LWJpbmRpbmdzOiBtbWM6IHNkaGNpLW9mLWR3Y21zaGM6
IEFkZCBFc3dpbiBFSUM3NzAwIikKPiA+IFNpZ25lZC1vZmYtYnk6IFByaXRlc2ggUGF0ZWwgPHBy
aXRlc2gucGF0ZWxAZWluZm9jaGlwcy5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIdWFuIEhlIDxo
ZWh1YW4xQGVzd2luY29tcHV0aW5nLmNvbT4KPiA+IC0tLQo+ID4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9zbnBzLGR3Y21zaGMtc2RoY2kueWFtbCAgICAgICAgIHwgNiAtLS0tLS0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc25wcyxkd2Ntc2hjLXNkaGNpLnlh
bWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3NucHMsZHdjbXNoYy1z
ZGhjaS55YW1sCj4gPiBpbmRleCA3ZTdjNTVkYzI0NDAuLjhhZjU1YTUzYjU2OSAxMDA2NDQKPiA+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc25wcyxkd2Ntc2hj
LXNkaGNpLnlhbWwKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvc25wcyxkd2Ntc2hjLXNkaGNpLnlhbWwKPiA+IEBAIC00OSwxMiArNDksNiBAQCBwcm9wZXJ0
aWVzOgo+ID4gICAgcG93ZXItZG9tYWluczoKPiA+ICAgICAgbWF4SXRlbXM6IDEKPiA+ICAKPiA+
IC0gIHJlc2V0czoKPiA+IC0gICAgbWF4SXRlbXM6IDUKPiA+IC0KPiA+IC0gIHJlc2V0LW5hbWVz
Ogo+ID4gLSAgICBtYXhJdGVtczogNQo+IAo+IE5vLCBhZGQgJ21pbkl0ZW1zJyB0aGF0IGNvdmVy
cyB0aGUgd2hvbGUgcmFuZ2UgbmVlZGVkLgoKVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGFraW5n
IHRoZSB0aW1lIHRvIHJldmlldyB0aGUgcGF0Y2ggYW5kIGZvciB5b3VyCnZhbHVhYmxlIGZlZWRi
YWNrLgoKSSBoYXZlIGNoZWNrZWQgb3RoZXIgdmVuZG9ycyBpbiB0aGUga2VybmVsIHRoYXQgdXNl
IHRoZSByZXNldHMgcHJvcGVydHkuClRoZSBtaW5pbXVtIG51bWJlciBpbiBhY3R1YWwgdXNlIGlz
IDQgKEVzd2luIHVzZXMgNCwgb3RoZXJzIHVzZSA1KS4KCklzIGl0IHJlYXNvbmFibGUgdG8gYWRk
ICJtaW5JdGVtczogMSI/CgpCZXN0IHJlZ2FyZHMsCkh1YW4gSGUK
