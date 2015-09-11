From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 2/2] mmc: core: sdio: claim host before power up or
 power off
Date: Fri, 11 Sep 2015 18:47:26 +0530
Message-ID: <55F2D466.30806@ti.com>
References: <1440411317-8813-1-git-send-email-kishon@ti.com>	<1440411317-8813-2-git-send-email-kishon@ti.com> <CAPDyKFoBBBE_BBkS5hrBvCWjnpxkeBr2_hE1D_w=WBv-Ti2TRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoBBBE_BBkS5hrBvCWjnpxkeBr2_hE1D_w=WBv-Ti2TRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Neil Brown <neilb@suse.de>, "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Friday 11 September 2015 06:15 PM, Ulf Hansson wrote:
> On 24 August 2015 at 12:15, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> mmc_sdio_runtime_resume and mmc_sdio_runtime_suspend does power up and
>> power off respectively but does so without claiming the host. Among other
>> things mmc_claim_host inovkes pm_runtime_get_sync to enable the clocks.
>> Invoke mmc_claim_host before mmc_power_up and mmc_power_off in
>> mmc_sdio_runtime_resume and mmc_sdio_runtime_suspend respectively.
>>
>> This is required since certain platforms (like TI SoCs) access
>> the controller registers during power up.
> 
> I realize the issue. Actually I have been working on similar patch
> which take a bit wider approach. That's because there are more cases
> where the host needs to be claimed, when it isn't.
> 
> I just posted a patch, please have a look and see if it makes sense to
> you, you are on cc.
> "[PATCH] mmc: core: Keep host claimed while invoking mmc_power_off|up()"

Sure Uffe.

-Kishon

> 
> Kind regards
> Uffe
> 
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/mmc/core/sdio.c |   10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index 0cbbfb8..40795b2 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -1023,16 +1023,24 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
>>
>>  static int mmc_sdio_runtime_suspend(struct mmc_host *host)
>>  {
>> +       mmc_claim_host(host);
>>         /* No references to the card, cut the power to it. */
>>         mmc_power_off(host);
>> +       mmc_release_host(host);
>>         return 0;
>>  }
>>
>>  static int mmc_sdio_runtime_resume(struct mmc_host *host)
>>  {
>> +       int ret;
>> +
>> +       mmc_claim_host(host);
>>         /* Restore power and re-initialize. */
>>         mmc_power_up(host, host->card->ocr);
>> -       return mmc_sdio_power_restore(host);
>> +       ret = _mmc_sdio_power_restore(host);
>> +       mmc_release_host(host);
>> +
>> +       return ret;
>>  }
>>
>>  static int mmc_sdio_reset(struct mmc_host *host)
>> --
>> 1.7.9.5
>>
