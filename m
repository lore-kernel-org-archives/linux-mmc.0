From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V2 1/3] mmc: sdhci: Allow platform controlled voltage switching
Date: Thu, 20 Sep 2018 11:52:36 +0530
Message-ID: <1537424558-17989-2-git-send-email-vbadigan@codeaurora.org>
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc: linux-mmc@vger.kernel.org, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, evgreen@chromium.org, dianders@google.com, Vijay Viswanath <vviswana@codeaurora.org>, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

From: Vijay Viswanath <vviswana@codeaurora.org>

Some controllers can have internal mechanism to inform the SW that it
is ready for voltage switching. For such controllers, changing voltage
before the HW is ready can result in various issues.

During setup/cleanup of host, check whether regulator enable/disable
was already done by platform driver.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 22 +++++++++++++++-------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae5..04b3fd2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3616,6 +3616,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	unsigned int override_timeout_clk;
 	u32 max_clk;
 	int ret;
+	bool enable_vqmmc = false;
 
 	WARN_ON(host == NULL);
 	if (host == NULL)
@@ -3629,9 +3630,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * the host can take the appropriate action if regulators are not
 	 * available.
 	 */
-	ret = mmc_regulator_get_supply(mmc);
-	if (ret)
-		return ret;
+	if (!mmc->supply.vmmc) {
+		ret = mmc_regulator_get_supply(mmc);
+		if (ret)
+			return ret;
+		enable_vqmmc  = true;
+	}
 
 	DBG("Version:   0x%08x | Present:  0x%08x\n",
 	    sdhci_readw(host, SDHCI_HOST_VERSION),
@@ -3880,7 +3884,11 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = regulator_enable(mmc->supply.vqmmc);
+		if (enable_vqmmc) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			host->vqmmc_enabled = !ret;
+		} else
+			ret = 0;
 
 		/* If vqmmc provides no 1.8V signalling, then there's no UHS */
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
@@ -4136,7 +4144,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	return 0;
 
 unreg:
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->vqmmc_enabled)
 		regulator_disable(mmc->supply.vqmmc);
 undma:
 	if (host->align_buffer)
@@ -4154,7 +4162,7 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->vqmmc_enabled)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
@@ -4287,7 +4295,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	tasklet_kill(&host->finish_tasklet);
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (host->vqmmc_enabled)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b001cf4..3c28152 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -524,6 +524,7 @@ struct sdhci_host {
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
+	bool vqmmc_enabled;	/* Vqmmc is enabled */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
