Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA01E7660;
	Mon, 14 Sep 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354246; cv=none; b=aOQHjfRbH3dHsDTSAoUTVMWZoYmpThr2SRMuTyasU5haBxdNwaERWR4EmASpOVFWVxcfm96625HXZbDmrieKK3JlUoldtB0RWjMAiNoKPByp6fBJuhFQFR+RKVYAuSaHT038GcLGGLstlD9uXNALpnLJ/jQgz/aAITDTP9T+J9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354246; c=relaxed/simple;
	bh=yqdUUqr89aI+R3momdS13awxkaIkK8le4awmFVKTrw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TxXHOLaV+K7SU9yDbWG6vQGXn4Gyizcq9aEOqiRGB3NIcCnPhVB8TbI8WA6dkN2AQIYlUTu73/hLK82bCvrAE8noPAIJAkSacVGZJ1v62FFDikIGCZUVTwS9eGI3rR2WJ7yU3lEsYScgtrNcAhqcF50M7dGMae+3mT8XxMoHZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=wcqFNbxc; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="wcqFNbxc"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTPS id 68E2ntOV052713
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 14 Sep 2026 10:49:55 +0800 (+08)
	(envelope-from xiaojie.li2@unisoc.com)
Received: from SHDLP.spreadtrum.com (unknown [10.0.1.210])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4hjqLq37s6z2NFXKg;
	Mon, 14 Sep 2026 10:47:31 +0800 (CST)
Received: from zeshmbx09.spreadtrum.com (10.29.3.107) by
 zeshmbx02.spreadtrum.com (10.0.1.210) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 14 Sep 2026 10:49:54 +0800
Received: from zeshmbx09.spreadtrum.com ([fe80::7981:d4bc:3eee:c0be]) by
 zeshmbx09.spreadtrum.com ([fe80::7981:d4bc:3eee:c0be%17]) with mapi id
 15.00.1497.048; Mon, 14 Sep 2026 10:49:54 +0800
From: =?utf-8?B?5p2O5pmT5rSBIChYaWFvamllIExpLzEzMjMzKQ==?=
	<xiaojie.li2@unisoc.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: Ulf Hansson <ulfh@kernel.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        =?utf-8?B?6ZmI5paH6LaFIChXZW5jaGFvIENoZW4p?=
	<Wenchao.Chen@unisoc.com>,
        =?utf-8?B?5byg5aaC5rOJIChSYWluIFpoYW5nKQ==?=
	<Rain.Zhang@unisoc.com>,
        =?utf-8?B?5ZSQ5pyI5p6XIChZdWVsaW4gVGFuZyk=?=
	<yuelin.tang@unisoc.com>,
        "cixi.geng@linux.dev" <cixi.geng@linux.dev>
Subject: [PATCH] mmc: core: Modify the CMD1 transmission interval
Thread-Topic: [PATCH] mmc: core: Modify the CMD1 transmission interval
Thread-Index: AQHdNgR8DmoNOL7mLUCpmwUb62wN6bbHVn+AgAFmtuCAAFoWgIAETeuw
Date: Mon, 14 Sep 2026 02:49:53 +0000
Message-ID: <e92f094cbb354956aa0bf78060bd82cc@zeshmbx09.spreadtrum.com>
References: <20260827091436.1339716-1-xiaojie.li2@unisoc.com>
 <CAPx+jO8Lc3iNNBVjBB33aJYUfdr2EJqpL8mS8weKnZcBaDf0vA@mail.gmail.com>
 <e69a63062a43456097939c622395cc7b@zeshmbx09.spreadtrum.com>
 <CAPx+jO9Sw=pTq-925h0S7Urw2moANp=n+aScfwRxV9Dn642g3Q@mail.gmail.com>
In-Reply-To: <CAPx+jO9Sw=pTq-925h0S7Urw2moANp=n+aScfwRxV9Dn642g3Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 68E2ntOV052713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1789354205;
	bh=yqdUUqr89aI+R3momdS13awxkaIkK8le4awmFVKTrw8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=wcqFNbxc742CA5zizbJmUekG+jDq1Do/4UOb/HMmwEquLTo4CdyTFr2zlgaATzxbA
	 qyp/GRqQMq5/9rO6tjiBe+11jvsdvF0OeElmOTU0EKprWqH6EPa9ip7WS+iFUpYPr4
	 9kTFis52BM+2pQxEpQU3vVKmcGXS/PZriljIj89WCE+xy9OmFt2WT04+X96q/o0K5Z
	 RrtgOstvLUre4PXj5YzTo7jDA1yyvFSjIHR/VOtcEslDi4UjDZGR21WYKnyrfYyO9l
	 eVAu/RzGFagaIDSL4LJi9FgaTpIDl1TY243wllz7aNwlDJdm8NosA8wNXf/9GVFOpG
	 FDEMYk/NVYUkg==

DQo+IE9uIEZyaSwgU2VwIDExLCAyMDI2IGF0IDQ6NDXigK9BTSDmnY7mmZPmtIEgKFhpYW9qaWUg
TGkvMTMyMzMpIDx4aWFvamllLmxpMkB1bmlzb2MuY29tPiB3cm90ZToNCj4NCj4JTm8sIHRoYXQn
cyB0aGUgd2hvbGUgcG9pbnQuIFdlIGRvbid0IHdhbnQgb3BlbiBjb2RlZCBwb2xsaW5nIGxvb3Bz
LCBpdCdzIGp1c3QgYSBuaWdodG1hcmUgdG8gbWFpbnRhaW4uIFBsZWFzZSB0cnkgdG8gZXh0ZW5k
IHRoZSBleGlzdGluZw0KPl9fbW1jX3BvbGxfZm9yX2J1c3koKSBpbnN0ZWFkLg0KDQpVbmRlcnN0
b29kLiBJIHdpbGwgc3RvcCBsb29raW5nIGludG8gYSBkZWRpY2F0ZWQgZnVuY3Rpb24gYW5kIGZv
Y3VzIG9uIGV4dGVuZGluZyB0aGUgZXhpc3RpbmcgX19tbWNfcG9sbF9mb3JfYnVzeSgpIHRvIHN1
cHBvcnQgQ01EMSdzIHNwZWNpZmljIHJlcXVpcmVtZW50cy4NCg0KSSB3aWxsIGZvbGxvdyB1cCB3
aXRoIGFuIHVwZGF0ZSBvbmNlIHRoZSBjb2RlIGlzIGRlYnVnZ2VkLg0KDQpUaGFuayB5b3UgZm9y
IHlvdXIgYWR2aWNlIGFuZCByZXBseS4NCg0KQmVzdCByZWdhcmRzLA0KWGlhb2ppZS5MaQ0KDQot
LS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3Nv
bkBvc3MucXVhbGNvbW0uY29tPiANCuWPkemAgeaXtumXtDogMjAyNuW5tDnmnIgxMeaXpSAyMzo0
Nw0K5pS25Lu25Lq6OiDmnY7mmZPmtIEgKFhpYW9qaWUgTGkvMTMyMzMpIDx4aWFvamllLmxpMkB1
bmlzb2MuY29tPg0K5oqE6YCBOiBVbGYgSGFuc3NvbiA8dWxmaEBrZXJuZWwub3JnPjsgbGludXgt
bW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg6ZmI5paH
6LaFIChXZW5jaGFvIENoZW4pIDxXZW5jaGFvLkNoZW5AdW5pc29jLmNvbT47IOW8oOWmguaziSAo
UmFpbiBaaGFuZykgPFJhaW4uWmhhbmdAdW5pc29jLmNvbT47IOWUkOaciOaelyAoWXVlbGluIFRh
bmcpIDx5dWVsaW4udGFuZ0B1bmlzb2MuY29tPjsgY2l4aS5nZW5nQGxpbnV4LmRldg0K5Li76aKY
OiBSZTogW1BBVENIXSBtbWM6IGNvcmU6IE1vZGlmeSB0aGUgQ01EMSB0cmFuc21pc3Npb24gaW50
ZXJ2YWwNCg0KDQrms6jmhI86IOi/meWwgemCruS7tuadpeiHquS6juWklumDqOOAgumZpOmdnuS9
oOehruWumumCruS7tuWGheWuueWuieWFqO+8jOWQpuWImeS4jeimgeeCueWHu+S7u+S9lemTvuaO
peWSjOmZhOS7tuOAgg0KQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lk
ZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUuDQoNCg0KDQpPbiBGcmksIFNlcCAxMSwgMjAyNiBhdCA0OjQ14oCvQU0g5p2O5pmT
5rSBIChYaWFvamllIExpLzEzMjMzKSA8eGlhb2ppZS5saTJAdW5pc29jLmNvbT4gd3JvdGU6DQo+
DQo+IEhpIFVmZmU6DQo+ICAgICAgICAgVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KPiAgICAg
ICAgIEhvd2V2ZXIsIEkgbm90aWNlZCB0aGF0IF9fbW1jX3BvbGxfZm9yX2J1c3koKSBhbmQgbW1j
X3BvbGxfZm9yX2J1c3koKSBhcmUgaW52b2tlZCBlaXRoZXIgZGlyZWN0bHkgb3IgaW5kaXJlY3Rs
eSBieSBtYW55IG90aGVyIGZ1bmN0aW9ucyB3aXRoaW4gdGhlIE1NQyBkcml2ZXIuDQo+IE1vZGlm
eWluZyB0aGVtIGRpcmVjdGx5IGNvdWxkIHBvdGVudGlhbGx5IGludHJvZHVjZSB1bmludGVuZGVk
IHNpZGUgZWZmZWN0cy4NCj4NCj4gICAgICAgICBXb3VsZCBpdCBiZSBhY2NlcHRhYmxlIHRvIGlt
cGxlbWVudCBhIGRlZGljYXRlZCBmdW5jdGlvbiBzcGVjaWZpY2FsbHkgZm9yIENNRDE/IFdlIGNv
dWxkIGNyZWF0ZSBhIENNRDEtc3BlY2lmaWMgdmFyaWFudCBiYXNlZCBvbiB0aGUgZXhpc3Rpbmcg
X19tbWNfcG9sbF9mb3JfYnVzeSgpLg0KPiBUaGlzIGFwcHJvYWNoIHdvdWxkIHNpZ25pZmljYW50
bHkgbWluaW1pemUgdGhlIHBvdGVudGlhbCBpbXBhY3Qgb24gdGhlIHJlc3Qgb2YgdGhlIGNvZGVi
YXNlLg0KDQpObywgdGhhdCdzIHRoZSB3aG9sZSBwb2ludC4gV2UgZG9uJ3Qgd2FudCBvcGVuIGNv
ZGVkIHBvbGxpbmcgbG9vcHMsIGl0J3MganVzdCBhIG5pZ2h0bWFyZSB0byBtYWludGFpbi4gUGxl
YXNlIHRyeSB0byBleHRlbmQgdGhlIGV4aXN0aW5nDQpfX21tY19wb2xsX2Zvcl9idXN5KCkgaW5z
dGVhZC4NCg0KQW5kIG5leHQgdGltZSwgcGxlYXNlIGRvbid0IHRvcCBwb3N0Lg0KDQpbLi4uXQ0K
DQpLaW5kIHJlZ2FyZHMNClVmZmUNCg==
