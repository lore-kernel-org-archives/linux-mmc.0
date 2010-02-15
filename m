From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v2] Enable DMA for Ricoh reader on Lenovo laptops
Date: Mon, 15 Feb 2010 18:20:39 +0200
Message-ID: <201002151820.45110.anarsoul@gmail.com>
References: <201002011111.13010.anarsoul@gmail.com> <201002151150.00761.anarsoul@gmail.com> <1266249504.10662.5.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2746475.8CnnaAgiEy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:10749 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab0BOQVD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2010 11:21:03 -0500
Received: by fg-out-1718.google.com with SMTP id 16so119007fgg.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2010 08:21:01 -0800 (PST)
In-Reply-To: <1266249504.10662.5.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mmc@vger.kernel.org

--nextPart2746475.8CnnaAgiEy
Content-Type: multipart/mixed;
  boundary="Boundary-01=_XRXeLRGouPiv9hW"
Content-Transfer-Encoding: 7bit


--Boundary-01=_XRXeLRGouPiv9hW
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
15 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 17:58:24 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Maxim Levitsky =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> Not sure if I need the SDHCI_QUIRK_CLOCK_BEFORE_RESET.

Driver sometimes doesn't detect card without this quirk for me.

> What I don't get is why DMA capability isn't advertised?
>=20
> Since xD and memstick portions do support DMA, I can't belive that they
> don't use DMA in SD/SDHCI portion.=20
>=20
> Ah, I forgot that SDHCI is handled by microsoft driver.... Maybe it
> doesn't test the DMA bits.
>=20
> If we were to follow the way MS driver works, we wouldn't need the
> quirks, right?

We need generic quirk for ricoh readers, see attached patch

Regards
Vasily

--Boundary-01=_XRXeLRGouPiv9hW
Content-Type: text/x-patch;
  charset="utf-8";
  name="0001-Enable-DMA-on-Ricoh-sdhci-reader-by-default.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0001-Enable-DMA-on-Ricoh-sdhci-reader-by-default.patch"

=46rom 9cbd6c6667d8a2fce583e1e2e7c253b75ec1b675 Mon Sep 17 00:00:00 2001
=46rom: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 15 Feb 2010 18:10:41 +0200
Subject: [PATCH] Enable DMA on Ricoh sdhci reader by default

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
=2D--
 drivers/mmc/host/sdhci-pci.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 5c3a176..12f5b09 100644
=2D-- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -80,9 +80,6 @@ struct sdhci_pci_chip {
=20
 static int ricoh_probe(struct sdhci_pci_chip *chip)
 {
=2D	if (chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_IBM)
=2D		chip->quirks |=3D SDHCI_QUIRK_CLOCK_BEFORE_RESET;
=2D
 	if (chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_SAMSUNG ||
 	    chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_SONY)
 		chip->quirks |=3D SDHCI_QUIRK_NO_CARD_NO_RESET;
@@ -92,7 +89,9 @@ static int ricoh_probe(struct sdhci_pci_chip *chip)
=20
 static const struct sdhci_pci_fixes sdhci_ricoh =3D {
 	.probe		=3D ricoh_probe,
=2D	.quirks		=3D SDHCI_QUIRK_32BIT_DMA_ADDR,
+	.quirks		=3D SDHCI_QUIRK_32BIT_DMA_ADDR |
+			  SDHCI_QUIRK_FORCE_DMA |
+			  SDHCI_QUIRK_CLOCK_BEFORE_RESET,
 };
=20
 static const struct sdhci_pci_fixes sdhci_ene_712 =3D {
=2D-=20
1.6.6.1


--Boundary-01=_XRXeLRGouPiv9hW--

--nextPart2746475.8CnnaAgiEy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt5dF0ACgkQRM6pQpltKE7HrwCcDEV42Q47aiOAxkuEjPTepo8n
OswAnRwRA7aQmZyZ0RsOhy6z+LjTjP12
=DmqC
-----END PGP SIGNATURE-----

--nextPart2746475.8CnnaAgiEy--
