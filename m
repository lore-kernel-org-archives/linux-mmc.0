From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/5] mmc: step power class after final selection of bus mode
Date: Fri, 14 Mar 2014 08:31:04 +0100
Message-ID: <CAPDyKFqbnncOD3Xp6qsPu184sX9WLfCjiJQ1Z1hskUHS+HHCVQ@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006a01cf2a59$863f6030$92be2090$%jun@samsung.com>
	<003d01cf3a12$9eedf150$dcc9d3f0$%jun@samsung.com>
	<CAPDyKFrPLdGbSwB=ZfodivYKwywQkhc=SrSrDrVQX4GR_oHd9g@mail.gmail.com>
	<002201cf3f30$09d94dd0$1d8be970$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:58950 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133AbaCNHbG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Mar 2014 03:31:06 -0400
Received: by mail-qc0-f171.google.com with SMTP id x13so2463518qcv.30
        for <linux-mmc@vger.kernel.org>; Fri, 14 Mar 2014 00:31:04 -0700 (PDT)
In-Reply-To: <002201cf3f30$09d94dd0$1d8be970$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Jackey Shen <jackey.shen@amd.com>, Alim Akhtar <alim.akhtar@samsung.com>

On 14 March 2014 03:49, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Thu, March 13, 2014, Ulf Hansson wrote:
>> On 7 March 2014 15:36, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> > Power class is changed once only after selection of bus modes
>> > including speed and bus-width finishes finally.
>> >
>> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> > ---
>> > Changes in v2:
>> >         Cleaned up some unnecessary codes.
>> >
>> >  drivers/mmc/core/mmc.c |   94 +++++++++++++++++++++++++++--------------------
>> >  1 files changed, 54 insertions(+), 40 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 0abece0..88ff217 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -737,17 +737,13 @@ static inline unsigned int mmc_snoop_ddr(struct mmc_card *card)
>> >   * extended CSD register, select it by executing the
>> >   * mmc_switch command.
>> >   */
>> > -static int mmc_select_powerclass(struct mmc_card *card,
>> > -               unsigned int bus_width)
>> > +static int __mmc_select_powerclass(struct mmc_card *card,
>> > +                                  unsigned int bus_width)
>> >  {
>> >         int err = 0;
>> >         unsigned int pwrclass_val = 0;
>> > -       struct mmc_host *host;
>> > -
>> > -       BUG_ON(!card);
>> > -
>> > -       host = card->host;
>> > -       BUG_ON(!host);
>> > +       struct mmc_host *host = card->host;
>> > +       struct mmc_ext_csd *ext_csd = &card->ext_csd;
>> >
>> >         /* Power class selection is supported for versions >= 4.0 */
>> >         if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
>> > @@ -759,14 +755,14 @@ static int mmc_select_powerclass(struct mmc_card *card,
>> >
>> >         switch (1 << host->ios.vdd) {
>> >         case MMC_VDD_165_195:
>> > -               if (host->ios.clock <= 26000000)
>> > -                       pwrclass_val = card->ext_csd.raw_pwr_cl_26_195;
>> > -               else if (host->ios.clock <= 52000000)
>> > +               if (host->ios.clock <= MMC_HIGH_26_MAX_DTR)
>> > +                       pwrclass_val = ext_csd->raw_pwr_cl_26_195;
>> > +               else if (host->ios.clock <= MMC_HIGH_52_MAX_DTR)
>> >                         pwrclass_val = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
>> > -                               card->ext_csd.raw_pwr_cl_52_195 :
>> > -                               card->ext_csd.raw_pwr_cl_ddr_52_195;
>> > -               else if (host->ios.clock <= 200000000)
>> > -                       pwrclass_val = card->ext_csd.raw_pwr_cl_200_195;
>> > +                               ext_csd->raw_pwr_cl_52_195 :
>> > +                               ext_csd->raw_pwr_cl_ddr_52_195;
>> > +               else if (host->ios.clock <= MMC_HS200_MAX_DTR)
>> > +                       pwrclass_val = ext_csd->raw_pwr_cl_200_195;
>> >                 break;
>> >         case MMC_VDD_27_28:
>> >         case MMC_VDD_28_29:
>> > @@ -777,14 +773,14 @@ static int mmc_select_powerclass(struct mmc_card *card,
>> >         case MMC_VDD_33_34:
>> >         case MMC_VDD_34_35:
>> >         case MMC_VDD_35_36:
>> > -               if (host->ios.clock <= 26000000)
>> > -                       pwrclass_val = card->ext_csd.raw_pwr_cl_26_360;
>> > -               else if (host->ios.clock <= 52000000)
>> > +               if (host->ios.clock <= MMC_HIGH_26_MAX_DTR)
>> > +                       pwrclass_val = ext_csd->raw_pwr_cl_26_360;
>> > +               else if (host->ios.clock <= MMC_HIGH_52_MAX_DTR)
>> >                         pwrclass_val = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
>> > -                               card->ext_csd.raw_pwr_cl_52_360 :
>> > -                               card->ext_csd.raw_pwr_cl_ddr_52_360;
>> > -               else if (host->ios.clock <= 200000000)
>> > -                       pwrclass_val = card->ext_csd.raw_pwr_cl_200_360;
>> > +                               ext_csd->raw_pwr_cl_52_360 :
>> > +                               ext_csd->raw_pwr_cl_ddr_52_360;
>> > +               else if (host->ios.clock <= MMC_HS200_MAX_DTR)
>> > +                       pwrclass_val = ext_csd->raw_pwr_cl_200_360;
>> >                 break;
>> >         default:
>> >                 pr_warning("%s: Voltage range not supported "
>> > @@ -810,6 +806,37 @@ static int mmc_select_powerclass(struct mmc_card *card,
>> >         return err;
>> >  }
>> >
>> > +static int mmc_select_powerclass(struct mmc_card *card)
>> > +{
>> > +       int err, ddr;
>> > +       u32 bus_width, ext_csd_bits;
>> > +       struct mmc_host *host = card->host;
>> > +
>> > +       /* Power class selection is supported for versions >= 4.0 */
>> > +       if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
>> > +               return 0;
>> > +
>> > +       bus_width = host->ios.bus_width;
>> > +       /* Power class values are defined only for 4/8 bit bus */
>> > +       if (bus_width == MMC_BUS_WIDTH_1)
>> > +               return 0;
>> > +
>> > +       ddr = mmc_snoop_ddr(card);
>> > +       if (ddr)
>> > +               ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
>> > +                       EXT_CSD_DDR_BUS_WIDTH_8 : EXT_CSD_DDR_BUS_WIDTH_4;
>> > +       else
>> > +               ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
>> > +                       EXT_CSD_BUS_WIDTH_8 :  EXT_CSD_BUS_WIDTH_4;
>> > +
>> > +       err = __mmc_select_powerclass(card, ext_csd_bits);
>> > +       if (err)
>> > +               pr_warn("%s: power class selection to bus width %d ddr %d failed\n",
>> > +                       mmc_hostname(host), 1 << bus_width, ddr);
>> > +
>> > +       return err;
>> > +}
>> > +
>> >  /*
>> >   * Selects the desired buswidth and switch to the HS200 mode
>> >   * if bus width set without error
>> > @@ -1171,11 +1198,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >
>> >                 ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
>> >                                 EXT_CSD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
>> > -               err = mmc_select_powerclass(card, ext_csd_bits);
>> > -               if (err)
>> > -                       pr_warning("%s: power class selection to bus width %d"
>> > -                                  " failed\n", mmc_hostname(card->host),
>> > -                                  1 << bus_width);
>> >         }
>> >
>> >         /*
>> > @@ -1204,12 +1226,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >                         bus_width = bus_widths[idx];
>> >                         if (bus_width == MMC_BUS_WIDTH_1)
>> >                                 ddr = 0; /* no DDR for 1-bit width */
>> > -                       err = mmc_select_powerclass(card, ext_csd_bits[idx][0]);
>> > -                       if (err)
>> > -                               pr_warning("%s: power class selection to "
>> > -                                          "bus width %d failed\n",
>> > -                                          mmc_hostname(card->host),
>> > -                                          1 << bus_width);
>> >
>> >                         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> >                                          EXT_CSD_BUS_WIDTH,
>> > @@ -1234,13 +1250,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >                 }
>> >
>> >                 if (!err && ddr) {
>> > -                       err = mmc_select_powerclass(card, ext_csd_bits[idx][1]);
>> > -                       if (err)
>> > -                               pr_warning("%s: power class selection to "
>> > -                                          "bus width %d ddr %d failed\n",
>> > -                                          mmc_hostname(card->host),
>> > -                                          1 << bus_width, ddr);
>> > -
>> >                         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> >                                          EXT_CSD_BUS_WIDTH,
>> >                                          ext_csd_bits[idx][1],
>> > @@ -1278,6 +1287,11 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>> >         }
>> >
>> >         /*
>> > +        * Choose the power calss with selected bus interface
>>
>> One line of comment is enough.
>>
>> "calss" -> "class".
> OK.
>
>>
>> > +        */
>> > +       mmc_select_powerclass(card);
>> > +
>> > +       /*
>> >          * Enable HPI feature (if supported)
>> >          */
>> >         if (card->ext_csd.hpi) {
>> > --
>> > 1.7.0.4
>> >
>> >
>>
>> You should run checkpatch as well.
> It think there was no warning & error in 3/5.
> Ok. Let me check more.
>

You are right, this patch didn't have checkpatch warnings or errors,
but some of the other in this patchset had. Sorry.

Kind regards
Ulf Hansson

>>
>> Besides these minor things, looks good - nice clean up!
>
> Thanks,
> Seungwon Jeon
>>
>> Kind regards
>> Ulf Hansson
>
