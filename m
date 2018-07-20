From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V1 1/3] mmc: sdhci: Allow platform controlled voltage switching
Date: Fri, 20 Jul 2018 16:16:04 +0530
Message-ID: <1532083566-43215-2-git-send-email-vviswana@codeaurora.org>
References: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, evgreen@chromium.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Some controllers can have internal mechanism to inform the SW that it
is ready for voltage switching. For such controllers, changing voltage
before the HW is ready can result in various issues.

During setup/cleanup of host, check whether regulator enable/disable
was already done by platform driver.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..494a1e2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3472,6 +3472,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	unsigned int override_timeout_clk;
 	u32 max_clk;
 	int ret;
+	bool enable_vqmmc = false;
 
 	WARN_ON(host == NULL);
 	if (host == NULL)
@@ -3485,7 +3486,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * the host can take the appropriate action if regulators are not
 	 * available.
 	 */
-	ret = mmc_regulator_get_supply(mmc);
+	if (!mmc->supply.vmmc) {
+		ret = mmc_regulator_get_supply(mmc);
+		enable_vqmmc  = true;
+	} else {
+		ret = 0;
+	}
 	if (ret)
 		return ret;
 
@@ -3736,7 +3742,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = regulator_enable(mmc->supply.vqmmc);
+		if (enable_vqmmc)
+			ret = regulator_enable(mmc->supply.vqmmc);
+		else
+			ret = 0;
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
 						    1950000))
 			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
@@ -3984,7 +3993,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	return 0;
 
 unreg:
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (!IS_ERR(mmc->supply.vqmmc) && enable_vqmmc)
 		regulator_disable(mmc->supply.vqmmc);
 undma:
 	if (host->align_buffer)
@@ -4002,7 +4011,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (!IS_ERR(mmc->supply.vqmmc) &&
+			(regulator_is_enabled(mmc->supply.vqmmc) > 0))
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
@@ -4135,7 +4145,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	tasklet_kill(&host->finish_tasklet);
 
-	if (!IS_ERR(mmc->supply.vqmmc))
+	if (!IS_ERR(mmc->supply.vqmmc) &&
+			(regulator_is_enabled(mmc->supply.vqmmc) > 0))
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->align_buffer)
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
