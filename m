From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 3/4] mmc: mmci: Cache MMCIDATACTRL register
Date: Wed, 15 May 2013 11:40:21 +0200
Message-ID: <1368610823-14113-4-git-send-email-ulf.hansson@stericsson.com>
References: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog124.obsmtp.com ([207.126.144.157]:40029 "EHLO
	eu1sys200aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758786Ab3EOJl4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 05:41:56 -0400
In-Reply-To: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Add a cache variable in the host struct that reflects the current data in
the MMCIDATACTRL register. This patch will not introduce any functional
change but instead provide an easy option to keep specific bits in the
register between each data transfer.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   17 ++++++++++++++---
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8d4ceb8..4530217 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -191,6 +191,17 @@ static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
 /*
  * This must be called with host->lock held
  */
+static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
+{
+	if (host->datactrl_reg != datactrl) {
+		host->datactrl_reg = datactrl;
+		writel(datactrl, host->base + MMCIDATACTRL);
+	}
+}
+
+/*
+ * This must be called with host->lock held
+ */
 static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 {
 	struct variant_data *variant = host->variant;
@@ -275,7 +286,7 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
 
 static void mmci_stop_data(struct mmci_host *host)
 {
-	writel(0, host->base + MMCIDATACTRL);
+	mmci_write_datactrlreg(host, 0);
 	mmci_set_mask1(host, 0);
 	host->data = NULL;
 }
@@ -552,7 +563,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	datactrl |= MCI_DPSM_DMAENABLE;
 
 	/* Trigger the DMA transfer */
-	writel(datactrl, host->base + MMCIDATACTRL);
+	mmci_write_datactrlreg(host, datactrl);
 
 	/*
 	 * Let the MMCI say when the data is ended and it's time
@@ -750,7 +761,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		irqmask = MCI_TXFIFOHALFEMPTYMASK;
 	}
 
-	writel(datactrl, base + MMCIDATACTRL);
+	mmci_write_datactrlreg(host, datactrl);
 	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
 	mmci_set_mask1(host, irqmask);
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 1383c9c..0b6cc54 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -183,6 +183,7 @@ struct mmci_host {
 	unsigned int		cclk;
 	u32			pwr_reg;
 	u32			clk_reg;
+	u32			datactrl_reg;
 	bool			vqmmc_enabled;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
-- 
1.7.10

