From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/2] mmc: sdhci: Add platform_cmd_err() to sdhci_ops
Date: Tue, 26 Feb 2019 21:46:05 +0530
Message-ID: <20190226161606.18569-2-faiz_abbas@ti.com>
References: <20190226161606.18569-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226161606.18569-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Some platforms might need a custom method for handling command error
interrupts. Add a callback to sdhci_ops to facilitate the same. Move
default command error handling to its own non-static function so it can
be called from platform drivers. Also make sdhci_finish_command()
non-static.

Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
callback")
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 37 +++++++++++++++++++++++--------------
 drivers/mmc/host/sdhci.h |  4 ++++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index eba9bcc92ad3..12302432605c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1440,7 +1440,7 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
-static void sdhci_finish_command(struct sdhci_host *host)
+void sdhci_finish_command(struct sdhci_host *host)
 {
 	struct mmc_command *cmd = host->cmd;
 
@@ -2772,6 +2772,25 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
  *                                                                           *
 \*****************************************************************************/
 
+void sdhci_cmd_err(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
+{
+		if (intmask & SDHCI_INT_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+		else
+			host->cmd->error = -EILSEQ;
+
+		/* Treat data command CRC error the same as data CRC error */
+		if (host->cmd->data &&
+		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
+		     SDHCI_INT_CRC) {
+			host->cmd = NULL;
+			*intmask_p |= SDHCI_INT_DATA_CRC;
+			return;
+		}
+
+		sdhci_finish_mrq(host, host->cmd->mrq);
+}
+
 static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 {
 	/* Handle auto-CMD12 error */
@@ -2805,21 +2824,11 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 
 	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
 		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
-		if (intmask & SDHCI_INT_TIMEOUT)
-			host->cmd->error = -ETIMEDOUT;
+		if (host->ops->platform_cmd_err)
+			host->ops->platform_cmd_err(host, intmask, intmask_p);
 		else
-			host->cmd->error = -EILSEQ;
+			sdhci_cmd_err(host, intmask, intmask_p);
 
-		/* Treat data command CRC error the same as data CRC error */
-		if (host->cmd->data &&
-		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
-		     SDHCI_INT_CRC) {
-			host->cmd = NULL;
-			*intmask_p |= SDHCI_INT_DATA_CRC;
-			return;
-		}
-
-		sdhci_finish_mrq(host, host->cmd->mrq);
 		return;
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6cc9a3c2ac66..523a47c4efa4 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -639,6 +639,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*platform_cmd_err)(struct sdhci_host *host, u32 intmask,
+				    u32 *intmask_p);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -792,5 +794,7 @@ void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_cmd_err(struct sdhci_host *host, u32 intmask, u32 *intmask_p);
+void sdhci_finish_command(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
2.19.2
