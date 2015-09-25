From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] tmio_mmc_pio: test TMIO_MMC_WRPROTECT_DISABLE earlier
Date: Sat, 26 Sep 2015 01:13:38 +0300
Message-ID: <5605C712.3060400@cogentembedded.com>
References: <1513691.2yatcrs42i@wasted.cogentembedded.com>
 <CAPDyKFqt3AygyfXG5M-jTVqdvLi0CxWuyUmPFjg+A0dmz+o7qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqt3AygyfXG5M-jTVqdvLi0CxWuyUmPFjg+A0dmz+o7qA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello.

On 09/25/2015 11:24 PM, Ulf Hansson wrote:

>> There seems  to be no sense in the runtime PM calls when the actual register
>> read is suppressed by the TMIO_MMC_WRPROTECT_DISABLE flag.  Check that flag
>> before trying to read the register and  thus doing the runtime PM dance...
>>
>> While at it, kill useless local variable and add empty line after declarations.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branch.
>>
>>   drivers/mmc/host/tmio_mmc_pio.c |    8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> Index: mmc/drivers/mmc/host/tmio_mmc_pio.c
>> ===================================================================
>> --- mmc.orig/drivers/mmc/host/tmio_mmc_pio.c
>> +++ mmc/drivers/mmc/host/tmio_mmc_pio.c
>> @@ -988,14 +988,16 @@ static void tmio_mmc_set_ios(struct mmc_
>>   static int tmio_mmc_get_ro(struct mmc_host *mmc)
>>   {
>>          struct tmio_mmc_host *host = mmc_priv(mmc);
>> -       struct tmio_mmc_data *pdata = host->pdata;
>>          int ret = mmc_gpio_get_ro(mmc);
>> +
>>          if (ret >= 0)
>>                  return ret;
>>
>> +       if (host->pdata->flags & TMIO_MMC_WRPROTECT_DISABLE)
>> +               return 0;
>> +
>>          pm_runtime_get_sync(mmc_dev(mmc));
>> -       ret = !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
>> -               (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
>> +       ret = !(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT);
>>          pm_runtime_mark_last_busy(mmc_dev(mmc));
>>          pm_runtime_put_autosuspend(mmc_dev(mmc));
>>
>
> Actually this change won't have the desired effect, as the mmc core
> already done a pm_runtime_get_sync() since it has claimed the mmc
> host[1].

> I do realize that most drivers are still maintaining the
> pm_runtime_get|put() calls, but in most cases that's not needed any
> more.

    Hm, OK. Should be OK to remove the RPM dances from at least this 
particular driver, right?

> [1]
> commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host devices")

    Looking at the code, the following fragment of mmc_attach_sd() doesn't 
make much sense to me:

         mmc_release_host(host);
         err = mmc_add_card(host->card);
         mmc_claim_host(host);
         if (err)
                 goto remove_card;

         return 0;

remove_card:
         mmc_release_host(host);
         mmc_remove_card(host->card);
         host->card = NULL;
         mmc_claim_host(host);

    Why claim the host and immediately release it on mmc_add_card() error? Can 
we only claim on success and save a call here?

> Kind regards
> Uffe

MBR, Sergei

