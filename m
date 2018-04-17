From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC 2/2] dw_mmc: add multislot support
Date: Tue, 17 Apr 2018 15:11:30 +0300
Message-ID: <20180417121130.25281-3-Eugeniy.Paltsev@synopsys.com>
References: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds missing stuff to support multislot mode in
DesignWare MMC driver.

The main changes:
 * Add missing slot switch to __dw_mci_start_request() function.
 * Refactor set_ios function:
   a) Calculate common clock which is
      suitable for all slots instead of directly use clock value
      provided by mmc core. We calculate common clock as the minimum
      among each used slot clocks. This clock is calculated in
      dw_mci_calc_common_clock() function which is called
      from set_ios()
   b) Disable clock only if no other slots are ON.
   c) Setup clock directly in set_ios() only if no other slots
      are ON. Otherwise adjust clock in __dw_mci_start_request()
      function before slot switch.
   d) Move timings and bus_width setup to separate funcions.
 * Use timing field in each slot structure instead of common field in
   host structure.
 * Add locks to serialize access to registers.

NOTE: this patch is based off of v4.17-rc1

NOTE: as of today I tested this changes (in singleslot and multislot
   modes) only on Synopsys HSDK board. But I will get ODROID-XU4 board
   (with Exynos5422 which has DW MMC controller) the next week
   so I will test it on this board too to catch any regressions.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/mmc/host/dw_mmc.c | 325 ++++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/dw_mmc.h |  14 +-
 2 files changed, 253 insertions(+), 86 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f8b1e3528e99..e0d30f56cc59 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -261,7 +261,8 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 	mci_writel(host, CMDARG, arg);
 	wmb(); /* drain writebuffer */
 	dw_mci_wait_while_busy(host, cmd);
-	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
+	mci_writel(host, CMD, SDMMC_CMD_START | cmd |
+			      (slot->id << SDMMC_CMD_CARD_NUM_OFFSET));
 
 	if (readl_poll_timeout_atomic(host->regs + SDMMC_CMD, cmd_status,
 				      !(cmd_status & SDMMC_CMD_START),
@@ -428,7 +429,8 @@ static void dw_mci_start_command(struct dw_mci *host,
 	wmb(); /* drain writebuffer */
 	dw_mci_wait_while_busy(host, cmd_flags);
 
-	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
+	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START |
+		   (host->cur_slot->id << SDMMC_CMD_CARD_NUM_OFFSET));
 
 	/* response expected command only */
 	if (cmd_flags & SDMMC_CMD_RESP_EXP)
@@ -1065,7 +1067,7 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 	 * It's used when HS400 mode is enabled.
 	 */
 	if (data->flags & MMC_DATA_WRITE &&
-		!(host->timing != MMC_TIMING_MMC_HS400))
+		!(host->cur_slot->timing != MMC_TIMING_MMC_HS400))
 		return;
 
 	if (data->flags & MMC_DATA_WRITE)
@@ -1073,8 +1075,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 	else
 		enable = SDMMC_CARD_RD_THR_EN;
 
-	if (host->timing != MMC_TIMING_MMC_HS200 &&
-	    host->timing != MMC_TIMING_UHS_SDR104)
+	if (host->cur_slot->timing != MMC_TIMING_MMC_HS200 &&
+	    host->cur_slot->timing != MMC_TIMING_UHS_SDR104)
 		goto disable;
 
 	blksz_depth = blksz / (1 << host->data_shift);
@@ -1218,13 +1220,45 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 	}
 }
 
-static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
+/* must be called in the locked context */
+static void dw_mci_setup_clock_off(struct dw_mci_slot *slot)
+{
+	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT |
+			     (slot->id << SDMMC_CMD_CARD_NUM_OFFSET);
+
+	if (!slot->host->new_clk_speed) {
+		mci_writel(slot->host, CLKENA, 0);
+		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
+		slot->host->current_speed = 0;
+	}
+}
+
+static u32 dw_mci_calc_clock_div(struct dw_mci *host)
+{
+	unsigned int clock = host->new_clk_speed;
+	u32 bus_hz = host->bus_hz;
+	u32 div;
+
+	div = bus_hz / clock;
+	if (bus_hz % clock && bus_hz > clock)
+		/*
+		 * move the + 1 after the divide to prevent
+		 * over-clocking the card.
+		 */
+		div += 1;
+
+	return (bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
+}
+
+/* must be called in the locked context */
+static void dw_mci_setup_clock(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
-	unsigned int clock = slot->clock;
+	unsigned int clock = host->new_clk_speed;
 	u32 div;
 	u32 clk_en_a;
-	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
+	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT |
+			     (slot->id << SDMMC_CMD_CARD_NUM_OFFSET);
 
 	/* We must continue to set bit 28 in CMD until the change is complete */
 	if (host->state == STATE_WAITING_CMD11_DONE)
@@ -1233,79 +1267,173 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	if (!clock) {
 		mci_writel(host, CLKENA, 0);
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
-	} else if (clock != host->current_speed || force_clkinit) {
-		div = host->bus_hz / clock;
-		if (host->bus_hz % clock && host->bus_hz > clock)
-			/*
-			 * move the + 1 after the divide to prevent
-			 * over-clocking the card.
-			 */
-			div += 1;
-
-		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
+		host->current_speed = 0;
 
-		if ((clock != slot->__clk_old &&
-			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
-			force_clkinit) {
-			/* Silent the verbose log if calling from PM context */
-			if (!force_clkinit)
-				dev_info(&slot->mmc->class_dev,
-					 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
-					 slot->id, host->bus_hz, clock,
-					 div ? ((host->bus_hz / div) >> 1) :
-					 host->bus_hz, div);
+		return;
+	}
 
-			/*
-			 * If card is polling, display the message only
-			 * one time at boot time.
-			 */
-			if (slot->mmc->caps & MMC_CAP_NEEDS_POLL &&
-					slot->mmc->f_min == clock)
-				set_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags);
-		}
+	if (clock != host->current_speed || force_clkinit) {
+		div = dw_mci_calc_clock_div(host);
 
-		/* disable clock */
-		mci_writel(host, CLKENA, 0);
+		/*
+		 * Stop all clocks by writing xxxx0000 to the CLKENA register.
+		 * We don't want to touch LOW_PWR bits to avoid changing for
+		 * another slot.
+		 */
+		clk_en_a = mci_readl(host, CLKENA);
+		clk_en_a &= ~SDMMC_CLKEN_CLK_ALL;
+		mci_writel(host, CLKENA, clk_en_a);
 		mci_writel(host, CLKSRC, 0);
-
-		/* inform CIU */
+		/* inform CIU about clock disabling */
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
 
 		/* set clock to desired speed */
 		mci_writel(host, CLKDIV, div);
-
-		/* inform CIU */
+		/* inform CIU about CLKDIV change */
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
 
 		/* enable clock; only low power if no SDIO */
-		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
-		if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags))
+		clk_en_a = mci_readl(host, CLKENA);
+		clk_en_a |= SDMMC_CLKEN_ENABLE << slot->id;
+		if (test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags))
+			clk_en_a &= ~(SDMMC_CLKEN_LOW_PWR << slot->id);
+		else
 			clk_en_a |= SDMMC_CLKEN_LOW_PWR << slot->id;
 		mci_writel(host, CLKENA, clk_en_a);
-
-		/* inform CIU */
+		/*
+		 * Inform CIU about clock enabling and (possibly) LOW_PWR bit
+		 * change.
+		 */
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
 
-		/* keep the last clock value that was requested from core */
-		slot->__clk_old = clock;
+		host->current_speed = clock;
 	}
+}
+
+/* must be called with host->lock held */
+static void dw_mci_setup_timings(struct dw_mci_slot *slot, u8 timing)
+{
+	u32 reg;
+
+	slot->timing = timing;
+
+	/* Set the current slot timings */
+	reg = mci_readl(slot->host, UHS_REG);
+
+	/* DDR mode set */
+	if (timing == MMC_TIMING_MMC_DDR52 ||
+	    timing == MMC_TIMING_UHS_DDR50 ||
+	    timing == MMC_TIMING_MMC_HS400)
+		reg |= ((0x1 << slot->id) << 16);
+	else
+		reg &= ~((0x1 << slot->id) << 16);
 
-	host->current_speed = clock;
+	mci_writel(slot->host, UHS_REG, reg);
+}
+
+/* must be called with host->lock held */
+static void dw_mci_calc_common_clock(struct dw_mci_slot *slot)
+{
+	struct dw_mci *host = slot->host;
+	u32 clock_min = ~0U;
+	int i;
+
+	/*
+	 * Calculate new clock which is suitable for all slots and save it in
+	 * host->new_clk_speed
+	 */
+	for (i = 0; i < host->num_slots; i++) {
+		if (host->slot[i] &&
+		    host->slot[i]->clock &&
+		    host->slot[i]->clock < clock_min) {
+			clock_min = host->slot[i]->clock;
+		}
+	}
+
+	/* all slots have clock == 0 */
+	if (clock_min == ~0U)
+		clock_min = 0;
+
+	host->new_clk_speed = clock_min;
+
+	if (clock_min != host->current_speed)
+		dev_vdbg(host->dev, "[%u] ios: choose new common clock: %u\n",
+			 slot->id, clock_min);
+}
+
+/* must be called with host->lock held */
+static void dw_mci_setup_bus_width(struct dw_mci_slot *slot, u8 bus_width)
+{
+	u32 reg;
+
+	switch (bus_width) {
+	case MMC_BUS_WIDTH_4:
+		slot->ctype = SDMMC_CTYPE_4BIT;
+		break;
+	case MMC_BUS_WIDTH_8:
+		slot->ctype = SDMMC_CTYPE_8BIT;
+		break;
+	default:
+		/* set default 1 bit mode */
+		slot->ctype = SDMMC_CTYPE_1BIT;
+	}
 
 	/* Set the current slot bus width */
-	mci_writel(host, CTYPE, (slot->ctype << slot->id));
+	reg = mci_readl(slot->host, CTYPE);
+	reg &= ~((SDMMC_CTYPE_8BIT | SDMMC_CTYPE_4BIT | SDMMC_CTYPE_1BIT) << slot->id);
+	reg |= slot->ctype << slot->id;
+	mci_writel(slot->host, CTYPE, reg);
+}
+
+static void dw_mci_switch_card(struct dw_mci *host, struct dw_mci_slot *prev_slot)
+{
+	struct dw_mci_slot *slot = host->cur_slot;
+	u32 new_id = host->cur_slot->id;
+	u32 clk_en;
+
+	if (!prev_slot)
+		return;
+
+	if (prev_slot->id == new_id)
+		return;
+
+	dev_vdbg(host->dev, "[%u->%u] slot change\n", prev_slot->id, new_id);
+
+	/* Stop all clocks by writing xxxx0000 to the CLKENA register. */
+	clk_en = mci_readl(host, CLKENA);
+	clk_en &= ~SDMMC_CLKEN_CLK_ALL;
+	mci_writel(host, CLKENA, clk_en);
+
+	/* Inform CIU about clock disabling. */
+	mci_send_cmd(slot, SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
+
+	/* Enable clock, carry about new slot LOW_PWR bit */
+	if (test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags))
+		clk_en &= ~(SDMMC_CLKEN_LOW_PWR << new_id);
+	else
+		clk_en |= SDMMC_CLKEN_LOW_PWR << new_id;
+	clk_en |= SDMMC_CLKEN_ENABLE << new_id;
+	mci_writel(host, CLKENA, clk_en);
+
+	/*
+	 * Inform CIU about clock enabling and (possibly) LOW_PWR bit
+	 * change.
+	 */
+	mci_send_cmd(slot, SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
 }
 
 static void __dw_mci_start_request(struct dw_mci *host,
 				   struct dw_mci_slot *slot,
 				   struct mmc_command *cmd)
 {
+	struct dw_mci_slot *prev_slot;
 	struct mmc_request *mrq;
 	struct mmc_data	*data;
 	u32 cmdflags;
 
 	mrq = slot->mrq;
 
+	prev_slot = host->cur_slot;
 	host->cur_slot = slot;
 	host->mrq = mrq;
 
@@ -1315,6 +1443,12 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	host->data_status = 0;
 	host->dir_status = 0;
 
+	/* Change common clock frequency if it is required */
+	dw_mci_setup_clock(slot, false);
+
+	/* Swithch to another slot if it is required */
+	dw_mci_switch_card(host, prev_slot);
+
 	data = cmd->data;
 	if (data) {
 		mci_writel(host, TMOUT, 0xFFFFFFFF);
@@ -1422,6 +1556,20 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_bh(&host->lock);
 }
 
+/* must be called with host->lock held */
+static u8 dw_mci_num_card_is_on(struct dw_mci *host)
+{
+	u8 num_card = 0;
+	int i;
+
+	for (i = 0; i < host->num_slots; i++)
+		if (host->slot[i])
+			if (test_bit(DW_MMC_CARD_IS_ON, &host->slot[i]->flags))
+				num_card++;
+
+	return num_card;
+}
+
 static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
@@ -1429,36 +1577,18 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	u32 regs;
 	int ret;
 
-	switch (ios->bus_width) {
-	case MMC_BUS_WIDTH_4:
-		slot->ctype = SDMMC_CTYPE_4BIT;
-		break;
-	case MMC_BUS_WIDTH_8:
-		slot->ctype = SDMMC_CTYPE_8BIT;
-		break;
-	default:
-		/* set default 1 bit mode */
-		slot->ctype = SDMMC_CTYPE_1BIT;
-	}
-
-	regs = mci_readl(slot->host, UHS_REG);
-
-	/* DDR mode set */
-	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
-	    ios->timing == MMC_TIMING_UHS_DDR50 ||
-	    ios->timing == MMC_TIMING_MMC_HS400)
-		regs |= ((0x1 << slot->id) << 16);
-	else
-		regs &= ~((0x1 << slot->id) << 16);
+	spin_lock_bh(&slot->host->lock);
 
-	mci_writel(slot->host, UHS_REG, regs);
-	slot->host->timing = ios->timing;
+	dw_mci_setup_bus_width(slot, ios->bus_width);
+	dw_mci_setup_timings(slot, ios->timing);
 
 	/*
 	 * Use mirror of ios->clock to prevent race with mmc
 	 * core ios update when finding the minimum.
 	 */
 	slot->clock = ios->clock;
+	/* Calculate new clock which is suitable for all slots */
+	dw_mci_calc_common_clock(slot);
 
 	if (drv_data && drv_data->set_ios)
 		drv_data->set_ios(slot->host, ios);
@@ -1481,6 +1611,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		mci_writel(slot->host, PWREN, regs);
 		break;
 	case MMC_POWER_ON:
+		set_bit(DW_MMC_CARD_IS_ON, &slot->flags);
+
+		/*
+		 * Don't care about regulators and controller reset in
+		 * multislot mode as external regulators can't be used in
+		 * multislot mode. (we explicitly check it in probe function)
+		 */
 		if (!slot->host->vqmmc_enabled) {
 			if (!IS_ERR(mmc->supply.vqmmc)) {
 				ret = regulator_enable(mmc->supply.vqmmc);
@@ -1500,13 +1637,20 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 					  SDMMC_CTRL_ALL_RESET_FLAGS);
 		}
 
-		/* Adjust clock / bus width after power is up */
-		dw_mci_setup_bus(slot, false);
+		/*
+		 * If we are first controller user setup clock. Otherwise
+		 * clock will be adjusted before request.
+		 */
+		if (dw_mci_num_card_is_on(slot->host) == 1)
+			dw_mci_setup_clock(slot, false);
 
 		break;
 	case MMC_POWER_OFF:
-		/* Turn clock off before power goes down */
-		dw_mci_setup_bus(slot, false);
+		clear_bit(DW_MMC_CARD_IS_ON, &slot->flags);
+
+		/* set clock to 0 only if no other card is ON */
+		if (dw_mci_num_card_is_on(slot->host) == 0)
+			dw_mci_setup_clock_off(slot);
 
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
@@ -1525,6 +1669,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
 		slot->host->state = STATE_IDLE;
+
+	spin_unlock_bh(&slot->host->lock);
 }
 
 static int dw_mci_card_busy(struct mmc_host *mmc)
@@ -1553,6 +1699,8 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (drv_data && drv_data->switch_voltage)
 		return drv_data->switch_voltage(mmc, ios);
 
+
+	spin_lock_bh(&slot->host->lock);
 	/*
 	 * Program the voltage.  Note that some instances of dw_mmc may use
 	 * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
@@ -1563,6 +1711,8 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 		uhs &= ~v18;
 	else
 		uhs |= v18;
+	mci_writel(host, UHS_REG, uhs);
+	spin_unlock_bh(&slot->host->lock);
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret = mmc_regulator_set_vqmmc(mmc, ios);
@@ -1574,7 +1724,6 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 			return ret;
 		}
 	}
-	mci_writel(host, UHS_REG, uhs);
 
 	return 0;
 }
@@ -1641,6 +1790,7 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 		u32 clk_en_a_old;
 		u32 clk_en_a;
 
+		spin_lock(&host->lock);
 		clk_en_a_old = mci_readl(host, CLKENA);
 
 		if (card->type == MMC_TYPE_SDIO ||
@@ -1657,6 +1807,7 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 			mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
 				     SDMMC_CMD_PRV_DAT_WAIT, 0);
 		}
+		spin_unlock(&host->lock);
 	}
 }
 
@@ -1929,7 +2080,6 @@ static void dw_mci_set_drto(struct dw_mci *host)
 	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (drto_div == 0)
 		drto_div = 1;
-
 	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
 				   host->bus_hz);
 
@@ -2843,7 +2993,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	slot->sdio_id = host->sdio_id0 + id;
 	slot->mmc = mmc;
 	slot->host = host;
-	host->slot[id] = slot;
 
 	mmc->ops = &dw_mci_ops;
 
@@ -2852,6 +3001,13 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (ret)
 		goto err_host_allocated;
 
+	if (host->num_slots > 1 &&
+	    (!IS_ERR(slot->mmc->supply.vmmc) || !IS_ERR(mmc->supply.vqmmc))) {
+		dev_err(host->dev,
+			"external regulators in multislot mode are not supported\n");
+		goto err_host_allocated;
+	}
+
 	if (!mmc->ocr_avail)
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
@@ -2889,6 +3045,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 	dw_mci_get_cd(mmc);
 
+	/* Add slot to the slot array only if it is allocated successfuly */
+	host->slot[id] = slot;
+
 	ret = mmc_add_host(mmc);
 	if (ret)
 		goto err_host_allocated;
@@ -2900,6 +3059,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	return 0;
 
 err_host_allocated:
+	host->slot[id] = NULL;
 	mmc_free_host(mmc);
 	return ret;
 }
@@ -3379,7 +3539,8 @@ int dw_mci_probe(struct dw_mci *host)
 		host->num_slots = 1;
 
 	if (host->num_slots < 1 ||
-	    host->num_slots > SDMMC_GET_SLOT_NUM(mci_readl(host, HCON))) {
+	    host->num_slots > SDMMC_GET_SLOT_NUM(mci_readl(host, HCON)) ||
+	    host->num_slots > MAX_MCI_SLOTS) {
 		dev_err(host->dev,
 			"Platform data must supply correct num_slots.\n");
 		ret = -ENODEV;
@@ -3540,7 +3701,7 @@ int dw_mci_runtime_resume(struct device *dev)
 			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
 
 		/* Force setup bus to guarantee available clock output */
-		dw_mci_setup_bus(slot, true);
+		dw_mci_setup_clock(slot, true);
 	}
 
 	/* Now that slots are all setup, we can enable card detect */
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 92ece82c76f2..47d7f20be4de 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -75,7 +75,6 @@ struct dw_mci_dma_slave {
  *	transfer is in progress.
  * @stop_abort: The command currently prepared for stoping transfer.
  * @prev_blksz: The former transfer blksz record.
- * @timing: Record of current ios timing.
  * @use_dma: Which DMA channel is in use for the current transfer, zero
  *	denotes PIO mode.
  * @using_dma: Whether DMA is in use for the current transfer.
@@ -103,7 +102,10 @@ struct dw_mci_dma_slave {
  * @queue: List of slots waiting for access to the controller.
  * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
  *	rate and timeout calculations.
- * @current_speed: Configured rate of the controller.
+ * @current_speed: Current clock rate of the controller.
+ * @new_clk_speed: New clock rate of the controller which is suitable for all
+ *	slots. It is calculated in set_ios function. After applyimg it
+ *	becomes @current_speed.
  * @num_slots: Number of slots available.
  * @fifoth_val: The value of FIFOTH register.
  * @verid: Denote Version ID.
@@ -178,7 +180,6 @@ struct dw_mci {
 	struct mmc_data		*data;
 	struct mmc_command	stop_abort;
 	unsigned int		prev_blksz;
-	unsigned char		timing;
 
 	/* DMA interface members*/
 	int			use_dma;
@@ -208,6 +209,7 @@ struct dw_mci {
 
 	u32			bus_hz;
 	u32			current_speed;
+	u32			new_clk_speed;
 	u32			num_slots;
 	u32			fifoth_val;
 	u16			verid;
@@ -364,6 +366,7 @@ struct dw_mci_board {
 /* Clock Enable register defines */
 #define SDMMC_CLKEN_LOW_PWR		BIT(16)
 #define SDMMC_CLKEN_ENABLE		BIT(0)
+#define SDMMC_CLKEN_CLK_ALL		0xFFFF
 /* time-out register defines */
 #define SDMMC_TMOUT_DATA(n)		_SBF(8, (n))
 #define SDMMC_TMOUT_DATA_MSK		0xFFFFFF00
@@ -411,6 +414,7 @@ struct dw_mci_board {
 #define SDMMC_CMD_RESP_LONG		BIT(7)
 #define SDMMC_CMD_RESP_EXP		BIT(6)
 #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
+#define SDMMC_CMD_CARD_NUM_OFFSET	16
 /* Status register defines */
 #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
 #define SDMMC_STATUS_DMA_REQ		BIT(31)
@@ -519,6 +523,7 @@ extern int dw_mci_runtime_resume(struct device *device);
  * @mmc: The mmc_host representing this slot.
  * @host: The MMC controller this slot is using.
  * @ctype: Card type for this slot.
+ * @timing: Record of current ios timing for this slot.
  * @mrq: mmc_request currently being processed or waiting to be
  *	processed, or NULL when the slot is idle.
  * @queue_node: List node for placing this node in the @queue list of
@@ -535,12 +540,12 @@ struct dw_mci_slot {
 	struct dw_mci		*host;
 
 	u32			ctype;
+	unsigned char		timing;
 
 	struct mmc_request	*mrq;
 	struct list_head	queue_node;
 
 	unsigned int		clock;
-	unsigned int		__clk_old;
 
 	unsigned long		flags;
 #define DW_MMC_CARD_PRESENT	0
@@ -548,6 +553,7 @@ struct dw_mci_slot {
 #define DW_MMC_CARD_NO_LOW_PWR	2
 #define DW_MMC_CARD_NO_USE_HOLD 3
 #define DW_MMC_CARD_NEEDS_POLL	4
+#define DW_MMC_CARD_IS_ON	5
 	int			id;
 	int			sdio_id;
 };
-- 
2.14.3
