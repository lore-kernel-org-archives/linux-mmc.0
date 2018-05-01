From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH RFC 3/4] host: sdhci: fix current caps when there is no host->vmmc
Date: Tue,  1 May 2018 16:09:12 +0530
Message-ID: <1525171153-24476-4-git-send-email-vviswana@codeaurora.org>
References: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

When the regulators are not managed by SDHCI host driver (i.e.,
when host->vmmc and host->vmmcq are absent), get the regulator
current capabilities through a new host op get_current_limit().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
[vviswana@codeaurora.org: fixed trivial merge conflicts]
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>

Change-Id: I3370a2411beec1f03cc5f102bf95cd816c60351e
---
 drivers/mmc/host/sdhci.c | 11 ++++++++---
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0d5fcca..edc2ccd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3570,10 +3570,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * value.
 	 */
 	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
-	if (!max_current_caps && !IS_ERR(mmc->supply.vmmc)) {
-		int curr = regulator_get_current_limit(mmc->supply.vmmc);
-		if (curr > 0) {
+	if (!max_current_caps) {
+		u32 curr = 0;
+
+		if (!IS_ERR(mmc->supply.vmmc))
+			curr = regulator_get_current_limit(mmc->supply.vmmc);
+		else if (host->ops->get_current_limit)
+			curr = host->ops->get_current_limit(host);
 
+		if (curr > 0) {
 			/* convert to SDHCI_MAX_CURRENT format */
 			curr = curr/1000;  /* convert to mA */
 			curr = curr/SDHCI_MAX_CURRENT_MULTIPLIER;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 54bc444..a01af78 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -584,6 +584,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	unsigned int	(*get_current_limit)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
