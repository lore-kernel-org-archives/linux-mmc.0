From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2] mmc: core: Add default timeout value for CMD6.
Date: Thu, 29 Sep 2011 15:37:04 +0900
Message-ID: <000201cc7e72$33bf5350$9b3df9f0$%jun@samsung.com>
References: <1315462202-28032-1-git-send-email-tgih.jun@samsung.com>
 <CAGxe1ZFMwdVtNf-XKKwVXPR3FteMrXk+_3reRdF-=Y8FrBUvCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38542 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab1I2GhF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 02:37:05 -0400
In-reply-to: <CAGxe1ZFMwdVtNf-XKKwVXPR3FteMrXk+_3reRdF-=Y8FrBUvCg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Girish K S wrote:
> 
> Hi Jeon,
> 
> I tried to apply your patch to the latest Chris-mmc/mmc-next branch.
> but the patch fails. can you please check
> err message.
> 
> error: patch failed: include/linux/mmc/card.h:52
> error: include/linux/mmc/card.h: patch does not apply
> error: patch failed: include/linux/mmc/mmc.h:293
> error: include/linux/mmc/mmc.h: patch does not apply
> Patch failed at 0001 mmc: core: Add default timeout value for CMD6.

Thank you for informing me.
But V4 is latest patch.
Anyway, since I has submitted this patch, several patches were updated.
So base branch is changed. Could I update this patch?

Best regards,
Seungwon Jeon.
> 
> regards
> Girish K S
> > EXT_CSD[248] includes the default maximum timeout for CMD6.
> > This field is added at eMMC4.5 Spec. And it can be used for default
> > timeout except for some operations which don't define the timeout(i.e.
> > background operation, sanitize, flush cache) in eMMC4.5 Spec.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> > v2 : apply default maximum timeout of CMD6 which specific timeout is not
> defined.
> >
> >  drivers/mmc/core/mmc.c   |   14 ++++++++++----
> >  include/linux/mmc/card.h |    1 +
> >  include/linux/mmc/mmc.h  |    1 +
> >  3 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 5700b1c..b148bb1 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -410,6 +410,10 @@ static int mmc_read_ext_csd(struct mmc_card *card,
> u8 *ext_csd)
> >        else
> >                card->erased_byte = 0x0;
> >
> > +       if (card->ext_csd.rev >= 6)
> > +               card->ext_csd.generic_cmd6_time = 10 *
> > +                       ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
> > +
> >  out:
> >        return err;
> >  }
> > @@ -668,7 +672,8 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
> >         */
> >        if (card->ext_csd.enhanced_area_en) {
> >                err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > -                                EXT_CSD_ERASE_GROUP_DEF, 1, 0);
> > +                                EXT_CSD_ERASE_GROUP_DEF, 1,
> > +                                card->ext_csd.generic_cmd6_time);
> >
> >                if (err && err != -EBADMSG)
> >                        goto free_card;
> > @@ -711,7 +716,8 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
> >        if ((card->ext_csd.hs_max_dtr != 0) &&
> >                (host->caps & MMC_CAP_MMC_HIGHSPEED)) {
> >                err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > -                                EXT_CSD_HS_TIMING, 1, 0);
> > +                                EXT_CSD_HS_TIMING, 1,
> > +                                card->ext_csd.generic_cmd6_time);
> >                if (err && err != -EBADMSG)
> >                        goto free_card;
> >
> > @@ -783,7 +789,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
> >                        err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >                                         EXT_CSD_BUS_WIDTH,
> >                                         ext_csd_bits[idx][0],
> > -                                        0);
> > +                                        card->ext_csd.generic_cmd6_time);
> >                        if (!err) {
> >                                mmc_set_bus_width(card->host, bus_width);
> >
> > @@ -806,7 +812,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
> >                        err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >                                         EXT_CSD_BUS_WIDTH,
> >                                         ext_csd_bits[idx][1],
> > -                                        0);
> > +                                        card->ext_csd.generic_cmd6_time);
> >                }
> >                if (err) {
> >                        printk(KERN_WARNING "%s: switch to bus width %d
> ddr %d "
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index b460fc2..e992fe3 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -52,6 +52,7 @@ struct mmc_ext_csd {
> >        u8                      part_config;
> >        unsigned int            part_time;              /* Units: ms */
> >        unsigned int            sa_timeout;             /* Units: 100ns */
> > +       unsigned int            generic_cmd6_time;      /* Units: ms */
> >        unsigned int            hs_max_dtr;
> >        unsigned int            sectors;
> >        unsigned int            card_type;
> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> > index 5a794cb..e869f00 100644
> > --- a/include/linux/mmc/mmc.h
> > +++ b/include/linux/mmc/mmc.h
> > @@ -293,6 +293,7 @@ struct _mmc_csd {
> >  #define EXT_CSD_SEC_ERASE_MULT         230     /* RO */
> >  #define EXT_CSD_SEC_FEATURE_SUPPORT    231     /* RO */
> >  #define EXT_CSD_TRIM_MULT              232     /* RO */
> > +#define EXT_CSD_GENERIC_CMD6_TIME      248     /* RO */
> >
> >  /*
> >  * EXT_CSD field definitions
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

