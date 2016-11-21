From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v9 09/16] mmc: sdhci: Factor out sdhci_enable_clk
Date: Mon, 21 Nov 2016 12:07:19 +0530
Message-ID: <1479710246-26676-10-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbcKUGjD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2016 01:39:03 -0500
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>

Factor out sdhci_enable_clk from sdhci_set_clock
and make it EXPORT_SYMBOL so that it can be called.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 28 +++++++++++++++++-----------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d08d507..62aedf1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1344,20 +1344,10 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 }
 EXPORT_SYMBOL_GPL(sdhci_calc_clk);
 
-void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 {
-	u16 clk;
 	unsigned long timeout;
 
-	host->mmc->actual_clock = 0;
-
-	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
-
-	if (clock == 0)
-		return;
-
-	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
-
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
@@ -1378,6 +1368,22 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_clk);
+
+void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+
+	host->mmc->actual_clock = 0;
+
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	if (clock == 0)
+		return;
+
+	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
+	sdhci_enable_clk(host, clk);
+}
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
 static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9c35776..2fe9e80 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -682,6 +682,7 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
+void sdhci_enable_clk(struct sdhci_host *host, u16 clk);
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		     unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

