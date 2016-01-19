From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/3] mmc: dw_mmc: expose dw_mci_pltfm_prepare_command
Date: Tue, 19 Jan 2016 11:40:20 +0800
Message-ID: <1453174820-13581-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:59347 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757132AbcASDp2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 22:45:28 -0500
In-Reply-To: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch change dw_mci_pltfm_prepare_command into
more like a library call.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc-pltfm.c | 3 ++-
 drivers/mmc/host/dw_mmc-pltfm.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 81bdeeb..3752035 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -26,10 +26,11 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-static void dw_mci_pltfm_prepare_command(struct dw_mci *host, u32 *cmdr)
+inline void dw_mci_pltfm_prepare_command(struct dw_mci *host, u32 *cmdr)
 {
 	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
 }
+EXPORT_SYMBOL_GPL(dw_mci_pltfm_prepare_command);
 
 static const struct dw_mci_drv_data socfpga_drv_data = {
 	.prepare_command	= dw_mci_pltfm_prepare_command,
diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
index 68e7fd2..c607f68 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.h
+++ b/drivers/mmc/host/dw_mmc-pltfm.h
@@ -15,6 +15,6 @@
 extern int dw_mci_pltfm_register(struct platform_device *pdev,
 				const struct dw_mci_drv_data *drv_data);
 extern int dw_mci_pltfm_remove(struct platform_device *pdev);
+extern void dw_mci_pltfm_prepare_command(struct dw_mci *host, u32 *cmdr);
 extern const struct dev_pm_ops dw_mci_pltfm_pmops;
-
 #endif /* _DW_MMC_PLTFM_H_ */
-- 
2.3.7



