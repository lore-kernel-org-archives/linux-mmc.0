From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2] mmc: core: Add default timeout value for CMD6.
Date: Thu, 08 Sep 2011 16:10:47 +0900
Message-ID: <000001cc6df6$6f337f10$4d9a7d30$%jun@samsung.com>
References: <1315462202-28032-1-git-send-email-tgih.jun@samsung.com>
 <CAH9JG2XcE2En3wrBaJPuDycs4b-rvcCQv=8L7+9y8rQ_aUa1Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAH9JG2XcE2En3wrBaJPuDycs4b-rvcCQv=8L7+9y8rQ_aUa1Mw@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Thank you for comment.
I will apply it.

Best regards,
Seungwon Jeon.

Kyungmin Park wrote:
> 
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Nitpick: see below comments and typo.
> 
> On Thu, Sep 8, 2011 at 3:10 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
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
> Even though generic_cmd6_time is cleared at card initialization. Make
> sure set the 0 when not eMMC v4.5 to make consistent with previous
> version and codes.
>              else
>                    card->ext_csd.generic_cmd6_time = 0;
Yes, it would be better.

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
> The correct unit is 10ms
> 
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
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> soc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
