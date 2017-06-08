From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdio: Keep card runtime resumed while adding
 function devices
Date: Thu, 8 Jun 2017 14:27:26 +0300
Message-ID: <618cdbd3-70c1-57d5-d4b7-43acdf1397be@intel.com>
References: <1495107722-13444-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFp5--WEeBsUrEzDUwgraY7stEV1cHxdp3tbk=wwJr9w7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45131 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbdFHLdo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Jun 2017 07:33:44 -0400
In-Reply-To: <CAPDyKFp5--WEeBsUrEzDUwgraY7stEV1cHxdp3tbk=wwJr9w7A@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 07/06/17 17:45, Ulf Hansson wrote:
> On 18 May 2017 at 13:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Drivers core will runtime suspend a device with no driver. That means the
>> SDIO card will be runtime suspended as soon as it is added. It is then
>> runtime resumed to add each function. That is entirely pointless, so add
>> pm runtime get/put to keep the SDIO card runtime resumed until the function
>> devices have been added.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Adrian, apologize for the delay!
> 
>> ---
>>  drivers/mmc/core/sdio.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index fae732c870a9..97bedde0610c 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -1110,6 +1110,8 @@ int mmc_attach_sdio(struct mmc_host *host)
>>                 if (err)
>>                         goto remove;
>>
>> +               pm_runtime_get_noresume(&card->dev);
> 
> Please move this above pm_runtime_set_active(), just to be really sure
> the device remains active. Thus you also need to update the error
> path.

As you wish, but even if there was somehow another code path that could get
a reference to this device, it couldn't runtime suspend it because it is not
runtime enabled.

> 
>> +
>>                 /*
>>                  * Enable runtime PM for this card
>>                  */
>> @@ -1129,7 +1131,7 @@ int mmc_attach_sdio(struct mmc_host *host)
>>         for (i = 0; i < funcs; i++, card->sdio_funcs++) {
>>                 err = sdio_init_func(host->card, i + 1);
>>                 if (err)
>> -                       goto remove;
>> +                       goto remove_get;
>>
>>                 /*
>>                  * Enable Runtime PM for this func (if supported)
>> @@ -1156,6 +1158,10 @@ int mmc_attach_sdio(struct mmc_host *host)
>>         }
>>
>>         mmc_claim_host(host);
>> +
>> +       if (host->caps & MMC_CAP_POWER_OFF_CARD)
>> +               pm_runtime_put(&card->dev);
>> +
>>         return 0;
>>
>>
>> @@ -1163,6 +1169,9 @@ int mmc_attach_sdio(struct mmc_host *host)
>>         /* Remove without lock if the device has been added. */
>>         mmc_sdio_remove(host);
>>         mmc_claim_host(host);
>> +remove_get:
>> +       if (host->caps & MMC_CAP_POWER_OFF_CARD)
>> +               pm_runtime_put(&card->dev);

I notice this is wrong here - it needs to be before mmc_sdio_remove()
because mmc_sdio_remove() deletes the devices.

> 
> Looking in the error path, I also notice that there is a
> pm_runtime_disable missing. Would you mind fixing that (as a separate
> change of course) as well?

We can't call pm_runtime_disable() after mmc_sdio_remove() because
mmc_sdio_remove() deletes the devices.  device_del() anyway takes care of
runtime pm (i.e. ends up calling __pm_runtime_disable()).

If we call pm_runtime_disable() before mmc_sdio_remove() then it results in
the devices staying in the pm state they were in at that point.  The
->remove() callbacks expect that to be "active" but AFAICT they in turn
leave the devices "suspended", so we would end up changing the current
behaviour.

So it looks to me like we don't need to call pm_runtime_disable() and we
can't call it here without side-effects.

> 
>>  remove:
>>         /* And with lock if it hasn't been added. */
>>         mmc_release_host(host);
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 

