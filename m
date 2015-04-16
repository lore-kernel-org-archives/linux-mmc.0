From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 02/15] mmc: core: Enable / disable re-tuning
Date: Thu, 16 Apr 2015 14:00:27 +0200
Message-ID: <CAPDyKFr_7giwZt76z3TnoqqJbQPBUJqRj1cepFR888FiseraGg@mail.gmail.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
	<1429017146-15981-3-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpsBA+B3NbopfYQRgo+KKJpWsseo3bCJx-ToR5bOzJYUg@mail.gmail.com>
	<552F805B.9080003@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:35404 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbbDPMA2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2015 08:00:28 -0400
Received: by qcbii10 with SMTP id ii10so4560774qcb.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2015 05:00:28 -0700 (PDT)
In-Reply-To: <552F805B.9080003@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 16 April 2015 at 11:26, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 16/04/15 11:57, Ulf Hansson wrote:
>> On 14 April 2015 at 15:12, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> Enable re-tuning when tuning is executed and
>>> disable re-tuning when card is no longer initialized.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>  drivers/mmc/core/core.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index c296bc0..dd43f9b 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1109,6 +1109,8 @@ int mmc_execute_tuning(struct mmc_card *card)
>>>
>>>         if (err)
>>>                 pr_err("%s: tuning execution failed\n", mmc_hostname(host));
>>> +       else
>>> +               mmc_retune_enable(host);
>>>
>>>         return err;
>>>  }
>>> @@ -1140,6 +1142,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>>>   */
>>>  void mmc_set_initial_state(struct mmc_host *host)
>>>  {
>>> +       mmc_retune_disable(host);
>>> +
>>>         if (mmc_host_is_spi(host))
>>>                 host->ios.chip_select = MMC_CS_HIGH;
>>>         else
>>> --
>>> 1.9.1
>>
>> I don't think you have fully considered these cases for the mmc/sd/sdio cards.
>
> Thanks for look at this, but I don't see a problem - see below.
>
>>
>> 1) Card removal/detect (hold/release?)
>
> Re-tuning will be done if needed before detect (because it is done before a
> request), which is necessary because detect can fail if tuning is needed.
>
> Re-tuning is done before a request. Requests aren't started if the card has
> been removed i.e. mmc_start_request() calls mmc_card_removed()
>
> If tuning is executed while a card is being removed, then the tuning will
> fail and the request will be errored out.

So you are saying that we instead of relying on the CMD13 (for SD/MMC)
to check whether the card is still alive, it's fine to trigger a
re-tuning instead.

I don't think that is an effective way to remove a card.

Moreover, I find it quite unreasonable to say the check for an alive
card, would fail because of that a re-tuning is needed. That would in
principle mean that we never should be able to hold re-tune for any
commands sequences.

>
>> 2) system PM (disable?)
>
> System pm does mmc_power_off() which calls mmc_set_initial_state()

At System PM other commands will be sent to put the card into sleep
state. For example CMD5. These commands are invoked prior
mmc_power_off() is called.

In the SDIO case, mmc_power_off() might not even be called at all,
since SDIO func drivers might have enabled MMC_PM_KEEP_POWER.

>
>> 3) runtime PM (disable?)
>
> If the card powers off then mmc_set_initial_state() will called.

Again that's too late, since for example the CMD5 might have been sent
before this.

>
> For anything else the card might be doing, the mmc_retune_hold() /
> mmc_retune_release() functions are used.
>
>> 4) reset (?)
>
> Reset goes through mmc_set_initial_state()

In the mmc case, CMD13 is sent prior that. Shouldn't we hold re-tune
during that period?

>
>

Kind regards
Uffe
