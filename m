Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD468234964;
	Wed,  3 Jun 2026 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.240.192.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780447356; cv=none; b=SiLUWE670a+43w2gJ9Q4OGCxWYZgUefYvCAD2uGOewI27s++3FdI801guPTlf7B7S+6W5tabUZNBtCyjS2JMNWWmqQRcj1JtNIVUKje3Juw0jpPhwa8DLbk/mtB9xjec8dj0UG5yZWTs4Od1oDiOa/sBW0WiTkheiLy/Z0YndaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780447356; c=relaxed/simple;
	bh=FvT8e6H5bV4Sb478lc4rJq4EaEuMNZ5mkePeXHeOLs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ob26ye1KqOGlPYahkVNQGCZhV/7eqClgd9NkTmMtLHgU9ga7ZxBpXqbcR/rAIYQP8AhnHvaD97KQywiXAwj0mtLp3eyFo8nFu+Okq5f5RYF28C7lS9VT8eHXXNu9Egpv3ph4w2yCzeAOPj7uyEUlvH0wbN32gn7r/n95sojlTDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com; spf=pass smtp.mailfrom=siengine.com; arc=none smtp.client-ip=43.240.192.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siengine.com
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
	by mail03.siengine.com with ESMTPS id 6530gGqX048698
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 08:42:16 +0800 (+08)
	(envelope-from lucas.liu@siengine.com)
Received: from SEEXMB03-2019.siengine.com (SEEXMB03-2019.siengine.com [10.8.1.33])
	by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4gVTRr5D9Qz1T2P;
	Wed,  3 Jun 2026 08:42:16 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB03-2019.siengine.com (10.8.1.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 08:42:15 +0800
Received: from SEEXMB03-2019.siengine.com ([fe80::23e0:1bbb:3ec9:73fe]) by
 SEEXMB03-2019.siengine.com ([fe80::23e0:1bbb:3ec9:73fe%16]) with mapi id
 15.02.2562.037; Wed, 3 Jun 2026 08:42:15 +0800
From: =?gb2312?B?TGl1IEx1Y2FzL8H1saPW+Q==?= <lucas.liu@siengine.com>
To: "ulfh@kernel.org" <ulfh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: =?gb2312?B?16q3ojogW1BBVENIXSBtbWM6IFVwZGF0ZSB0aGUgdmFsdWUgb2YgaW9zLmRy?=
 =?gb2312?B?dl90eXBlIGF0IHRoZSBsb2NhdGlvbiB3aGVyZSBmaXhlZF9kcnZfdHlwZSBp?=
 =?gb2312?Q?s_used?=
Thread-Topic: [PATCH] mmc: Update the value of ios.drv_type at the location
 where fixed_drv_type is used
Thread-Index: AQHc8lTxGDh4CJtnDEOr2Q0v+cFnG7Yr/kTg
Date: Wed, 3 Jun 2026 00:42:15 +0000
Message-ID: <ef0acccc56bb493bbd66661f404082b1@siengine.com>
References: <20260602061001.63579-1-lucas.liu@siengine.com>
In-Reply-To: <20260602061001.63579-1-lucas.liu@siengine.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:mail03.siengine.com 6530gGqX048698

RHVlIHRvIHRoZSBmYWlsdXJlIG9mIHRoZSBwcmV2aW91cyBlbWFpbCB0cmFuc21pc3Npb24sIEkg
YW0gZm9yd2FyZGluZyBpdCBhZ2Fpbi4NCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IGJh
b3podS5saXUgPGx1Y2FzLmxpdUBzaWVuZ2luZS5jb20+IA0Kt6LLzcqxvOQ6IDIwMjbE6jbUwjLI
1SAxNDoxMA0KytW8/sjLOiB1bGZoQGtlcm5lbC5vcmcNCrOty806IGxpbnV4LW1tY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpdSBMdWNhcy/B9bGj1vkg
PGx1Y2FzLmxpdUBzaWVuZ2luZS5jb20+DQrW98ziOiBbUEFUQ0hdIG1tYzogVXBkYXRlIHRoZSB2
YWx1ZSBvZiBpb3MuZHJ2X3R5cGUgYXQgdGhlIGxvY2F0aW9uIHdoZXJlIGZpeGVkX2Rydl90eXBl
IGlzIHVzZWQNCg0KTW9kaWZ5IHRoZSB2YWx1ZSBvZiAiZml4ZWQtZW1tYy1kcml2ZXItdHlwZSIg
aW4gdGhlIGRldmljZSB0cmVlLCBidXQgd2hlbiBjaGVja2luZyAiY2F0IC9zeXMva2VybmVsL2Rl
YnVnL21tYy9pb3MiLCBpdCBpcyBmb3VuZCB0aGF0IHRoZSBkcml2ZXIgdHlwZSBoYXMgbm90IGNo
YW5nZWQuDQpTbywgdXBkYXRlIHRoZSB2YWx1ZSBvZiBpb3MuZHJ2X3R5cGUgYXQgdGhlIGxvY2F0
aW9uIHdoZXJlIGZpeGVkX2Rydl90eXBlIGlzIHVzZWQuDQoNClNpZ25lZC1vZmYtYnk6IGJhb3po
dS5saXUgPGx1Y2FzLmxpdUBzaWVuZ2luZS5jb20+DQotLS0NCiBkcml2ZXJzL21tYy9jb3JlL21t
Yy5jIHwgNyArKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJz
L21tYy9jb3JlL21tYy5jIGluZGV4IDA1NDQ0ZWNmMzkwOS4uNzczZDQ5NmI4NTZhIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KKysrIGIvZHJpdmVycy9tbWMvY29yZS9tbWMu
Yw0KQEAgLTEzNjEsMTQgKzEzNjEsMTUgQEAgc3RhdGljIHZvaWQgbW1jX3NlbGVjdF9kcml2ZXJf
dHlwZShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQpDQogCWNhcmRfZHJ2X3R5cGUgPSBjYXJkLT5leHRf
Y3NkLnJhd19kcml2ZXJfc3RyZW5ndGggfA0KIAkJCW1tY19kcml2ZXJfdHlwZV9tYXNrKDApOw0K
IA0KLQlpZiAoZml4ZWRfZHJ2X3R5cGUgPj0gMCkNCisJaWYgKGZpeGVkX2Rydl90eXBlID49IDAp
IHsNCiAJCWRyaXZlX3N0cmVuZ3RoID0gY2FyZF9kcnZfdHlwZSAmIG1tY19kcml2ZXJfdHlwZV9t
YXNrKGZpeGVkX2Rydl90eXBlKQ0KIAkJCQkgPyBmaXhlZF9kcnZfdHlwZSA6IDA7DQotCWVsc2UN
CisJCWNhcmQtPmhvc3QtPmlvcy5kcnZfdHlwZSA9IGRyaXZlX3N0cmVuZ3RoOw0KKwl9IGVsc2Ug
ew0KIAkJZHJpdmVfc3RyZW5ndGggPSBtbWNfc2VsZWN0X2RyaXZlX3N0cmVuZ3RoKGNhcmQsDQog
CQkJCQkJCSAgIGNhcmQtPmV4dF9jc2QuaHMyMDBfbWF4X2R0ciwNCiAJCQkJCQkJICAgY2FyZF9k
cnZfdHlwZSwgJmRydl90eXBlKTsNCi0NCisJfQ0KIAljYXJkLT5kcml2ZV9zdHJlbmd0aCA9IGRy
aXZlX3N0cmVuZ3RoOw0KIA0KIAlpZiAoZml4ZWRfZHJ2X3R5cGUgPj0gMCAmJiBkcml2ZV9zdHJl
bmd0aCkNCi0tDQoyLjM0LjENCg0K
