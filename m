From: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH] mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400
Date: Wed, 28 Jun 2017 16:23:07 +0530
Message-ID: <1498647187-18272-1-git-send-email-Nehal-bakulchandra.Shah@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com ([104.47.38.73]:39360
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751498AbdF1LFg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 28 Jun 2017 07:05:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: Shyam-sundar.S-k@amd.com, linux-mmc@vger.kernel.org, Sandeep.Singh@amd.com, Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>

From: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>

This patch supports HS400 for AMD upcoming emmc 5.0 controller.The
HS400 and HS200 mode requires hardware work around also. This patch
adds the quirks for the same.

Signed-off-by: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/mmc/core/mmc.c        | 36 +++++++++++++++++++-----------------
 drivers/mmc/host/sdhci-acpi.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      | 22 ++++++++++++++++++++++
 drivers/mmc/host/sdhci.h      |  4 +++-
 include/linux/mmc/host.h      |  1 +
 5 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4ffea14..29c46d7 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1161,14 +1161,14 @@ static int mmc_select_hs400(struct mmc_card *card)
 			mmc_hostname(host), err);
 		return err;
 	}
-
-	/* Set host controller to HS timing */
-	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
-
-	/* Reduce frequency to HS frequency */
-	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
+	/*In AMD Platform due to hardware ip issue this fails*/
+	if (!host->ops->set_hs400_dll) {
+		/* Set host controller to HS timing */
+		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+		/* Reduce frequency to HS frequency */
+		max_dtr = card->ext_csd.hs_max_dtr;
+		mmc_set_clock(host, max_dtr);
+	}
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
@@ -1204,7 +1204,8 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
-
+	if (host->ops->set_hs400_dll)
+		host->ops->set_hs400_dll(host);
 	return 0;
 
 out_err:
@@ -1227,8 +1228,8 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 
 	/* Reduce frequency to HS */
 	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
+	if (!host->ops->set_hs400_dll)
+		mmc_set_clock(host, max_dtr);
 	/* Switch HS400 to HS DDR */
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
@@ -1236,12 +1237,13 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 			   true, false, true);
 	if (err)
 		goto out_err;
-
-	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
-
-	err = mmc_switch_status(card);
-	if (err)
-		goto out_err;
+       /*In AMD Platform due to hardware ip issue this fails*/
+	if (!host->ops->set_hs400_dll) {
+		mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
+		err = mmc_switch_status(card);
+		if (err)
+			goto out_err;
+	}
 
 	/* Switch HS DDR to HS */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index cf66a3d..7702459 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -103,6 +103,16 @@ static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 	usleep_range(300, 1000);
 }
 
+static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host)
+{
+	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	if (host->mmc->caps2 == MMC_CAP2_HS400_1_8V) {
+		sdhci_writel(host, 0x40003210, 0x908);
+		udelay(10);
+		sdhci_writel(host, 0x40033210, 0x908);
+	}
+}
+
 static const struct sdhci_ops sdhci_acpi_ops_dflt = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -122,6 +132,17 @@ static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 	.ops = &sdhci_acpi_ops_int,
 };
 
+static const struct sdhci_ops sdhci_acpi_ops_amd = {
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_hs400_dll = sdhci_acpi_amd_hs400_dll,
+};
+
+static const struct sdhci_acpi_chip sdhci_acpi_chip_amd = {
+	.ops = &sdhci_acpi_ops_amd,
+};
 #ifdef CONFIG_X86
 
 static bool sdhci_acpi_byt(void)
@@ -282,6 +303,18 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 	.probe_slot	= sdhci_acpi_emmc_probe_slot,
 };
 
+static const struct sdhci_acpi_slot sdhci_acpi_slot_amd_emmc = {
+	.chip    = &sdhci_acpi_chip_amd,
+	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
+		   MMC_CAP_HW_RESET,
+	.quirks  = SDHCI_QUIRK_32BIT_DMA_ADDR |
+		   SDHCI_QUIRK_32BIT_DMA_SIZE |
+		   SDHCI_QUIRK_32BIT_ADMA_SIZE,
+	.quirks2 = SDHCI_QUIRK2_BROKEN_TUNING_WA,
+	.probe_slot     = sdhci_acpi_emmc_probe_slot,
+
+};
+
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		   SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
@@ -335,6 +368,8 @@ struct sdhci_acpi_uid_slot {
 	{ "INT344D"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "PNP0D40"  },
+	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc  },
+	{ "AMDI0040"},
 	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
 	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
 	{ },
@@ -353,6 +388,7 @@ struct sdhci_acpi_uid_slot {
 	{ "PNP0D40"  },
 	{ "QCOM8051" },
 	{ "QCOM8052" },
+	{ "AMDI0040" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d43..6e0e73d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1170,6 +1170,13 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		flags |= SDHCI_CMD_DATA;
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+
+	if (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200  &&
+	    (host->quirks2 & SDHCI_QUIRK2_BROKEN_TUNING_WA)) {
+		mdelay(10);
+		sdhci_writel(host, 0x8803040a, 0x8b8);
+		mdelay(10);
+	}
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
@@ -1818,6 +1825,14 @@ static void sdhci_hw_reset(struct mmc_host *mmc)
 		host->ops->hw_reset(host);
 }
 
+static void sdhci_set_hs400_dll(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->ops && host->ops->set_hs400_dll)
+		host->ops->set_hs400_dll(host);
+}
+
 static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 {
 	if (!(host->flags & SDHCI_DEVICE_DEAD)) {
@@ -2295,6 +2310,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	.get_cd		= sdhci_get_cd,
 	.get_ro		= sdhci_get_ro,
 	.hw_reset	= sdhci_hw_reset,
+	.set_hs400_dll = sdhci_set_hs400_dll,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.prepare_hs400_tuning		= sdhci_prepare_hs400_tuning,
@@ -3202,6 +3218,12 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 		host->caps1 &= ~upper_32_bits(dt_caps_mask);
 		host->caps1 |= upper_32_bits(dt_caps);
 	}
+
+	if ((host->caps1 & SDHCI_SUPPORT_SDR104) &&
+	    (host->caps1 & SDHCI_SUPPORT_DDR50) &&
+	    (host->quirks2 & SDHCI_QUIRK2_BROKEN_TUNING_WA)) {
+		host->mmc->caps2 = MMC_CAP2_HS400_1_8V;
+	}
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0469fa1..d3ec57c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -435,7 +435,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
-
+/* Tuning work around */
+#define SDHCI_QUIRK2_BROKEN_TUNING_WA		        (1<<16)
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
 
@@ -576,6 +577,7 @@ struct sdhci_ops {
 	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
 	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
+	void    (*set_hs400_dll)(struct sdhci_host *host);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ebd1ceb..1b00c28 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -152,6 +152,7 @@ struct mmc_host_ops {
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
 	void	(*hw_reset)(struct mmc_host *host);
+	void	(*set_hs400_dll)(struct mmc_host *host);
 	void	(*card_event)(struct mmc_host *host);
 
 	/*
-- 
1.9.1

