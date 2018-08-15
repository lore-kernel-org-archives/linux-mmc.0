From: Igor Opaniuk <igor.opaniuk@linaro.org>
Subject: [PATCH 1/1] mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 capability
Date: Wed, 15 Aug 2018 14:39:44 +0300
Message-ID: <1534333184-25599-1-git-send-email-igor.opaniuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, tianshuliang@hisilicon.com, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Enable access to the RPMB on the on-board eMMC of the
Poplar board.

Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
---
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index f9b333f..7a023f0 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -23,6 +23,12 @@ struct hi3798cv200_priv {
 	struct clk *drive_clk;
 };
 
+static unsigned long dw_mci_hi3798cv200_caps[] = {
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	0
+};
+
 static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct hi3798cv200_priv *priv = host->priv;
@@ -160,6 +166,8 @@ static int dw_mci_hi3798cv200_init(struct dw_mci *host)
 }
 
 static const struct dw_mci_drv_data hi3798cv200_data = {
+	.caps = dw_mci_hi3798cv200_caps,
+	.num_caps = ARRAY_SIZE(dw_mci_hi3798cv200_caps),
 	.init = dw_mci_hi3798cv200_init,
 	.set_ios = dw_mci_hi3798cv200_set_ios,
 	.execute_tuning = dw_mci_hi3798cv200_execute_tuning,
-- 
2.7.4
