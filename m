From: Stefan Christ <s.christ@phytec.de>
Subject: [PATCH] mmc: sdhci-esdhc-imx: implement reset quirks for i.MX6 DualLite/Solo
Date: Thu, 12 May 2016 13:52:48 +0200
Message-ID: <1463053968-11598-1-git-send-email-s.christ@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.visioncatalog.de ([217.6.246.34]:54277 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbcELMA3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2016 08:00:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: aisheng.dong@freescale.com, festevam@gmail.com

The ROM Code of i.MX6 Quad/Dual uses the MMC interfaces differently tha=
n
the i.MX6 Solo/DualLite when it loads the bootloader from the interface=
:

                Register DLL_CTRL(0x60)  Bit 25 FBCLK_SEL (0x48)
    Quad:       0x0                      0
    DualLite:   0x01000021               1

Since the linux kernel or bootloader driver doesn't reset all registers=
,
the MMC interface is in an inconsistent state, which leads to boot
failures for some eMMC devices on the i.MX6 DualLite SoC. The errors
look like:

    mmcblk1: error -84 transferring data, sector 0, nr 8, cmd response =
0x900, card status 0xb00
    mmcblk1: retrying using single block read
    mmcblk1: error -84 transferring data, sector 2, nr 6, cmd response =
0x900, card status 0x0
    blk_update_request: I/O error, dev mmcblk1, sector 2
    mmcblk1: error -84 transferring data, sector 3, nr 5, cmd response =
0x900, card status 0x0
    blk_update_request: I/O error, dev mmcblk1, sector 3

The register DLL_CTRL is already reset. Reset also the bit FBCLK_SEL.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
Hi,

this patch is a follow up to

    http://www.spinics.net/lists/linux-mmc/msg36331.html

    mmc: sdhci-esdhci-imx: disable DLL delay line settings explicitly

    Disable DLL delay line settings explicitly during driver initializa=
tion
    in case ROM/uBoot had set an invalid delay.
    e.g. MX6DL ROM has set the default delay line(DLLCTRL) to 0x1000021=
,
    the uSDHC clock timing will become marginal when works on DDR mode
    due to default delay and will possibly see CRC errors in case the b=
oard
    is not perfectly designed on the eMMC chip layout.
   =20
    Signed-off-by: Dong Aisheng <aisheng.dong@xxxxxxx>

It doesn't apply cleanly on Linus master branch, since the above patch =
is
missing.

Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
        Stefan Christ
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-esdhc-imx.c
index 4490808..9101556 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1191,6 +1191,10 @@ static int sdhci_esdhc_imx_probe(struct platform=
_device *pdev)
=20
 		/* disable DLL_CTRL delay line settings */
 		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
+
+		/* reset bit FBCLK_SEL for i.MX6 Solo/DualLite ROM code */
+		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) & ~BIT(25),
+			host->ioaddr + ESDHC_MIX_CTRL);
 	}
=20
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
--=20
1.9.1

