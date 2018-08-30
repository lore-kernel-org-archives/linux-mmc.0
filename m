From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V8 6/9] mmc: sdhci: Add Auto CMD Auto Select support
Date: Thu, 30 Aug 2018 16:21:42 +0800
Message-ID: <1535617305-16952-7-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

As SD Host Controller Specification v4.10 documents:
Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
Selection of Auto CMD depends on setting of CMD23 Enable in the Host
Control 2 register which indicates whether card supports CMD23. If CMD23
Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
recommended rather than use of Auto CMD12 Enable or Auto CMD23
Enable.

This patch add this new mode support.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 49 ++++++++++++++++++++++++++++++++++++++----------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 604bf4c..62d843ac90 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1095,6 +1095,43 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 	       !mrq->cap_cmd_during_tfr;
 }
 
+static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
+					 struct mmc_command *cmd,
+					 u16 *mode)
+{
+	bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
+			 (cmd->opcode != SD_IO_RW_EXTENDED);
+	bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
+	u16 ctrl2;
+
+	/*
+	 * In case of Version 4.10 or later, use of 'Auto CMD Auto
+	 * Select' is recommended rather than use of 'Auto CMD12
+	 * Enable' or 'Auto CMD23 Enable'.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
+		*mode |= SDHCI_TRNS_AUTO_SEL;
+
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (use_cmd23)
+			ctrl2 |= SDHCI_CMD23_ENABLE;
+		else
+			ctrl2 &= ~SDHCI_CMD23_ENABLE;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+
+		return;
+	}
+
+	/*
+	 * If we are sending CMD23, CMD12 never gets sent
+	 * on successful completion (so no Auto-CMD12).
+	 */
+	if (use_cmd12)
+		*mode |= SDHCI_TRNS_AUTO_CMD12;
+	else if (use_cmd23)
+		*mode |= SDHCI_TRNS_AUTO_CMD23;
+}
+
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
@@ -1123,17 +1160,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
 	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
 		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
-		/*
-		 * If we are sending CMD23, CMD12 never gets sent
-		 * on successful completion (so no Auto-CMD12).
-		 */
-		if (sdhci_auto_cmd12(host, cmd->mrq) &&
-		    (cmd->opcode != SD_IO_RW_EXTENDED))
-			mode |= SDHCI_TRNS_AUTO_CMD12;
-		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
-			mode |= SDHCI_TRNS_AUTO_CMD23;
+		sdhci_auto_cmd_select(host, cmd, &mode);
+		if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23))
 			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
-		}
 	}
 
 	if (data->flags & MMC_DATA_READ)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f7a1079..4a19ff8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -42,6 +42,7 @@
 #define  SDHCI_TRNS_BLK_CNT_EN	0x02
 #define  SDHCI_TRNS_AUTO_CMD12	0x04
 #define  SDHCI_TRNS_AUTO_CMD23	0x08
+#define  SDHCI_TRNS_AUTO_SEL	0x0C
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
@@ -185,6 +186,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
-- 
2.7.4
