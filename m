From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
Date: Wed, 25 Jun 2014 22:08:54 +0900
Message-ID: <001501cf9076$9de45000$d9acf000$%jun@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
 <1403520321-2431-4-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1403520321-2431-4-git-send-email-yuvaraj.cd@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Yuvaraj Kumar C D' <yuvaraj.cd@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: sonnyrao@chromium.org, t.figa@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, ks.giri@samsung.com, prashanth.g@samsung.com, alim.akhtar@samsung.com, 'Doug Anderson' <dianders@chromium.org>, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, June 23, 2014, Yuvaraj Kumar C D wrote:
> Subject: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
> 
> From: Doug Anderson <dianders@chromium.org>
> 
> For UHS cards we need the ability to switch voltages from 3.3V to
> 1.8V.  Add support to the dw_mmc driver to handle this.  Note that
> dw_mmc needs a little bit of extra code since the interface needs a
> special bit programmed to the CMD register while CMD11 is progressing.
> This means adding a few extra states to the state machine to track.

Overall new additional states makes it complicated.
Can we do that in other way?

> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> 
> ---
>  drivers/mmc/host/dw_mmc.c  |  145 +++++++++++++++++++++++++++++++++++++++++---
>  drivers/mmc/host/dw_mmc.h  |    5 +-
>  include/linux/mmc/dw_mmc.h |    2 +
>  3 files changed, 142 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index e034bce..38eb548 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -29,6 +29,7 @@
>  #include <linux/irq.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
>  #include <linux/mmc/sdio.h>
>  #include <linux/mmc/dw_mmc.h>
>  #include <linux/bitops.h>
> @@ -235,10 +236,13 @@ err:
>  }
>  #endif /* defined(CONFIG_DEBUG_FS) */
> 
> +static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
> +
>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>  	struct mmc_data	*data;
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
>  	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>  	u32 cmdr;
>  	cmd->error = -EINPROGRESS;
> @@ -254,6 +258,32 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  	else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
>  		cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
> 
> +	if (cmd->opcode == SD_SWITCH_VOLTAGE) {
> +		u32 clk_en_a;
> +
> +		/* Special bit makes CMD11 not die */
> +		cmdr |= SDMMC_CMD_VOLT_SWITCH;
> +
> +		/* Change state to continue to handle CMD11 weirdness */
> +		WARN_ON(slot->host->state != STATE_SENDING_CMD);
> +		slot->host->state = STATE_SENDING_CMD11;
> +
> +		/*
> +		 * We need to disable clock stop while doing voltage switch
> +		 * according to 7.4.1.2 Voltage Switch Normal Scenario.
> +		 *
> +		 * It's assumed that by the next time the CLKENA is updated
> +		 * (when we set the clock next) that the voltage change will
> +		 * be over, so we don't bother setting any bits to synchronize
> +		 * with dw_mci_setup_bus().
> +		 */
> +		clk_en_a = mci_readl(host, CLKENA);
> +		clk_en_a &= ~(SDMMC_CLKEN_LOW_PWR << slot->id);
> +		mci_writel(host, CLKENA, clk_en_a);
> +		mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
> +			     SDMMC_CMD_PRV_DAT_WAIT, 0);
dw_mci_disable_low_power() can be used here.

> +	}
> +
>  	if (cmd->flags & MMC_RSP_PRESENT) {
>  		/* We expect a response, so set this bit */
>  		cmdr |= SDMMC_CMD_RESP_EXP;
> @@ -776,11 +806,15 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  	unsigned int clock = slot->clock;
>  	u32 div;
>  	u32 clk_en_a;
> +	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
> +
> +	/* We must continue to set bit 28 in CMD until the change is complete */
> +	if (host->state == STATE_WAITING_CMD11_DONE)
> +		sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
I didn't get the reason SDMMC_CMD_VOLT_SWITCH is needed during clock update(enable/disable)
Can you explain it in details?

> 
>  	if (!clock) {
>  		mci_writel(host, CLKENA, 0);
> -		mci_send_cmd(slot,
> -			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
> +		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
>  	} else if (clock != host->current_speed || force_clkinit) {
>  		div = host->bus_hz / clock;
>  		if (host->bus_hz % clock && host->bus_hz > clock)
> @@ -804,15 +838,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  		mci_writel(host, CLKSRC, 0);
> 
>  		/* inform CIU */
> -		mci_send_cmd(slot,
> -			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
> +		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> 
>  		/* set clock to desired speed */
>  		mci_writel(host, CLKDIV, div);
> 
>  		/* inform CIU */
> -		mci_send_cmd(slot,
> -			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
> +		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> 
>  		/* enable clock; only low power if no SDIO */
>  		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
> @@ -821,8 +853,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  		mci_writel(host, CLKENA, clk_en_a);
> 
>  		/* inform CIU */
> -		mci_send_cmd(slot,
> -			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
> +		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
> 
>  		/* keep the clock with reflecting clock dividor */
>  		slot->__clk_old = clock << div;
> @@ -898,6 +929,17 @@ static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
> 
>  	slot->mrq = mrq;
> 
> +	if (host->state == STATE_WAITING_CMD11_DONE) {
> +		dev_warn(&slot->mmc->class_dev,
> +			 "Voltage change didn't complete\n");
> +		/*
> +		 * this case isn't expected to happen, so we can
> +		 * either crash here or just try to continue on
> +		 * in the closest possible state
> +		 */
> +		host->state = STATE_IDLE;
> +	}
> +
>  	if (host->state == STATE_IDLE) {
>  		host->state = STATE_SENDING_CMD;
>  		dw_mci_start_request(host, slot);
> @@ -993,6 +1035,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	/* Slot specific timing and width adjustment */
>  	dw_mci_setup_bus(slot, false);
> 
> +	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
> +		slot->host->state = STATE_IDLE;
> +
>  	switch (ios->power_mode) {
>  	case MMC_POWER_UP:
>  		if ((!IS_ERR(mmc->supply.vmmc)) &&
> @@ -1039,6 +1084,68 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	}
>  }
> 
> +static int dw_mci_card_busy(struct mmc_host *mmc)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	u32 status;
> +
> +	/*
> +	 * Check the busy bit which is low when DAT[3:0]
> +	 * (the data lines) are 0000
> +	 */
> +	status = mci_readl(slot->host, STATUS);
> +
> +	return !!(status & SDMMC_STATUS_BUSY);
> +}
> +
> +static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +	u32 uhs;
> +	u32 v18 = SDMMC_UHS_18V << slot->id;
> +	int min_uv, max_uv;
> +	int ret;
> +
> +	/*
> +	 * Program the voltage.  Note that some instances of dw_mmc may use
> +	 * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
> +	 * does no harm but you need to set the regulator directly.  Try both.
> +	 */
> +	uhs = mci_readl(host, UHS_REG);
> +	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> +		min_uv = 2700000;
> +		max_uv = 3600000;
> +		uhs &= ~v18;
> +	} else {
> +		min_uv = 1700000;
> +		max_uv = 1950000;
> +		uhs |= v18;
> +	}
> +	if (!IS_ERR(mmc->supply.vqmmc)) {
> +		ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
> +
> +		/*
> +		 * Only complain if regulator claims that it's not in the 1.8V
> +		 * range.  This avoids a bunch of errors in the case that
> +		 * we've got a fixed 1.8V regulator but the core SD code still
> +		 * thinks it ought to try to switch to 3.3 and then back to 1.8
> +		 */
> +		if (ret) {
I think if ret is error, printing message and returning error is good.
Currently, just returning '0' though it fails.

> +			int cur_voltage = 0;
> +
> +			cur_voltage = regulator_get_voltage(mmc->supply.vqmmc);
> +			if (cur_voltage < 1700000 || cur_voltage > 1950000)
> +				dev_warn(&mmc->class_dev,
> +					 "Regulator set error %d: %d - %d\n",
> +					 ret, min_uv, max_uv);
> +		}
> +	}
> +	mci_writel(host, UHS_REG, uhs);
> +
> +	return 0;
> +}
> +
>  static int dw_mci_get_ro(struct mmc_host *mmc)
>  {
>  	int read_only;
> @@ -1180,6 +1287,9 @@ static const struct mmc_host_ops dw_mci_ops = {
>  	.get_cd			= dw_mci_get_cd,
>  	.enable_sdio_irq	= dw_mci_enable_sdio_irq,
>  	.execute_tuning		= dw_mci_execute_tuning,
> +	.card_busy		= dw_mci_card_busy,
> +	.start_signal_voltage_switch = dw_mci_switch_voltage,
> +
>  };
> 
>  static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
> @@ -1203,7 +1313,11 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>  		dw_mci_start_request(host, slot);
>  	} else {
>  		dev_vdbg(host->dev, "list empty\n");
> -		host->state = STATE_IDLE;
> +
> +		if (host->state == STATE_SENDING_CMD11)
> +			host->state = STATE_WAITING_CMD11_DONE;
> +		else
> +			host->state = STATE_IDLE;
>  	}
> 
>  	spin_unlock(&host->lock);
> @@ -1314,8 +1428,10 @@ static void dw_mci_tasklet_func(unsigned long priv)
> 
>  		switch (state) {
>  		case STATE_IDLE:
> +		case STATE_WAITING_CMD11_DONE:
>  			break;
> 
> +		case STATE_SENDING_CMD11:
>  		case STATE_SENDING_CMD:
>  			if (!test_and_clear_bit(EVENT_CMD_COMPLETE,
>  						&host->pending_events))
> @@ -1870,6 +1986,15 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  	}
> 
>  	if (pending) {
> +		/* Check volt switch first, since it can look like an error */
> +		if ((host->state == STATE_SENDING_CMD11) &&
> +		    (pending & SDMMC_INT_VOLT_SWITCH)) {
> +			mci_writel(host, RINTSTS, SDMMC_INT_VOLT_SWITCH);
> +			pending &= ~SDMMC_INT_VOLT_SWITCH;
> +			dw_mci_cmd_interrupt(host,
> +					     pending | SDMMC_INT_CMD_DONE);
Artificially adding SDMMC_INT_CMD_DONE to pending is needed to complete cmd handling?
Is there any reason?

Thanks,
Seungwon Jeon

> +		}
> +
>  		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
>  			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
>  			host->cmd_status = pending;
> @@ -1975,7 +2100,9 @@ static void dw_mci_work_routine_card(struct work_struct *work)
> 
>  					switch (host->state) {
>  					case STATE_IDLE:
> +					case STATE_WAITING_CMD11_DONE:
>  						break;
> +					case STATE_SENDING_CMD11:
>  					case STATE_SENDING_CMD:
>  						mrq->cmd->error = -ENOMEDIUM;
>  						if (!mrq->data)
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 5c95d00..af1d35f 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -99,6 +99,7 @@
>  #define SDMMC_INT_HLE			BIT(12)
>  #define SDMMC_INT_FRUN			BIT(11)
>  #define SDMMC_INT_HTO			BIT(10)
> +#define SDMMC_INT_VOLT_SWITCH		BIT(10) /* overloads bit 10! */
>  #define SDMMC_INT_DRTO			BIT(9)
>  #define SDMMC_INT_RTO			BIT(8)
>  #define SDMMC_INT_DCRC			BIT(7)
> @@ -113,6 +114,7 @@
>  /* Command register defines */
>  #define SDMMC_CMD_START			BIT(31)
>  #define SDMMC_CMD_USE_HOLD_REG	BIT(29)
> +#define SDMMC_CMD_VOLT_SWITCH		BIT(28)
>  #define SDMMC_CMD_CCS_EXP		BIT(23)
>  #define SDMMC_CMD_CEATA_RD		BIT(22)
>  #define SDMMC_CMD_UPD_CLK		BIT(21)
> @@ -129,6 +131,7 @@
>  #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
>  /* Status register defines */
>  #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
> +#define SDMMC_STATUS_BUSY		BIT(9)
>  /* FIFOTH register defines */
>  #define SDMMC_SET_FIFOTH(m, r, t)	(((m) & 0x7) << 28 | \
>  					 ((r) & 0xFFF) << 16 | \
> @@ -149,7 +152,7 @@
>  #define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
>  /* Card read threshold */
>  #define SDMMC_SET_RD_THLD(v, x)		(((v) & 0x1FFF) << 16 | (x))
> -
> +#define SDMMC_UHS_18V			BIT(0)
>  /* Register access macros */
>  #define mci_readl(dev, reg)			\
>  	__raw_readl((dev)->regs + SDMMC_##reg)
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index babaea9..9e31564 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -26,6 +26,8 @@ enum dw_mci_state {
>  	STATE_DATA_BUSY,
>  	STATE_SENDING_STOP,
>  	STATE_DATA_ERROR,
> +	STATE_SENDING_CMD11,
> +	STATE_WAITING_CMD11_DONE,
>  };
> 
>  enum {
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
