From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH V5] mmc: core: HS200 mode support for eMMC 4.5
Date: Thu, 1 Dec 2011 15:33:05 +0530
Message-ID: <000301ccb010$6da0c5c0$48e25140$@org>
References: <1322643228-10320-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1322643228-10320-1-git-send-email-girish.shivananjappa@linaro.org>
Content-Language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Girish K S
> Sent: Wednesday, November 30, 2011 2:24 PM
> To: linux-mmc@vger.kernel.org
> Cc: patches@linaro.org; linux-samsung-soc@vger.kernel.org;
> subhashj@codeaurora.org; Girish K S; Chris Ball
> Subject: [PATCH V5] mmc: core: HS200 mode support for eMMC 4.5
> 
> This patch adds the support of the HS200 bus speed for eMMC 4.5
> devices.
> The eMMC 4.5 devices have support for 200MHz bus speed.The mmc core and
> host modules have been touched to add support for this module.
> 
> It is necessary to know the card type in the sdhci.c file to add
> support
> for eMMC tuning function. So card.h file is included to import the card
> data structure.
> 
> cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> Changes in v5:
> 	Reduced the case statements for better code readability. Removed
> 	unused macro definitions. Modified the tuning function prototype
> 	and definition to support tuning for both SD and eMMC cards.
> Changes in v4:
> 	Rebased onto chris-mmc/mmc-next branch. This patch is
> successfully
> 	applied on commit with id
> de022ed3fdc14808299b2fa66dbb1ed5ab921912.
> Changes in v3:
> 	In the previous commits of chris-mmc/mmc-next branch, the patch
> with
> 	commit id (c0f22a2c92e357e7cb3988b0b13034d70b7461f9) defines
> caps2 for
> 	more capabilities. This patch version deletes the member
> ext_caps(created
> 	in my earlier patch) from struct mmc_host and reuses already
> accepted
> 	caps2 member.
> Changes in v2:
> 	Rebased to latest chris-mmc/mmc-next branch. Resolved indentation
> 	problems identified in review. This patch has to be applied
> before
> 	the patch released for modifying the printk messages.
> Changes in v1:
> 	Case statements in switch that produce same result have
> 	been combined to reduce repeated assignments.
> 	patch recreated after rebase to chris balls mmc-next branch.
> 
>  drivers/mmc/core/bus.c    |    3 +-
>  drivers/mmc/core/mmc.c    |   77
> ++++++++++++++++++++++++++++++++++++++++----
>  drivers/mmc/core/sd.c     |    3 +-
>  drivers/mmc/core/sdio.c   |    4 ++-
>  drivers/mmc/host/sdhci.c  |   38 +++++++++++++++++-----
>  include/linux/mmc/card.h  |    3 ++
>  include/linux/mmc/host.h  |   11 ++++++-
>  include/linux/mmc/mmc.h   |   66
> ++++++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/sdhci.h |    1 +
>  9 files changed, 185 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 5639fdf..83c9f8d 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -301,10 +301,11 @@ int mmc_add_card(struct mmc_card *card)
>  			mmc_card_ddr_mode(card) ? "DDR " : "",
>  			type);
>  	} else {
> -		printk(KERN_INFO "%s: new %s%s%s card at address %04x\n",
> +		pr_info("%s: new %s%s%s%s card at address %04x\n",
>  			mmc_hostname(card->host),
>  			mmc_card_uhs(card) ? "ultra high speed " :
>  			(mmc_card_highspeed(card) ? "high speed " : ""),
> +			(mmc_card_hs200(card) ? "HS200 " : ""),
>  			mmc_card_ddr_mode(card) ? "DDR " : "",
>  			type, card->rca);
>  	}
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a1223bd..f4124d6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -285,6 +285,27 @@ static int mmc_read_ext_csd(struct mmc_card *card,
> u8 *ext_csd)
>  	}
>  	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
>  	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
> +	case EXT_CSD_CARD_TYPE_SDR_ALL:
> +	case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V:
> +	case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V:
> +	case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52:
> +		card->ext_csd.hs_max_dtr = 200000000;
> +		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_200;
> +		break;
> +	case EXT_CSD_CARD_TYPE_SDR_1_2V_ALL:
> +	case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V:
> +	case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V:
> +	case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52:
> +		card->ext_csd.hs_max_dtr = 200000000;
> +		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_2V;
> +		break;
> +	case EXT_CSD_CARD_TYPE_SDR_1_8V_ALL:
> +	case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V:
> +	case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V:
> +	case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52:
> +		card->ext_csd.hs_max_dtr = 200000000;
> +		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_8V;
> +		break;
>  	case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
>  	     EXT_CSD_CARD_TYPE_26:
>  		card->ext_csd.hs_max_dtr = 52000000;
> @@ -699,6 +720,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
>  {
>  	struct mmc_card *card;
>  	int err, ddr = 0;
> +	int hs_sdr = 0;
>  	u32 cid[4];
>  	unsigned int max_dtr;
>  	u32 rocr;
> @@ -894,11 +916,16 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  	/*
>  	 * Activate high speed (if supported)
>  	 */
> -	if ((card->ext_csd.hs_max_dtr != 0) &&
> -		(host->caps & MMC_CAP_MMC_HIGHSPEED)) {
> -		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -				 EXT_CSD_HS_TIMING, 1,
> -				 card->ext_csd.generic_cmd6_time);
> +	if (card->ext_csd.hs_max_dtr != 0) {
> +		err = 0;
> +		if ((card->ext_csd.hs_max_dtr > 52000000) &&
> +		    (host->caps2 & MMC_CAP2_HS200))
> +			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +					 EXT_CSD_HS_TIMING, 2, 0);
> +		else if	(host->caps & MMC_CAP_MMC_HIGHSPEED)
> +			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +					 EXT_CSD_HS_TIMING, 1, 0);
> +
>  		if (err && err != -EBADMSG)
>  			goto free_card;
> 
> @@ -907,7 +934,11 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  			       mmc_hostname(card->host));
>  			err = 0;
>  		} else {
> -			mmc_card_set_highspeed(card);
> +			if ((card->ext_csd.hs_max_dtr > 52000000) &&
> +			    (host->caps2 & MMC_CAP2_HS200))
> +				mmc_card_set_hs200(card);
> +			else
> +				mmc_card_set_highspeed(card);
>  			mmc_set_timing(card->host, MMC_TIMING_MMC_HS);

MMC_TIMING_MMC_HS200 is defined but still not used.

So I guess it should be like this ::
 +			if ((card->ext_csd.hs_max_dtr > 52000000) &&
 +			    (host->caps2 & MMC_CAP2_HS200)) {
 +				mmc_card_set_hs200(card);
 +     			mmc_set_timing(card->host, MMC_TIMING_MMC_HS200)
 +			} else {
 +				mmc_card_set_highspeed(card);
 +				mmc_set_timing(card->host,
MMC_TIMING_MMC_HS)
 + 			}














>  		}
>  	}
> @@ -933,7 +964,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
>  	 */
>  	max_dtr = (unsigned int)-1;
> 
> -	if (mmc_card_highspeed(card)) {
> +	if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
>  		if (max_dtr > card->ext_csd.hs_max_dtr)
>  			max_dtr = card->ext_csd.hs_max_dtr;
>  	} else if (max_dtr > card->csd.max_dtr) {
> @@ -959,6 +990,18 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  	}
> 
>  	/*
> +	 * Indicate HS200 SDR mode (if supported).
> +	 */
> +	if (mmc_card_hs200(card)) {
> +		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V)
> +			&& (host->caps2 & MMC_CAP2_HS200_1_8V_SDR))
> +				hs_sdr = MMC_1_8V_SDR_MODE;
> +		else if ((card->ext_csd.card_type &
> EXT_CSD_CARD_TYPE_SDR_1_2V)
> +			&& (host->caps2 & MMC_CAP2_HS200_1_2V_SDR))
> +				hs_sdr = MMC_1_2V_SDR_MODE;
> +	}
> +
> +	/*
>  	 * Activate wide bus and DDR (if supported).
>  	 */
>  	if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
> @@ -998,6 +1041,17 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  			if (!err) {
>  				mmc_set_bus_width(card->host, bus_width);
> 
> +				if ((host->caps2 & MMC_CAP2_HS200) &&
> +				    card->host->ops->execute_tuning)
> +					err = card->host->ops->	\
> +					      execute_tuning(card->host,
> +
MMC_SEND_TUNING_BLOCK_HS200);


execute_tuning should be done right after the timing is changed to HS200 and
clock rate is changed to 200Mhz. This is not the correct sequence to call
the execute_tuning().

> +
> +				if (err) {
> +					pr_warning("tuning execution
failed\n");
> +					continue;
> +				}
> +
>  				/*
>  				 * If controller can't handle bus width
test,
>  				 * compare ext_csd previously read in 1 bit
> mode
> @@ -1056,6 +1110,15 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  			mmc_card_set_ddr_mode(card);
>  			mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
>  			mmc_set_bus_width(card->host, bus_width);
> +		} else if (hs_sdr) {
> +			if (hs_sdr == EXT_CSD_CARD_TYPE_SDR_1_2V) {
> +				err = mmc_set_signal_voltage(host,
> +					MMC_SIGNAL_VOLTAGE_120, 0);
> +				if (err)
> +					goto err;
> +			}
> +			mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> +			mmc_set_bus_width(card->host, bus_width);
>  		}
>  	}
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1d5a3bd..c1d3ee3 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -660,7 +660,8 @@ static int mmc_sd_init_uhs_card(struct mmc_card
> *card)
> 
>  	/* SPI mode doesn't define CMD19 */
>  	if (!mmc_host_is_spi(card->host) && card->host->ops-
> >execute_tuning)
> -		err = card->host->ops->execute_tuning(card->host);
> +		err = card->host->ops->execute_tuning(card->host,	\
> +
MMC_SEND_TUNING_BLOCK);
> 
>  out:
>  	kfree(status);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 8c04f7f..8ef8817 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -14,6 +14,7 @@
> 
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/mmc.h>
>  #include <linux/mmc/sdio.h>
>  #include <linux/mmc/sdio_func.h>
>  #include <linux/mmc/sdio_ids.h>
> @@ -556,7 +557,8 @@ static int mmc_sdio_init_uhs_card(struct mmc_card
> *card)
> 
>  	/* Initialize and start re-tuning timer */
>  	if (!mmc_host_is_spi(card->host) && card->host->ops-
> >execute_tuning)
> -		err = card->host->ops->execute_tuning(card->host);
> +		err = card->host->ops->execute_tuning(card->host,
> +
MMC_SEND_TUNING_BLOCK);
> 
>  out:
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a7c2311..13d74bb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -49,7 +49,7 @@ static void sdhci_finish_data(struct sdhci_host *);
> 
>  static void sdhci_send_command(struct sdhci_host *, struct mmc_command
> *);
>  static void sdhci_finish_command(struct sdhci_host *);
> -static int sdhci_execute_tuning(struct mmc_host *mmc);
> +static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  static void sdhci_tuning_timer(unsigned long data);
> 
>  #ifdef CONFIG_PM_RUNTIME
> @@ -1016,7 +1016,8 @@ static void sdhci_send_command(struct sdhci_host
> *host, struct mmc_command *cmd)
>  		flags |= SDHCI_CMD_INDEX;
> 
>  	/* CMD19 is special in that the Data Present Select should be set
> */
> -	if (cmd->data || (cmd->opcode == MMC_SEND_TUNING_BLOCK))
> +	if (cmd->data || (cmd->opcode == MMC_SEND_TUNING_BLOCK) ||
> +	    (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))
>  		flags |= SDHCI_CMD_DATA;
> 
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),
> SDHCI_COMMAND);
> @@ -1287,7 +1288,7 @@ static void sdhci_request(struct mmc_host *mmc,
> struct mmc_request *mrq)
>  		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
>  		    !(present_state & (SDHCI_DOING_WRITE |
> SDHCI_DOING_READ))) {
>  			spin_unlock_irqrestore(&host->lock, flags);
> -			sdhci_execute_tuning(mmc);
> +			sdhci_execute_tuning(mmc, mrq->cmd->opcode);
>  			spin_lock_irqsave(&host->lock, flags);
> 
>  			/* Restore original mmc_request structure */
> @@ -1673,7 +1674,7 @@ static int
> sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  	return err;
>  }
> 
> -static int sdhci_execute_tuning(struct mmc_host *mmc)
> +static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct sdhci_host *host;
>  	u16 ctrl;
> @@ -1694,10 +1695,13 @@ static int sdhci_execute_tuning(struct mmc_host
> *mmc)
>  	 * Host Controller needs tuning only in case of SDR104 mode
>  	 * and for SDR50 mode when Use Tuning for SDR50 is set in
>  	 * Capabilities register.
> +	 * If the Host Controller supports the HS200 mode then tuning
> +	 * function has to be executed.
>  	 */
>  	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
>  	    (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50) &&
> -	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)))
> +	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)) ||
> +	    (host->flags & SDHCI_HS200_NEEDS_TUNING))
>  		ctrl |= SDHCI_CTRL_EXEC_TUNING;
>  	else {
>  		spin_unlock(&host->lock);
> @@ -1733,7 +1737,7 @@ static int sdhci_execute_tuning(struct mmc_host
> *mmc)
>  		if (!tuning_loop_counter && !timeout)
>  			break;
> 
> -		cmd.opcode = MMC_SEND_TUNING_BLOCK;
> +		cmd.opcode = opcode;
>  		cmd.arg = 0;
>  		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>  		cmd.retries = 0;
> @@ -1748,7 +1752,17 @@ static int sdhci_execute_tuning(struct mmc_host
> *mmc)
>  		 * block to the Host Controller. So we set the block size
>  		 * to 64 here.
>  		 */
> -		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> SDHCI_BLOCK_SIZE);
> +		if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200) {
> +			if (mmc->ios.bus_width == MMC_BUS_WIDTH_8)
> +				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
> +					     SDHCI_BLOCK_SIZE);
> +			else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4)
> +				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> +					     SDHCI_BLOCK_SIZE);
> +		} else {
> +			sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> +				     SDHCI_BLOCK_SIZE);
> +		}
> 
>  		/*
>  		 * The tuning block is sent by the card to the host
> controller.
> @@ -2131,12 +2145,14 @@ static void sdhci_show_adma_error(struct
> sdhci_host *host) { }
> 
>  static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  {
> +	u32 command;
>  	BUG_ON(intmask == 0);
> 
>  	/* CMD19 generates _only_ Buffer Read Ready interrupt */
>  	if (intmask & SDHCI_INT_DATA_AVAIL) {
> -		if (SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND)) ==
> -		    MMC_SEND_TUNING_BLOCK) {
> +		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> +		if ((command == MMC_SEND_TUNING_BLOCK) ||
> +		    (command == MMC_SEND_TUNING_BLOCK_HS200)) {
>  			host->tuning_done = 1;
>  			wake_up(&host->buf_ready_int);
>  			return;
> @@ -2741,6 +2757,10 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (caps[1] & SDHCI_USE_SDR50_TUNING)
>  		host->flags |= SDHCI_SDR50_NEEDS_TUNING;
> 
> +	/* Does the host needs tuning for HS200? */
> +	if (mmc->caps2 & MMC_CAP2_HS200)
> +		host->flags |= SDHCI_HS200_NEEDS_TUNING;
> +
>  	/* Driver Type(s) (A, C, D) supported by the host */
>  	if (caps[1] & SDHCI_DRIVER_TYPE_A)
>  		mmc->caps |= MMC_CAP_DRIVER_TYPE_A;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 534974c..e76f649 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -209,6 +209,7 @@ struct mmc_card {
>  #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high
> speed mode */
>  #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra
> high speed mode */
>  #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
> +#define MMC_STATE_HIGHSPEED_200	(1<<7)	/* card is in HS200
> mode */
>  	unsigned int		quirks; 	/* card quirks */
>  #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0
> writes outside of the VS CCCR range */
>  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func-
> >cur_blksize */
> @@ -365,6 +366,7 @@ static inline void __maybe_unused
> remove_quirk(struct mmc_card *card, int data)
>  #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
>  #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
>  #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
> +#define mmc_card_hs200(c)	((c)->state & MMC_STATE_HIGHSPEED_200)
>  #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
>  #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
>  #define mmc_card_uhs(c)		((c)->state &
> MMC_STATE_ULTRAHIGHSPEED)
> @@ -374,6 +376,7 @@ static inline void __maybe_unused
> remove_quirk(struct mmc_card *card, int data)
>  #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>  #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
> +#define mmc_card_set_hs200(c)	((c)->state |=
> MMC_STATE_HIGHSPEED_200)
>  #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
>  #define mmc_card_set_ddr_mode(c) ((c)->state |=
> MMC_STATE_HIGHSPEED_DDR)
>  #define mmc_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 706f722..5eac57a 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -50,6 +50,7 @@ struct mmc_ios {
> 
>  #define MMC_TIMING_LEGACY	0
>  #define MMC_TIMING_MMC_HS	1
> +#define MMC_TIMING_MMC_HS200	2
>  #define MMC_TIMING_SD_HS	2
>  #define MMC_TIMING_UHS_SDR12	MMC_TIMING_LEGACY
>  #define MMC_TIMING_UHS_SDR25	MMC_TIMING_SD_HS
> @@ -60,6 +61,8 @@ struct mmc_ios {
>  #define MMC_SDR_MODE		0
>  #define MMC_1_2V_DDR_MODE	1
>  #define MMC_1_8V_DDR_MODE	2
> +#define MMC_1_2V_SDR_MODE	3
> +#define MMC_1_8V_SDR_MODE	4
> 
>  	unsigned char	signal_voltage;		/* signalling voltage
> (1.8V or 3.3V) */
> 
> @@ -148,7 +151,9 @@ struct mmc_host_ops {
>  	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
> 
>  	int	(*start_signal_voltage_switch)(struct mmc_host *host,
> struct mmc_ios *ios);
> -	int	(*execute_tuning)(struct mmc_host *host);
> +
> +	/* The tuning command opcode value is different for SD and eMMC
> cards */
> +	int	(*execute_tuning)(struct mmc_host *host, u32 opcode);
>  	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
>  	int	(*select_drive_strength)(unsigned int max_dtr, int
> host_drv, int card_drv);
>  	void	(*hw_reset)(struct mmc_host *host);
> @@ -242,6 +247,10 @@ struct mmc_host {
>  #define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
>  #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)	/* Notify poweroff
> supported */
>  #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads
> don't work */
> +#define MMC_CAP2_HS200_1_8V_SDR	(1 << 4)	/* can support */
> +#define MMC_CAP2_HS200_1_2V_SDR	(1 << 5)	/* can support */
> +#define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
> +				 MMC_CAP2_HS200_1_2V_SDR)
> 
>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>  	unsigned int        power_notify_type;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 0e71356..7996272 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -51,6 +51,7 @@
>  #define MMC_READ_SINGLE_BLOCK    17   /* adtc [31:0] data addr   R1
> */
>  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1
> */
>  #define MMC_SEND_TUNING_BLOCK    19   /* adtc                    R1
> */
> +#define MMC_SEND_TUNING_BLOCK_HS200	21	/* adtc R1  */
> 
>    /* class 3 */
>  #define MMC_WRITE_DAT_UNTIL_STOP 20   /* adtc [31:0] data addr   R1
> */
> @@ -333,13 +334,76 @@ struct _mmc_csd {
> 
>  #define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
>  #define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */
> -#define EXT_CSD_CARD_TYPE_MASK	0xF	/* Mask out reserved bits */
> +#define EXT_CSD_CARD_TYPE_MASK	0x3F	/* Mask out reserved bits */
>  #define EXT_CSD_CARD_TYPE_DDR_1_8V  (1<<2)   /* Card can run at 52MHz
> */
>  					     /* DDR mode @1.8V or 3V I/O */
>  #define EXT_CSD_CARD_TYPE_DDR_1_2V  (1<<3)   /* Card can run at 52MHz
> */
>  					     /* DDR mode @1.2V I/O */
>  #define EXT_CSD_CARD_TYPE_DDR_52       (EXT_CSD_CARD_TYPE_DDR_1_8V  \
>  					| EXT_CSD_CARD_TYPE_DDR_1_2V)
> +#define EXT_CSD_CARD_TYPE_SDR_1_8V	(1<<4)	/* Card can run at
> 200MHz */
> +#define EXT_CSD_CARD_TYPE_SDR_1_2V	(1<<5)	/* Card can run at
> 200MHz */
> +						/* SDR mode @1.2V I/O */
> +
> +#define EXT_CSD_CARD_TYPE_SDR_200	(EXT_CSD_CARD_TYPE_SDR_1_8V	\
> +					| EXT_CSD_CARD_TYPE_SDR_1_2V)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_ALL	(EXT_CSD_CARD_TYPE_SDR_200	\
> +					| EXT_CSD_CARD_TYPE_52		\
> +					| EXT_CSD_CARD_TYPE_26)
> +
> +#define	EXT_CSD_CARD_TYPE_SDR_1_2V_ALL
> 	(EXT_CSD_CARD_TYPE_SDR_1_2V	\
> +					| EXT_CSD_CARD_TYPE_52		\
> +					| EXT_CSD_CARD_TYPE_26)
> +
> +#define	EXT_CSD_CARD_TYPE_SDR_1_8V_ALL
> 	(EXT_CSD_CARD_TYPE_SDR_1_8V	\
> +					| EXT_CSD_CARD_TYPE_52		\
> +					| EXT_CSD_CARD_TYPE_26)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V
> 	(EXT_CSD_CARD_TYPE_SDR_1_2V  \
> +						| EXT_CSD_CARD_TYPE_DDR_1_8V
\
> +						| EXT_CSD_CARD_TYPE_52
\
> +						| EXT_CSD_CARD_TYPE_26)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V
> 	(EXT_CSD_CARD_TYPE_SDR_1_8V  \
> +						| EXT_CSD_CARD_TYPE_DDR_1_8V
\
> +						| EXT_CSD_CARD_TYPE_52
\
> +						| EXT_CSD_CARD_TYPE_26)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V
> 	(EXT_CSD_CARD_TYPE_SDR_1_2V  \
> +						| EXT_CSD_CARD_TYPE_DDR_1_2V
\
> +						| EXT_CSD_CARD_TYPE_52
\
> +						| EXT_CSD_CARD_TYPE_26)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V
> 	(EXT_CSD_CARD_TYPE_SDR_1_8V  \
> +						| EXT_CSD_CARD_TYPE_DDR_1_2V
\
> +						| EXT_CSD_CARD_TYPE_52
\
> +						| EXT_CSD_CARD_TYPE_26)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52
> 	(EXT_CSD_CARD_TYPE_SDR_1_2V  \
> +						| EXT_CSD_CARD_TYPE_DDR_52
\
> +						| EXT_CSD_CARD_TYPE_52
\
> +						| EXT_CSD_CARD_TYPE_26)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52
> 	(EXT_CSD_CARD_TYPE_SDR_1_8V  \
> +						| EXT_CSD_CARD_TYPE_DDR_52
\
> +						| EXT_CSD_CARD_TYPE_52
\
> +						| EXT_CSD_CARD_TYPE_26)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V
> 	(EXT_CSD_CARD_TYPE_SDR_200   \
> +						| EXT_CSD_CARD_TYPE_DDR_1_8V
\
> +						| EXT_CSD_CARD_TYPE_52
\
> +						| EXT_CSD_CARD_TYPE_26)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V
> 	(EXT_CSD_CARD_TYPE_SDR_200   \
> +						| EXT_CSD_CARD_TYPE_DDR_1_2V
\
> +						| EXT_CSD_CARD_TYPE_52
\
> +						| EXT_CSD_CARD_TYPE_26)
> +
> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52	(EXT_CSD_CARD_TYPE_SDR_200
> \
> +						| EXT_CSD_CARD_TYPE_DDR_52
\
> +						| EXT_CSD_CARD_TYPE_52
\
> +						| EXT_CSD_CARD_TYPE_26)
> 
>  #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
>  #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index e4b6935..d9a2222 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -121,6 +121,7 @@ struct sdhci_host {
>  #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
>  #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
>  #define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
> +#define SDHCI_HS200_NEEDS_TUNING (1<<10)	/* HS200 needs tuning */
> 
>  	unsigned int version;	/* SDHCI spec. version */
> 
> --
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
