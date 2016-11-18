From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 8/9] mmc: core: Allow CMD13 polling when switch to HS400 mode
Date: Fri, 18 Nov 2016 13:59:54 +0100
Message-ID: <CAPDyKFrEBsNK+TvjDMw8twKtSrqPOjanFrhUWfJjDqOe1SMbug@mail.gmail.com>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
 <1479293481-20186-9-git-send-email-ulf.hansson@linaro.org> <5b69bb3b-ede3-753c-e261-89e51ca0e43d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33523 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753286AbcKRM75 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 07:59:57 -0500
Received: by mail-wm0-f52.google.com with SMTP id c184so5514392wmd.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 04:59:56 -0800 (PST)
In-Reply-To: <5b69bb3b-ede3-753c-e261-89e51ca0e43d@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ziyuan Xu <xzy.xu@rock-chips.com>

On 18 November 2016 at 13:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 16/11/16 12:51, Ulf Hansson wrote:
>> In cases when the mmc host doesn't support HW busy detection, polling for
>> busy by using CMD13 is beneficial. The reasons have already been explained
>> in earlier change logs.
>>
>> Moreover, when polling with CMD13 during bus timing changes, we should
>> retry instead of fail when we get CRC errors.
>>
>> Switching from HS200 to HS400 and reverse includes several steps, where
>> each step changes the bus speed timing. Let's improve the behaviour during
>> these sequences, by allowing CMD13 polling for each of the step. Let's also
>> make sure the CMD13 polling becomes retried, while receiving a CRC error.
>
> I don't know we need to try to get polling for HS400.  The support of HS400
> suggests a relatively sophisticated host controller which really should
> support busy waiting as well.

That's a reasonable argument.

Moreover, I do also think that argument stands for a controller
supporting HS200. So I have no problem dropping the CMD13 polling
support for that bus speed mode as well, if people wants that.

>
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/mmc.c | 87 +++++++++++++++-----------------------------------
>>  1 file changed, 26 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 0b26383..24b9e72 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1094,8 +1094,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>>  static int mmc_select_hs400(struct mmc_card *card)
>>  {
>>       struct mmc_host *host = card->host;
>> -     unsigned int max_dtr;
>> -     int err = 0;
>> +     int err;
>>       u8 val;
>>
>>       /*
>> @@ -1105,34 +1104,26 @@ static int mmc_select_hs400(struct mmc_card *card)
>>             host->ios.bus_width == MMC_BUS_WIDTH_8))
>>               return 0;
>>
>> -     /* Switch card to HS mode */
>> -     val = EXT_CSD_TIMING_HS;
>> -     err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> -                        EXT_CSD_HS_TIMING, val,
>> -                        card->ext_csd.generic_cmd6_time, 0,
>> -                        true, false, true);
>> +     /*
>> +      * Switch card to HS mode.
>> +      * First reduce to the HS frequency as CMD13 are sent to poll for busy
>> +      * and/or to validate the switch status.
>> +      */
>> +     mmc_set_clock(host, card->ext_csd.hs_max_dtr);
>
> That was moved by commit 649c6059d2371fef886a8f967e21416204723d63
> ("mmc: mmc: Fix HS switch failure in mmc_select_hs400()") i.e. if you put it
> back I would expect the gru board problem to reappear.

Correct, thanks for pointing it out!

According to below comments, it's clear that the JEDEC spec lacks a
good description of the HS200/400 switch behaviour.

>
>> +     err = mmc_select_hs(card);
>>       if (err) {
>>               pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
>>                       mmc_hostname(host), err);
>>               return err;
>>       }
>>
>> -     /* Set host controller to HS timing */
>> -     mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>> -
>> -     /* Reduce frequency to HS frequency */
>> -     max_dtr = card->ext_csd.hs_max_dtr;
>> -     mmc_set_clock(host, max_dtr);
>> -
>> -     err = mmc_switch_status(card);
>> -     if (err)
>> -             goto out_err;
>> -
>> -     /* Switch card to DDR */
>> -     err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> -                      EXT_CSD_BUS_WIDTH,
>> -                      EXT_CSD_DDR_BUS_WIDTH_8,
>> -                      card->ext_csd.generic_cmd6_time);
>> +     /* Switch card to HS DDR */
>> +     err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +                        EXT_CSD_BUS_WIDTH,
>> +                        EXT_CSD_DDR_BUS_WIDTH_8,
>> +                        card->ext_csd.generic_cmd6_time,
>> +                        MMC_TIMING_MMC_DDR52,
>> +                        true, true, true);
>>       if (err) {
>>               pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
>>                       mmc_hostname(host), err);
>> @@ -1144,28 +1135,17 @@ static int mmc_select_hs400(struct mmc_card *card)
>>             card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>>       err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>                          EXT_CSD_HS_TIMING, val,
>> -                        card->ext_csd.generic_cmd6_time, 0,
>> -                        true, false, true);
>> +                        card->ext_csd.generic_cmd6_time,
>> +                        MMC_TIMING_MMC_HS400,
>> +                        true, true, true);
>
> This is not exactly right.  Tuning has been done at the HS400 operating
> frequency.  That is why we set the bus speed before sending any more
> commands. i.e. mmc_switch_status(card) is below mmc_set_bus_speed(card)

Right, I see!

I had another look at the JEDEC spec for HS400 mode switch:

---
6) Perform the Tuning Process at the HS400 target operating frequency,
NOTE Tuning process in HS200 mode is required to synchronize the
command response on the CMD line to CLK for HS400 operation.
---

This confirms your point. Although on the other hand by looking at the
HS400 switch flow chart, it says that checking the switch status shall
be done *before* bumping the clock rate. :-)

Anyway, I will move back to the behaviour where CMD13 polling is not
allowed for HS400, as that seems like the only thing we can do!

Kind regards
Uffe
