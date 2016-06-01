From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] mmc: dw_mmc: k3: add MMC_CAP_CMD23
Date: Wed,  1 Jun 2016 14:39:58 +0200
Message-ID: <1464784798-15828-1-git-send-email-jerome.forissier@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jerome Forissier <jerome.forissier@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Enables RPMB support for the on-board eMMC of the HiKey board as well
as for eMMC modules connected to the microSD slot.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/mmc/host/dw_mmc-k3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 63c2e2e..8e9d886 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -32,6 +32,12 @@ struct k3_priv {
 	struct regmap	*reg;
 };
 
+static unsigned long dw_mci_hi6220_caps[] = {
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	0
+};
+
 static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	int ret;
@@ -126,6 +132,7 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 }
 
 static const struct dw_mci_drv_data hi6220_data = {
+	.caps			= dw_mci_hi6220_caps,
 	.switch_voltage		= dw_mci_hi6220_switch_voltage,
 	.set_ios		= dw_mci_hi6220_set_ios,
 	.parse_dt		= dw_mci_hi6220_parse_dt,
-- 
2.7.4
