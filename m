From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 09/16] mmc: sdhci: Add quirk to disable HW timeout
Date: Mon, 5 Feb 2018 18:20:22 +0530
Message-ID: <20180205125029.21570-10-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add quirk to disable HW timeout if the requested timeout is more than
the maximum obtainable timeout.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 12 ++++++++++++
 drivers/mmc/host/sdhci.h |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 070aff9c108f..1aa74b4682f3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -735,6 +735,12 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		DBG("Too large timeout 0x%x requested for CMD%d!\n",
 		    count, cmd->opcode);
 		count = 0xE;
+		if (host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
+			host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
+			sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+			sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+			host->hw_timeout_disabled = true;
+		}
 	}
 
 	return count;
@@ -2349,6 +2355,12 @@ static bool sdhci_request_done(struct sdhci_host *host)
 	}
 
 	sdhci_del_timer(host, mrq);
+	if (sdhci_data_line_cmd(mrq->cmd) && host->hw_timeout_disabled) {
+		host->ier |= SDHCI_INT_DATA_TIMEOUT;
+		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+		host->hw_timeout_disabled = false;
+	}
 
 	/*
 	 * Always unmap the data buffers if they were mapped by
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index afab26fd70e6..3a967a56fcc3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -437,6 +437,11 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
 /* Controller has CRC in 136 bit Command Response */
 #define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
+/*
+ * Disable HW timeout if the requested timeout is more than the maximum
+ * obtainable timeout
+ */
+#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
@@ -522,6 +527,8 @@ struct sdhci_host {
 	unsigned int            ocr_avail_mmc;
 	u32 ocr_mask;		/* available voltages */
 
+	bool			hw_timeout_disabled;
+
 	unsigned		timing;		/* Current timing */
 
 	u32			thread_isr;
-- 
2.11.0
