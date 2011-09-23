From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v4] mmc: core: Add default timeout value for CMD6.
Date: Fri, 23 Sep 2011 09:58:35 +0900
Message-ID: <000001cc798b$ec57e4e0$c507aea0$%jun@samsung.com>
References: <1316657541-9221-1-git-send-email-tgih.jun@samsung.com>
 <4E7BB297.8090700@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13767 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab1IWA6h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2011 20:58:37 -0400
In-reply-to: <4E7BB297.8090700@linux.intel.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'J Freyensee' <james_p_freyensee@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Hi,

J Freyensee wrote:
> 
> On 09/21/2011 07:12 PM, Seungwon Jeon wrote:
> > EXT_CSD[248] includes the default maximum timeout for CMD6.
> > This field is added at eMMC4.5 Spec. And it can be used for default
> > timeout except for some operations which don't define the timeout(i.e.
> > background operation, sanitize, flush cache) in eMMC4.5 Spec.
> 
> Out of curiosity, what cache is being refered to in 'flush cache' comment?
It is described in eMMC4.5 Spec.

Best regards,
Seungwon Jeon.
> >
> > Signed-off-by: Seungwon Jeon<tgih.jun@samsung.com>
> > ---
> >   drivers/mmc/core/mmc.c   |   16 ++++++++++++----
> >   include/linux/mmc/card.h |    1 +
> >   include/linux/mmc/mmc.h  |    1 +
> >   3 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 5700b1c..b2ee14a 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -410,6 +410,12 @@ static int mmc_read_ext_csd(struct mmc_card *card,
> u8 *ext_csd)
> >   	else
> >   		card->erased_byte = 0x0;
> >
> > +	if (card->ext_csd.rev>= 6)
> > +		card->ext_csd.generic_cmd6_time = 10 *
> > +			ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
> > +	else
> > +		card->ext_csd.generic_cmd6_time = 0;
> > +
> >   out:
> >   	return err;
> >   }
> > @@ -668,7 +674,8 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
> >   	 */
> >   	if (card->ext_csd.enhanced_area_en) {
> >   		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > -				 EXT_CSD_ERASE_GROUP_DEF, 1, 0);
> > +				 EXT_CSD_ERASE_GROUP_DEF, 1,
> > +				 card->ext_csd.generic_cmd6_time);
> >
> >   		if (err&&  err != -EBADMSG)
> >   			goto free_card;
> > @@ -711,7 +718,8 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
> >   	if ((card->ext_csd.hs_max_dtr != 0)&&
> >   		(host->caps&  MMC_CAP_MMC_HIGHSPEED)) {
> >   		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > -				 EXT_CSD_HS_TIMING, 1, 0);
> > +				 EXT_CSD_HS_TIMING, 1,
> > +				 card->ext_csd.generic_cmd6_time);
> >   		if (err&&  err != -EBADMSG)
> >   			goto free_card;
> >
> > @@ -783,7 +791,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
> >   			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >   					 EXT_CSD_BUS_WIDTH,
> >   					 ext_csd_bits[idx][0],
> > -					 0);
> > +					 card->ext_csd.generic_cmd6_time);
> >   			if (!err) {
> >   				mmc_set_bus_width(card->host, bus_width);
> >
> > @@ -806,7 +814,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
> >   			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >   					 EXT_CSD_BUS_WIDTH,
> >   					 ext_csd_bits[idx][1],
> > -					 0);
> > +					 card->ext_csd.generic_cmd6_time);
> >   		}
> >   		if (err) {
> >   			printk(KERN_WARNING "%s: switch to bus width %d ddr %d
> "
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index b460fc2..b713abf 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -52,6 +52,7 @@ struct mmc_ext_csd {
> >   	u8			part_config;
> >   	unsigned int		part_time;		/* Units: ms */
> >   	unsigned int		sa_timeout;		/* Units: 100ns */
> > +	unsigned int		generic_cmd6_time;	/* Units: 10ms */
> >   	unsigned int		hs_max_dtr;
> >   	unsigned int		sectors;
> >   	unsigned int		card_type;
> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> > index 5a794cb..e869f00 100644
> > --- a/include/linux/mmc/mmc.h
> > +++ b/include/linux/mmc/mmc.h
> > @@ -293,6 +293,7 @@ struct _mmc_csd {
> >   #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
> >   #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
> >   #define EXT_CSD_TRIM_MULT		232	/* RO */
> > +#define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
> >
> >   /*
> >    * EXT_CSD field definitions
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> J (James/Jay) Freyensee
> Storage Technology Group
> Intel Corporation

