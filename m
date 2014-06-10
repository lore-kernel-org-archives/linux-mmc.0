From: Kumar Gala <galak@codeaurora.org>
Subject: [PATCH] mmc: sdhci-msm: Fix crash due to missing ops functions
Date: Tue, 10 Jun 2014 13:49:05 -0500
Message-ID: <1402426145-11180-1-git-send-email-galak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kumar Gala <galak@codeaurora.org>, linux-mmc@vger.kernel.org, rmk+kernel@arm.linux.org.uk, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Recent changes in sdhci core need to get reflected in sdhci_msm_ops otherwise
we ended up dereferencing null pointers in the ops struct and crash.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index acb0e9e..0d6cee0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -467,7 +467,11 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
 MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 
 static struct sdhci_ops sdhci_msm_ops = {
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
 	.platform_execute_tuning = sdhci_msm_execute_tuning,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static int sdhci_msm_probe(struct platform_device *pdev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
