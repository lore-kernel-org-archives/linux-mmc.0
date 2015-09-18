From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
Date: Fri, 18 Sep 2015 17:40:46 +0800
Message-ID: <CAGsJ_4zaWcmGsc82=LSohK0UHxJir2OJOBSgoU3sPRXYvLdOZQ@mail.gmail.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
 <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
 <CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
 <CAPDyKFpEwWvu3tnbMT9ZvM0TUvEHp0Qa8PADohyJoTaNZ9HS9g@mail.gmail.com>
 <CAGsJ_4x5Nd3Cts1BHsUyB_mCejxbHPPjznUVWUcFoZhxKy+Tcg@mail.gmail.com> <CAPDyKFpWfY9G4WG_GfCutJ2NkRbcAYZToYJXp3RvX=_25sgnWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:33406 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbbIRJlH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Sep 2015 05:41:07 -0400
Received: by lamp12 with SMTP id p12so26625365lam.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Sep 2015 02:41:06 -0700 (PDT)
In-Reply-To: <CAPDyKFpWfY9G4WG_GfCutJ2NkRbcAYZToYJXp3RvX=_25sgnWA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

2015-09-17 20:27 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 15 September 2015 at 09:13, Barry Song <21cnbao@gmail.com> wrote:
>> 2015-08-25 20:05 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>>> On 20 August 2015 at 02:16, Barry Song <21cnbao@gmail.com> wrote:
>>>> 2015-08-18 1:11 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>>>>> On 11 August 2015 at 10:41, Barry Song <21cnbao@gmail.com> wrote:
>>>>>> From: Weijun Yang <york.yang@csr.com>
>>>>>>
>>>>>> As SD Specifications Part1 Physical Layer Specification Version
>>>>>> 3.01 says, CMD19 tuning is available for unlocked cards in transfer
>>>>>> state of 1.8V signaling mode. The small difference between v3.00
>>>>>> and 3.01 spec means that CMD19 tuning is also available for DDR50
>>>>>> mode.
>>>>>
>>>>> So what happens with cards following the 3.0 spec version, those
>>>>> doesn't need to support the tuning CMD right? Perhaps that needs to be
>>>>> addressed in this patch well!?
>>>>
>>>> from HW registers of the card, we cann't know whether the HW needs
>>>> tuning. it is said 3.0.x need tuning, but 3.0 doesn't need.  @weijun,
>>>> pls fix me if i am wrong.
>>>> if so, it seems we need a static flag somewhere to indicate whether
>>>> the tuning is needed. we can't detect to find the tuning requirement.
>>>
>>> Another way is to always try doing the tuning for DDR50, but in case
>>> of errors just ignore them and print a debug/info message!?
>>
>> Uffe, do you mean something like below:
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 4e7366a..d4df9f0 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -629,8 +629,23 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>>       */
>>      if (!mmc_host_is_spi(card->host) &&
>>          (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
>> -         card->sd_bus_speed == UHS_SDR104_BUS_SPEED))
>> +         card->sd_bus_speed == UHS_DDR50_BUS_SPEED ||
>> +         card->sd_bus_speed == UHS_SDR104_BUS_SPEED)) {
>>          err = mmc_execute_tuning(card);
>> +
>> +        /*
>> +         * As SD Specifications Part1 Physical Layer Specification Version
>> +         * 3.01 says, CMD19 tuning is available for unlocked cards in transfer
>> +         * state of 1.8V signaling mode. The small difference between v3.00
>> +         * and 3.01 spec means that CMD19 tuning is also available for DDR50
>> +         * mode.
>> +         */
>> +        if (err && (card->sd_bus_speed == UHS_DDR50_BUS_SPEED))
>> +            pr_err("%s: ddr50 tuning failed\n", mmc_hostname(card->host));
>
> Perhaps pr_warn() instead.
>
> Moreover, you may just assign err = 0 and leave the return/kfree to
> the "out" label.
>
>> +            kfree(status);
>> +            return 0;
>> +        }
>> +    }
>>  out:
>>      kfree(status);
>>
>
> [...]
>
> Also, I was giving this a second thought...
>
> What happens with the SD 3.0 card when it *doesn't* support CMD19.
> Will it still be functional afterwards or will it move from "transfer
> state" to another not known state?

uffe, i am not the expert of this issue but weijun is. weijun told that
for the cards who don't support cmd19, it will take it as illegal
command and not response it. and it also sets illegal command error in
registers.
but the card status is still functional and doesn't cause unknown state.

so maybe we can just ignore the err of tuning, and use the second
patch with the refine you mentioned?

>
> So maybe we should just do the tuning and return the error if it
> fails, as you suggested in the original patch. :-)
>
> Kind regards
> Uffe

-barry
