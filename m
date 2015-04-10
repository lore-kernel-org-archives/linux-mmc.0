From: <dinguyen@opensource.altera.com>
Subject: [PATCH] mmc: dw_mmc: add fixed divider for ciu_clk on SoCFPGA
Date: Fri, 10 Apr 2015 08:56:02 -0500
Message-ID: <1428674162-11200-1-git-send-email-dinguyen@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: dinh.linux@gmail.com, linux-kernel@vger.kernel.org, setka@vsis.cz, Dinh Nguyen <dinguyen@opensource.altera.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-mmc@vger.kernel.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The ciu_clk(Card Interface Unit Clock) on the SoCFPGA platform has a fixed
divider of 4. Add the fixed clock divide code in the platform's clock
setup code.

Technically, this code could be be moved to dw_mmc-socfpga, like the Rockchip
and Exynos, but I don't think it's necessary for a small change that is
needed for the entire SoCFPGA family of SoCs.

Also, "altr,dw-mshc-ciu-div" can be introduced to respresent the ciu divider,
but since this divider is common across all SoCFPGA, I don't think its
necessary.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
CC: Seungwon Jeon <tgih.jun@samsung.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
CC: Chris Ball <chris@printf.net>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc-pltfm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index ec6dbcd..c92f790 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -26,13 +26,22 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
+#define SOCFPGA_CIU_CLK_DIV	4
+
 static void dw_mci_pltfm_prepare_command(struct dw_mci *host, u32 *cmdr)
 {
 	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
 }
 
+static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
+{
+	host->bus_hz /= SOCFPGA_CIU_CLK_DIV;
+	return 0;
+}
+
 static const struct dw_mci_drv_data socfpga_drv_data = {
 	.prepare_command	= dw_mci_pltfm_prepare_command,
+	.setup_clock		= dw_mci_socfpga_setup_clock,
 };
 
 static const struct dw_mci_drv_data pistachio_drv_data = {
-- 
2.2.1
