From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 5/5] mmc: mmci: move ST specific sdio setup under a condition
Date: Tue, 12 Aug 2014 13:05:27 +0100
Message-ID: <1407845127-8448-1-git-send-email-srinivas.kandadgatla@linaro.org>
References: <1407844950-8072-1-git-send-email-srinivas.kandadgatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407844950-8072-1-git-send-email-srinivas.kandadgatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch moves ST specific sdio setup under a vendor id condition,
this will ensure that the ST specfic setup is not done on other vendor
like Qualcomm.

Originally the issue was detected while testing WLAN ath6kl on IFC6410
board with APQ8064 SOC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/mmci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 848e2bb..1783be7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -828,7 +828,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 			 * otherwise the transfer will not start. The threshold
 			 * depends on the rate of MCLK.
 			 */
-			if (data->flags & MMC_DATA_WRITE &&
+			if (host->hw_designer == AMBA_VENDOR_ST &&
+			    data->flags & MMC_DATA_WRITE &&
 			    (host->size < 8 ||
 			     (host->size <= 8 && host->mclk > 50000000)))
 				clk = host->clk_reg & ~variant->clkreg_enable;
-- 
1.9.1
