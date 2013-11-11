From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 3/3] mmc: add support for hs400 mode of eMMC5.0
Date: Mon, 11 Nov 2013 21:51:16 +0900
Message-ID: <002201cededc$b5f58160$21e08420$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <003601ceda2a$dd0e8140$972b83c0$%jun@samsung.com>
 <0C8FBB70FF40A94D98BE847F9C171A9803AD4CDD@SCYBEXDAG04.amd.com>
 <003e01cedbad$e3d252c0$ab76f840$%jun@samsung.com>
 <20131108090533.GA6528@ubuntu.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50449 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab3KKMvS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2013 07:51:18 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MW300J4ZNPDAYA0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 11 Nov 2013 21:51:17 +0900 (KST)
In-reply-to: <20131108090533.GA6528@ubuntu.amd.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jackey Shen' <jackey.shen@amd.com>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Ulf Hansson' <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On Fri, November 08, 2013, Jackey Shen wrote:
> Hi Seungwon,
> 
> Another a little suggestion:
> It would be better that "hs400" in comments is updated to "HS400",
> since the symbol is a special one.
OK.

> 
> Does you test this feature on eMMC 5.0 card from
> http://www.samsung.com/global/business/semiconductor/product/flash-emmc/overview?

No, it seems not found in list.

Can you test eMMC5.0 in your side?


Thanks,
Seungwon Jeon

> 
> Thanks,
> Jackey
> 
> On Thu, Nov 07, 2013 at 08:38:33PM +0900, Seungwon Jeon wrote:
> > Hi Jackey,
> >
> > On Thur, November 07, 2013, Shen, Jackey wrote
> > > Hi Seungwon,
> > >
> > > > -----Original Message-----
> > > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org]
> > > > On Behalf Of Seungwon Jeon
> > > > Sent: Tuesday, November 05, 2013 9:28 PM
> > > > To: 'Chris Ball'; 'Ulf Hansson'
> > > > Cc: linux-mmc@vger.kernel.org
> > > > Subject: [PATCH 3/3] mmc: add support for hs400 mode of eMMC5.0
> > > >
> > > > This patch adds HS400 mode support for eMMC5.0 device.
> > > > HS400 mode is high speed DDDR interface timing from HS200.
> > >
> > > DDDR should be DDR.
> > Ok. Thanks.
> >
> > >
> > > > Clock frequency is up to 200MHz and only 8-bit bus width is
> > > > supported. In addition, tuning process of HS200 is required
> > > > to synchronize the command response on the CMD line because
> > > > CMD input timing for HS400 mode is the same as HS200 mode.
> > > >
> > > > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > > > ---
> > > >  drivers/mmc/core/bus.c   |    3 +-
> > > >  drivers/mmc/core/mmc.c   |  128 +++++++++++++++++++++++++++++++++++++++++++--
> > > > -
> > > >  include/linux/mmc/card.h |   10 +++-
> > > >  include/linux/mmc/host.h |    6 ++
> > > >  include/linux/mmc/mmc.h  |    8 +++-
> > > >  5 files changed, 144 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> > > > index cdca8a7..fd4ba2b 100644
> > > > --- a/drivers/mmc/core/bus.c
> > > > +++ b/drivers/mmc/core/bus.c
> > > > @@ -351,10 +351,11 @@ int mmc_add_card(struct mmc_card *card)
> > > >  			mmc_card_ddr_mode(card) ? "DDR " : "",
> > > >  			type);
> > > >  	} else {
> > > > -		pr_info("%s: new %s%s%s%s%s card at address %04x\n",
> > > > +		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
> > > >  			mmc_hostname(card->host),
> > > >  			mmc_card_uhs(card) ? "ultra high speed " :
> > > >  			(mmc_card_highspeed(card) ? "high speed " : ""),
> > > > +			mmc_card_hs400(card) ? "HS400 " : "",
> > >
> > > I think the following line will be better:
> > > 			mmc_card_hs400(card) ? "HS400 " :
> > Ok.
> >
> > >
> > > >  			(mmc_card_hs200(card) ? "HS200 " : ""),
> > > >  			mmc_card_ddr_mode(card) ? "DDR " : "",
> > > >  			uhs_bus_speed_mode, type, card->rca);
> > > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > > index 1668ea4..7c23b67 100644
> > > > --- a/drivers/mmc/core/mmc.c
> > > > +++ b/drivers/mmc/core/mmc.c
> > > > @@ -280,6 +280,18 @@ static void mmc_select_card_type(struct mmc_card *card)
> > > >  		avail_type |= EXT_CSD_CARD_TYPE_SDR_1_2V;
> > > >  	}
> > > >
> > > > +	if (caps2 & MMC_CAP2_HS400_1_8V &&
> > > > +	    card_type & EXT_CSD_CARD_TYPE_HS400_1_8V) {
> > >
> > > Only 1 byte for ext_csd.raw_card_type as per eMMC spec, so I suggest:
> > > 1. remove EXT_CSD_CARD_TYPE_MASK
> > > 2. card_type is initialized as:
> > >    u8 card_type = card->ext_csd.raw_card_type;
> > Yes. It seems no more need.
> >
> > >
> > > > +		hs200_max_dtr = MMC_HS200_MAX_DTR;
> > > > +		avail_type |= EXT_CSD_CARD_TYPE_HS400_1_8V;
> > > > +	}
> > > > +
> > > > +	if (caps2 & MMC_CAP2_HS400_1_2V &&
> > > > +	    card_type & EXT_CSD_CARD_TYPE_HS400_1_2V) {
> > >
> > > See above comments.
> > >
> > > > +		hs200_max_dtr = MMC_HS200_MAX_DTR;
> > > > +		avail_type |= EXT_CSD_CARD_TYPE_HS400_1_2V;
> > > > +	}
> > > > +
> > > >  	card->ext_csd.hs_max_dtr = hs_max_dtr;
> > > >  	card->ext_csd.hs200_max_dtr = hs200_max_dtr;
> > > >  	card->ext_csd.card_type = card_type;
> > > > @@ -499,6 +511,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8
> > > > *ext_csd)
> > > >  			ext_csd[EXT_CSD_PWR_CL_DDR_52_195];
> > > >  		card->ext_csd.raw_pwr_cl_ddr_52_360 =
> > > >  			ext_csd[EXT_CSD_PWR_CL_DDR_52_360];
> > > > +		card->ext_csd.raw_pwr_cl_ddr_200_360 =
> > > > +			ext_csd[EXT_CSD_PWR_CL_DDR_200_360];
> > > >  	}
> > > >
> > > >  	if (card->ext_csd.rev >= 5) {
> > > > @@ -665,7 +679,10 @@ static int mmc_compare_ext_csds(struct mmc_card *card,
> > > > unsigned bus_width)
> > > >  		(card->ext_csd.raw_pwr_cl_ddr_52_195 ==
> > > >  			bw_ext_csd[EXT_CSD_PWR_CL_DDR_52_195]) &&
> > > >  		(card->ext_csd.raw_pwr_cl_ddr_52_360 ==
> > > > -			bw_ext_csd[EXT_CSD_PWR_CL_DDR_52_360]));
> > > > +			bw_ext_csd[EXT_CSD_PWR_CL_DDR_52_360]) &&
> > > > +		(card->ext_csd.raw_pwr_cl_ddr_200_360 ==
> > > > +			bw_ext_csd[EXT_CSD_PWR_CL_DDR_200_360]));
> > > > +
> > > >  	if (err)
> > > >  		err = -EINVAL;
> > > >
> > > > @@ -780,7 +797,9 @@ static int __mmc_select_powerclass(struct mmc_card *card,
> > > >  				card->ext_csd.raw_pwr_cl_52_360 :
> > > >  				card->ext_csd.raw_pwr_cl_ddr_52_360;
> > > >  		else if (host->ios.clock <= 200000000)
> > > > -			pwrclass_val = card->ext_csd.raw_pwr_cl_200_360;
> > > > +			pwrclass_val = (bus_width == EXT_CSD_DDR_BUS_WIDTH_8) ?
> > > > +				card->ext_csd.raw_pwr_cl_ddr_200_360 :
> > > > +				card->ext_csd.raw_pwr_cl_200_360;
> > > >  		break;
> > > >  	default:
> > > >  		pr_warning("%s: Voltage range not supported "
> > > > @@ -808,7 +827,8 @@ static int __mmc_select_powerclass(struct mmc_card *card,
> > > >
> > > >  static inline unsigned int mmc_snoop_ddr(struct mmc_card *card)
> > > >  {
> > > > -	return card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_52;
> > > > +	return card->mmc_avail_type &
> > > > +		(EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_HS400);
> > > >  }
> > > >
> > > >  static int mmc_select_powerclass(struct mmc_card *card, u8 *ext_csd)
> > > > @@ -858,7 +878,7 @@ static void mmc_set_bus_speed(struct mmc_card *card)
> > > >
> > > >  	BUG_ON(!card);
> > > >
> > > > -	if (mmc_card_hs200(card)) {
> > > > +	if (mmc_card_hs200(card) || mmc_card_hs400(card)) {
> > > >  		if (max_dtr > card->ext_csd.hs200_max_dtr)
> > > >  			max_dtr = card->ext_csd.hs200_max_dtr;
> > > >  	} else if (mmc_card_highspeed(card)) {
> > > > @@ -967,6 +987,31 @@ static int mmc_select_hs(struct mmc_card *card)
> > > >  }
> > > >
> > > >  /*
> > > > + * Revert to the high-speed mode from above speed
> > > > + */
> > > > +static int mmc_revert_to_hs(struct mmc_card *card)
> > > > +{
> > > > +	BUG_ON(!card);
> > > > +
> > > > +	/*
> > > > +	 * CMD13, which is used to confirm the completion of timing
> > > > +	 * change, will be issued at higher speed timing condtion
> > > > +	 * rather than high-speed. If device has completed the change
> > > > +	 * to high-speed mode, it may not be proper timing to issue
> > > > +	 * command. Low speed supplies better timing margin than high
> > > > +	 * speed. Accordingly clock rate & timging should be chagned
> > > > +	 * ahead before actual switch.
> > > > +	 */
> > > > +	mmc_card_set_highspeed(card);
> > > > +	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> > > > +	mmc_set_bus_speed(card);
> > > > +
> > > > +	return mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > > > +			  EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
> > > > +			  card->ext_csd.generic_cmd6_time);
> > > > +}
> > > > +
> > > > +/*
> > > >   * Activate wide bus and DDR if supported.
> > > >   */
> > > >  static int mmc_select_hs_ddr(struct mmc_card *card, u8 *ext_csd)
> > > > @@ -1026,6 +1071,61 @@ static int mmc_select_hs_ddr(struct mmc_card *card, u8
> > > > *ext_csd)
> > > >  	return err;
> > > >  }
> > > >
> > > > +static int mmc_select_hs400(struct mmc_card *card, u8 *ext_csd)
> > > > +{
> > > > +	struct mmc_host *host;
> > > > +	int err = 0, ddr;
> > > > +
> > > > +	BUG_ON(!card);
> > > > +
> > > > +	host = card->host;
> > > > +
> > > > +	ddr = mmc_snoop_ddr(card);
> > > > +
> > > > +	/*
> > > > +	 * The bus width is set to only 8 DDR in HS400 mode
> > > > +	 */
> > > > +	if (!(ddr & EXT_CSD_CARD_TYPE_HS400 &&
> > > > +	      card->host->ios.bus_width == MMC_BUS_WIDTH_8))
> > > > +		return 0;
> > > > +
> > > > +	/*
> > > > +	 * Before setting BUS_WIDTH for dual data rate operation,
> > > > +	 * HS_TIMING must be set to High Speed(0x1)
> > >
> > > This rule is defined by eMMC spec as we know.
> > > Does eMMC card you're testing support to switch to HS400 timing directly?
> > If you mean switch to HS400 from power-on, it doesn't support.
> >
> > >
> > > > +	 */
> > > > +	err = mmc_revert_to_hs(card);
> > > > +	if (err) {
> > > > +		pr_warn("%s: switch to high-speed from hs200 failed, err:%d\n",
> > > > +			mmc_hostname(card->host), err);
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > > > +			 EXT_CSD_BUS_WIDTH,
> > > > +			 EXT_CSD_DDR_BUS_WIDTH_8,
> > > > +			 card->ext_csd.generic_cmd6_time);
> > > > +	if (err) {
> > > > +		pr_warn("%s: switch to bus width for hs400 failed, err:%d\n",
> > > > +			mmc_hostname(card->host), err);
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > > > +			 EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS400,
> > > > +			 card->ext_csd.generic_cmd6_time);
> > > > +	if (err) {
> > > > +		pr_warn("%s: switch to hs400 failed, err:%d\n",
> > > > +			 mmc_hostname(card->host), err);
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	mmc_card_set_hs400(card);
> > > > +	mmc_set_timing(card->host, MMC_TIMING_MMC_HS400);
> > > > +	mmc_set_bus_speed(card);
> > >
> > > There is no code in your patch set to do this work (set timing and bus width)
> > > for MMC host controller. Is this controller Synopsys DesignWare MMC host controller?
> > > As we know, DesignWare MMC host controller is used in Exynos 5420 (SMDK5420),
> > > which supports eMMC 5.0 card.
> > > Will you submit these patches later?
> > Sure, I could send before not long before.
> > I already have completed to test.
> >
> > >
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  /*
> > > >   * For device supporting HS200 mode, the following sequence
> > > >   * should be done before executing the tuning process.
> > > > @@ -1061,10 +1161,19 @@ static int mmc_select_hs200(struct mmc_card *card)
> > > >  		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > > >  				 EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS200,
> > > >  				 card->ext_csd.generic_cmd6_time);
> > > > -		if (!err) {
> > > > -			mmc_card_set_hs200(card);
> > > > +		if (err)
> > > > +			goto err;
> > > > +
> > > > +		mmc_card_set_hs200(card);
> > > > +
> > > > +		if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400)
> > > > +			/*
> > > > +			 * Timing should be adjusted to the HS400 target
> > > > +			 * operation frequency for tuning process
> > > > +			 */
> > > > +			mmc_set_timing(host, MMC_TIMING_MMC_HS400_TUNING);
> > > > +		else
> > > >  			mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> > > > -		}
> > > >  	}
> > > >  err:
> > > >  	return err;
> > > > @@ -1114,7 +1223,7 @@ bus_speed:
> > > >
> > > >  /*
> > > >   * Execute tuning sequence to seek the proper bus operating
> > > > - * conditions for HS200, which sends CMD21 to the device.
> > > > + * conditions for HS200 and HS400, which sends CMD21 to the device.
> > > >   */
> > > >  static int mmc_hs200_tuning(struct mmc_card *card)
> > > >  {
> > > > @@ -1353,6 +1462,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> > > >  		err = mmc_hs200_tuning(card);
> > > >  		if (err)
> > > >  			goto err;
> > > > +		err = mmc_select_hs400(card, ext_csd);
> > > > +		if (err)
> > > > +			goto err;
> > > >  	} else if (mmc_card_highspeed(card)) {
> > > >  		/* Select the desired bus width optionally */
> > > >  		err = mmc_select_bus_width(card);
> > > > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > > > index f2c2620..3d41869 100644
> > > > --- a/include/linux/mmc/card.h
> > > > +++ b/include/linux/mmc/card.h
> > > > @@ -111,6 +111,7 @@ struct mmc_ext_csd {
> > > >  	u8			raw_pwr_cl_200_360;	/* 237 */
> > > >  	u8			raw_pwr_cl_ddr_52_195;	/* 238 */
> > > >  	u8			raw_pwr_cl_ddr_52_360;	/* 239 */
> > > > +	u8			raw_pwr_cl_ddr_200_360;	/* 253 */
> > > >  	u8			raw_bkops_status;	/* 246 */
> > > >  	u8			raw_sectors[4];		/* 212 - 4 bytes */
> > > >
> > > > @@ -258,12 +259,14 @@ struct mmc_card {
> > > >  #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
> > > >  #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
> > > >  #define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
> > > > +#define MMC_STATE_HIGHSPEED_400	(1<<9)		/* card is in HS400 mode */
> > > >  #define MMC_STATE_DOING_BKOPS	(1<<10)		/* card is doing BKOPS */
> > > >  #define MMC_STATE_SUSPENDED	(1<<11)		/* card is suspended */
> > > >  #define MMC_STATE_SPEED_MASK	(MMC_STATE_HIGHSPEED | \
> > > >  				 MMC_STATE_HIGHSPEED_DDR | \
> > > >  				 MMC_STATE_ULTRAHIGHSPEED | \
> > > > -				 MMC_STATE_HIGHSPEED_200)
> > > > +				 MMC_STATE_HIGHSPEED_200 | \
> > > > +				 MMC_STATE_HIGHSPEED_400)
> > > >  						/* Mask for default speed(DS) */
> > > >  	unsigned int		quirks; 	/* card quirks */
> > > >  #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside
> > > > of the VS CCCR range */
> > > > @@ -428,6 +431,7 @@ static inline void __maybe_unused remove_quirk(struct
> > > > mmc_card *card, int data)
> > > >  #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
> > > >  #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
> > > >  #define mmc_card_hs200(c)	((c)->state & MMC_STATE_HIGHSPEED_200)
> > > > +#define mmc_card_hs400(c)	((c)->state & MMC_STATE_HIGHSPEED_400)
> > > >  #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
> > > >  #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
> > > >  #define mmc_card_uhs(c)		((c)->state & MMC_STATE_ULTRAHIGHSPEED)
> > > > @@ -456,6 +460,10 @@ static inline void __maybe_unused remove_quirk(struct
> > > > mmc_card *card, int data)
> > > >  			((c)->state = \
> > > >  			 ((c)->state & ~MMC_STATE_SPEED_MASK) | \
> > > >  			 MMC_STATE_HIGHSPEED_200)
> > > > +#define mmc_card_set_hs400(c) \
> > > > +			((c)->state = \
> > > > +			 ((c)->state & ~MMC_STATE_SPEED_MASK) | \
> > > > +			 MMC_STATE_HIGHSPEED_400)
> > > >  #define mmc_card_set_uhs(c) \
> > > >  			((c)->state = \
> > > >  			 ((c)->state & ~MMC_STATE_SPEED_MASK) | \
> > > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > > index 69d58b1..8e66f4d 100644
> > > > --- a/include/linux/mmc/host.h
> > > > +++ b/include/linux/mmc/host.h
> > > > @@ -59,6 +59,8 @@ struct mmc_ios {
> > > >  #define MMC_TIMING_UHS_SDR104	6
> > > >  #define MMC_TIMING_UHS_DDR50	7
> > > >  #define MMC_TIMING_MMC_HS200	8
> > > > +#define MMC_TIMING_MMC_HS400	9
> > > > +#define MMC_TIMING_MMC_HS400_TUNING 10
> > > >
> > > >  	unsigned char	signal_voltage;		/* signalling voltage (1.8V or
> > > > 3.3V) */
> > > >
> > > > @@ -276,6 +278,10 @@ struct mmc_host {
> > > >  				 MMC_CAP2_PACKED_WR)
> > > >  #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
> > > >  #define MMC_CAP2_SANITIZE	(1 << 15)		/* Support Sanitize */
> > > > +#define MMC_CAP2_HS400_1_8V	(1 << 16)	/* Can support HS400 1.8V */
> > > > +#define MMC_CAP2_HS400_1_2V	(1 << 17)	/* Can support HS400 1.2V */
> > > > +#define MMC_CAP2_HS400		(MMC_CAP2_HS400_1_8V | \
> > > > +				 MMC_CAP2_HS400_1_2V)
> > > >
> > > >  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
> > > >
> > > > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> > > > index 87df508..7d5c27d 100644
> > > > --- a/include/linux/mmc/mmc.h
> > > > +++ b/include/linux/mmc/mmc.h
> > > > @@ -325,6 +325,7 @@ struct _mmc_csd {
> > > >  #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
> > > >  #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
> > > >  #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
> > > > +#define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
> > > >  #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
> > > >  #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
> > > >  #define EXT_CSD_MAX_PACKED_WRITES	500	/* RO */
> > > > @@ -356,7 +357,7 @@ struct _mmc_csd {
> > > >
> > > >  #define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
> > > >  #define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */
> > > > -#define EXT_CSD_CARD_TYPE_MASK	0x3F	/* Mask out reserved bits */
> > > > +#define EXT_CSD_CARD_TYPE_MASK	0xFF	/* Mask out reserved bits */
> > > >  #define EXT_CSD_CARD_TYPE_DDR_1_8V  (1<<2)   /* Card can run at 52MHz */
> > > >  					     /* DDR mode @1.8V or 3V I/O */
> > > >  #define EXT_CSD_CARD_TYPE_DDR_1_2V  (1<<3)   /* Card can run at 52MHz */
> > > > @@ -366,6 +367,10 @@ struct _mmc_csd {
> > > >  #define EXT_CSD_CARD_TYPE_SDR_1_8V	(1<<4)	/* Card can run at 200MHz */
> > > >  #define EXT_CSD_CARD_TYPE_SDR_1_2V	(1<<5)	/* Card can run at 200MHz */
> > > >  						/* SDR mode @1.2V I/O */
> > > > +#define EXT_CSD_CARD_TYPE_HS400_1_8V	(1<<6)	/* Card can run at 200MHz DDR,
> > > > 1.8V */
> > > > +#define EXT_CSD_CARD_TYPE_HS400_1_2V	(1<<7)	/* Card can run at 200MHz DDR,
> > > > 1.2V */
> > > > +#define EXT_CSD_CARD_TYPE_HS400		(EXT_CSD_CARD_TYPE_HS400_1_8V | \
> > > > +					 EXT_CSD_CARD_TYPE_HS400_1_2V)
> > > >
> > > >  #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
> > > >  #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
> > > > @@ -376,6 +381,7 @@ struct _mmc_csd {
> > > >  #define EXT_CSD_TIMING_BC	0	/* Backwards compatility */
> > > >  #define EXT_CSD_TIMING_HS	1	/* High speed */
> > > >  #define EXT_CSD_TIMING_HS200	2	/* HS200 */
> > > > +#define EXT_CSD_TIMING_HS400	3	/* HS400 */
> > > >
> > > >  #define EXT_CSD_SEC_ER_EN	BIT(0)
> > > >  #define EXT_CSD_SEC_BD_BLK_EN	BIT(2)
> > > > --
> > > > 1.7.0.4
> > > >
> > >
> > > In addition, for debug purpose for HS400, the following patch segment should be added in debugfs.c:
> > >
> > > diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> > > index 54829c0..e1f075c 100644
> > > --- a/drivers/mmc/core/debugfs.c
> > > +++ b/drivers/mmc/core/debugfs.c
> > > @@ -138,6 +138,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
> > >  	case MMC_TIMING_MMC_HS200:
> > >  		str = "mmc high-speed SDR200";
> > >  		break;
> > > +	case MMC_TIMING_MMC_HS400:
> > > +		str = "mmc high-speed DDR200";
> > > +		break;
> > >  	default:
> > >  		str = "invalid";
> > >  		break;
> > Ok. I'll add.
> >
> > >
> > > Besides, may I venture to ask that whether you test on specified hardware and pass test cases?
> > As you asked above, I tested it with exynos5420.
> >
> > Thanks,
> > Seungwon Jeon
> >
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

