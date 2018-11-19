From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/4] mmc: sdhci-omap: Fix DCRC error handling during tuning
Date: Mon, 19 Nov 2018 16:46:15 +0530
Message-ID: <20181119111618.2745-2-faiz_abbas@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119111618.2745-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Commit 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
disabled DCRC interrupts during tuning. This write to the interrupt
enable register gets overwritten in sdhci_prepare_data() and the
interrupt is not in fact disabled. Fix this by disabling the interrupt
in the host->ier variable.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 88347ce78f23..87138067e334 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -290,7 +290,6 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	u32 start_window = 0, max_window = 0;
 	u8 cur_match, prev_match = 0;
 	u32 length = 0, max_len = 0;
-	u32 ier = host->ier;
 	u32 phase_delay = 0;
 	int ret = 0;
 	u32 reg;
@@ -317,9 +316,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * during the tuning procedure. So disable it during the
 	 * tuning procedure.
 	 */
-	ier &= ~SDHCI_INT_DATA_CRC;
-	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
-	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+	host->ier &= ~SDHCI_INT_DATA_CRC;
 
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
@@ -366,6 +363,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 ret:
 	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	/* Reenable forbidden interrupt */
+	host->ier |= SDHCI_INT_DATA_CRC;
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 	return ret;
-- 
2.19.1
