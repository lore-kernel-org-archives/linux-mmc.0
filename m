From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 05/16] mmc: sdhci-omap: Workaround for Errata i802
Date: Mon, 5 Feb 2018 18:20:18 +0530
Message-ID: <20180205125029.21570-6-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:11512 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753067AbeBEMvm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Feb 2018 07:51:42 -0500
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Errata i802 in AM572x Sitara Processors Silicon Revision 2.0, 1.1
(SPRZ429K July 2014–Revised March 2017 [1]) mentions
DCRC error interrupts (MMCHS_STAT[21] DCRC=0x1) can occur
during the tuning procedure and it has to be disabled during the
tuning procedure Implement workaround for Errata i802 here..

[1] -> http://www.ti.com/lit/er/sprz429k/sprz429k.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-omap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 36e0626d3de2..e24ae903f7ba 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -257,6 +257,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	u32 start_window = 0, max_window = 0;
 	u8 cur_match, prev_match = 0;
 	u32 length = 0, max_len = 0;
+	u32 ier = host->ier;
 	u32 phase_delay = 0;
 	int ret = 0;
 	u32 reg;
@@ -277,6 +278,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	reg |= DLL_SWT;
 	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
 
+	/*
+	 * OMAP5/DRA74X/DRA72x Errata i802:
+	 * DCRC error interrupts (MMCHS_STAT[21] DCRC=0x1) can occur
+	 * during the tuning procedure. So disable it during the
+	 * tuning procedure.
+	 */
+	ier &= ~SDHCI_INT_DATA_CRC;
+	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
 
@@ -322,6 +333,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 ret:
 	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 	return ret;
 }
 
-- 
2.11.0

