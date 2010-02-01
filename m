From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] Enable DMA for Ricoh reader on Lenovo laptops
Date: Mon, 1 Feb 2010 11:10:53 +0200
Message-ID: <201002011111.13010.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2909022.n0jmEJhtnr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:44053 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab0BAJMJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2010 04:12:09 -0500
Received: by fxm20 with SMTP id 20so3969218fxm.21
        for <linux-mmc@vger.kernel.org>; Mon, 01 Feb 2010 01:12:08 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

--nextPart2909022.n0jmEJhtnr
Content-Type: multipart/mixed;
  boundary="Boundary-01=_dqpZLTWt7gA0SF1"
Content-Transfer-Encoding: 7bit


--Boundary-01=_dqpZLTWt7gA0SF1
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ricoh SD/MMC card reader on Lenovo laptops (3000 n100, 3000 n200) doesn't=20
announce DMA capability, however it supports DMA. Without this patch audio=
=20
clicks and cursor is jerky during card access.

--Boundary-01=_dqpZLTWt7gA0SF1
Content-Type: text/x-patch;
  charset="us-ascii";
  name="0001-Enable-DMA-for-Ricoh-reader-on-Lenovo-laptops.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0001-Enable-DMA-for-Ricoh-reader-on-Lenovo-laptops.patch"

=46rom 442d0b0234a20f442cacfd0844bc8128a81638bc Mon Sep 17 00:00:00 2001
=46rom: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 1 Feb 2010 10:55:55 +0200
Subject: [PATCH] Enable DMA for Ricoh reader on Lenovo laptops

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
=2D--
 drivers/mmc/host/sdhci-pci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 5c3a176..ada9d10 100644
=2D-- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -87,6 +87,9 @@ static int ricoh_probe(struct sdhci_pci_chip *chip)
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


--Boundary-01=_dqpZLTWt7gA0SF1--

--nextPart2909022.n0jmEJhtnr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAktmmrAACgkQRM6pQpltKE6UJgCg5joJy78uj6qIu6aHEG5UGmjP
GjoAoLSKio/UVRVMP6WYzVR4YJSkxQm8
=xb5i
-----END PGP SIGNATURE-----

--nextPart2909022.n0jmEJhtnr--
