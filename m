From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 1/2] mmc: msm_sdcc: Add gpio handling function to driver
Date: Tue, 18 Jan 2011 11:22:49 +0530
Message-ID: <1295329970-26814-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org
Cc: dwalker@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, san@google.com, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Configure SDCC GPIOs when the host is powered up or powered off.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/mmc.h |   11 +++++++++
 drivers/mmc/host/msm_sdcc.c          |   40 +++++++++++++++++++++++++++++++++-
 drivers/mmc/host/msm_sdcc.h          |    1 +
 3 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/mmc.h b/arch/arm/mach-msm/include/mach/mmc.h
index d54b6b0..5631b51 100644
--- a/arch/arm/mach-msm/include/mach/mmc.h
+++ b/arch/arm/mach-msm/include/mach/mmc.h
@@ -15,12 +15,23 @@ struct embedded_sdio_data {
 	int num_funcs;
 };
 
+struct msm_mmc_gpio {
+	unsigned no;
+	const char *name;
+};
+
+struct msm_mmc_gpio_data {
+	struct msm_mmc_gpio *gpio;
+	u8 size;
+};
+
 struct msm_mmc_platform_data {
 	unsigned int ocr_mask;			/* available voltages */
 	u32 (*translate_vdd)(struct device *, unsigned int);
 	unsigned int (*status)(struct device *);
 	struct embedded_sdio_data *embedded_sdio;
 	int (*register_status_notify)(void (*callback)(int card_present, void *dev_id), void *dev_id);
+	struct msm_mmc_gpio_data *gpio_data;
 };
 
 #endif
diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 5decfd0..f50f6bb 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -36,6 +36,7 @@
 #include <linux/io.h>
 #include <linux/memory.h>
 #include <linux/gfp.h>
+#include <linux/gpio.h>
 
 #include <asm/cacheflush.h>
 #include <asm/div64.h>
@@ -946,6 +947,38 @@ msmsdcc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void msmsdcc_setup_gpio(struct msmsdcc_host *host, bool enable)
+{
+	struct msm_mmc_gpio_data *curr;
+	int i, rc = 0;
+
+	if (!host->plat->gpio_data && host->gpio_config_status == enable)
+		return;
+
+	curr = host->plat->gpio_data;
+	for (i = 0; i < curr->size; i++) {
+		if (enable) {
+			rc = gpio_request(curr->gpio[i].no,
+						curr->gpio[i].name);
+			if (rc) {
+				pr_err("%s: gpio_request(%d, %s) failed %d\n",
+					mmc_hostname(host->mmc),
+					curr->gpio[i].no,
+					curr->gpio[i].name, rc);
+				goto free_gpios;
+			}
+		} else {
+			gpio_free(curr->gpio[i].no);
+		}
+	}
+	host->gpio_config_status = enable;
+	return;
+
+free_gpios:
+	for (; i >= 0; i--)
+		gpio_free(curr->gpio[i].no);
+}
+
 static void
 msmsdcc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
@@ -958,6 +991,8 @@ msmsdcc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	msmsdcc_enable_clocks(host);
 
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	if (ios->clock) {
 		if (ios->clock != host->clk_rate) {
 			rc = clk_set_rate(host->clk, ios->clock);
@@ -984,9 +1019,11 @@ msmsdcc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
+		msmsdcc_setup_gpio(host, false);
 		break;
 	case MMC_POWER_UP:
 		pwr |= MCI_PWR_UP;
+		msmsdcc_setup_gpio(host, true);
 		break;
 	case MMC_POWER_ON:
 		pwr |= MCI_PWR_ON;
@@ -1003,9 +1040,10 @@ msmsdcc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		msmsdcc_writel(host, pwr, MMCIPOWER);
 	}
 #if BUSCLK_PWRSAVE
+	spin_lock_irqsave(&host->lock, flags);
 	msmsdcc_disable_clocks(host, 1);
-#endif
 	spin_unlock_irqrestore(&host->lock, flags);
+#endif
 }
 
 static void msmsdcc_enable_sdio_irq(struct mmc_host *mmc, int enable)
diff --git a/drivers/mmc/host/msm_sdcc.h b/drivers/mmc/host/msm_sdcc.h
index 939557a..42d7bbc 100644
--- a/drivers/mmc/host/msm_sdcc.h
+++ b/drivers/mmc/host/msm_sdcc.h
@@ -243,6 +243,7 @@ struct msmsdcc_host {
 	unsigned int		cmd_datactrl;
 	struct mmc_command	*cmd_cmd;
 	u32			cmd_c;
+	bool			gpio_config_status;
 
 	bool prog_scan;
 	bool prog_enable;
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
