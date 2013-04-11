From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: dw_mmc: exynos: Turn SDIO interrupts on
Date: Thu, 11 Apr 2013 09:38:58 -0700
Message-ID: <1365698338-27503-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, Bing Zhao <bzhao@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The mmc part in exynos supports SDIO interrupts and they work fine, so
turn the capability on.  With this I see download speeds increase
about 10x.  This is a port of a change present in the Chrome OS tree
that can be found at <https://gerrit.chromium.org/gerrit/#/c/26729/>.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc-exynos.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index c7f0976..3a227be 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -192,10 +192,10 @@ static int dw_mci_exynos_setup_bus(struct dw_mci *host,
 /* Common capabilities of Exynos4/Exynos5 SoC */
 static unsigned long exynos_dwmmc_caps[4] = {
 	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
-		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
+		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
+	MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
+	MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
+	MMC_CAP_CMD23 | MMC_CAP_SDIO_IRQ,
 };
 
 static const struct dw_mci_drv_data exynos_drv_data = {
-- 
1.8.1.3
