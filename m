From: Philip Rakity <prakity@marvell.com>
Subject: RE: RE: Bug in mmc.c == stops eMMC toshiba from working - sector
 check not good (PATCH)
Date: Thu, 11 Mar 2010 21:17:10 -0800
Message-ID: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_43E4817426ED174AA81263BCECB4351D131745CF98scvexch3marve_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:45185 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab0CLFRM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Mar 2010 00:17:12 -0500
Received: from maili.marvell.com (maili.marvell.com [10.68.76.51])
	by dakia2.marvell.com (Spam & Virus Firewall) with ESMTP id 09A27E4238
	for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2010 21:17:11 -0800 (PST)
Received: from maili.marvell.com (maili.marvell.com [10.68.76.51]) by dakia2.marvell.com with ESMTP id QXyvfhPqRUCuFyUP for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2010 21:17:11 -0800 (PST)
Received: from MSI-MTA.marvell.com (msi-mta.marvell.com [10.68.76.91])
	by maili.marvell.com (Postfix) with ESMTP id D0AC788166
	for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2010 21:17:11 -0800 (PST)
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Nicolas Pitre <nico@marvell.com>, Lennert Buijtenhek <buytenh@marvell.com>, Philip Rakity <prakity@marvell.com>

--_002_43E4817426ED174AA81263BCECB4351D131745CF98scvexch3marve_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

MMC 4.4 Spec JEDEC Standard No. 84-A44 says CMD1 response from card
has bit 30 set if card is high capacity.  (page 111 - Section 8.1)

Toshiba flash <=3D 2GB has EXT_CSD sectors but does not support
High Capacity but because of bad test -- card was put into sector mode
causing failure.

Signed-off-by: Philip Rakity <prakity@marvell.com>

diff -ru linux-2.6.32.8/drivers/mmc/core/mmc.c linux-2.6.32.8 copy/drivers/=
mmc/core/mmc.c
--- linux-2.6.32.8/drivers/mmc/core/mmc.c	2010-02-09 04:57:19.000000000 -08=
00
+++ linux-2.6.32.8 copy/drivers/mmc/core/mmc.c	2010-03-11 14:15:03.00000000=
0 -0800
@@ -221,8 +221,6 @@
 			ext_csd[EXT_CSD_SEC_CNT + 1] << 8 |
 			ext_csd[EXT_CSD_SEC_CNT + 2] << 16 |
 			ext_csd[EXT_CSD_SEC_CNT + 3] << 24;
-		if (card->ext_csd.sectors)
-			mmc_card_set_blockaddr(card);
 	}
=20
 	switch (ext_csd[EXT_CSD_CARD_TYPE]) {
@@ -306,6 +304,7 @@
 	int err;
 	u32 cid[4];
 	unsigned int max_dtr;
+	u32 rocr;
=20
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -319,7 +318,7 @@
 	mmc_go_idle(host);
=20
 	/* The extra bit indicates that we support high capacity */
-	err =3D mmc_send_op_cond(host, ocr | (1 << 30), NULL);
+	err =3D mmc_send_op_cond(host, ocr | MMC_CARD_SECTOR_ADDR, &rocr);
 	if (err)
 		goto err;
=20
@@ -407,6 +406,9 @@
 		err =3D mmc_read_ext_csd(card);
 		if (err)
 			goto free_card;
+
+		if(rocr & MMC_CARD_SECTOR_ADDR)
+		  mmc_card_set_blockaddr(card);
 	}
=20
 	/*
diff -ru linux-2.6.32.8/include/linux/mmc/mmc.h linux-2.6.32.8 copy/include=
/linux/mmc/mmc.h
--- linux-2.6.32.8/include/linux/mmc/mmc.h	2010-02-09 04:57:19.000000000 -0=
800
+++ linux-2.6.32.8 copy/include/linux/mmc/mmc.h	2010-03-11 13:47:00.0000000=
00 -0800
@@ -202,6 +202,7 @@
  * OCR bits are mostly in host.h
  */
 #define MMC_CARD_BUSY	0x80000000	/* Card Power up status bit */
+#define MMC_CARD_SECTOR_ADDR	0x40000000	/* Card supports sectors */
=20
 /*
  * Card Command Classes (CCC)

--_002_43E4817426ED174AA81263BCECB4351D131745CF98scvexch3marve_
Content-Type: application/octet-stream; name="eMMCHighCapacity.patch"
Content-Description: eMMCHighCapacity.patch
Content-Disposition: attachment; filename="eMMCHighCapacity.patch"; size=1933;
	creation-date="Thu, 11 Mar 2010 14:27:38 GMT";
	modification-date="Thu, 11 Mar 2010 14:27:38 GMT"
Content-Transfer-Encoding: base64

TU1DIDQuNCBTcGVjIEpFREVDIFN0YW5kYXJkIE5vLiA4NC1BNDQgc2F5cyBDTUQxIHJlc3BvbnNl
IGZyb20gY2FyZA0KaGFzIGJpdCAzMCBzZXQgaWYgY2FyZCBpcyBoaWdoIGNhcGFjaXR5LiAgKHBh
Z2UgMTExIC0gU2VjdGlvbiA4LjEpDQoNClRvc2hpYmEgZmxhc2ggPD0gMkdCIGhhcyBFWFRfQ1NE
IHNlY3RvcnMgYnV0IGRvZXMgbm90IHN1cHBvcnQNCkhpZ2ggQ2FwYWNpdHkgYnV0IGJlY2F1c2Ug
b2YgYmFkIHRlc3QgLS0gY2FyZCB3YXMgcHV0IGludG8gc2VjdG9yIG1vZGUNCmNhdXNpbmcgZmFp
bHVyZS4NCg0KU2lnbmVkLW9mZi1ieTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNv
bT4NCg0KZGlmZiAtcnUgbGludXgtMi42LjMyLjgvZHJpdmVycy9tbWMvY29yZS9tbWMuYyBsaW51
eC0yLjYuMzIuOCBjb3B5L2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCi0tLSBsaW51eC0yLjYuMzIu
OC9kcml2ZXJzL21tYy9jb3JlL21tYy5jCTIwMTAtMDItMDkgMDQ6NTc6MTkuMDAwMDAwMDAwIC0w
ODAwDQorKysgbGludXgtMi42LjMyLjggY29weS9kcml2ZXJzL21tYy9jb3JlL21tYy5jCTIwMTAt
MDMtMTEgMTQ6MTU6MDMuMDAwMDAwMDAwIC0wODAwDQpAQCAtMjIxLDggKzIyMSw2IEBADQogCQkJ
ZXh0X2NzZFtFWFRfQ1NEX1NFQ19DTlQgKyAxXSA8PCA4IHwNCiAJCQlleHRfY3NkW0VYVF9DU0Rf
U0VDX0NOVCArIDJdIDw8IDE2IHwNCiAJCQlleHRfY3NkW0VYVF9DU0RfU0VDX0NOVCArIDNdIDw8
IDI0Ow0KLQkJaWYgKGNhcmQtPmV4dF9jc2Quc2VjdG9ycykNCi0JCQltbWNfY2FyZF9zZXRfYmxv
Y2thZGRyKGNhcmQpOw0KIAl9DQogDQogCXN3aXRjaCAoZXh0X2NzZFtFWFRfQ1NEX0NBUkRfVFlQ
RV0pIHsNCkBAIC0zMDYsNiArMzA0LDcgQEANCiAJaW50IGVycjsNCiAJdTMyIGNpZFs0XTsNCiAJ
dW5zaWduZWQgaW50IG1heF9kdHI7DQorCXUzMiByb2NyOw0KIA0KIAlCVUdfT04oIWhvc3QpOw0K
IAlXQVJOX09OKCFob3N0LT5jbGFpbWVkKTsNCkBAIC0zMTksNyArMzE4LDcgQEANCiAJbW1jX2dv
X2lkbGUoaG9zdCk7DQogDQogCS8qIFRoZSBleHRyYSBiaXQgaW5kaWNhdGVzIHRoYXQgd2Ugc3Vw
cG9ydCBoaWdoIGNhcGFjaXR5ICovDQotCWVyciA9IG1tY19zZW5kX29wX2NvbmQoaG9zdCwgb2Ny
IHwgKDEgPDwgMzApLCBOVUxMKTsNCisJZXJyID0gbW1jX3NlbmRfb3BfY29uZChob3N0LCBvY3Ig
fCBNTUNfQ0FSRF9TRUNUT1JfQUREUiwgJnJvY3IpOw0KIAlpZiAoZXJyKQ0KIAkJZ290byBlcnI7
DQogDQpAQCAtNDA3LDYgKzQwNiw5IEBADQogCQllcnIgPSBtbWNfcmVhZF9leHRfY3NkKGNhcmQp
Ow0KIAkJaWYgKGVycikNCiAJCQlnb3RvIGZyZWVfY2FyZDsNCisNCisJCWlmKHJvY3IgJiBNTUNf
Q0FSRF9TRUNUT1JfQUREUikNCisJCSAgbW1jX2NhcmRfc2V0X2Jsb2NrYWRkcihjYXJkKTsNCiAJ
fQ0KIA0KIAkvKg0KZGlmZiAtcnUgbGludXgtMi42LjMyLjgvaW5jbHVkZS9saW51eC9tbWMvbW1j
LmggbGludXgtMi42LjMyLjggY29weS9pbmNsdWRlL2xpbnV4L21tYy9tbWMuaA0KLS0tIGxpbnV4
LTIuNi4zMi44L2luY2x1ZGUvbGludXgvbW1jL21tYy5oCTIwMTAtMDItMDkgMDQ6NTc6MTkuMDAw
MDAwMDAwIC0wODAwDQorKysgbGludXgtMi42LjMyLjggY29weS9pbmNsdWRlL2xpbnV4L21tYy9t
bWMuaAkyMDEwLTAzLTExIDEzOjQ3OjAwLjAwMDAwMDAwMCAtMDgwMA0KQEAgLTIwMiw2ICsyMDIs
NyBAQA0KICAqIE9DUiBiaXRzIGFyZSBtb3N0bHkgaW4gaG9zdC5oDQogICovDQogI2RlZmluZSBN
TUNfQ0FSRF9CVVNZCTB4ODAwMDAwMDAJLyogQ2FyZCBQb3dlciB1cCBzdGF0dXMgYml0ICovDQor
I2RlZmluZSBNTUNfQ0FSRF9TRUNUT1JfQUREUgkweDQwMDAwMDAwCS8qIENhcmQgc3VwcG9ydHMg
c2VjdG9ycyAqLw0KIA0KIC8qDQogICogQ2FyZCBDb21tYW5kIENsYXNzZXMgKENDQykNCg==

--_002_43E4817426ED174AA81263BCECB4351D131745CF98scvexch3marve_--
