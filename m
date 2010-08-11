From: akpm@linux-foundation.org
Subject: [patch 042/177] sdhci-pltfm: reorganize Makefile entries to support SoC devices
Date: Tue, 10 Aug 2010 18:01:49 -0700
Message-ID: <201008110101.o7B11nG1027071@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49031 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757897Ab0HKBCs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:02:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, avorontsov@mvista.com, ben@simtec.co.uk, linux-mmc@vger.kernel.org, richard.rojfors@pelagicore.com

=46rom: Anton Vorontsov <avorontsov@mvista.com>

Due to build system limitations, intermediate and final objects can't h=
ave
the same names.  And as we're going to start building SoC-specific
objects, let's rename the module to sdhci-platform, into which we'll li=
nk
sdhci-pltfm and SoC-specifc objects.

There should be no issue in renaming as the driver uses modalias
mechanism.

This is exactly the same approach as in sdhci-of driver.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: Richard R=F6jfors <richard.rojfors@pelagicore.com>=20
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/Makefile~sdhci-pltfm-reorganize-makefile-ent=
ries-to-support-soc-devices drivers/mmc/host/Makefile
--- a/drivers/mmc/host/Makefile~sdhci-pltfm-reorganize-makefile-entries=
-to-support-soc-devices
+++ a/drivers/mmc/host/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_MMC_IMX)		+=3D imxmmc.o
 obj-$(CONFIG_MMC_MXC)		+=3D mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+=3D sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+=3D sdhci-pci.o
-obj-$(CONFIG_MMC_SDHCI_PLTFM)	+=3D sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+=3D sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+=3D sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+=3D wbsd.o
@@ -38,6 +37,9 @@ obj-$(CONFIG_SDH_BFIN)		+=3D bfin_sdh.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+=3D sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+=3D jz4740_mmc.o
=20
+obj-$(CONFIG_MMC_SDHCI_PLTFM)			+=3D sdhci-platform.o
+sdhci-platform-y				:=3D sdhci-pltfm.o
+
 obj-$(CONFIG_MMC_SDHCI_OF)	+=3D sdhci-of.o
 sdhci-of-y				:=3D sdhci-of-core.o
 sdhci-of-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+=3D sdhci-of-esdhc.o
_
