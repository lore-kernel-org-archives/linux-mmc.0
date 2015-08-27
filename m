From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 13/15] mmc: host: omap_hsmmc: use regulator_is_enabled
 to find pbias status
Date: Thu, 27 Aug 2015 14:42:30 +0200
Message-ID: <CAPDyKFpm1BsKvD0f_hNvPM1LmKbd2AL8yddYRpayLPKsN2UQfw@mail.gmail.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
	<1440666847-12594-14-git-send-email-kishon@ti.com>
	<CAPDyKFqkwHPiiLVXpwNB_nBt3bdXAOhUH46cD5npS8OFsBrfeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqkwHPiiLVXpwNB_nBt3bdXAOhUH46cD5npS8OFsBrfeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Neil Brown <neilb@suse.de>
List-Id: linux-mmc@vger.kernel.org

On 27 August 2015 at 14:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 27 August 2015 at 11:14, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Use regulator_is_enabled of pbias regulator to find pbias regulator
>> status instead of maintaining a custom bookkeeping
>> pbias_enabled variable.
>
> Doesn't this cause a problem for the scenario when the initial state
> of the regulator is enabled?
>
> Both in the sense that you will increase the enable count for it

/s/will/won't

> (potentially it may then become disabled when you need it enabled) but
> also from a enable/disable imbalance point of view.
>
> Kind regards
> Uffe
>
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Tested-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  drivers/mmc/host/omap_hsmmc.c |    8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 5a5946a..4cd7a58 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -182,7 +182,6 @@ struct omap_hsmmc_host {
>>         struct  clk             *fclk;
>>         struct  clk             *dbclk;
>>         struct  regulator       *pbias;
>> -       bool                    pbias_enabled;
>>         void    __iomem         *base;
>>         int                     vqmmc_enabled;
>>         resource_size_t         mapbase;
>> @@ -330,22 +329,20 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
>>                         return ret;
>>                 }
>>
>> -               if (host->pbias_enabled == 0) {
>> +               if (!regulator_is_enabled(host->pbias)) {
>>                         ret = regulator_enable(host->pbias);
>>                         if (ret) {
>>                                 dev_err(host->dev, "pbias reg enable fail\n");
>>                                 return ret;
>>                         }
>> -                       host->pbias_enabled = 1;
>>                 }
>>         } else {
>> -               if (host->pbias_enabled == 1) {
>> +               if (regulator_is_enabled(host->pbias)) {
>>                         ret = regulator_disable(host->pbias);
>>                         if (ret) {
>>                                 dev_err(host->dev, "pbias reg disable fail\n");
>>                                 return ret;
>>                         }
>> -                       host->pbias_enabled = 0;
>>                 }
>>         }
>>
>> @@ -2081,7 +2078,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>>         host->base      = base + pdata->reg_offset;
>>         host->power_mode = MMC_POWER_OFF;
>>         host->next_data.cookie = 1;
>> -       host->pbias_enabled = 0;
>>         host->vqmmc_enabled = 0;
>>
>>         ret = omap_hsmmc_gpio_init(mmc, host, pdata);
>> --
>> 1.7.9.5
>>
