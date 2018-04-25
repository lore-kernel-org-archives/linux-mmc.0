From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 06/12] mmc: sdhci: Add quirk to disable HW timeout
Date: Wed, 25 Apr 2018 17:39:31 +0530
Message-ID: <20180425120937.29867-7-kishon@ti.com>
References: <20180425120937.29867-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425120937.29867-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add quirk to disable HW timeout if the requested timeout is more than the
maximum obtainable timeout.

Also, if the quirk is set and ->get_max_timeout_count() is not implemented,
max_busy_timeout is set to zero.

Based-on-patch-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 38 ++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.h |  5 +++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b5f047b5f3ae..b91163de4da4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -709,12 +709,15 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
-static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
+			     bool *too_big)
 {
 	u8 count;
 	struct mmc_data *data = cmd->data;
 	unsigned target_timeout, current_timeout;
 
+	*too_big = true;
+
 	/*
 	 * If the host controller provides us with an incorrect timeout
 	 * value, just skip the check and use 0xE.  The hardware may take
@@ -768,9 +771,12 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (count >= 0xF) {
-		DBG("Too large timeout 0x%x requested for CMD%d!\n",
-		    count, cmd->opcode);
+		if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
+			DBG("Too large timeout 0x%x requested for CMD%d!\n",
+			    count, cmd->opcode);
 		count = 0xE;
+	} else {
+		*too_big = false;
 	}
 
 	return count;
@@ -790,6 +796,16 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
+static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
+{
+	if (enable)
+		host->ier |= SDHCI_INT_DATA_TIMEOUT;
+	else
+		host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+}
+
 static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
@@ -797,7 +813,17 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	if (host->ops->set_timeout) {
 		host->ops->set_timeout(host, cmd);
 	} else {
-		count = sdhci_calc_timeout(host, cmd);
+		bool too_big = false;
+
+		count = sdhci_calc_timeout(host, cmd, &too_big);
+
+		if (too_big &&
+		    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
+			sdhci_set_data_timeout_irq(host, false);
+		} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
+			sdhci_set_data_timeout_irq(host, true);
+		}
+
 		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
 	}
 }
@@ -3616,6 +3642,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->max_busy_timeout /= host->timeout_clk;
 	}
 
+	if (host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT &&
+	    !host->ops->get_max_timeout_count)
+		mmc->max_busy_timeout = 0;
+
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c95b0a4a7594..f6555c0f4ad3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -437,6 +437,11 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
 /* Controller has CRC in 136 bit Command Response */
 #define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
+/*
+ * Disable HW timeout if the requested timeout is more than the maximum
+ * obtainable timeout.
+ */
+#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.17.0
