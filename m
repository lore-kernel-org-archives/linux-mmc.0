From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH] mmc: dw_mmc: Remove architecture dependency
Date: Wed, 13 Aug 2014 10:32:33 -0700
Message-ID: <1407951153-918-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>
List-Id: linux-mmc@vger.kernel.org

The dw_mmc host may also be present on non-ARC/ARM SoCs (e.g. MIPS)
and the driver itself does not appear to depend on any particular
architecture(s).

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/mmc/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index a565254..15b110a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -563,7 +563,6 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
 
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
-	depends on ARC || ARM
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
-- 
2.1.0.rc2.206.gedb03e5
