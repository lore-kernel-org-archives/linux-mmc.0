From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 1/6] mmc: davinci: Constify platform_device_id
Date: Sat,  2 May 2015 00:49:17 +0900
Message-ID: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 1625f908dc70..ea2a2ebc6b91 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1161,7 +1161,7 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
 	mmc_davinci_reset_ctrl(host, 0);
 }
 
-static struct platform_device_id davinci_mmc_devtype[] = {
+static const struct platform_device_id davinci_mmc_devtype[] = {
 	{
 		.name	= "dm6441-mmc",
 		.driver_data = MMC_CTLR_VERSION_1,
-- 
2.1.4
