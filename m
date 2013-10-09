From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] mmc: sh_mmcif: Get rid of MMC_BLOCK dependency
Date: Thu, 10 Oct 2013 07:45:45 +0900
Message-ID: <20131009224545.23119.45781.sendpatchset@w520>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, g.liakhovetski@gmail.com, horms@verge.net.au
List-Id: linux-mmc@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

It seems like sh_mmcif.c now is the only MMC driver depending on MMC_BLOCK,
the hardware is not special in any way so rework the Kconfig dependency to
be less special.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/mmc/host/Kconfig
+++ work/drivers/mmc/host/Kconfig	2013-10-08 18:03:17.000000000 +0900
@@ -588,7 +588,7 @@ config MMC_DW_PCI
 
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
-	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
+	depends on SUPERH || ARCH_SHMOBILE
 	help
 	  This selects the MMC Host Interface controller (MMCIF).
 
