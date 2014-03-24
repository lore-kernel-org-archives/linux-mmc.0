From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 4/5] mmc: rework selection of bus speed mode
Date: Mon, 24 Mar 2014 14:11:37 +0100
Message-ID: <CAPDyKFq0GHo9Mj6Ev9g2Cy59Qja9a_wWdYWtmAhb73o7N2EA5g@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006b01cf2a59$a203d5d0$e60b8170$%jun@samsung.com>
	<003e01cf3f7f$43eb8a20$cbc29e60$%jun@samsung.com>
	<CAPDyKFoHR1Re6a3fpc0rCvx2jiXDQotU2wA7wSHiTQeWEguoxA@mail.gmail.com>
	<003301cf45c6$d4d42db0$7e7c8910$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:53038 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbaCXNLh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Mar 2014 09:11:37 -0400
Received: by mail-qg0-f44.google.com with SMTP id a108so16518936qge.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Mar 2014 06:11:37 -0700 (PDT)
In-Reply-To: <003301cf45c6$d4d42db0$7e7c8910$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Jackey Shen <jackey.shen@amd.com>, Alim Akhtar <alim.akhtar@samsung.com>

On 22 March 2014 13:04, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Fri, March 21, 2014, Ulf Hansson wrote:
>> On 14 March 2014 13:16, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> > Current implementation for bus speed mode selection is too
>> > complicated. This patch is to simplify the codes and remove
>> > some duplicate parts.
>>
>> Really appreciate you taking on this task!
>>
>> >
>> > The following changes are including:
>> > * Adds functions for each mode selection(HS, HS-DDR, HS200 and etc)
>> > * Rearranged the mode selection sequence with supported device type
>> > * Adds maximum speed for HS200 mode(hs200_max_dtr)
>> > * Adds field definition for HS_TIMING of EXT_CSD
>> >
>> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> > Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
>> > Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>> > ---
>> >  drivers/mmc/core/debugfs.c |    2 +-
>> >  drivers/mmc/core/mmc.c     |  431 ++++++++++++++++++++++++--------------------
>> >  include/linux/mmc/card.h   |    1 +
>> >  include/linux/mmc/mmc.h    |    4 +
>> >  4 files changed, 238 insertions(+), 200 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> > index 509229b..1f730db 100644
>> > --- a/drivers/mmc/core/debugfs.c
>> > +++ b/drivers/mmc/core/debugfs.c
>> > @@ -139,7 +139,7 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>> >                 str = "mmc DDR52";
>> >                 break;
>> >         case MMC_TIMING_MMC_HS200:
>> > -               str = "mmc high-speed SDR200";
>> > +               str = "mmc HS200";
>> >                 break;
>> >         default:
>> >                 str = "invalid";
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 480c100..6dd68e6 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -242,7 +242,7 @@ static void mmc_select_card_type(struct mmc_card *card)
>> >         struct mmc_host *host = card->host;
>> >         u8 card_type = card->ext_csd.raw_card_type & EXT_CSD_CARD_TYPE_MASK;
>> >         u32 caps = host->caps, caps2 = host->caps2;
>> > -       unsigned int hs_max_dtr = 0;
>> > +       unsigned int hs_max_dtr = 0, hs200_max_dtr = 0;
>> >         unsigned int avail_type = 0;
>> >
>> >         if (caps & MMC_CAP_MMC_HIGHSPEED &&
>> > @@ -271,17 +271,18 @@ static void mmc_select_card_type(struct mmc_card *card)
>> >
>> >         if (caps2 & MMC_CAP2_HS200_1_8V_SDR &&
>> >             card_type & EXT_CSD_CARD_TYPE_HS200_1_8V) {
>> > -               hs_max_dtr = MMC_HS200_MAX_DTR;
>> > +               hs200_max_dtr = MMC_HS200_MAX_DTR;
>> >                 avail_type |= EXT_CSD_CARD_TYPE_HS200_1_8V;
>> >         }
>> >
>> >         if (caps2 & MMC_CAP2_HS200_1_2V_SDR &&
>> >             card_type & EXT_CSD_CARD_TYPE_HS200_1_2V) {
>> > -               hs_max_dtr = MMC_HS200_MAX_DTR;
>> > +               hs200_max_dtr = MMC_HS200_MAX_DTR;
>> >                 avail_type |= EXT_CSD_CARD_TYPE_HS200_1_2V;
>> >         }
>> >
>> >         card->ext_csd.hs_max_dtr = hs_max_dtr;
>> > +       card->ext_csd.hs200_max_dtr = hs200_max_dtr;
>> >         card->mmc_avail_type = avail_type;
>> >  }
>> >
>> > @@ -833,37 +834,46 @@ static int mmc_select_powerclass(struct mmc_card *card)
>> >  }
>> >
>> >  /*
>> > - * Selects the desired buswidth and switch to the HS200 mode
>> > - * if bus width set without error
>> > + * Set the bus speed for the selected speed mode.
>> >   */
>> > -static int mmc_select_hs200(struct mmc_card *card)
>> > +static void mmc_set_bus_speed(struct mmc_card *card)
>> > +{
>> > +       unsigned int max_dtr = (unsigned int)-1;
>>
>> I guess this is to silence compile warnings? Why not just:
>> unsigned int max_dtr = 0;
> Basically, I made an effort to keep the previous codes if it's not a problem.
> If you found something wrong, please let me know.

Got it, let's keep it as is then!

>
>>
>> > +
>> > +       if (mmc_card_hs200(card) && max_dtr > card->ext_csd.hs200_max_dtr)
>> > +               max_dtr = card->ext_csd.hs200_max_dtr;
>> > +       else if (mmc_card_hs(card) && max_dtr > card->ext_csd.hs_max_dtr)
>> > +               max_dtr = card->ext_csd.hs_max_dtr;
>> > +       else if (max_dtr > card->csd.max_dtr)
>> > +               max_dtr = card->csd.max_dtr;
>> > +
>> > +       mmc_set_clock(card->host, max_dtr);
>> > +}
>> > +
>> > +/*
>> > + * Select the bus width amoung 4-bit and 8-bit(SDR).
>> > + * If the bus width is changed successfully, return the slected width value.
>> > + * Zero is returned instead of error value if the wide width is not supported.
>> > + */
>> > +static int mmc_select_bus_width(struct mmc_card *card)
>> >  {
>> > -       int idx, err = -EINVAL;
>> > -       struct mmc_host *host;
>> >         static unsigned ext_csd_bits[] = {
>> > -               EXT_CSD_BUS_WIDTH_4,
>> >                 EXT_CSD_BUS_WIDTH_8,
>> > +               EXT_CSD_BUS_WIDTH_4,
>> >         };
>> >         static unsigned bus_widths[] = {
>> > -               MMC_BUS_WIDTH_4,
>> >                 MMC_BUS_WIDTH_8,
>> > +               MMC_BUS_WIDTH_4,
>> >         };
>>
>> Do we really need to keep these arrays? The only contain only two values.
>>
>> Can't we just try with 8-bit, if supported, and if it fails try with
>> 4-bit. Would that further simplify the code?
> Yes, current implementation does that.
> First,  it tries with 8-bit if supported, and if failed, it will be tried with 4-bit.
> And I think using array can make simple retry coding if considering failure case.
> I intended to keep original way.

I understand you want to make as small changes as possible, that's
good. So let's keep this as is then.

If we want to change this, we can do that in a follow up patch instead.

>
>>
>> Overall looks good to me, besides the minor comments above.
>>
>> Since this kind of touches quite old code, I would appreciate if it
>> could go though some more testing in linux next, thus it's material
>> for early queueing to 3.16.
>>
>> But before we go on, I would like to know if you managed to test all
>> the different variants of buswidth/speedmode and the bus width test?
>> If there is any specific test would like to get help to run, just tell
>> me.
>>
>> Nice work!
> It would be nice if it's picked for 3.15.
> As I mentioned above, I basically kept the original flow and way.

I leave the decision to Chris. Still I think some more testing in
linux-next would be nice.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

>
> This change applies only to eMMC type and participates only in card initialization's process.
> I tested on the following various mode and detection is performed successfully.
>
> - HS400 w/ 8-bit
> - HS400 w/ 4-bit        : HS200 mode is selected(Because HS400 is possible with 8-bit)
> - HS200 w/ 4-bit or 8-bit
> - DDR52 w/ 4-bit or 8-bit
> - High speed    w/ 1-bit, 4-bit or 8-bit
> - Backwards     w/ 1-bit, 4-bit or 8-bit
>
> I really appreciate your deep reviews.
>
> Thanks,
> Seungwon Jeon
>
