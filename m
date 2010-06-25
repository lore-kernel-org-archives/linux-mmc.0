From: Anton Vorontsov <avorontsov@mvista.com>
Subject: [PATCH 2/3] sdhci-pltfm: Reorganize Makefile entries to support
 SoC devices
Date: Fri, 25 Jun 2010 22:06:31 +0400
Message-ID: <20100625180631.GB18241@oksana.dev.rtsoft.ru>
References: <20100625180527.GA11280@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100625180527.GA11280@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ben Dooks <ben@simtec.co.uk>, Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors@pelagicore.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Due to build system limitations, intermediate and final objects can't
have the same names. And as we're going to start building SoC-specific
objects, let's rename the module to sdhci-platform, into which we'll
link sdhci-pltfm and SoC-specifc objects.

There should be no issue in renaming as the driver uses modalias
mechanism.

This is exactly the same approach as in sdhci-of driver.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/mmc/host/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e30c2ee..28622d5 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_MMC_IMX)		+= imxmmc.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
-obj-$(CONFIG_MMC_SDHCI_PLTFM)	+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
@@ -37,6 +36,9 @@ obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 
+obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
+sdhci-platform-y				:= sdhci-pltfm.o
+
 obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 sdhci-of-y				:= sdhci-of-core.o
 sdhci-of-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
-- 
1.7.0.5
