From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] mmc_block: Increase max_devices
Date: Thu, 06 Nov 2014 03:35:09 +0000
Message-ID: <1415244909.3398.51.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-7wXLpiNaJyPz0lR1y4B4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57067 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbaKFDfb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 22:35:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org


--=-7wXLpiNaJyPz0lR1y4B4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently the driver imposes a limit of 256 total minor numbers,
apparently based on the historic Unix/Linux limit.  This is quite
restrictive, particularly if we raise the maximum number of
partitions per card to 256 to match sd.

In order to make the full minor number space available we would
have to replace the static dev_use and name_use arrays with struct
ida.  But we can at least allow use of 256 cards rather than just
256 minors, with only a small change.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/card/block.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1fa4c80..d9783da 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -78,13 +78,16 @@ static int perdev_minors =3D CONFIG_MMC_BLOCK_MINORS;
=20
 /*
  * We've only got one major, so number of mmcblk devices is
- * limited to 256 / number of minors per device.
+ * limited to (1 << 20) / number of minors per device.  It is also
+ * currently limited by the size of the static bitmaps below.
  */
 static int max_devices;
=20
-/* 256 minors, so at most 256 separate devices */
-static DECLARE_BITMAP(dev_use, 256);
-static DECLARE_BITMAP(name_use, 256);
+#define MAX_DEVICES 256
+
+/* TODO: Replace these with struct ida */
+static DECLARE_BITMAP(dev_use, MAX_DEVICES);
+static DECLARE_BITMAP(name_use, MAX_DEVICES);
=20
 /*
  * There is one mmc_blk_data per slot.
@@ -2563,7 +2566,7 @@ static int __init mmc_blk_init(void)
 	if (perdev_minors !=3D CONFIG_MMC_BLOCK_MINORS)
 		pr_info("mmcblk: using %d minors per device\n", perdev_minors);
=20
-	max_devices =3D 256 / perdev_minors;
+	max_devices =3D min(MAX_DEVICES, (1 << MINORBITS) / perdev_minors);
=20
 	res =3D register_blkdev(MMC_BLOCK_MAJOR, "mmc");
 	if (res)

--=20
Ben Hutchings
Beware of programmers who carry screwdrivers. - Leonard Brandwein

--=-7wXLpiNaJyPz0lR1y4B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVFrseee/yOyVhhEJAQoDYg//Z8ipIXPo9t7d5uhG+AEVhEyNRlzvo+VX
GUxCuBCHOb3Ui2bHoEXk5lQcNsD+//09SPn223mrrsZPVb3Z8mdpEAWlcQ8ecJbd
oPXacL4ZsrsWg+zUCiDfvBAdvIdhXD8xenu7W1yjr/vH1jMxKwCOLla2SzlNYsL/
YLLNvsTfubxst2Uaaw5OU6EpvIqlfBiDdEQNAqHVQERuiinvCTCTwe0cdofiP53E
IIkPL+VQ9fN4CT3hCxvI7l2y4nbwh/8gMsO42mTmHgY2cwKW2p2JAxi7tZbIoYdP
0T1xAlTxsjFyPB5BqteSwttAZIVMwC0JoGan0HPaerhpue8I1YH+YaZk6Ea0nckH
U4n6kp4FHmlKxynvKpweQekGpHPxvHqM811ZAWzUO/fW1x1nuOaqSHSyZrRz0LXc
H9h89/SjZhLwjlNsgdcTbWXggyEF17mu8qYdE4rXCec4ZBS0w5VwRXVsbqvesgOz
hF9JPzqqBMWDKfP0K1TEdjJgMD5WFrgqb3uHo7bvtS+BWQuNskpqbEzUmomLqP3q
1ep2GFUn8TyZSQCFoEPfMUC81b3vXMBUdE5m0v9IGW/qlmlyNmMsivG0Fs5EJZR4
zHr1+PovNYafMA4chIfXIlLnEc+RpH3uWnp3bsbzYV1k+0WBEcvlTkC++AqqgoaJ
b0rX662VbIk=
=8Mhu
-----END PGP SIGNATURE-----

--=-7wXLpiNaJyPz0lR1y4B4--
