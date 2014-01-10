From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v8 1/7] mmc: omap_hsmmc: use devm_regulator API
Date: Fri, 10 Jan 2014 21:25:20 +0530
Message-ID: <52D017E8.7000308@ti.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com> <1389279062-32291-1-git-send-email-balajitk@ti.com> <1389279062-32291-2-git-send-email-balajitk@ti.com> <20140109151844.GB2417@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20140109151844.GB2417@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org, tony@atomide.com, mark.rutland@arm.com
List-Id: linux-mmc@vger.kernel.org

On Thursday 09 January 2014 08:48 PM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Jan 09, 2014 at 08:20:56PM +0530, Balaji T K wrote:
>> Use devm_regulator API, while at it use
>> devm_regulator_get_optional for optional vmmc_aux supply
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c |    6 ++----
>>   1 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index dbd32ad..1eb4350 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -316,7 +316,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>>   	struct regulator *reg;
>>   	int ocr_value = 0;
>>
>> -	reg = regulator_get(host->dev, "vmmc");
>> +	reg = devm_regulator_get(host->dev, "vmmc");
>>   	if (IS_ERR(reg)) {
>>   		dev_err(host->dev, "vmmc regulator missing\n");
>>   		return PTR_ERR(reg);
>> @@ -336,7 +336,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>>   		}
>>
>>   		/* Allow an aux regulator */
>> -		reg = regulator_get(host->dev, "vmmc_aux");
>> +		reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
>>   		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
>>
>>   		/* For eMMC do not power off when not in sleep state */
>> @@ -366,8 +366,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>>
>>   static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
>
> since this function does nothing now, you could pretty much remove it
> and move set_power assignment to ->remove() directly. No strong feelings
> though.
>
Hi Felipe,

omap_hsmmc_reg_put is used in probe error handling path in addition to .remove(),
so I would keep it for now to balance omap_hsmmc_reg_get.

