From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 02/15] mmc: core: Enable / disable re-tuning
Date: Fri, 17 Apr 2015 09:53:17 +0300
Message-ID: <5530ADDD.1030408@intel.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>	<1429017146-15981-3-git-send-email-adrian.hunter@intel.com>	<CAPDyKFpsBA+B3NbopfYQRgo+KKJpWsseo3bCJx-ToR5bOzJYUg@mail.gmail.com>	<552F805B.9080003@intel.com>	<CAPDyKFr_7giwZt76z3TnoqqJbQPBUJqRj1cepFR888FiseraGg@mail.gmail.com>	<552FB5AA.7010306@intel.com> <CAPDyKFrSQVzawd4rZZ=aidWRY8XdiWAbBr9usUP0sH8mwPmMNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22407 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbbDQGzZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Apr 2015 02:55:25 -0400
In-Reply-To: <CAPDyKFrSQVzawd4rZZ=aidWRY8XdiWAbBr9usUP0sH8mwPmMNQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 16/04/15 16:57, Ulf Hansson wrote:
> [...]
> 
>>>>> 2) system PM (disable?)
>>>>
>>>> System pm does mmc_power_off() which calls mmc_set_initial_state()
>>>
>>> At System PM other commands will be sent to put the card into sleep
>>> state. For example CMD5. These commands are invoked prior
>>> mmc_power_off() is called.
>>
>> You can't do *any* commands after CMD5 except CMD0 or another CMD5 to wake up.
>>
>> So if you want to wake-up from sleep, then you need to hold re-tuning, but
>> that is not what is happening at the moment.
> 
> So then we need to fix this.
> 
> Also, it seems like disabling the re-tuning timer would also be the
> proper thing to do, thus we should rather do disable instead of
> hold/release.

I can add hold/release. The hold should be done before sleeping
and the release after waking up. In this case there is no wake-up, instead
there is power-off, so the release can be done then.

Disabling before CMD5 is not the right thing to do because we might want to
re-tune before issuing CMD5.

> 
>>
>>>
>>> In the SDIO case, mmc_power_off() might not even be called at all,
>>> since SDIO func drivers might have enabled MMC_PM_KEEP_POWER.
>>
>> If the card is not going to be re-initialized then disabling is not necessary.
> 
> I don't want the re-tuning timer to be running, thus it seems like we
> should do disable. Right?

Re-tuning remains enabled while the card has a transfer mode that requires
it. Re-tuning is only done before a request so it doesn't need to be
disabled during suspend i.e. no requests implies no-retuning

I can add disabling the re-tuning timer, although the host does that too.

> 
>>
>>>
>>>>
>>>>> 3) runtime PM (disable?)
>>>>
>>>> If the card powers off then mmc_set_initial_state() will called.
>>>
>>> Again that's too late, since for example the CMD5 might have been sent
>>> before this.
>>
>> CMD5 is only used by _mmc_suspend()
>>
>> Yes if it were used elsewhere then re-tuning would have to be held, which is
>> why I added a comment before mmc_sleep()
>>
>>         /* If necessary, callers must hold re-tuning */
>>         static int mmc_sleep(struct mmc_host *host)
>>
> 
> I don't follow here. Why would we like to allow a re-tuning to be done
> in this part of the system PM phase? It doesn't make sense to me.

Because it is needed.

If re-tuning is needed and can be done, it is done. It doesn't need to be
more complicated than that.

> 
>>>
>>>>
>>>> For anything else the card might be doing, the mmc_retune_hold() /
>>>> mmc_retune_release() functions are used.
>>>>
>>>>> 4) reset (?)
>>>>
>>>> Reset goes through mmc_set_initial_state()
>>>
>>> In the mmc case, CMD13 is sent prior that. Shouldn't we hold re-tune
>>> during that period?
>>
>> If reset happens, then the next command will fail, whether it is re-tuning
>> or CMD13, so no different.
> 
> That depends on how each an every host has implemented their tuning mechanism.

No it doesn't. Tuning either succeeds or fails. When there is no card, if it
fails then the CMD13 is not needed, and if it succeeds then CMD13 will fail.

> 
> CMD13 is more light weight, so I believe we should hold re-tune to
> make sure we do the CMD13 and fail quickly.

If re-tuning is needed and can be done, it is done. It doesn't need to be
more complicated than that.

> 
>>
>> If reset doesn't happen, then it is no different to normal operations.
>>

