Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71B17C96
	for <linux-mmc@vger.kernel.org>; Fri,  9 Aug 2024 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723186448; cv=none; b=SsBwD1b8EXnSetlrzIhoh0qzhUdXv4BZShYpj5+k23RM7hoX8P7zyUreXHohcCRc+w2L9OCPD3dOblDLhX+ueAy+dShpOfkwcmVg8xvgA17k9hoIdHIouXcpRXHOOUUyGn5GPWqhqNUlctWfOcYMkhpn907WosLg8O6kaJ2F5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723186448; c=relaxed/simple;
	bh=vrLqAoFr9t/fVx7iJAmVvPqpTAlVR2hJq2x5tg8T0B8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YgxVYlQseKdApGC5ltn3zC4KinznVQmHLekH+VvnBzZJaqak8KeFQt2VikDDEmX59O8k6aKeu5bdRYWNiSMxkHWGycMWq6I1sr/kVwxYQ6OSKnvNSuEfKLRbD5BqIu6kqle5DJ5J/HMLfORdFZc+FKiUXHfTxminSeHM9owIFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=soICM0xL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="soICM0xL"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4796s1ucD483776, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723186441; bh=vrLqAoFr9t/fVx7iJAmVvPqpTAlVR2hJq2x5tg8T0B8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=soICM0xLay+NzeyOT3Yba0FTpEJztXMExPajNM/WXDie+mgBIJEcIqarhX48UsSS4
	 kplxAkXjKhQMPQHbVcLPbP0GEO+Xi9XFriLZM9h/Xy7mwaHfRPXjMW7R7AxEPIJsQy
	 8vJsc51GRxaOsQrBQvWSsjXKLMFE5HssOjnvyXoBPqky1/9nEPsP2bRV+b0cgtdPA8
	 TXOZa/BxQAIU3sIsHsyZIHtrIbhtF7W2tPOQt2KnqEascZ2A6ErlD6Ic9hAdRsuB46
	 bk/b035WJfcZF4kBSZus8ZV8TdFkvNmwy4r6BWLEcpvqx66EqWu7UZXMvp6Uoeh3iK
	 H8QXjxRpJIKJw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4796s1ucD483776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 14:54:01 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 14:54:02 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Aug 2024 14:54:02 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::2c08:7dc1:82be:6c38]) by
 RTEXMBS01.realtek.com.tw ([fe80::2c08:7dc1:82be:6c38%5]) with mapi id
 15.01.2507.035; Fri, 9 Aug 2024 14:54:02 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 00/10] Add SDUC Support
Thread-Topic: [PATCH v2 00/10] Add SDUC Support
Thread-Index: AQHa6I+w5OjtTFqH0Eu1irEa7dNGv7IefrZA
Date: Fri, 9 Aug 2024 06:54:02 +0000
Message-ID: <1e25e47ddfe84bbb82a2b9c1b6eafe84@realtek.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
In-Reply-To: <20240807060309.2403023-1-avri.altman@wdc.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

SGkgQXZyaSwNCg0KSSB0ZXN0ZWQgdGhpcyBTRFVDIHBhdGNoIGZvciBSZWFsdGVrIGNhcmQgcmVh
ZGVycyBhbmQgaXQgd29ya3MgIA0KDQoNCj4gVWx0cmEgQ2FwYWNpdHkgU0QgY2FyZHMgKFNEVUMp
IHdhcyBhbHJlYWR5IGludHJvZHVjZWQgaW4gU0Q3LjAuICBUaG9zZSBjYXJkcw0KPiBzdXBwb3J0
IGNhcGFjaXR5IGxhcmdlciB0aGFuIDJUQiBhbmQgdXAgdG8gaW5jbHVkaW5nIDEyOFRCLiBUaHVz
LCB0aGUgYWRkcmVzcw0KPiByYW5nZSBvZiB0aGUgY2FyZCBleHBhbmRzIGJleW9uZCB0aGUgMzIt
Yml0IGNvbW1hbmQgYXJndW1lbnQuIFRvIHRoYXQgZW5kLA0KPiBhIG5ldyBjb21tYW5kIC0gQ01E
MjIgaXMgZGVmaW5lZCwgdG8gY2FycnkgdGhlIGV4dHJhIDYtYml0IHVwcGVyIHBhcnQgb2YgdGhl
DQo+IDM4LWJpdCBibG9jayBhZGRyZXNzIHRoYXQgZW5hYmxlIGFjY2VzcyB0byAxMjhUQiBtZW1v
cnkgc3BhY2UuDQo+IA0KPiBTRFVDIGNhcGFjaXR5IGlzIGFnbm9zdGljIHRvIHRoZSBpbnRlcmZh
Y2UgbW9kZTogVUhTLUkgYW5kIFVIUy1JSSDigJMgU2FtZSBhcw0KPiBTRFhDLg0KPiANCj4gVGhl
IHNwZWMgZGVmaW5lcyBzZXZlcmFsIGV4dGVuc2lvbnMvbW9kaWZpY2F0aW9ucyB0byB0aGUgY3Vy
cmVudCBTRFhDIGNhcmRzLA0KPiB3aGljaCB3ZSBhZGRyZXNzIGluIHBhdGNoZXMgMSAtIDEwLiAg
T3RoZXJ3aXNlIHJlcXVpcmVtZW50cyBhcmUgb3V0LW9mLXNjb3BlDQo+IG9mIHRoaXMgY2hhbmdl
LiAgU3BlY2lmaWNhbGx5LCBDTURRIChDTUQ0NCtDTUQ0NSksIGFuZCBFeHRlbnNpb24gZm9yDQo+
IFZpZGVvIFNwZWVkIENsYXNzIChDTUQyMCkuDQo+IA0KPiBGaXJzdCBwdWJsaWNhdGlvbiBvZiBT
RFVDIHdhcyBpbiBbMV0uICBUaGlzIHNlcmllcyB3YXMgZGV2ZWxvcGVkIGFuZCB0ZXN0ZWQNCj4g
c2VwYXJhdGVseSBmcm9tIFsxXSBhbmQgZG9lcyBub3QgYm9ycm93IGZyb20gaXQuDQo+IA0KPiBb
MV0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzk4MjU2Ni8NCj4gDQo+IC0tLQ0KPiBDaGFuZ2Vz
IGluIHYyOg0KPiAgLSBBdHRlbmQga2VybmVsIHRlc3Qgcm9ib3Qgd2FybmluZ3MNCj4gDQo+IC0t
LQ0KPiANCj4gQXZyaSBBbHRtYW4gKDEwKToNCj4gICBtbWM6IHNkOiBTRFVDIFN1cHBvcnQgUmVj
b2duaXRpb24NCj4gICBtbWM6IHNkOiBBZGQgU0QgQ1NEIHZlcnNpb24gMy4wDQo+ICAgbW1jOiBz
ZDogQWRkIEV4dGVuc2lvbiBtZW1vcnkgYWRkcmVzc2luZw0KPiAgIG1tYzogY29yZTogQWRkIG9w
ZW4tZW5kZWQgRXh0IG1lbW9yeSBhZGRyZXNzaW5nDQo+ICAgbW1jOiBob3N0OiBBbHdheXMgdXNl
IG1hbnVhbC1jbWQyMyBpbiBTRFVDDQo+ICAgbW1jOiBjb3JlOiBBZGQgY2xvc2UtZW5kZWQgRXh0
IG1lbW9yeSBhZGRyZXNzaW5nDQo+ICAgbW1jOiBob3N0OiBBZGQgY2xvc2UtZW5kZWQgRXh0IG1l
bW9yeSBhZGRyZXNzaW5nDQo+ICAgbW1jOiBjb3JlOiBBbGxvdyBtbWMgZXJhc2UgdG8gY2Fycnkg
bGFyZ2UgYWRkcmVzc2VzDQo+ICAgbW1jOiBjb3JlOiBBZGQgRXh0IG1lbW9yeSBhZGRyZXNzaW5n
IGZvciBlcmFzZQ0KPiAgIG1tYzogY29yZTogQWRqdXN0IEFDTUQyMiB0byBTRFVDDQo+IA0KPiAg
ZHJpdmVycy9tbWMvY29yZS9ibG9jay5jICB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLQ0KPiAgZHJpdmVycy9tbWMvY29yZS9idXMuYyAgICB8ICA0ICsrKy0NCj4gIGRy
aXZlcnMvbW1jL2NvcmUvY2FyZC5oICAgfCAgMyArKysNCj4gIGRyaXZlcnMvbW1jL2NvcmUvY29y
ZS5jICAgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gIGRy
aXZlcnMvbW1jL2NvcmUvY29yZS5oICAgfCAgMiArLQ0KPiAgZHJpdmVycy9tbWMvY29yZS9xdWV1
ZS5oICB8ICAxICsNCj4gIGRyaXZlcnMvbW1jL2NvcmUvc2QuYyAgICAgfCAxNiArKysrKysrKyst
LS0tDQo+ICBkcml2ZXJzL21tYy9jb3JlL3NkX29wcy5jIHwgMzQgKysrKysrKysrKysrKysrKysr
KysrKystLS0tDQo+IGRyaXZlcnMvbW1jL2NvcmUvc2Rfb3BzLmggfCAgMSArICBkcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLmMgIHwgMzgNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLSAg
aW5jbHVkZS9saW51eC9tbWMvY2FyZC5oICB8ICAyICstDQo+IGluY2x1ZGUvbGludXgvbW1jL2Nv
cmUuaCAgfCAgMSArICBpbmNsdWRlL2xpbnV4L21tYy9ob3N0LmggIHwgIDYgKysrKysNCj4gIGlu
Y2x1ZGUvbGludXgvbW1jL3NkLmggICAgfCAgNCArKysrDQo+ICAxNCBmaWxlcyBjaGFuZ2VkLCAx
NjkgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjI1LjENCg0K
