From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] mmc: sdhci-msm: Add set_uhs_signaling() implementation
Date: Tue, 19 Jul 2016 17:52:25 +0300
Message-ID: <1468939945-15233-1-git-send-email-georgi.djakov@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34877 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbcGSOwu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2016 10:52:50 -0400
Received: by mail-lf0-f47.google.com with SMTP id f93so16609289lfi.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2016 07:52:49 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, riteshh@codeaurora.org, bjorn.andersson@linaro.org, srinivas.kandagatla@linaro.org

From: Ritesh Harjani <riteshh@codeaurora.org>

To allow UHS mode to work properly, we need to implement a Qualcomm
specific set_uhs_signaling() callback function. This function differs
from the sdhci_set_uhs_signaling() in that we need check the clock
rate and enable UHS timing only if the frequency is above 100MHz.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

This patch resolves the mmc_select_hs200 timeouts noticed after merging
commit a5c1f3e55c99 ("mmc: mmc: do not use CMD13 to get status after
speed mode switch")

mmc0: mmc_select_hs200 failed, error -110
mmc0: error -110 whilst initialising MMC card
mmc0: Reset 0x1 never completed.
sdhci: =========== REGISTER DUMP (mmc0)===========
sdhci: Sys addr: 0x00000000 | Version: 0x00002e02
sdhci: Blk size: 0x00004000 | Blk cnt: 0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present: 0x01f80000 | Host ctl: 0x00000000
sdhci: Power: 0x00000000 | Blk gap: 0x00000000
sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
sdhci: Timeout: 0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps: 0x322dc8b2 | Caps_1: 0x00008007
sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
sdhci: Host ctl2: 0x00000000
sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000000000000
sdhci: ===========================================

 drivers/mmc/host/sdhci-msm.c |   48 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 343e4bd4dc08..d1fce941cdd4 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -410,6 +410,52 @@ retry:
 	return rc;
 }
 
+static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
+					unsigned int uhs)
+{
+	struct mmc_host *mmc = host->mmc;
+	u16 ctrl_2;
+
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	switch (uhs) {
+	case MMC_TIMING_UHS_SDR12:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+		break;
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_UHS_SDR104:
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+		break;
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+		break;
+	}
+
+	/*
+	 * When clock frequency is less than 100MHz, the feedback clock must be
+	 * provided and DLL must not be used so that tuning can be skipped. To
+	 * provide feedback clock, the mode selection can be any value less
+	 * than 3'b011 in bits [2:0] of HOST CONTROL2 register.
+	 */
+	if (host->clock <= 100000000 &&
+	    (uhs == MMC_TIMING_MMC_HS400 ||
+	     uhs == MMC_TIMING_MMC_HS200 ||
+	     uhs == MMC_TIMING_UHS_SDR104))
+		ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+
+	dev_dbg(mmc_dev(mmc), "%s: clock=%u uhs=%u ctrl_2=0x%x\n",
+		mmc_hostname(host->mmc), host->clock, uhs, ctrl_2);
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
@@ -422,7 +468,7 @@ static const struct sdhci_ops sdhci_msm_ops = {
 	.reset = sdhci_reset,
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
