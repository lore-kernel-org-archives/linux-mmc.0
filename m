From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2] Enable DMA for Ricoh reader on Lenovo laptops
Date: Tue, 2 Feb 2010 18:17:15 +0200
Message-ID: <201002021817.35773.anarsoul@gmail.com>
References: <201002011111.13010.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3537305.1mcWgbFrQn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:34944 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0BBQSj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2010 11:18:39 -0500
Received: by fxm7 with SMTP id 7so253886fxm.28
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2010 08:18:37 -0800 (PST)
In-Reply-To: <201002011111.13010.anarsoul@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

--nextPart3537305.1mcWgbFrQn
Content-Type: multipart/mixed;
  boundary="Boundary-01=_LAFaLuKr/39Frdh"
Content-Transfer-Encoding: 7bit


--Boundary-01=_LAFaLuKr/39Frdh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: base64
Content-Disposition: inline

0JIg0YHQvtC+0LHRidC10L3QuNC4INC+0YIgMSDRhNC10LLRgNCw0LvRjyAyMDEwIDExOjEwOjUz
INCw0LLRgtC+0YAgVmFzaWx5IEtob3J1emhpY2sg0L3QsNC/0LjRgdCw0Ls6Cj4gUmljb2ggU0Qv
TU1DIGNhcmQgcmVhZGVyIG9uIExlbm92byBsYXB0b3BzICgzMDAwIG4xMDAsIDMwMDAgbjIwMCkg
ZG9lc24ndAo+IGFubm91bmNlIERNQSBjYXBhYmlsaXR5LCBob3dldmVyIGl0IHN1cHBvcnRzIERN
QS4gV2l0aG91dCB0aGlzIHBhdGNoIGF1ZGlvCj4gY2xpY2tzIGFuZCBjdXJzb3IgaXMgamVya3kg
ZHVyaW5nIGNhcmQgYWNjZXNzLgoKSXQgc2VlbXMgdGhhdCBSaWNvaCBSNUM4MjIgY2FyZCByZWFk
ZXIgb24gbWVudGlvbmVkIGxhcHRvcHMgbmVlZCBvbmUgbW9yZSAKcXVpcmsuIEhlcmUncyB1cGRh
dGVkIHBhdGNoLgo=

--Boundary-01=_LAFaLuKr/39Frdh
Content-Type: text/x-patch;
  charset="iso-8859-15";
  name="0001-Enable-DMA-for-Ricoh-reader-on-Lenovo-laptops.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0001-Enable-DMA-for-Ricoh-reader-on-Lenovo-laptops.patch"

=46rom 3b93e891e0e37afefc1f1eca461dcfc3ded879f9 Mon Sep 17 00:00:00 2001
=46rom: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 2 Feb 2010 18:12:54 +0200
Subject: [PATCH v2] Enable DMA for Ricoh reader on Lenovo laptops

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
=2D--
 drivers/mmc/host/sdhci-pci.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 5c3a176..d49e5ff 100644
=2D-- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -80,13 +80,17 @@ struct sdhci_pci_chip {
=20
 static int ricoh_probe(struct sdhci_pci_chip *chip)
 {
=2D	if (chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_IBM)
+	if (chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_IBM ||
+	    chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_LENOVO)
 		chip->quirks |=3D SDHCI_QUIRK_CLOCK_BEFORE_RESET;
=20
 	if (chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_SAMSUNG ||
 	    chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_SONY)
 		chip->quirks |=3D SDHCI_QUIRK_NO_CARD_NO_RESET;
=20
+	if (chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_LENOVO)
+		chip->quirks |=3D SDHCI_QUIRK_FORCE_DMA;
+
 	return 0;
 }
=20
=2D-=20
1.6.6.1


--Boundary-01=_LAFaLuKr/39Frdh--

--nextPart3537305.1mcWgbFrQn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAktoUB8ACgkQRM6pQpltKE5ZKwCfUUxCybDD8p66WbQ8mMGwoVF2
6G0AnicQg5//dG9Z6CfmDIQwBFqvRPGe
=iTJ2
-----END PGP SIGNATURE-----

--nextPart3537305.1mcWgbFrQn--
