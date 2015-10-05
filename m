From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 1/2] mmc: sdhci-pci: Build o2micro support in the same module
Date: Mon, 05 Oct 2015 20:31:18 +0100
Message-ID: <1444073478.2730.308.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-LE7GRpIUb78X+ug+lrVf"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46746 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751676AbbJETbb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 15:31:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Guo <peter.guo@bayhubtech.com>, linux-mmc@vger.kernel.org


--=-LE7GRpIUb78X+ug+lrVf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sdhci-pci-o2micro.c contains no initialisation and its functions are only
called from shdci-pci.c, so there is no reason for it to be a separate
module, let alone or for it to always be built-in.

- Rename sdhci-pci.c to sdhci-pci-core.c so that the sdhci-pci module
  can be built from multiple source files
- Add sdhci-pci-o2micro.c to it
- Remove redundant exports

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/host/Makefile                          | 2 +-
 drivers/mmc/host/{sdhci-pci.c =3D> sdhci-pci-core.c} | 0
 drivers/mmc/host/sdhci-pci-o2micro.c               | 4 ----
 3 files changed, 1 insertion(+), 5 deletions(-)
 rename drivers/mmc/host/{sdhci-pci.c =3D> sdhci-pci-core.c} (100%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4f3452a..3595f83 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -9,8 +9,8 @@ obj-$(CONFIG_MMC_MXC)		+=3D mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+=3D mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+=3D sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+=3D sdhci-pci.o
+sdhci-pci-y			+=3D sdhci-pci-core.o sdhci-pci-o2micro.o
 obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+=3D sdhci-pci-data.o
-obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+=3D sdhci-pci-o2micro.o
 obj-$(CONFIG_MMC_SDHCI_ACPI)	+=3D sdhci-acpi.o
 obj-$(CONFIG_MMC_SDHCI_PXAV3)	+=3D sdhci-pxav3.o
 obj-$(CONFIG_MMC_SDHCI_PXAV2)	+=3D sdhci-pxav2.o
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci-core=
.c
similarity index 100%
rename from drivers/mmc/host/sdhci-pci.c
rename to drivers/mmc/host/sdhci-pci-core.c
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index e2ec108d..9a5e191 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -145,7 +145,6 @@ void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip=
 *chip)
 	scratch_32 |=3D 0x00080000;
 	pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL4, scratch_32);
 }
-EXPORT_SYMBOL_GPL(sdhci_pci_o2_fujin2_pci_init);
=20
 int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
@@ -179,7 +178,6 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot=
)
=20
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sdhci_pci_o2_probe_slot);
=20
 int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 {
@@ -385,11 +383,9 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
=20
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sdhci_pci_o2_probe);
=20
 int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
 {
 	sdhci_pci_o2_probe(chip);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sdhci_pci_o2_resume);

--=20
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source
--=-LE7GRpIUb78X+ug+lrVf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVhLQBue/yOyVhhEJAQohDRAAurVTCDa3hudsX6ZAlUuAWGYiOon2YYTx
tkuNE/p3SJS9SfoPZCYLWIMU/AuEbWEM7YWeZl0v4rMZAhTOkWRK1QymwWFpxGnY
rTb8DZ+PuGo5p2AbQ5Yze5OOeV4tylrLgt8mKBL9P5h2OjPhcajWoUJIq30PtwTc
3HpC+I2m02cTB4TOKl9KM2a8+mX00vNLrXBJkuSa2dHJSkqXg0PhWLnXI9Nfj4kn
NniVksgNQz5ymFpORWti+6EiqELEdntJcA8tLNfryTgyI+UVxpYBZPtReldW7JrW
MFWjYGBLEjdNnsUQx+V8JEBltDSe4vyQenhwapaaAnWUgjpQgCCSOKooZPjYGmjQ
Wqx7iQVvUZBGIvHtCZV2LMfaAGLtNB6EaPjo3hGvyUTevbdnkisqzRsgFdgCph6x
yEUOumBY/kSBjw/T0NQhebAuAzNP9xX456xOCyIq9OfRZJ5/hH8e65L5svd037i0
EO5IXp9nq5u13ElaTg7d9ghnE9rNiE8H/NR/ikA2N2CrX39jBd0KkPmya51f8p8n
wZ3GfGeephBBmUy4hqgrNXJxBBxYU8Njlhq65iXTc9fO326SF4JTUOnaHatVPZu2
LBeNxL3K0bxQdd89SZNzNhCpWNyzckj5x/Xmr0Izbn9vqtauolzPku5dCzayM7k0
Ru0o7G3PR5Q=
=XZQI
-----END PGP SIGNATURE-----

--=-LE7GRpIUb78X+ug+lrVf--
