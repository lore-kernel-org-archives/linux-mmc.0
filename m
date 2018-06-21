From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH RFC 1/2] mmc: sdhci: Allow platform controlled voltage switching
Date: Thu, 21 Jun 2018 17:53:45 +0530
Message-ID: <1529583826-42020-2-git-send-email-vviswana@codeaurora.org>
References: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Some controllers can have internal mechanism to inform the SW that it
is ready for voltage switching. For such controllers, changing voltage
before the HW is ready can result in various issues.

Add a quirk, which can be used by drivers of such controllers.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 20 +++++++++++++++-----
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..f0346d4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1615,7 +1615,8 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		     unsigned short vdd)
 {
-	if (IS_ERR(host->mmc->supply.vmmc))
+	if (IS_ERR(host->mmc->supply.vmmc) ||
+			(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
 		sdhci_set_power_noreg(host, mode, vdd);
 	else
 		sdhci_set_power_reg(host, mode, vdd);
@@ -2009,7 +2010,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		ctrl &= ~SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
-		if (!IS_ERR(mmc->supply.vqmmc)) {
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+				!(host->quirks2 &
+					SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
 			if (ret) {
 				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
@@ -2032,7 +2035,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	case MMC_SIGNAL_VOLTAGE_180:
 		if (!(host->flags & SDHCI_SIGNALING_180))
 			return -EINVAL;
-		if (!IS_ERR(mmc->supply.vqmmc)) {
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+			!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {
 			ret = mmc_regulator_set_vqmmc(mmc, ios);
 			if (ret) {
 				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
@@ -3485,7 +3489,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * the host can take the appropriate action if regulators are not
 	 * available.
 	 */
-	ret = mmc_regulator_get_supply(mmc);
+	if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
+		ret = mmc_regulator_get_supply(mmc);
+	else
+		ret = 0;
 	if (ret)
 		return ret;
 
@@ -3736,7 +3743,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = regulator_enable(mmc->supply.vqmmc);
+		if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
+			ret = regulator_enable(mmc->supply.vqmmc);
+		else
+			ret = 0;
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
 						    1950000))
 			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..3b0c97a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -450,6 +450,8 @@ struct sdhci_host {
  * obtainable timeout.
  */
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+/* Regulator voltage changes are being done from platform layer */
+#define SDHCI_QUIRK2_INTERNAL_PWR_CTL				(1<<18)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
