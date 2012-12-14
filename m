From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Fri, 14 Dec 2012 15:38:46 +0000
Message-ID: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:43378 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217Ab2LNPjJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 10:39:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Pawel Moll <pawel.moll@arm.com>

The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
and v116/216) contains a modified version of the PL180 MMCI, with
PeriphID Configuration value changed to 0x2.

This version adds an optional "hardware flow control" feature. When
enabled MMC card clock will be automatically disabled when FIFO is
about to over/underflow and re-enabled once the host retrieved some
data. This makes the controller immune to over/underrun errors caused
by big interrupt handling latencies.

This patch adds relevant device variant in the driver.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mmc/host/mmci.c |   13 +++++++++++++
 drivers/mmc/host/mmci.h |    2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..b2b550f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -86,6 +86,14 @@ static struct variant_data variant_arm_extended_fifo =3D=
 {
 =09.pwrreg_powerup=09=09=3D MCI_PWR_UP,
 };
=20
+static struct variant_data variant_arm_extended_fifo_hwfc =3D {
+=09.fifosize=09=09=3D 128 * 4,
+=09.fifohalfsize=09=09=3D 64 * 4,
+=09.clkreg_enable=09=09=3D MCI_ARM_HWFCEN,
+=09.datalength_bits=09=3D 16,
+=09.pwrreg_powerup=09=09=3D MCI_PWR_UP,
+};
+
 static struct variant_data variant_u300 =3D {
 =09.fifosize=09=09=3D 16 * 4,
 =09.fifohalfsize=09=09=3D 8 * 4,
@@ -1628,6 +1636,11 @@ static struct amba_id mmci_ids[] =3D {
 =09=09.data=09=3D &variant_arm_extended_fifo,
 =09},
 =09{
+=09=09.id=09=3D 0x02041180,
+=09=09.mask=09=3D 0xff0fffff,
+=09=09.data=09=3D &variant_arm_extended_fifo_hwfc,
+=09},
+=09{
 =09=09.id=09=3D 0x00041181,
 =09=09.mask=09=3D 0x000fffff,
 =09=09.data=09=3D &variant_arm,
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d437ccf..00d6d0c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -28,6 +28,8 @@
 #define MCI_ST_UX500_NEG_EDGE=09(1 << 13)
 #define MCI_ST_UX500_HWFCEN=09(1 << 14)
 #define MCI_ST_UX500_CLK_INV=09(1 << 15)
+/* Modified PL180 on Versatile Express platform */
+#define MCI_ARM_HWFCEN=09=09(1 << 12)
=20
 #define MMCIARGUMENT=09=090x008
 #define MMCICOMMAND=09=090x00c
--=20
1.7.10.4


