From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 21/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:11:13 -0800
Message-ID: <8C0DD4AF-253D-47E2-88BC-90375FE7A782@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_8C0DD4AF253D47E288BC90375FE7A782marvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43607 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752007Ab0LVHPo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:15:44 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_8C0DD4AF253D47E288BC90375FE7A782marvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 510b7871a7613ef56fd5f7818415d6c0c85ad7dc Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Mon, 20 Dec 2010 21:51:51 -0800
Subject: [PATCH] sdhci: add support for H/W clock gating of SD controller

MMP2 controller allows clock gating for SD/eMMC/SDIO cards
by extending the definition for SDCTRL_2_ASYNC_INT_EN in the
host control register 2. The SD Host Controller spec
defines this bit (14) for use with SDIO.

Use standard values in sdhci.h for register.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
Tested-by: Philip Rakity
---
 drivers/mmc/host/sdhci-mmp2.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-mmp2.c b/drivers/mmc/host/sdhci-mmp2.c
index 6824177..7303421 100644
--- a/drivers/mmc/host/sdhci-mmp2.c
+++ b/drivers/mmc/host/sdhci-mmp2.c
@@ -39,7 +39,6 @@
=20
 #define DRIVER_NAME "sdhci-mmp2"
=20
-#define HOST_CTRL_2		0x3E
 #define ASYNC_INT_EN		(1 << 14)
=20
 #define SD_CFG_FIFO_PARAM       0x100
@@ -148,9 +147,9 @@ static void programFIFO(struct sdhci_host *host, int en=
able)
 	tmp =3D readw(host->ioaddr + HOST_CTRL_2);
=20
 	if (enable)
-		tmp |=3D ASYNC_INT_EN;
+		tmp |=3D SDCTRL_2_ASYNC_INT_EN;
 	else
-		tmp &=3D ~ASYNC_INT_EN;
+		tmp &=3D ~SDCTRL_2_ASYNC_INT_EN;
=20
 	writew(tmp, host->ioaddr + HOST_CTRL_2);
 }
--=20
1.6.0.4

--_002_8C0DD4AF253D47E288BC90375FE7A782marvellcom_
Content-Type: application/octet-stream;
	name="0021-sdhci-add-support-for-H-W-clock-gating-of-SD-contro.patch"
Content-Description: 0021-sdhci-add-support-for-H-W-clock-gating-of-SD-contro.patch
Content-Disposition: attachment;
	filename="0021-sdhci-add-support-for-H-W-clock-gating-of-SD-contro.patch";
	size=1369; creation-date="Tue, 21 Dec 2010 23:11:13 GMT";
	modification-date="Tue, 21 Dec 2010 23:11:13 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1MTBiNzg3MWE3NjEzZWY1NmZkNWY3ODE4NDE1ZDZjMGM4NWFkN2RjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBNb24sIDIwIERlYyAyMDEwIDIxOjUxOjUxIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IGFkZCBzdXBwb3J0IGZvciBIL1cgY2xvY2sgZ2F0aW5nIG9mIFNEIGNvbnRyb2xsZXIKCk1N
UDIgY29udHJvbGxlciBhbGxvd3MgY2xvY2sgZ2F0aW5nIGZvciBTRC9lTU1DL1NESU8gY2FyZHMK
YnkgZXh0ZW5kaW5nIHRoZSBkZWZpbml0aW9uIGZvciBTRENUUkxfMl9BU1lOQ19JTlRfRU4gaW4g
dGhlCmhvc3QgY29udHJvbCByZWdpc3RlciAyLiBUaGUgU0QgSG9zdCBDb250cm9sbGVyIHNwZWMK
ZGVmaW5lcyB0aGlzIGJpdCAoMTQpIGZvciB1c2Ugd2l0aCBTRElPLgoKVXNlIHN0YW5kYXJkIHZh
bHVlcyBpbiBzZGhjaS5oIGZvciByZWdpc3Rlci4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcCBSYWtp
dHkgPHByYWtpdHlAbWFydmVsbC5jb20+ClNpZ25lZC1vZmYtYnk6IE1hcmsgRi4gQnJvd24gPG1h
cmtiQG1hcnZlbGwuY29tPgpUZXN0ZWQtYnk6IFBoaWxpcCBSYWtpdHkKLS0tCiBkcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLW1tcDIuYyB8ICAgIDUgKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktbW1wMi5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1tbXAyLmMKaW5kZXggNjgyNDE3
Ny4uNzMwMzQyMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1tbXAyLmMKKysr
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1tbXAyLmMKQEAgLTM5LDcgKzM5LDYgQEAKIAogI2Rl
ZmluZSBEUklWRVJfTkFNRSAic2RoY2ktbW1wMiIKIAotI2RlZmluZSBIT1NUX0NUUkxfMgkJMHgz
RQogI2RlZmluZSBBU1lOQ19JTlRfRU4JCSgxIDw8IDE0KQogCiAjZGVmaW5lIFNEX0NGR19GSUZP
X1BBUkFNICAgICAgIDB4MTAwCkBAIC0xNDgsOSArMTQ3LDkgQEAgc3RhdGljIHZvaWQgcHJvZ3Jh
bUZJRk8oc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIGludCBlbmFibGUpCiAJdG1wID0gcmVhZHco
aG9zdC0+aW9hZGRyICsgSE9TVF9DVFJMXzIpOwogCiAJaWYgKGVuYWJsZSkKLQkJdG1wIHw9IEFT
WU5DX0lOVF9FTjsKKwkJdG1wIHw9IFNEQ1RSTF8yX0FTWU5DX0lOVF9FTjsKIAllbHNlCi0JCXRt
cCAmPSB+QVNZTkNfSU5UX0VOOworCQl0bXAgJj0gflNEQ1RSTF8yX0FTWU5DX0lOVF9FTjsKIAog
CXdyaXRldyh0bXAsIGhvc3QtPmlvYWRkciArIEhPU1RfQ1RSTF8yKTsKIH0KLS0gCjEuNi4wLjQK
Cg==

--_002_8C0DD4AF253D47E288BC90375FE7A782marvellcom_--
