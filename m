From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/3] mmc: rework selection of bus speed mode
Date: Wed, 06 Nov 2013 18:09:08 +0900
Message-ID: <001201cedacf$d9a97550$8cfc5ff0$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <003401ceda2a$bd04e7e0$370eb7a0$%jun@samsung.com>
 <CAPDyKFpBg0HH7P69AhN2h+CeCcbEg07c9LXSRBrYs3FgxnQ96w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:21605 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134Ab3KFJJQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 04:09:16 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVU00F9F42N3BU0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Nov 2013 18:09:09 +0900 (KST)
In-reply-to: <CAPDyKFpBg0HH7P69AhN2h+CeCcbEg07c9LXSRBrYs3FgxnQ96w@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'linux-mmc' <linux-mmc@vger.kernel.org>

Hi Ulf,

On Tue, November 05, 2013, Ulf Hansson wrote:
> Hi Seungwon,
> 
> On 5 November 2013 14:27, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Current implementation for bus speed mode selection is too
> > complicated. This patch is to simplify the codes and remove
> > some duplicate parts.
> >
> > The following changes are including:
> > * Adds functions for each mode selection(HS, HS-DDR, HS200 and etc)
> > * Rearranged the mode selection sequence with supported device type
> > * Power class is switched once only after bus modes(speed/width)
> >   are selected finally
> > * Adds maximum speed for HS200 mode(hs200_max_dtr)
> > * Adds available device type to be supported by both host and device
> > * Adds field definition for HS_TIMING of EXT_CSD
> 
> Very nice work you are doing here, this is certainly needed.
> 
> Although, from a reviewing point of view it would be nice if you could
> split up and do re-factoring in more minor pieces. Could that be done?

Ok. I'll consider that.
But I guess it would not be done nicely because a whole flow is organic.
If you have any opinion, please let me know.

Thanks,
Seungwon Jeon

> 
> Kind regards
> Ulf Hansson
> 
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/core/mmc.c   |  574 +++++++++++++++++++++++++++-------------------
> >  include/linux/mmc/card.h |    6 +-
> >  include/linux/mmc/host.h |    6 -
> >  include/linux/mmc/mmc.h  |    4 +
> >  4 files changed, 345 insertions(+), 245 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index f631f5a..f4f8991 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -242,29 +242,48 @@ static void mmc_select_card_type(struct mmc_card *card)
> >         struct mmc_host *host = card->host;
> >         u8 card_type = card->ext_csd.raw_card_type & EXT_CSD_CARD_TYPE_MASK;
> >         u32 caps = host->caps, caps2 = host->caps2;
> > -       unsigned int hs_max_dtr = 0;
> > +       unsigned int avail_type = 0;
> > +       unsigned int hs_max_dtr = 0, hs200_max_dtr = 0;
> >
> > -       if (card_type & EXT_CSD_CARD_TYPE_26)
> > +       if (card_type & EXT_CSD_CARD_TYPE_26) {
> >                 hs_max_dtr = MMC_HIGH_26_MAX_DTR;
> > +               avail_type |= EXT_CSD_CARD_TYPE_26;
> > +       }
> >
> >         if (caps & MMC_CAP_MMC_HIGHSPEED &&
> > -                       card_type & EXT_CSD_CARD_TYPE_52)
> > +           card_type & EXT_CSD_CARD_TYPE_52) {
> >                 hs_max_dtr = MMC_HIGH_52_MAX_DTR;
> > +               avail_type |= EXT_CSD_CARD_TYPE_52;
> > +       }
> > +
> > +       if (caps & MMC_CAP_1_8V_DDR &&
> > +           card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
> > +               hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
> > +               avail_type |= EXT_CSD_CARD_TYPE_DDR_1_8V;
> > +       }
> >
> > -       if ((caps & MMC_CAP_1_8V_DDR &&
> > -                       card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) ||
> > -           (caps & MMC_CAP_1_2V_DDR &&
> > -                       card_type & EXT_CSD_CARD_TYPE_DDR_1_2V))
> > +       if (caps & MMC_CAP_1_2V_DDR &&
> > +           card_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
> >                 hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
> > +               avail_type |= EXT_CSD_CARD_TYPE_DDR_1_2V;
> > +       }
> > +
> > +       if (caps2 & MMC_CAP2_HS200_1_8V_SDR &&
> > +           card_type & EXT_CSD_CARD_TYPE_SDR_1_8V) {
> > +               hs200_max_dtr = MMC_HS200_MAX_DTR;
> > +               avail_type |= EXT_CSD_CARD_TYPE_SDR_1_8V;
> > +       }
> >
> > -       if ((caps2 & MMC_CAP2_HS200_1_8V_SDR &&
> > -                       card_type & EXT_CSD_CARD_TYPE_SDR_1_8V) ||
> > -           (caps2 & MMC_CAP2_HS200_1_2V_SDR &&
> > -                       card_type & EXT_CSD_CARD_TYPE_SDR_1_2V))
> > -               hs_max_dtr = MMC_HS200_MAX_DTR;
> > +       if (caps2 & MMC_CAP2_HS200_1_2V_SDR &&
> > +           card_type & EXT_CSD_CARD_TYPE_SDR_1_2V) {
> > +               hs200_max_dtr = MMC_HS200_MAX_DTR;
> > +               avail_type |= EXT_CSD_CARD_TYPE_SDR_1_2V;
> > +       }
> >
> >         card->ext_csd.hs_max_dtr = hs_max_dtr;
> > +       card->ext_csd.hs200_max_dtr = hs200_max_dtr;
> >         card->ext_csd.card_type = card_type;
> > +       card->mmc_avail_type = avail_type;
> >  }
> >
> >  /*
> > @@ -714,8 +733,8 @@ static struct device_type mmc_type = {
> >   * extended CSD register, select it by executing the
> >   * mmc_switch command.
> >   */
> > -static int mmc_select_powerclass(struct mmc_card *card,
> > -               unsigned int bus_width)
> > +static int __mmc_select_powerclass(struct mmc_card *card,
> > +                                  unsigned int bus_width, u8 *ext_csd)
> >  {
> >         int err = 0;
> >         unsigned int pwrclass_val = 0;
> > @@ -787,40 +806,99 @@ static int mmc_select_powerclass(struct mmc_card *card,
> >         return err;
> >  }
> >
> > +static inline unsigned int mmc_snoop_ddr(struct mmc_card *card)
> > +{
> > +       return card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_52;
> > +}
> > +
> > +static int mmc_select_powerclass(struct mmc_card *card, u8 *ext_csd)
> > +{
> > +       int err, ddr;
> > +       u32 bus_width, ext_csd_bits;
> > +       struct mmc_host *host;
> > +
> > +       BUG_ON(!card);
> > +
> > +       host = card->host;
> > +
> > +       if (!ext_csd)
> > +               return 0;
> > +
> > +       /* Power class selection is supported for versions >= 4.0 */
> > +       if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
> > +               return 0;
> > +
> > +       bus_width = host->ios.bus_width;
> > +       /* Power class values are defined only for 4/8 bit bus */
> > +       if (bus_width == MMC_BUS_WIDTH_1)
> > +               return 0;
> > +
> > +       ddr = mmc_snoop_ddr(card);
> > +       if (ddr)
> > +               ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
> > +                       EXT_CSD_DDR_BUS_WIDTH_8 : EXT_CSD_DDR_BUS_WIDTH_4;
> > +       else
> > +               ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
> > +                       EXT_CSD_BUS_WIDTH_8 :  EXT_CSD_BUS_WIDTH_4;
> > +
> > +       err = __mmc_select_powerclass(card, ext_csd_bits, ext_csd);
> > +       if (err)
> > +               pr_warn("%s: power class selection to bus width %d ddr %d failed\n",
> > +                       mmc_hostname(host), 1 << bus_width, ddr);
> > +
> > +       return err;
> > +}
> > +
> >  /*
> > - * Selects the desired buswidth and switch to the HS200 mode
> > - * if bus width set without error
> > + * Set the bus speed for the selected speed mode.
> >   */
> > -static int mmc_select_hs200(struct mmc_card *card)
> > +static void mmc_set_bus_speed(struct mmc_card *card)
> > +{
> > +       unsigned int max_dtr = (unsigned int)-1;
> > +
> > +       BUG_ON(!card);
> > +
> > +       if (mmc_card_hs200(card)) {
> > +               if (max_dtr > card->ext_csd.hs200_max_dtr)
> > +                       max_dtr = card->ext_csd.hs200_max_dtr;
> > +       } else if (mmc_card_highspeed(card)) {
> > +               if (max_dtr > card->ext_csd.hs_max_dtr)
> > +                       max_dtr = card->ext_csd.hs_max_dtr;
> > +       } else if (max_dtr > card->csd.max_dtr) {
> > +               max_dtr = card->csd.max_dtr;
> > +       }
> > +
> > +       mmc_set_clock(card->host, max_dtr);
> > +}
> > +
> > +/*
> > + * Select the bus width amoung 4-bit and 8-bit(SDR).
> > + * If the bus width is changed successfully, return the slected width value.
> > + * Zero is returned instead of error value if the wide width is not supported.
> > + */
> > +static int mmc_select_bus_width(struct mmc_card *card)
> >  {
> > -       int idx, err = -EINVAL;
> > -       struct mmc_host *host;
> >         static unsigned ext_csd_bits[] = {
> > -               EXT_CSD_BUS_WIDTH_4,
> >                 EXT_CSD_BUS_WIDTH_8,
> > +               EXT_CSD_BUS_WIDTH_4,
> >         };
> >         static unsigned bus_widths[] = {
> > -               MMC_BUS_WIDTH_4,
> >                 MMC_BUS_WIDTH_8,
> > +               MMC_BUS_WIDTH_4,
> >         };
> > +       struct mmc_host *host;
> > +       unsigned idx, bus_width = 0;
> > +       int err = 0;
> >
> >         BUG_ON(!card);
> >
> >         host = card->host;
> >
> > -       if (card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V &&
> > -                       host->caps2 & MMC_CAP2_HS200_1_2V_SDR)
> > -               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
> > -
> > -       if (err && card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V &&
> > -                       host->caps2 & MMC_CAP2_HS200_1_8V_SDR)
> > -               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
> > -
> > -       /* If fails try again during next card power cycle */
> > -       if (err)
> > -               goto err;
> > +       if ((card->csd.mmca_vsn < CSD_SPEC_VER_4) &&
> > +           !(host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)))
> > +               return 0;
> >
> > -       idx = (host->caps & MMC_CAP_8_BIT_DATA) ? 1 : 0;
> > +       idx = (host->caps & MMC_CAP_8_BIT_DATA) ? 0 : 1;
> >
> >         /*
> >          * Unlike SD, MMC cards dont have a configuration register to notify
> > @@ -828,8 +906,7 @@ static int mmc_select_hs200(struct mmc_card *card)
> >          * the supported bus width or compare the ext csd values of current
> >          * bus width and ext csd values of 1 bit mode read earlier.
> >          */
> > -       for (; idx >= 0; idx--) {
> > -
> > +       for (; idx < ARRAY_SIZE(bus_widths); idx++) {
> >                 /*
> >                  * Host is capable of 8bit transfer, then switch
> >                  * the device to work in 8bit transfer mode. If the
> > @@ -844,25 +921,226 @@ static int mmc_select_hs200(struct mmc_card *card)
> >                 if (err)
> >                         continue;
> >
> > -               mmc_set_bus_width(card->host, bus_widths[idx]);
> > +               bus_width = bus_widths[idx];
> > +               mmc_set_bus_width(host, bus_width);
> >
> > +               /*
> > +                * If controller can't handle bus width test,
> > +                * compare ext_csd previously read in 1 bit mode
> > +                * against ext_csd at new bus width
> > +                */
> >                 if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
> > -                       err = mmc_compare_ext_csds(card, bus_widths[idx]);
> > +                       err = mmc_compare_ext_csds(card, bus_width);
> >                 else
> > -                       err = mmc_bus_test(card, bus_widths[idx]);
> > -               if (!err)
> > +                       err = mmc_bus_test(card, bus_width);
> > +
> > +               if (!err) {
> > +                       err = bus_width;
> >                         break;
> > +               } else {
> > +                       pr_warn("%s: switch to bus width %d failed\n",
> > +                               mmc_hostname(card->host), ext_csd_bits[idx]);
> > +               }
> >         }
> >
> > -       /* switch to HS200 mode if bus width set successfully */
> > -       if (!err)
> > +       return err;
> > +}
> > +
> > +/*
> > + * Switch to the high-speed mode
> > + */
> > +static int mmc_select_hs(struct mmc_card *card)
> > +{
> > +       int err;
> > +
> > +       BUG_ON(!card);
> > +
> > +       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +                        EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
> > +                        card->ext_csd.generic_cmd6_time);
> > +       if (!err) {
> > +               mmc_card_set_highspeed(card);
> > +               mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +/*
> > + * Activate wide bus and DDR if supported.
> > + */
> > +static int mmc_select_hs_ddr(struct mmc_card *card, u8 *ext_csd)
> > +{
> > +       struct mmc_host *host;
> > +       u32 bus_width, ext_csd_bits;
> > +       int err = 0, ddr;
> > +
> > +       BUG_ON(!card);
> > +
> > +       ddr = mmc_snoop_ddr(card);
> > +       if (!(ddr & EXT_CSD_CARD_TYPE_DDR_52))
> > +               return 0;
> > +
> > +       host = card->host;
> > +       bus_width = host->ios.bus_width;
> > +       if (bus_width == MMC_BUS_WIDTH_1)
> > +               return 0;
> > +
> > +       ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
> > +               EXT_CSD_DDR_BUS_WIDTH_8 : EXT_CSD_DDR_BUS_WIDTH_4;
> > +
> > +       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +                       EXT_CSD_BUS_WIDTH,
> > +                       ext_csd_bits,
> > +                       card->ext_csd.generic_cmd6_time);
> > +       if (err) {
> > +               pr_warn("%s: switch to bus width %d ddr failed\n",
> > +                       mmc_hostname(host), 1 << bus_width);
> > +               return err;
> > +       }
> > +
> > +       /*
> > +        * eMMC cards can support 3.3V to 1.2V i/o (vccq)
> > +        * signaling.
> > +        *
> > +        * EXT_CSD_CARD_TYPE_DDR_1_8V means 3.3V or 1.8V vccq.
> > +        *
> > +        * 1.8V vccq at 3.3V core voltage (vcc) is not required
> > +        * in the JEDEC spec for DDR.
> > +        *
> > +        * Do not force change in vccq since we are obviously
> > +        * working and no change to vccq is needed.
> > +        *
> > +        * WARNING: eMMC rules are NOT the same as SD DDR
> > +        */
> > +       if (ddr & EXT_CSD_CARD_TYPE_DDR_1_2V) {
> > +               err = __mmc_set_signal_voltage(host,
> > +                               MMC_SIGNAL_VOLTAGE_120);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       mmc_card_set_ddr_mode(card);
> > +       mmc_set_timing(host, MMC_TIMING_UHS_DDR50);
> > +
> > +       return err;
> > +}
> > +
> > +/*
> > + * For device supporting HS200 mode, the following sequence
> > + * should be done before executing the tuning process.
> > + * 1. set the desired bus width(4-bit or 8-bit, 1-bit is not supported)
> > + * 2. switch to HS200 mode
> > + * 3. set the clock to > 52Mhz and <=200MHz
> > + */
> > +static int mmc_select_hs200(struct mmc_card *card)
> > +{
> > +       int err = -EINVAL;
> > +       struct mmc_host *host;
> > +
> > +       BUG_ON(!card);
> > +
> > +       host = card->host;
> > +
> > +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_SDR_1_2V)
> > +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
> > +
> > +       if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_SDR_1_8V)
> > +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
> > +
> > +       /* If fails try again during next card power cycle */
> > +       if (err)
> > +               goto err;
> > +
> > +       /*
> > +        * Set the bus width(4 or 8) with host's support and
> > +        * switch to HS200 mode if bus width is set successfully.
> > +        */
> > +       err = mmc_select_bus_width(card);
> > +       if (!IS_ERR_VALUE(err)) {
> >                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > -                                EXT_CSD_HS_TIMING, 2, 0);
> > +                                EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS200,
> > +                                card->ext_csd.generic_cmd6_time);
> > +               if (!err) {
> > +                       mmc_card_set_hs200(card);
> > +                       mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> > +               }
> > +       }
> >  err:
> >         return err;
> >  }
> >
> >  /*
> > + * Activate High Speed or HS200 mode if supported.
> > + */
> > +static int mmc_select_timing(struct mmc_card *card)
> > +{
> > +       struct mmc_host *host;
> > +       int err = 0;
> > +
> > +       BUG_ON(!card);
> > +
> > +       host = card->host;
> > +
> > +       if ((card->csd.mmca_vsn < CSD_SPEC_VER_4 &&
> > +            card->ext_csd.hs_max_dtr == 0))
> > +               goto bus_speed;
> > +
> > +       if (card->ext_csd.hs200_max_dtr > 52000000 &&
> > +                       host->caps2 & MMC_CAP2_HS200)
> > +               err = mmc_select_hs200(card);
> > +       else if (host->caps & MMC_CAP_MMC_HIGHSPEED)
> > +               err = mmc_select_hs(card);
> > +
> > +       if (err && err != -EBADMSG)
> > +               return err;
> > +
> > +       if (err) {
> > +               pr_warn("%s: switch to %s failed\n",
> > +                       mmc_card_highspeed(card) ? "high-speed" :
> > +                       (mmc_card_hs200(card) ? "hs200" : ""),
> > +                       mmc_hostname(card->host));
> > +               err = 0;
> > +       }
> > +
> > +bus_speed:
> > +       /*
> > +        * Set the bus speed to the selected bus timing.
> > +        * If timing is not selected, backward compatible is the default.
> > +        */
> > +       mmc_set_bus_speed(card);
> > +       return err;
> > +}
> > +
> > +/*
> > + * Execute tuning sequence to seek the proper bus operating
> > + * conditions for HS200, which sends CMD21 to the device.
> > + */
> > +static int mmc_hs200_tuning(struct mmc_card *card)
> > +{
> > +       int err = 0;
> > +       struct mmc_host *host;
> > +
> > +       BUG_ON(!card);
> > +
> > +       host = card->host;
> > +
> > +       if (host->caps2 & MMC_CAP2_HS200 &&
> > +           card->host->ops->execute_tuning) {
> > +               mmc_host_clk_hold(card->host);
> > +               err = card->host->ops->execute_tuning(card->host,
> > +                               MMC_SEND_TUNING_BLOCK_HS200);
> > +               mmc_host_clk_release(card->host);
> > +
> > +               if (err)
> > +                       pr_warn("%s: tuning execution failed\n",
> > +                               mmc_hostname(card->host));
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +/*
> >   * Handle the detection and initialisation of a card.
> >   *
> >   * In the case of a resume, "oldcard" will contain the card
> > @@ -872,9 +1150,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >         struct mmc_card *oldcard)
> >  {
> >         struct mmc_card *card;
> > -       int err, ddr = 0;
> > +       int err;
> >         u32 cid[4];
> > -       unsigned int max_dtr;
> >         u32 rocr;
> >         u8 *ext_csd = NULL;
> >
> > @@ -1066,209 +1343,30 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >         }
> >
> >         /*
> > -        * Activate high speed (if supported)
> > -        */
> > -       if (card->ext_csd.hs_max_dtr != 0) {
> > -               err = 0;
> > -               if (card->ext_csd.hs_max_dtr > 52000000 &&
> > -                   host->caps2 & MMC_CAP2_HS200)
> > -                       err = mmc_select_hs200(card);
> > -               else if (host->caps & MMC_CAP_MMC_HIGHSPEED)
> > -                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > -                                        EXT_CSD_HS_TIMING, 1,
> > -                                        card->ext_csd.generic_cmd6_time);
> > -
> > -               if (err && err != -EBADMSG)
> > -                       goto free_card;
> > -
> > -               if (err) {
> > -                       pr_warning("%s: switch to highspeed failed\n",
> > -                              mmc_hostname(card->host));
> > -                       err = 0;
> > -               } else {
> > -                       if (card->ext_csd.hs_max_dtr > 52000000 &&
> > -                           host->caps2 & MMC_CAP2_HS200) {
> > -                               mmc_card_set_hs200(card);
> > -                               mmc_set_timing(card->host,
> > -                                              MMC_TIMING_MMC_HS200);
> > -                       } else {
> > -                               mmc_card_set_highspeed(card);
> > -                               mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> > -                       }
> > -               }
> > -       }
> > -
> > -       /*
> > -        * Compute bus speed.
> > -        */
> > -       max_dtr = (unsigned int)-1;
> > -
> > -       if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
> > -               if (max_dtr > card->ext_csd.hs_max_dtr)
> > -                       max_dtr = card->ext_csd.hs_max_dtr;
> > -               if (mmc_card_highspeed(card) && (max_dtr > 52000000))
> > -                       max_dtr = 52000000;
> > -       } else if (max_dtr > card->csd.max_dtr) {
> > -               max_dtr = card->csd.max_dtr;
> > -       }
> > -
> > -       mmc_set_clock(host, max_dtr);
> > -
> > -       /*
> > -        * Indicate DDR mode (if supported).
> > +        * Select timing interface
> >          */
> > -       if (mmc_card_highspeed(card)) {
> > -               if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
> > -                       && ((host->caps & (MMC_CAP_1_8V_DDR |
> > -                            MMC_CAP_UHS_DDR50))
> > -                               == (MMC_CAP_1_8V_DDR | MMC_CAP_UHS_DDR50)))
> > -                               ddr = MMC_1_8V_DDR_MODE;
> > -               else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
> > -                       && ((host->caps & (MMC_CAP_1_2V_DDR |
> > -                            MMC_CAP_UHS_DDR50))
> > -                               == (MMC_CAP_1_2V_DDR | MMC_CAP_UHS_DDR50)))
> > -                               ddr = MMC_1_2V_DDR_MODE;
> > -       }
> > +       err = mmc_select_timing(card);
> > +       if (err)
> > +               goto free_card;
> >
> > -       /*
> > -        * Indicate HS200 SDR mode (if supported).
> > -        */
> >         if (mmc_card_hs200(card)) {
> > -               u32 ext_csd_bits;
> > -               u32 bus_width = card->host->ios.bus_width;
> > -
> > -               /*
> > -                * For devices supporting HS200 mode, the bus width has
> > -                * to be set before executing the tuning function. If
> > -                * set before tuning, then device will respond with CRC
> > -                * errors for responses on CMD line. So for HS200 the
> > -                * sequence will be
> > -                * 1. set bus width 4bit / 8 bit (1 bit not supported)
> > -                * 2. switch to HS200 mode
> > -                * 3. set the clock to > 52Mhz <=200MHz and
> > -                * 4. execute tuning for HS200
> > -                */
> > -               if ((host->caps2 & MMC_CAP2_HS200) &&
> > -                   card->host->ops->execute_tuning) {
> > -                       mmc_host_clk_hold(card->host);
> > -                       err = card->host->ops->execute_tuning(card->host,
> > -                               MMC_SEND_TUNING_BLOCK_HS200);
> > -                       mmc_host_clk_release(card->host);
> > -               }
> > -               if (err) {
> > -                       pr_warning("%s: tuning execution failed\n",
> > -                                  mmc_hostname(card->host));
> > +               err = mmc_hs200_tuning(card);
> > +               if (err)
> >                         goto err;
> > +       } else if (mmc_card_highspeed(card)) {
> > +               /* Select the desired bus width optionally */
> > +               err = mmc_select_bus_width(card);
> > +               if (!IS_ERR_VALUE(err)) {
> > +                       err = mmc_select_hs_ddr(card, ext_csd);
> > +                       if (err)
> > +                               goto err;
> >                 }
> > -
> > -               ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
> > -                               EXT_CSD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
> > -               err = mmc_select_powerclass(card, ext_csd_bits);
> > -               if (err)
> > -                       pr_warning("%s: power class selection to bus width %d"
> > -                                  " failed\n", mmc_hostname(card->host),
> > -                                  1 << bus_width);
> >         }
> >
> >         /*
> > -        * Activate wide bus and DDR (if supported).
> > +        * Choose the power calss with selected bus interface
> >          */
> > -       if (!mmc_card_hs200(card) &&
> > -           (card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
> > -           (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
> > -               static unsigned ext_csd_bits[][2] = {
> > -                       { EXT_CSD_BUS_WIDTH_8, EXT_CSD_DDR_BUS_WIDTH_8 },
> > -                       { EXT_CSD_BUS_WIDTH_4, EXT_CSD_DDR_BUS_WIDTH_4 },
> > -                       { EXT_CSD_BUS_WIDTH_1, EXT_CSD_BUS_WIDTH_1 },
> > -               };
> > -               static unsigned bus_widths[] = {
> > -                       MMC_BUS_WIDTH_8,
> > -                       MMC_BUS_WIDTH_4,
> > -                       MMC_BUS_WIDTH_1
> > -               };
> > -               unsigned idx, bus_width = 0;
> > -
> > -               if (host->caps & MMC_CAP_8_BIT_DATA)
> > -                       idx = 0;
> > -               else
> > -                       idx = 1;
> > -               for (; idx < ARRAY_SIZE(bus_widths); idx++) {
> > -                       bus_width = bus_widths[idx];
> > -                       if (bus_width == MMC_BUS_WIDTH_1)
> > -                               ddr = 0; /* no DDR for 1-bit width */
> > -                       err = mmc_select_powerclass(card, ext_csd_bits[idx][0]);
> > -                       if (err)
> > -                               pr_warning("%s: power class selection to "
> > -                                          "bus width %d failed\n",
> > -                                          mmc_hostname(card->host),
> > -                                          1 << bus_width);
> > -
> > -                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > -                                        EXT_CSD_BUS_WIDTH,
> > -                                        ext_csd_bits[idx][0],
> > -                                        card->ext_csd.generic_cmd6_time);
> > -                       if (!err) {
> > -                               mmc_set_bus_width(card->host, bus_width);
> > -
> > -                               /*
> > -                                * If controller can't handle bus width test,
> > -                                * compare ext_csd previously read in 1 bit mode
> > -                                * against ext_csd at new bus width
> > -                                */
> > -                               if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
> > -                                       err = mmc_compare_ext_csds(card,
> > -                                               bus_width);
> > -                               else
> > -                                       err = mmc_bus_test(card, bus_width);
> > -                               if (!err)
> > -                                       break;
> > -                       }
> > -               }
> > -
> > -               if (!err && ddr) {
> > -                       err = mmc_select_powerclass(card, ext_csd_bits[idx][1]);
> > -                       if (err)
> > -                               pr_warning("%s: power class selection to "
> > -                                          "bus width %d ddr %d failed\n",
> > -                                          mmc_hostname(card->host),
> > -                                          1 << bus_width, ddr);
> > -
> > -                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > -                                        EXT_CSD_BUS_WIDTH,
> > -                                        ext_csd_bits[idx][1],
> > -                                        card->ext_csd.generic_cmd6_time);
> > -               }
> > -               if (err) {
> > -                       pr_warning("%s: switch to bus width %d ddr %d "
> > -                               "failed\n", mmc_hostname(card->host),
> > -                               1 << bus_width, ddr);
> > -                       goto free_card;
> > -               } else if (ddr) {
> > -                       /*
> > -                        * eMMC cards can support 3.3V to 1.2V i/o (vccq)
> > -                        * signaling.
> > -                        *
> > -                        * EXT_CSD_CARD_TYPE_DDR_1_8V means 3.3V or 1.8V vccq.
> > -                        *
> > -                        * 1.8V vccq at 3.3V core voltage (vcc) is not required
> > -                        * in the JEDEC spec for DDR.
> > -                        *
> > -                        * Do not force change in vccq since we are obviously
> > -                        * working and no change to vccq is needed.
> > -                        *
> > -                        * WARNING: eMMC rules are NOT the same as SD DDR
> > -                        */
> > -                       if (ddr == MMC_1_2V_DDR_MODE) {
> > -                               err = __mmc_set_signal_voltage(host,
> > -                                       MMC_SIGNAL_VOLTAGE_120);
> > -                               if (err)
> > -                                       goto err;
> > -                       }
> > -                       mmc_card_set_ddr_mode(card);
> > -                       mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
> > -                       mmc_set_bus_width(card->host, bus_width);
> > -               }
> > -       }
> > +       mmc_select_powerclass(card, ext_csd);
> >
> >         /*
> >          * Enable HPI feature (if supported)
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 176fdf8..c119735 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -63,6 +63,7 @@ struct mmc_ext_csd {
> >         unsigned int            power_off_longtime;     /* Units: ms */
> >         u8                      power_off_notification; /* state */
> >         unsigned int            hs_max_dtr;
> > +       unsigned int            hs200_max_dtr;
> >  #define MMC_HIGH_26_MAX_DTR    26000000
> >  #define MMC_HIGH_52_MAX_DTR    52000000
> >  #define MMC_HIGH_DDR_MAX_DTR   52000000
> > @@ -299,7 +300,10 @@ struct mmc_card {
> >         const char              **info;         /* info strings */
> >         struct sdio_func_tuple  *tuples;        /* unknown common tuples */
> >
> > -       unsigned int            sd_bus_speed;   /* Bus Speed Mode set for the card */
> > +       union {
> > +               unsigned int            sd_bus_speed;   /* Bus Speed Mode set for the card */
> > +               unsigned int            mmc_avail_type; /* supported device type by both host and card */
> > +       };
> >
> >         struct dentry           *debugfs_root;
> >         struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 99f5709..69d58b1 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -60,12 +60,6 @@ struct mmc_ios {
> >  #define MMC_TIMING_UHS_DDR50   7
> >  #define MMC_TIMING_MMC_HS200   8
> >
> > -#define MMC_SDR_MODE           0
> > -#define MMC_1_2V_DDR_MODE      1
> > -#define MMC_1_8V_DDR_MODE      2
> > -#define MMC_1_2V_SDR_MODE      3
> > -#define MMC_1_8V_SDR_MODE      4
> > -
> >         unsigned char   signal_voltage;         /* signalling voltage (1.8V or 3.3V) */
> >
> >  #define MMC_SIGNAL_VOLTAGE_330 0
> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> > index 50bcde3..87df508 100644
> > --- a/include/linux/mmc/mmc.h
> > +++ b/include/linux/mmc/mmc.h
> > @@ -373,6 +373,10 @@ struct _mmc_csd {
> >  #define EXT_CSD_DDR_BUS_WIDTH_4        5       /* Card is in 4 bit DDR mode */
> >  #define EXT_CSD_DDR_BUS_WIDTH_8        6       /* Card is in 8 bit DDR mode */
> >
> > +#define EXT_CSD_TIMING_BC      0       /* Backwards compatility */
> > +#define EXT_CSD_TIMING_HS      1       /* High speed */
> > +#define EXT_CSD_TIMING_HS200   2       /* HS200 */
> > +
> >  #define EXT_CSD_SEC_ER_EN      BIT(0)
> >  #define EXT_CSD_SEC_BD_BLK_EN  BIT(2)
> >  #define EXT_CSD_SEC_GB_CL_EN   BIT(4)
> > --
> > 1.7.0.4
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

