From: P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto tuning mode.
Date: Tue, 19 Jan 2016 19:47:31 +0530
Message-ID: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>, Emil Lenchak <emill@xilinx.com>, Tobias Klauser <tklauser@distanz.ch>, Sudeep Holla <Sudeep.Holla@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, "Ivan T.
 Ivanov" <ivan.ivanov@linaro.org>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Haibo Chen <haibo.chen@freescale.com>, Marek Vasut <marex@denx.de>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, Suman Tripathi <stripathi@apm.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: devicetree@vger.kernel.org, Harini Katakam <harinik@xilinx.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, P L Sai Krishna <lakshmis@xilinx.com>, Anirudha Sarangi <anirudh@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

During the auto tuning mode of SDR104, a couple of transactions
on rx_tap_value which are not incremental or decremental by 1.
Since the DLL supports only increment/decrement by 1 during
dynamic change, observed unexpected delays during both these
transactions.
The first transaction occurs when the tap value
reached 0x1F, it will reset to 0x0 and go till 0x7. This
transaction can be avoided by changing the corecfg_dis1p5xtuningcnt
to 1'b1 which is currently tied to 1'b0 in the RTL.
The second transaction occurs after the tuning is completed.
Once the tuning is done, the tuning fsm in the host controller
calculates the average pattern match and will write the value
on the rx tap value. Therefore observed a transaction from 0x7 to
the final value which need not be a increment/decrement value.
Because of this issue DLL tuning will not be accurate and SDR50,
SDR104 & HS200 modes may not work.

This patch adds workaround to change the SD clock after
tuning done to provide accurate DLL tuning for SDR50,
SD104 & HS200 modes.

After receiving the tuning done, program "SDCLK Frequency Select"
of clock control register with a value different from the desired
value. Wait for the "Internal Clock Stable" bit of the clock
control register and program the desired frequency.

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 18 ++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c     |  3 +++
 drivers/mmc/host/sdhci.c           |  5 +++++
 drivers/mmc/host/sdhci.h           |  4 ++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 75379cb..7f30577 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -52,6 +52,23 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
 	return freq;
 }
 
+void arasan_tune_sdclk(struct sdhci_host *host)
+{
+	unsigned int clock;
+
+	clock = host->clock;
+
+	/*
+	 * As per controller erratum, program the SDCLK Frequency
+	 * Select of clock control register with a value, say
+	 * clock/2. Wait for the Internal clock stable and program
+	 * the desired frequency.
+	 */
+	host->ops->set_clock(host, clock/2);
+
+	host->ops->set_clock(host, host->clock);
+}
+
 static struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -59,6 +76,7 @@ static struct sdhci_ops sdhci_arasan_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.tune_clk = arasan_tune_sdclk,
 };
 
 static struct sdhci_pltfm_data sdhci_arasan_pdata = {
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 072bb27..223c5eb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -90,6 +90,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	if (of_get_property(np, "no-1-8-v", NULL))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
+	if (of_get_property(np, "broken-tuning", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_TUNING;
+
 	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d622435..8b064cd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2043,6 +2043,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		err = -EIO;
 	}
 
+	if ((host->quirks2 & SDHCI_QUIRK2_BROKEN_TUNING) &&
+		(tuning_loop_counter >= 0) && (ctrl & SDHCI_CTRL_TUNED_CLK)) {
+		host->ops->tune_clk(host);
+	}
+
 out:
 	if (tuning_count) {
 		/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7654ae5..16419f0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -417,6 +417,9 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Tuning Broken for HS200, SDR50 and SDR104 */
+#define SDHCI_QUIRK2_BROKEN_TUNING			(1<<16)
+
 /*
  * When internal clock is disabled, a delay is needed before modifying the
  * SD clock frequency or enabling back the internal clock.
@@ -548,6 +551,7 @@ struct sdhci_ops {
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	void	(*tune_clk)(struct sdhci_host *host);
 	int	(*select_drive_strength)(struct sdhci_host *host,
 					 struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
-- 
2.1.2
