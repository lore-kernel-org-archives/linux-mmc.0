From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2] mmc: sdhci-msm: Optionally wait for signal level changes
Date: Mon, 20 Nov 2017 11:56:47 -0800
Message-ID: <20171120195647.22677-1-bjorn.andersson@linaro.org>
References: <20171120183451.18966-1-bjorn.andersson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47083 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbdKTT4w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Nov 2017 14:56:52 -0500
Received: by mail-pg0-f67.google.com with SMTP id z184so8201388pgd.13
        for <linux-mmc@vger.kernel.org>; Mon, 20 Nov 2017 11:56:52 -0800 (PST)
In-Reply-To: <20171120183451.18966-1-bjorn.andersson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Vijay Viswanath <vviswana@codeaurora.org>

Not all instances of the SDCC core supports changing signal voltage and
as such will not generate a power interrupt when the software attempts
to change the voltage. This results in probing the eMMC on some devices
to take over 2 minutes.

Check that the SWITCHABLE_SIGNALING_VOLTAGE bit in MCI_GENERICS is set
before waiting for the power interrupt.

Cc: Sahitya Tummala <stummala@codeaurora.org>
Cc: Vijay Viswanath <vviswana@codeaurora.org>
Fixes: c0309b3803fe ("mmc: sdhci-msm: Add sdhci msm register write APIs which wait for pwr irq")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

The offending patch is part of your v4.15 pull request, so please pick
this up for the -rcs.

Changes since v1:
- Fixed spelling of swichable...

 drivers/mmc/host/sdhci-msm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3fb7d2eec93f..c283291db705 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -29,6 +29,9 @@
 #define CORE_VERSION_MAJOR_MASK		(0xf << CORE_VERSION_MAJOR_SHIFT)
 #define CORE_VERSION_MINOR_MASK		0xff
 
+#define CORE_MCI_GENERICS		0x70
+#define SWITCHABLE_SIGNALING_VOLTAGE	BIT(29)
+
 #define CORE_HC_MODE		0x78
 #define HC_MODE_EN		0x1
 #define CORE_POWER		0x0
@@ -1028,11 +1031,22 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	bool done = false;
+	u32 val;
 
 	pr_debug("%s: %s: request %d curr_pwr_state %x curr_io_level %x\n",
 			mmc_hostname(host->mmc), __func__, req_type,
 			msm_host->curr_pwr_state, msm_host->curr_io_level);
 
+	/*
+	 * The power interrupt will not be generated for signal voltage
+	 * switches if SWITCHABLE_SIGNALING_VOLTAGE in MCI_GENERICS is not set.
+	 */
+	val = readl(msm_host->core_mem + CORE_MCI_GENERICS);
+	if ((req_type & REQ_IO_HIGH || req_type & REQ_IO_LOW) &&
+	    !(val & SWITCHABLE_SIGNALING_VOLTAGE)) {
+		return;
+	}
+
 	/*
 	 * The IRQ for request type IO High/LOW will be generated when -
 	 * there is a state change in 1.8V enable bit (bit 3) of
-- 
2.15.0

