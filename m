From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/2] mmc: meson-gx: add basic tuning for rx clock phase
Date: Tue, 4 Apr 2017 21:11:17 +0200
Message-ID: <7a2da0fd-d529-ae23-9fc5-900ae2b26610@gmail.com>
References: <1d60ec2c-54c9-6b1c-7eaa-40e96fcd5be5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33226 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbdDDTL2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2017 15:11:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id o81so7452322wmb.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2017 12:11:27 -0700 (PDT)
In-Reply-To: <1d60ec2c-54c9-6b1c-7eaa-40e96fcd5be5@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

This patch adds basic tuning which changes the rx clock phase only
until a working setting is found.

On a Odroid C2 with 128GB eMMC card and 200 MHz MMC clock only
180° rx clock phase make the system boot w/o CRC errors.

With other MMC devices / clock speeds this might be different,
therefore don't change the driver config in general.

When retuning skip the currently active parameter set. This avoids
the current problematic config to be chosen again if it causes CRC
errors just occasionally.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 3a6e51c8..eb5ee68d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -349,6 +349,31 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	return ret;
 }
 
+static void meson_mmc_set_tuning_params(struct mmc_host *mmc)
+{
+	struct meson_host *host = mmc_priv(mmc);
+	u32 regval;
+
+	/* stop clock */
+	regval = readl(host->regs + SD_EMMC_CFG);
+	regval |= CFG_STOP_CLOCK;
+	writel(regval, host->regs + SD_EMMC_CFG);
+
+	regval = readl(host->regs + SD_EMMC_CLOCK);
+	regval &= ~CLK_CORE_PHASE_MASK;
+	regval |= FIELD_PREP(CLK_CORE_PHASE_MASK, host->tp.core_phase);
+	regval &= ~CLK_TX_PHASE_MASK;
+	regval |= FIELD_PREP(CLK_TX_PHASE_MASK, host->tp.tx_phase);
+	regval &= ~CLK_RX_PHASE_MASK;
+	regval |= FIELD_PREP(CLK_RX_PHASE_MASK, host->tp.rx_phase);
+	writel(regval, host->regs + SD_EMMC_CLOCK);
+
+	/* start clock */
+	regval = readl(host->regs + SD_EMMC_CFG);
+	regval &= ~CFG_STOP_CLOCK;
+	writel(regval, host->regs + SD_EMMC_CFG);
+}
+
 static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -682,6 +707,29 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct meson_host *host = mmc_priv(mmc);
+	struct meson_tuning_params tp_old = host->tp;
+	int ret = -EINVAL, i, cmd_error;
+
+	dev_info(mmc_dev(mmc), "(re)tuning...\n");
+
+	for (i = CLK_PHASE_0; i <= CLK_PHASE_270; i++) {
+		host->tp.rx_phase = i;
+		/* exclude the active parameter set if retuning */
+		if (!memcmp(&tp_old, &host->tp, sizeof(tp_old)) &&
+		    mmc->doing_retune)
+			continue;
+		meson_mmc_set_tuning_params(mmc);
+		ret = mmc_send_tuning(mmc, opcode, &cmd_error);
+		if (!ret)
+			break;
+	}
+
+	return ret;
+}
+
 /*
  * NOTE: we only need this until the GPIO/pinctrl driver can handle
  * interrupts.  For now, the MMC core will use this for polling.
@@ -712,6 +760,7 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.request	= meson_mmc_request,
 	.set_ios	= meson_mmc_set_ios,
 	.get_cd         = meson_mmc_get_cd,
+	.execute_tuning = meson_mmc_execute_tuning,
 };
 
 static int meson_mmc_probe(struct platform_device *pdev)
-- 
2.12.1


