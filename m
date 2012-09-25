From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v3 08/11] mmc: sdhci: enhance preset value function
Date: Tue, 25 Sep 2012 18:39:03 +0800
Message-ID: <1348569546-13242-9-git-send-email-keyuan.liu@gmail.com>
References: <1348569546-13242-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:48027 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754893Ab2IYKoq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 06:44:46 -0400
In-Reply-To: <1348569546-13242-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Preset value support was added by 4d55c5a1.

But preset value is enabled after setting clock finished,
which means the clock is still set by driver firstly and
then switch to preset value at this point. So the
driver setting beforehand is useless and unnecessary.
What's more, driver is still using the old value which may
differ from the preset one. The better way is enable preset
value just after switch to UHS mode so the preset value can
be used directly. So move preset value enable from
mmc_sd_init_card to sdhci_set_ios which will be called during
set timing.

And preset value is disabled at the begining of mmc_attach_sd.
It's a bit late since low freq should be set in mmc_power_up.
So move preset value disable to sdhci_set_ios which will be
called during power up.

Also update host->clock and ios->drv_type according to the
preset value.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/sd.c     |   17 ------
 drivers/mmc/host/sdhci.c  |  128 ++++++++++++++++++++++++++++++--------------
 drivers/mmc/host/sdhci.h  |   12 ++++
 include/linux/mmc/host.h  |    1 -
 include/linux/mmc/sdhci.h |    2 +-
 5 files changed, 100 insertions(+), 60 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 74972c2..3dafb54 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -960,16 +960,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 
 		/* Card is an ultra-high-speed card */
 		mmc_card_set_uhs(card);
-
-		/*
-		 * Since initialization is now complete, enable preset
-		 * value registers for UHS-I cards.
-		 */
-		if (host->ops->enable_preset_value) {
-			mmc_host_clk_hold(card->host);
-			host->ops->enable_preset_value(host, true);
-			mmc_host_clk_release(card->host);
-		}
 	} else {
 		/*
 		 * Attempt to change to high-speed (if supported)
@@ -1148,13 +1138,6 @@ int mmc_attach_sd(struct mmc_host *host)
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
-	/* Disable preset value enable if already set since last time */
-	if (host->ops->enable_preset_value) {
-		mmc_host_clk_hold(host);
-		host->ops->enable_preset_value(host, false);
-		mmc_host_clk_release(host);
-	}
-
 	err = mmc_send_app_op_cond(host, 0, &ocr);
 	if (err)
 		return err;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7c85e49..8e109c3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -53,6 +53,7 @@ static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
 static void sdhci_finish_command(struct sdhci_host *);
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_tuning_timer(unsigned long data);
+static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
 #ifdef CONFIG_PM_RUNTIME
 static int sdhci_runtime_pm_get(struct sdhci_host *host);
@@ -1095,6 +1096,34 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	}
 }
 
+static u16 sdhci_get_preset_value(struct sdhci_host *host)
+{
+	u16 ctrl, preset = 0;
+
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+	switch (ctrl & SDHCI_CTRL_UHS_MASK) {
+	case SDHCI_CTRL_UHS_SDR12:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR12);
+		break;
+	case SDHCI_CTRL_UHS_SDR25:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR25);
+		break;
+	case SDHCI_CTRL_UHS_SDR50:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR50);
+		break;
+	case SDHCI_CTRL_UHS_SDR104:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR104);
+		break;
+	case SDHCI_CTRL_UHS_DDR50:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_DDR50);
+		break;
+	default:
+		BUG();
+	}
+	return preset;
+}
+
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div = 0; /* Initialized for compiler warning */
@@ -1119,35 +1148,45 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		goto out;
 
 	if (host->version >= SDHCI_SPEC_300) {
+		if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
+			SDHCI_CTRL_PRESET_VAL_ENABLE) {
+			u16 pre_val;
+
+			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+			pre_val = sdhci_get_preset_value(host);
+			div = (pre_val & SDHCI_PRESET_SDCLK_FREQ_MASK)
+				>> SDHCI_PRESET_SDCLK_FREQ_SHIFT;
+			if (host->clk_mul &&
+				(pre_val & SDHCI_PRESET_CLKGEN_SEL_MASK)) {
+				clk = SDHCI_PROG_CLOCK_MODE;
+				real_div = div + 1;
+				clk_mul = host->clk_mul;
+			} else {
+				if (div == 0)
+					real_div = 1;
+				else
+					real_div = div << 1;
+			}
+			goto preset;
+		}
 		/*
 		 * Check if the Host Controller supports Programmable Clock
 		 * Mode.
 		 */
 		if (host->clk_mul) {
-			u16 ctrl;
-
+			for (div = 1; div <= 1024; div++) {
+				if (((host->max_clk * host->clk_mul) /
+							div) <= clock)
+					break;
+			}
 			/*
-			 * We need to figure out whether the Host Driver needs
-			 * to select Programmable Clock Mode, or the value can
-			 * be set automatically by the Host Controller based on
-			 * the Preset Value registers.
+			 * Set Programmable Clock Mode in the Clock
+			 * Control register.
 			 */
-			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-			if (!(ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
-				for (div = 1; div <= 1024; div++) {
-					if (((host->max_clk * host->clk_mul) /
-					      div) <= clock)
-						break;
-				}
-				/*
-				 * Set Programmable Clock Mode in the Clock
-				 * Control register.
-				 */
-				clk = SDHCI_PROG_CLOCK_MODE;
-				real_div = div;
-				clk_mul = host->clk_mul;
-				div--;
-			}
+			clk = SDHCI_PROG_CLOCK_MODE;
+			real_div = div;
+			clk_mul = host->clk_mul;
+			div--;
 		} else {
 			/* Version 3.00 divisors must be a multiple of 2. */
 			if (host->max_clk <= clock)
@@ -1172,6 +1211,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		div >>= 1;
 	}
 
+preset:
 	if (real_div)
 		host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
 
@@ -1377,6 +1417,10 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		sdhci_reinit(host);
 	}
 
+	if (host->version >= SDHCI_SPEC_300 &&
+		(ios->power_mode == MMC_POWER_UP))
+		sdhci_enable_preset_value(host, false);
+
 	sdhci_set_clock(host, ios->clock);
 	ios->clock = host->clock;
 
@@ -1489,7 +1533,19 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 		}
-
+		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
+			((ios->timing == MMC_TIMING_UHS_SDR12) ||
+			 (ios->timing == MMC_TIMING_UHS_SDR25) ||
+			 (ios->timing == MMC_TIMING_UHS_SDR50) ||
+			 (ios->timing == MMC_TIMING_UHS_SDR104) ||
+			 (ios->timing == MMC_TIMING_UHS_DDR50))) {
+			u16 preset;
+
+			sdhci_enable_preset_value(host, true);
+			preset = sdhci_get_preset_value(host);
+			ios->drv_type = (preset & SDHCI_PRESET_DRV_MASK)
+					>> SDHCI_PRESET_DRV_SHIFT;
+		}
 		/* Re-enable SD Clock */
 		clock = host->clock;
 		host->clock = 0;
@@ -1951,17 +2007,15 @@ out:
 	return err;
 }
 
-static void sdhci_do_enable_preset_value(struct sdhci_host *host, bool enable)
+
+static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	u16 ctrl;
-	unsigned long flags;
 
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
 		return;
 
-	spin_lock_irqsave(&host->lock, flags);
-
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 
 	/*
@@ -1977,17 +2031,6 @@ static void sdhci_do_enable_preset_value(struct sdhci_host *host, bool enable)
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 		host->flags &= ~SDHCI_PV_ENABLED;
 	}
-
-	spin_unlock_irqrestore(&host->lock, flags);
-}
-
-static void sdhci_enable_preset_value(struct mmc_host *mmc, bool enable)
-{
-	struct sdhci_host *host = mmc_priv(mmc);
-
-	sdhci_runtime_pm_get(host);
-	sdhci_do_enable_preset_value(host, enable);
-	sdhci_runtime_pm_put(host);
 }
 
 static const struct mmc_host_ops sdhci_ops = {
@@ -1998,7 +2041,6 @@ static const struct mmc_host_ops sdhci_ops = {
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.execute_tuning			= sdhci_execute_tuning,
-	.enable_preset_value		= sdhci_enable_preset_value,
 };
 
 /*****************************************************************************\
@@ -2588,8 +2630,12 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 	sdhci_do_set_ios(host, &host->mmc->ios);
 
 	sdhci_do_start_signal_voltage_switch(host, &host->mmc->ios);
-	if (host_flags & SDHCI_PV_ENABLED)
-		sdhci_do_enable_preset_value(host, true);
+	if ((host_flags & SDHCI_PV_ENABLED) &&
+		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN)) {
+		spin_lock_irqsave(&host->lock, flags);
+		sdhci_enable_preset_value(host, true);
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
 
 	/* Set the re-tuning expiration flag */
 	if (host->flags & SDHCI_USING_RETUNING_TIMER)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 97653ea..5eb27bf 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -227,6 +227,18 @@
 
 /* 60-FB reserved */
 
+#define SDHCI_PRESET_FOR_SDR12 0x66
+#define SDHCI_PRESET_FOR_SDR25 0x68
+#define SDHCI_PRESET_FOR_SDR50 0x6A
+#define SDHCI_PRESET_FOR_SDR104        0x6C
+#define SDHCI_PRESET_FOR_DDR50 0x6E
+#define SDHCI_PRESET_DRV_MASK  0xC000
+#define SDHCI_PRESET_DRV_SHIFT  14
+#define SDHCI_PRESET_CLKGEN_SEL_MASK   0x400
+#define SDHCI_PRESET_CLKGEN_SEL_SHIFT	10
+#define SDHCI_PRESET_SDCLK_FREQ_MASK   0x3FF
+#define SDHCI_PRESET_SDCLK_FREQ_SHIFT	0
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 036a5cc..0ee92d2 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -133,7 +133,6 @@ struct mmc_host_ops {
 
 	/* The tuning command opcode value is different for SD and eMMC cards */
 	int	(*execute_tuning)(struct mmc_host *host, u32 opcode);
-	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
 	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
 	void	(*hw_reset)(struct mmc_host *host);
 };
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index fa8529a..d09c20d 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -91,7 +91,7 @@ struct sdhci_host {
 	unsigned int quirks2;	/* More deviations from spec. */
 
 #define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
-
+#define SDHCI_QUIRK2_PRESET_VALUE_BROKEN		(1<<1)
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
 
-- 
1.7.0.4

