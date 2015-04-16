From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 02/15] mmc: core: Enable / disable re-tuning
Date: Thu, 16 Apr 2015 15:57:39 +0200
Message-ID: <CAPDyKFrSQVzawd4rZZ=aidWRY8XdiWAbBr9usUP0sH8mwPmMNQ@mail.gmail.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
	<1429017146-15981-3-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpsBA+B3NbopfYQRgo+KKJpWsseo3bCJx-ToR5bOzJYUg@mail.gmail.com>
	<552F805B.9080003@intel.com>
	<CAPDyKFr_7giwZt76z3TnoqqJbQPBUJqRj1cepFR888FiseraGg@mail.gmail.com>
	<552FB5AA.7010306@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35415 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933571AbbDPN5k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2015 09:57:40 -0400
Received: by qkhg7 with SMTP id g7so132523451qkh.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2015 06:57:39 -0700 (PDT)
In-Reply-To: <552FB5AA.7010306@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

[...]

>>>> 2) system PM (disable?)
>>>
>>> System pm does mmc_power_off() which calls mmc_set_initial_state()
>>
>> At System PM other commands will be sent to put the card into sleep
>> state. For example CMD5. These commands are invoked prior
>> mmc_power_off() is called.
>
> You can't do *any* commands after CMD5 except CMD0 or another CMD5 to wake up.
>
> So if you want to wake-up from sleep, then you need to hold re-tuning, but
> that is not what is happening at the moment.

So then we need to fix this.

Also, it seems like disabling the re-tuning timer would also be the
proper thing to do, thus we should rather do disable instead of
hold/release.

>
>>
>> In the SDIO case, mmc_power_off() might not even be called at all,
>> since SDIO func drivers might have enabled MMC_PM_KEEP_POWER.
>
> If the card is not going to be re-initialized then disabling is not necessary.

I don't want the re-tuning timer to be running, thus it seems like we
should do disable. Right?

>
>>
>>>
>>>> 3) runtime PM (disable?)
>>>
>>> If the card powers off then mmc_set_initial_state() will called.
>>
>> Again that's too late, since for example the CMD5 might have been sent
>> before this.
>
> CMD5 is only used by _mmc_suspend()
>
> Yes if it were used elsewhere then re-tuning would have to be held, which is
> why I added a comment before mmc_sleep()
>
>         /* If necessary, callers must hold re-tuning */
>         static int mmc_sleep(struct mmc_host *host)
>

I don't follow here. Why would we like to allow a re-tuning to be done
in this part of the system PM phase? It doesn't make sense to me.

>>
>>>
>>> For anything else the card might be doing, the mmc_retune_hold() /
>>> mmc_retune_release() functions are used.
>>>
>>>> 4) reset (?)
>>>
>>> Reset goes through mmc_set_initial_state()
>>
>> In the mmc case, CMD13 is sent prior that. Shouldn't we hold re-tune
>> during that period?
>
> If reset happens, then the next command will fail, whether it is re-tuning
> or CMD13, so no different.

That depends on how each an every host has implemented their tuning mechanism.

CMD13 is more light weight, so I believe we should hold re-tune to
make sure we do the CMD13 and fail quickly.

>
> If reset doesn't happen, then it is no different to normal operations.
>

Kind regards
Uffe
