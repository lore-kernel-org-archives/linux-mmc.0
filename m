From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/5] mmc: add eMMC hardware reset support
Date: Mon, 29 Aug 2011 16:42:11 +0300
Message-ID: <1314625335-11638-2-git-send-email-adrian.hunter@intel.com>
References: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63266 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423Ab1H2NmZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Aug 2011 09:42:25 -0400
In-Reply-To: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

eMMC's may have a hardware reset line.  This patch provides a
host controller operation to implement hardware reset and
a function to reset and reinitialize the card.  Also, for MMC,
the reset is always performed before initialization.

The host must set the new host capability MMC_CAP_HW_RESET
to enable hardware reset.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c  |   95 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   |    4 +-
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/core.h |    3 +
 include/linux/mmc/host.h |    2 +
 include/linux/mmc/mmc.h  |    4 ++
 6 files changed, 108 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 557856b..3bdb981 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1768,6 +1768,95 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 }
 EXPORT_SYMBOL(mmc_set_blocklen);
 
+static void mmc_hw_reset_for_init(struct mmc_host *host)
+{
+	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
+		return;
+	mmc_host_clk_hold(host);
+	host->ops->hw_reset(host);
+	mmc_host_clk_release(host);
+}
+
+int mmc_can_reset(struct mmc_card *card)
+{
+	u8 rst_n_function;
+
+	if (!mmc_card_mmc(card))
+		return 0;
+	rst_n_function = card->ext_csd.rst_n_function;
+	if ((rst_n_function & EXT_CSD_RST_N_EN_MASK) != EXT_CSD_RST_N_ENABLED)
+		return 0;
+	return 1;
+}
+EXPORT_SYMBOL(mmc_can_reset);
+
+static int mmc_do_hw_reset(struct mmc_host *host, int check)
+{
+	struct mmc_card *card = host->card;
+
+	if (!host->bus_ops->power_restore)
+		return -EOPNOTSUPP;
+
+	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
+		return -EOPNOTSUPP;
+
+	if (!card)
+		return -EINVAL;
+
+	if (!mmc_can_reset(card))
+		return -EOPNOTSUPP;
+
+	mmc_host_clk_hold(host);
+	mmc_set_clock(host, host->f_init);
+
+	host->ops->hw_reset(host);
+
+	/* If the reset has happened, then a status command will fail */
+	if (check) {
+		struct mmc_command cmd = {0};
+		int err;
+
+		cmd.opcode = MMC_SEND_STATUS;
+		if (!mmc_host_is_spi(card->host))
+			cmd.arg = card->rca << 16;
+		cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
+		err = mmc_wait_for_cmd(card->host, &cmd, 0);
+		if (!err) {
+			mmc_host_clk_release(host);
+			return -ENOSYS;
+		}
+	}
+
+	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_DDR);
+	if (mmc_host_is_spi(host)) {
+		host->ios.chip_select = MMC_CS_HIGH;
+		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
+	} else {
+		host->ios.chip_select = MMC_CS_DONTCARE;
+		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
+	}
+	host->ios.bus_width = MMC_BUS_WIDTH_1;
+	host->ios.timing = MMC_TIMING_LEGACY;
+	host->ios.ddr = MMC_SDR_MODE;
+	mmc_set_ios(host);
+
+	mmc_host_clk_release(host);
+
+	return host->bus_ops->power_restore(host);
+}
+
+int mmc_hw_reset(struct mmc_host *host)
+{
+	return mmc_do_hw_reset(host, 0);
+}
+EXPORT_SYMBOL(mmc_hw_reset);
+
+int mmc_hw_reset_check(struct mmc_host *host)
+{
+	return mmc_do_hw_reset(host, 1);
+}
+EXPORT_SYMBOL(mmc_hw_reset_check);
+
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
@@ -1779,6 +1868,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	mmc_power_up(host);
 
 	/*
+	 * Some eMMCs (with VCCQ always on) may not be reset after power up, so
+	 * do a hardware reset if possible.
+	 */
+	mmc_hw_reset_for_init(host);
+
+	/*
 	 * sdio_reset sends CMD52 to reset card.  Since we do not know
 	 * if the card is being re-initialized, just send it.  CMD52
 	 * should be ignored by SD/eMMC cards.
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5700b1c..e090a87 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -402,8 +402,10 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			ext_csd[EXT_CSD_TRIM_MULT];
 	}
 
-	if (card->ext_csd.rev >= 5)
+	if (card->ext_csd.rev >= 5) {
 		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
+		card->ext_csd.rst_n_function = ext_csd[EXT_CSD_RST_N_FUNCTION];
+	}
 
 	if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
 		card->erased_byte = 0xFF;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b460fc2..a45c5b8 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -50,6 +50,7 @@ struct mmc_ext_csd {
 	u8			rel_sectors;
 	u8			rel_param;
 	u8			part_config;
+	u8			rst_n_function;
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		hs_max_dtr;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b8b1b7a..56e5625 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -162,6 +162,9 @@ extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
 extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
+extern int mmc_hw_reset(struct mmc_host *host);
+extern int mmc_hw_reset_check(struct mmc_host *host);
+extern int mmc_can_reset(struct mmc_card *card);
 
 extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
 extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4c4bddf..85b5626 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -148,6 +148,7 @@ struct mmc_host_ops {
 	int	(*execute_tuning)(struct mmc_host *host);
 	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
 	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
+	void	(*hw_reset)(struct mmc_host *host);
 };
 
 struct mmc_card;
@@ -230,6 +231,7 @@ struct mmc_host {
 #define MMC_CAP_MAX_CURRENT_600	(1 << 28)	/* Host max current limit is 600mA */
 #define MMC_CAP_MAX_CURRENT_800	(1 << 29)	/* Host max current limit is 800mA */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
+#define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 5a794cb..ed8fca8 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -272,6 +272,7 @@ struct _mmc_csd {
 
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
+#define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
@@ -328,6 +329,9 @@ struct _mmc_csd {
 #define EXT_CSD_SEC_BD_BLK_EN	BIT(2)
 #define EXT_CSD_SEC_GB_CL_EN	BIT(4)
 
+#define EXT_CSD_RST_N_EN_MASK	0x3
+#define EXT_CSD_RST_N_ENABLED	1	/* RST_n is enabled on card */
+
 /*
  * MMC_SWITCH access modes
  */
-- 
1.7.6

