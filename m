From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: HSMMC: explicit fields to declare cover/card
 detect pin
Date: Wed, 25 Mar 2015 08:51:32 -0700
Message-ID: <20150325155131.GZ31346@atomide.com>
References: <1426863234-28409-1-git-send-email-afenkart@gmail.com>
 <CAPDyKFq3nYPRLC-fKtBQs3g1qJjVA2YKUGP86ZS9fHAmmNkxEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFq3nYPRLC-fKtBQs3g1qJjVA2YKUGP86ZS9fHAmmNkxEQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [150325 01:32]:
> On 20 March 2015 at 15:53, Andreas Fenkart <afenkart@gmail.com> wrote:
> > board-rx51 has no card detect pin in the mmc slot, but can detect that
> > the (cell-phone) cover has been removed and the card is accessible.
> > The semantics between cover/card detect differ, the gpio on the slot
> > informs you after the card has been removed, cover removal does not
> > necessarily mean that the card has been removed.
> > This means different code paths are necessary. To complete this we
> > also want different fields in the platform data for cover and card
> > detect. This separation is not pushed all the way down into struct
> > omap2_hsmmc_info which is used to initialize the platform data.
> > If we did that we had to go over all board files and set the new
> > gpio_cod pin to -EINVAL. If we forget one board or some out-of-tree
> > archicture forgets that the default '0' is used which is a valid pin
> > number.
> >
> > Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
> 
> Tony, are you fine with this change? I believe I should take it
> through my mmc tree due to that I have other omap_hsmmc patches
> already queued.

Sure, sorry did notice earlier there are some arch changes here.

The patch looks good to me, please feel free to take it, it should
not conflict with anything I'm queueing for v4.1:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> > ---
> >  arch/arm/mach-omap2/hsmmc.c              | 33 ++++++++++++++++++++++++--------
> >  drivers/mmc/host/omap_hsmmc.c            | 11 ++++++-----
> >  include/linux/platform_data/hsmmc-omap.h |  6 ++----
> >  3 files changed, 33 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> > index dc6e79c..9a8611a 100644
> > --- a/arch/arm/mach-omap2/hsmmc.c
> > +++ b/arch/arm/mach-omap2/hsmmc.c
> > @@ -150,9 +150,13 @@ static int nop_mmc_set_power(struct device *dev, int power_on, int vdd)
> >  static inline void omap_hsmmc_mux(struct omap_hsmmc_platform_data
> >                                   *mmc_controller, int controller_nr)
> >  {
> > -       if (gpio_is_valid(mmc_controller->switch_pin) &&
> > -           (mmc_controller->switch_pin < OMAP_MAX_GPIO_LINES))
> > -               omap_mux_init_gpio(mmc_controller->switch_pin,
> > +       if (gpio_is_valid(mmc_controller->gpio_cd) &&
> > +           (mmc_controller->gpio_cd < OMAP_MAX_GPIO_LINES))
> > +               omap_mux_init_gpio(mmc_controller->gpio_cd,
> > +                                  OMAP_PIN_INPUT_PULLUP);
> > +       if (gpio_is_valid(mmc_controller->gpio_cod) &&
> > +           (mmc_controller->gpio_cod < OMAP_MAX_GPIO_LINES))
> > +               omap_mux_init_gpio(mmc_controller->gpio_cod,
> >                                    OMAP_PIN_INPUT_PULLUP);
> >         if (gpio_is_valid(mmc_controller->gpio_wp) &&
> >             (mmc_controller->gpio_wp < OMAP_MAX_GPIO_LINES))
> > @@ -250,15 +254,20 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
> >         mmc->internal_clock = !c->ext_clock;
> >         mmc->reg_offset = 0;
> >
> > -       mmc->switch_pin = c->gpio_cd;
> > +       if (c->cover_only) {
> > +               /* detect if mobile phone cover removed */
> > +               mmc->gpio_cd = -EINVAL;
> > +               mmc->gpio_cod = c->gpio_cd;
> > +       } else {
> > +               /* card detect pin on the mmc socket itself */
> > +               mmc->gpio_cd = c->gpio_cd;
> > +               mmc->gpio_cod = -EINVAL;
> > +       }
> >         mmc->gpio_wp = c->gpio_wp;
> >
> >         mmc->remux = c->remux;
> >         mmc->init_card = c->init_card;
> >
> > -       if (c->cover_only)
> > -               mmc->cover = 1;
> > -
> >         if (c->nonremovable)
> >                 mmc->nonremovable = 1;
> >
> > @@ -358,7 +367,15 @@ void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
> >                 if (!mmc_pdata)
> >                         continue;
> >
> > -               mmc_pdata->switch_pin = c->gpio_cd;
> > +               if (c->cover_only) {
> > +                       /* detect if mobile phone cover removed */
> > +                       mmc_pdata->gpio_cd = -EINVAL;
> > +                       mmc_pdata->gpio_cod = c->gpio_cd;
> > +               } else {
> > +                       /* card detect pin on the mmc socket itself */
> > +                       mmc_pdata->gpio_cd = c->gpio_cd;
> > +                       mmc_pdata->gpio_cod = -EINVAL;
> > +               }
> >                 mmc_pdata->gpio_wp = c->gpio_wp;
> >
> >                 res = omap_device_register(pdev);
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> > index 053cd38..265391f 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -427,15 +427,15 @@ static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
> >  {
> >         int ret;
> >
> > -       if (pdata->cover && gpio_is_valid(pdata->switch_pin)) {
> > -               ret = mmc_gpio_request_cd(mmc, pdata->switch_pin, 0);
> > +       if (gpio_is_valid(pdata->gpio_cod)) {
> > +               ret = mmc_gpio_request_cd(mmc, pdata->gpio_cod, 0);
> >                 if (ret)
> >                         return ret;
> >
> >                 host->get_cover_state = omap_hsmmc_get_cover_state;
> >                 mmc_gpio_set_cd_isr(mmc, omap_hsmmc_cover_irq);
> > -       } else if (!pdata->cover && gpio_is_valid(pdata->switch_pin)) {
> > -               ret = mmc_gpio_request_cd(mmc, pdata->switch_pin, 0);
> > +       } else if (gpio_is_valid(pdata->gpio_cd)) {
> > +               ret = mmc_gpio_request_cd(mmc, pdata->gpio_cd, 0);
> >                 if (ret)
> >                         return ret;
> >
> > @@ -1932,7 +1932,8 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
> >         if (of_find_property(np, "ti,dual-volt", NULL))
> >                 pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
> >
> > -       pdata->switch_pin = -EINVAL;
> > +       pdata->gpio_cd = -EINVAL;
> > +       pdata->gpio_cod = -EINVAL;
> >         pdata->gpio_wp = -EINVAL;
> >
> >         if (of_find_property(np, "ti,non-removable", NULL)) {
> > diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
> > index 67bbcf0..8e981be 100644
> > --- a/include/linux/platform_data/hsmmc-omap.h
> > +++ b/include/linux/platform_data/hsmmc-omap.h
> > @@ -55,9 +55,6 @@ struct omap_hsmmc_platform_data {
> >         u32 caps;       /* Used for the MMC driver on 2430 and later */
> >         u32 pm_caps;    /* PM capabilities of the mmc */
> >
> > -       /* switch pin can be for card detect (default) or card cover */
> > -       unsigned cover:1;
> > -
> >         /* use the internal clock */
> >         unsigned internal_clock:1;
> >
> > @@ -73,7 +70,8 @@ struct omap_hsmmc_platform_data {
> >  #define HSMMC_HAS_HSPE_SUPPORT (1 << 2)
> >         unsigned features;
> >
> > -       int switch_pin;                 /* gpio (card detect) */
> > +       int gpio_cd;                    /* gpio (card detect) */
> > +       int gpio_cod;                   /* gpio (cover detect) */
> >         int gpio_wp;                    /* gpio (write protect) */
> >
> >         int (*set_power)(struct device *dev, int power_on, int vdd);
> > --
> > 2.1.4
> >
