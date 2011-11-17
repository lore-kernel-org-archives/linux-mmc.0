From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH RESEND V4] mmc: core: HS200 mode support for eMMC 4.5
Date: Thu, 17 Nov 2011 11:06:07 +0530
Message-ID: <000701cca4ea$d0c5d3b0$72517b10$@org>
References: <1319605188-2909-1-git-send-email-girish.shivananjappa@linaro.org> <4EB8EACC.8030205@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4EB8EACC.8030205@codeaurora.org>
Content-language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sahitya Tummala' <stummala@codeaurora.org>, 'Girish K S' <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Sahitya Tummala
> Sent: Tuesday, November 08, 2011 2:10 PM
> To: Girish K S
> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; patches@linaro.org;
> linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH RESEND V4] mmc: core: HS200 mode support for eMMC
> 4.5
> 
> Hi Girish,
> 
> On 10/26/2011 10:29 AM, Girish K S wrote:
> > This patch adds the support of the HS200 bus speed for eMMC 4.5
> devices.
> > The eMMC 4.5 devices have support for 200MHz bus speed.The mmc core
> and
> > host modules have been touched to add support for this module.
> >
> > It is necessary to know the card type in the sdhci.c file to add
> support
> > for eMMC tuning function. So card.h file is included to import the
> card
> > data structure.
> >
> > cc: Chris Ball<cjb@laptop.org>
> > Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
> > ---
> > Changes in v4:
> > 	Rebased onto chris-mmc/mmc-next branch. This patch is
> successfully
> > 	applied on commit with id
> de022ed3fdc14808299b2fa66dbb1ed5ab921912.
> > Changes in v3:
> > 	In the previous commits of chris-mmc/mmc-next branch, the patch
> with
> > 	commit id (c0f22a2c92e357e7cb3988b0b13034d70b7461f9) defines
> caps2 for
> > 	more capabilities. This patch version deletes the member
> ext_caps(created
> > 	in my earlier patch) from struct mmc_host and reuses already
> accepted
> > 	caps2 member.
> > Changes in v2:
> > 	Rebased to latest chris-mmc/mmc-next branch. Resolved indentation
> > 	problems identified in review. This patch has to be applied
> before
> > 	the patch released for modifying the printk messages.
> > Changes in v1:
> > 	Case statements in switch that produce same result have
> > 	been combined to reduce repeated assignments.
> > 	patch recreated after rebase to chris balls mmc-next branch.
> >
> >   drivers/mmc/core/bus.c    |    3 +-
> >   drivers/mmc/core/mmc.c    |   92
> ++++++++++++++++++++++++++++++++++++++++----
> >   drivers/mmc/host/sdhci.c  |   36 +++++++++++++++---
> >   include/linux/mmc/card.h  |    3 +
> >   include/linux/mmc/host.h  |    6 +++
> >   include/linux/mmc/mmc.h   |    8 +++-
> >   include/linux/mmc/sdhci.h |    1 +
> >   7 files changed, 132 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> > index 46b6e84..2f82f6b 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -301,10 +301,11 @@ int mmc_add_card(struct mmc_card *card)
> >   			mmc_card_ddr_mode(card) ? "DDR " : "",
> >   			type);
> >   	} else {
> > -		printk(KERN_INFO "%s: new %s%s%s card at address %04x\n",
> > +		pr_info("%s: new %s%s%s%s card at address %04x\n",
> >   			mmc_hostname(card->host),
> >   			mmc_sd_card_uhs(card) ? "ultra high speed " :
> >   			(mmc_card_highspeed(card) ? "high speed " : ""),
> > +			(mmc_card_hs200(card) ? "HS200 " : ""),
> >   			mmc_card_ddr_mode(card) ? "DDR " : "",
> >   			type, card->rca);
> >   	}
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 3627044..4db248c 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -285,6 +285,39 @@ static int mmc_read_ext_csd(struct mmc_card
> *card, u8 *ext_csd)
> >   	}
> >   	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
> >   	switch (ext_csd[EXT_CSD_CARD_TYPE]&  EXT_CSD_CARD_TYPE_MASK) {
> > +	case EXT_CSD_CARD_TYPE_SDR_200 |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1_8V |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1_2V |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_52 |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +		card->ext_csd.hs_max_dtr = 200000000;
> > +		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_200;
> > +		break;
> > +	case EXT_CSD_CARD_TYPE_SDR_1_2V |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_1_8V |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_1_2V |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_52 |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +		card->ext_csd.hs_max_dtr = 200000000;
> > +		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_2V;
> > +		break;
> > +	case EXT_CSD_CARD_TYPE_SDR_1_8V |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_1_8V |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_1_2V |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_52 |
> > +	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> > +		card->ext_csd.hs_max_dtr = 200000000;
> > +		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_8V;
> > +		break;
> >   	case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
> >   	     EXT_CSD_CARD_TYPE_26:
> >   		card->ext_csd.hs_max_dtr = 52000000;
> > @@ -699,6 +732,7 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
> >   {
> >   	struct mmc_card *card;
> >   	int err, ddr = 0;
> > +	int hs_sdr = 0;
> >   	u32 cid[4];
> >   	unsigned int max_dtr;
> >   	u32 rocr;
> > @@ -890,11 +924,15 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
> >   	/*
> >   	 * Activate high speed (if supported)
> >   	 */
> > -	if ((card->ext_csd.hs_max_dtr != 0)&&
> > -		(host->caps&  MMC_CAP_MMC_HIGHSPEED)) {
> > -		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > -				 EXT_CSD_HS_TIMING, 1,
> > -				 card->ext_csd.generic_cmd6_time);
> > +	if (card->ext_csd.hs_max_dtr != 0) {
> > +		if ((card->ext_csd.hs_max_dtr>  52000000)&&
> > +		    (host->caps2&  MMC_CAP2_HIGHSPEED_200))
> > +			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +					 EXT_CSD_HS_TIMING, 2, 0);
> > +		else if	(host->caps&  MMC_CAP_MMC_HIGHSPEED)
> > +			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +					 EXT_CSD_HS_TIMING, 1, 0);
> > +
> >   		if (err&&  err != -EBADMSG)
> >   			goto free_card;
> >
> > @@ -903,7 +941,10 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
> >   			       mmc_hostname(card->host));
> >   			err = 0;
> >   		} else {
> > -			mmc_card_set_highspeed(card);
> > +			if (card->ext_csd.hs_max_dtr>  52000000)
> > +				mmc_card_set_hs200(card);
> > +			else
> > +				mmc_card_set_highspeed(card);
> >   			mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> >   		}
> >   	}
> > @@ -929,7 +970,7 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
> >   	 */
> >   	max_dtr = (unsigned int)-1;
> >
> > -	if (mmc_card_highspeed(card)) {
> > +	if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
> >   		if (max_dtr>  card->ext_csd.hs_max_dtr)
> >   			max_dtr = card->ext_csd.hs_max_dtr;
> >   	} else if (max_dtr>  card->csd.max_dtr) {
> > @@ -955,6 +996,22 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
> >   	}
> >
> >   	/*
> > +	 * Indicate HS200 SDR mode (if supported).
> > +	 */
> > +	if (mmc_card_hs200(card)) {
> > +		if ((card->ext_csd.card_type&  EXT_CSD_CARD_TYPE_SDR_1_8V)
> > +			&&  ((host->caps2&  (MMC_CAP2_HS200_1_8V_SDR |
> > +			     MMC_CAP2_HS200))
> > +				== (MMC_CAP2_HS200_1_8V_SDR |
MMC_CAP2_HS200)))
> > +				hs_sdr = MMC_1_8V_SDR_MODE;
> > +		else if ((card->ext_csd.card_type&
> EXT_CSD_CARD_TYPE_SDR_1_2V)
> > +			&&  ((host->caps2&  (MMC_CAP2_HS200_1_2V_SDR |
> > +			      MMC_CAP2_HS200))
> > +				== (MMC_CAP2_HS200_1_2V_SDR |
MMC_CAP2_HS200)))
> > +				hs_sdr = MMC_1_2V_SDR_MODE;
> > +	}
> > +
> > +	/*
> >   	 * Activate wide bus and DDR (if supported).
> >   	 */
> >   	if ((card->csd.mmca_vsn>= CSD_SPEC_VER_4)&&
> > @@ -994,16 +1051,24 @@ static int mmc_init_card(struct mmc_host
> *host, u32 ocr,
> >   			if (!err) {
> >   				mmc_set_bus_width(card->host, bus_width);
> >
> > +				if ((host->caps2&  MMC_CAP2_HS200)&&
> > +				    card->host->ops->execute_tuning)
> > +					err = card->host->ops->	\
> > +					      execute_tuning(card->host);
> > +
> >   				/*
> >   				 * If controller can't handle bus width
test,
> >   				 * compare ext_csd previously read in 1 bit
> mode
> >   				 * against ext_csd at new bus width
> >   				 */
> > -				if (!(host->caps&  MMC_CAP_BUS_WIDTH_TEST))
> > +				if (!(host->caps&  MMC_CAP_BUS_WIDTH_TEST)&&
> > +				    !err)
> >   					err = mmc_compare_ext_csds(card,
> >   						bus_width);
> > -				else
> > +				else if (!err)
> >   					err = mmc_bus_test(card, bus_width);
> > +				else
> > +					pr_warning("tuning execution
failed\n");
> >   				if (!err)
> >   					break;
> >   			}
> > @@ -1052,6 +1117,15 @@ static int mmc_init_card(struct mmc_host
> *host, u32 ocr,
> >   			mmc_card_set_ddr_mode(card);
> >   			mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
> >   			mmc_set_bus_width(card->host, bus_width);
> > +		} else if (hs_sdr) {
> > +			if (hs_sdr == EXT_CSD_CARD_TYPE_SDR_1_2V) {
> > +				err = mmc_set_signal_voltage(host,
> > +					MMC_SIGNAL_VOLTAGE_120, 0);
> > +				if (err)
> > +					goto err;
> > +			}
> > +			mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> Can you define a new timing mode for HS200 instead of using the same
> high speed
> timing mode MMC_TIMING_MMC_HS?  The host driver might need to configure
> it's controller with a different timing mode for HS200 cards.
> > +			mmc_set_bus_width(card->host, bus_width);
> >   		}
> >   	}
Any comment on using the new timing mode for HS200?

Regards,
Subhash

> Thanks,
> Sahitya.
> 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
