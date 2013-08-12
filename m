From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH] mmc:bfin_sdh fix build warning in sdh_dma_irq()
Date: Mon, 12 Aug 2013 02:32:51 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE31BC1AF6@NWD2MBX7.ad.analog.com>
References: <1376148055-2539-1-git-send-email-shuah.kh@samsung.com>
 <1376148055-2539-4-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [207.46.163.25] ([207.46.163.25]:22156 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755398Ab3HLCe0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Aug 2013 22:34:26 -0400
In-Reply-To: <1376148055-2539-4-git-send-email-shuah.kh@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>, "cjb@laptop.org" <cjb@laptop.org>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>

QWNrZWQtYnk6IFNvbmljIFpoYW5nPHNvbmljLnpoYW5nQGFuYWxvZy5jb20+DQoNCj4tLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNodWFoIEtoYW4gW21haWx0bzpzaHVhaC5raEBz
YW1zdW5nLmNvbV0NCj5TZW50OiBTYXR1cmRheSwgQXVndXN0IDEwLCAyMDEzIDExOjIxIFBNDQo+
VG86IFpoYW5nLCBTb25pYzsgY2piQGxhcHRvcC5vcmcNCj5DYzogU2h1YWggS2hhbjsgdWNsaW51
eC1kaXN0LWRldmVsQGJsYWNrZmluLnVjbGludXgub3JnOyBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnOw0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHNodWFoa2hhbkBnbWFpbC5jb20N
Cj5TdWJqZWN0OiBbUEFUQ0hdIG1tYzpiZmluX3NkaCBmaXggYnVpbGQgd2FybmluZyBpbiBzZGhf
ZG1hX2lycSgpDQo+DQo+Rml4IHRoZSBmb2xsb3dpbmcgYnVpbGQgd2FybmluZyBpbiBzZGhfZG1h
X2lycSgpDQo+ZHJpdmVycy9tbWMvaG9zdC9iZmluX3NkaC5jOjQ2NjoyOiB3YXJuaW5nOiBmb3Jt
YXQgICAlbHggICBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUNCj5sb25nIHVuc2lnbmVkIGludCAg
LCBidXQgYXJndW1lbnQgNSBoYXMgdHlwZSAgIGludCAgIFstV2Zvcm1hdF0NCj4gICAgICAgZGV2
X2RiZyhtbWNfZGV2KGhvc3QtPm1tYyksICIlcyBlbnRlciwgaXJxX3N0YXQ6IDB4JTA0eFxuIiwg
X19mdW5jX18sDQo+ICAgICAgICAgICAgICAgIGdldF9kbWFfY3Vycl9pcnFzdGF0KGhvc3QtPmRt
YV9jaCkpOw0KPg0KPlNpZ25lZC1vZmYtYnk6IFNodWFoIEtoYW4gPHNodWFoLmtoQHNhbXN1bmcu
Y29tPg0KPi0tLQ0KPiBkcml2ZXJzL21tYy9ob3N0L2JmaW5fc2RoLmMgfCAgICAyICstDQo+IDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPmRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9ob3N0L2JmaW5fc2RoLmMgYi9kcml2ZXJzL21tYy9ob3N0L2JmaW5f
c2RoLmMgaW5kZXgNCj43YjNlMTJmLi42MTE1N2M0IDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbW1j
L2hvc3QvYmZpbl9zZGguYw0KPisrKyBiL2RyaXZlcnMvbW1jL2hvc3QvYmZpbl9zZGguYw0KPkBA
IC00NjMsNyArNDYzLDcgQEAgc3RhdGljIGlycXJldHVybl90IHNkaF9kbWFfaXJxKGludCBpcnEs
IHZvaWQgKmRldmlkKSAgew0KPiAgICAgICBzdHJ1Y3Qgc2RoX2hvc3QgKmhvc3QgPSBkZXZpZDsN
Cj4NCj4tICAgICAgZGV2X2RiZyhtbWNfZGV2KGhvc3QtPm1tYyksICIlcyBlbnRlciwgaXJxX3N0
YXQ6IDB4JTA0bHhcbiIsIF9fZnVuY19fLA0KPisgICAgICBkZXZfZGJnKG1tY19kZXYoaG9zdC0+
bW1jKSwgIiVzIGVudGVyLCBpcnFfc3RhdDogMHglMDR4XG4iLCBfX2Z1bmNfXywNCj4gICAgICAg
ICAgICAgICBnZXRfZG1hX2N1cnJfaXJxc3RhdChob3N0LT5kbWFfY2gpKTsNCj4gICAgICAgY2xl
YXJfZG1hX2lycXN0YXQoaG9zdC0+ZG1hX2NoKTsNCj4gICAgICAgU1NZTkMoKTsNCj4tLQ0KPjEu
Ny4xMC40DQo+DQoNCg==

