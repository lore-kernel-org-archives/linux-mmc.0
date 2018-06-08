From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH 5/6] mmc: sdhci: add CMD23 support for v4 mode
Date: Fri,  8 Jun 2018 16:18:12 +0800
Message-ID: <1528445893-14530-6-git-send-email-zhang.chunyan@linaro.org>
References: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
List-Id: linux-mmc@vger.kernel.org

Host Driver Version 4.10 adds a new bit in Host Control 2 Register
for selecting Auto CMD23 or Auto CMD12 for ADMA3 data transfer.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b8ee124..3b2af7e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -954,6 +954,20 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 	       !mrq->cap_cmd_during_tfr;
 }
 
+static inline void sdhci_set_auto_cmd23(struct sdhci_host *host,
+					struct mmc_command *cmd)
+{
+	u16 ctrl2;
+
+	if (host->v4_mode) {
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl2 |= SDHCI_CMD23_ENABLE;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+	} else {
+		sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
+	}
+}
+
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
@@ -989,7 +1003,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 			mode |= SDHCI_TRNS_AUTO_CMD12;
 		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
 			mode |= SDHCI_TRNS_AUTO_CMD23;
-			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
+			sdhci_set_auto_cmd23(host, cmd);
 		}
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 1e84539..d5e1c10 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -185,6 +185,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
-- 
2.7.4
