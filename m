From: srinivas.kandagatla@linaro.org
Subject: [PATCH RFC 08/12] mmc: mmci: move ST specific register extensions access under condition.
Date: Mon, 21 Apr 2014 22:48:42 +0100
Message-ID: <1398116922-31556-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59018 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906AbaDUVsw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Apr 2014 17:48:52 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so3084356wgg.21
        for <linux-mmc@vger.kernel.org>; Mon, 21 Apr 2014 14:48:49 -0700 (PDT)
In-Reply-To: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch moves some of the ST specific register extensions access under
condition, so that other SOCs like Qualcomm or ARM would not a side effect of
writing to those reserved/different purpose bits.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/mmci.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2dc7581..179abfb 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -270,7 +270,8 @@ static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
 static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
 {
 	/* Keep ST Micro busy mode if enabled */
-	datactrl |= host->datactrl_reg & MCI_ST_DPSM_BUSYMODE;
+	if (host->hw_designer == AMBA_VENDOR_ST)
+		datactrl |= host->datactrl_reg & MCI_ST_DPSM_BUSYMODE;
 
 	if (host->datactrl_reg != datactrl) {
 		host->datactrl_reg = datactrl;
@@ -816,7 +817,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 			mmci_write_clkreg(host, clk);
 		}
 
-	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
+	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 &&
+	    host->hw_designer == AMBA_VENDOR_ST)
 		datactrl |= MCI_ST_DPSM_DDRMODE;
 
 	/*
-- 
1.7.9.5

