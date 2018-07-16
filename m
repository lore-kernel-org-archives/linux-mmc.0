From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH V7 3/5] mmc: sdhci: Export sdhci tuning function symbol
Date: Mon, 16 Jul 2018 14:26:53 +0800
Message-ID: <20180716062655.24703-3-ernest.zhang@bayhubtech.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com, chevron.li@bayhubtech.com, shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

Export sdhci tuning function symbols which are used by other SD Host
controller driver modules.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Changes in V7:
	Export sdhci tuning function symbols

Changes in V1~V6
	N/A
---
 drivers/mmc/host/sdhci.c | 12 ++++++++----
 drivers/mmc/host/sdhci.h |  5 +++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a7b5602ef6f7..bcea179a8d70 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2103,7 +2103,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
-static void sdhci_start_tuning(struct sdhci_host *host)
+void sdhci_start_tuning(struct sdhci_host *host)
 {
 	u16 ctrl;
 
@@ -2126,14 +2126,16 @@ static void sdhci_start_tuning(struct sdhci_host *host)
 	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
 	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_start_tuning);
 
-static void sdhci_end_tuning(struct sdhci_host *host)
+void sdhci_end_tuning(struct sdhci_host *host)
 {
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_end_tuning);
 
-static void sdhci_reset_tuning(struct sdhci_host *host)
+void sdhci_reset_tuning(struct sdhci_host *host)
 {
 	u16 ctrl;
 
@@ -2142,6 +2144,7 @@ static void sdhci_reset_tuning(struct sdhci_host *host)
 	ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 }
+EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
 
 static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 {
@@ -2162,7 +2165,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
  * interrupt setup is different to other commands and there is no timeout
  * interrupt so special handling is needed.
  */
-static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
+void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct mmc_command cmd = {};
@@ -2212,6 +2215,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 			   msecs_to_jiffies(50));
 
 }
+EXPORT_SYMBOL_GPL(sdhci_send_tuning);
 
 static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f887da6..f0bd36ce3817 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -748,4 +748,9 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 
 void sdhci_dumpregs(struct sdhci_host *host);
 
+void sdhci_start_tuning(struct sdhci_host *host);
+void sdhci_end_tuning(struct sdhci_host *host);
+void sdhci_reset_tuning(struct sdhci_host *host);
+void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+
 #endif /* __SDHCI_HW_H */
-- 
2.17.1
