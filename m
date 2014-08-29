From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] mmc: dw_mmc: add support for ARM64
Date: Fri, 29 Aug 2014 15:54:51 +0530
Message-ID: <1409307891-16523-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60314 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaH2K3I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Aug 2014 06:29:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: tgih.jun@samsung.com, jh80.chung@samsung.com, arnd@arndb.de, abrestic@chromium.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, yuvaraj.cd@samsung.com

There are upcoming ARM64 SoCs with dw_mmc host controller.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index a43295c..72dd6c2 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -580,7 +580,7 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
 	depends on HAS_DMA
-	depends on ARC || ARM || MIPS || COMPILE_TEST
+	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
-- 
1.7.10.4

