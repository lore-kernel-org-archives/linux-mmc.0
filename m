From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 25/40] mmc: sdhci: Add a quirk to disable card clock during tuning
Date: Wed, 1 Aug 2018 19:32:15 +0300
Message-ID: <1533141150-10511-26-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add a quirk to disable card clock when the tuning command is sent.

This has to be done to prevent the SDHCI controller from hanging on
Tegra210. Without the quirk enabled there appears to be around 10%
chance that the tuning sequence will fail and time out due to the
controller locking up.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 15 +++++++++++++++
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 04dc443..166b16f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2175,6 +2175,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	struct mmc_request mrq = {};
 	unsigned long flags;
 	u32 b = host->sdma_boundary;
+	u16 clk;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -2183,6 +2184,13 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	cmd.mrq = &mrq;
 
 	mrq.cmd = &cmd;
+
+	if (host->quirks2 & SDHCI_QUIRK2_TUNE_DIS_CARD_CLK) {
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	}
+
 	/*
 	 * In response to CMD19, the card sends 64 bytes of tuning
 	 * block to the Host Controller. So we set the block size
@@ -2213,6 +2221,13 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	if (host->quirks2 & SDHCI_QUIRK2_TUNE_DIS_CARD_CLK) {
+		udelay(1);
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	}
+
 	/* Wait for Buffer Read Ready interrupt */
 	wait_event_timeout(host->buf_ready_int, (host->tuning_done == 1),
 			   msecs_to_jiffies(50));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a99008..cc411b0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -452,6 +452,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
 /* Don't clear the SDHCI_TRANSFER_MODE register on tuning commands */
 #define SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG	(1<<18)
+/* Disable card clock during tuning */
+#define SDHCI_QUIRK2_TUNE_DIS_CARD_CLK			(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4
