From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2 02/10] mmc: omap_hsmmc: make vcc and vcc_aux independent
Date: Wed, 12 Jun 2013 20:03:53 +0530
Message-ID: <51B886D1.9040700@ti.com>
References: <20130523184045.GD13507@atomide.com> <1370546059-24181-1-git-send-email-balajitk@ti.com> <1370546059-24181-3-git-send-email-balajitk@ti.com> <20130612142553.GX8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130612142553.GX8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday 12 June 2013 07:55 PM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [130606 12:20]:
>> handle vcc and vcc_aux independently
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c |    9 +++++----
>>   1 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 1865321..bda1a42 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -253,7 +253,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>>   	 * If we don't see a Vcc regulator, assume it's a fixed
>>   	 * voltage always-on regulator.
>>   	 */
>> -	if (!host->vcc)
>> +	if (!host->vcc && !host->vcc_aux)
>>   		return 0;
>>   	/*
>>   	 * With DT, never turn OFF the regulator for MMC1. This is because
>
> Doesn't the above change break MMC for most boards that only pass
> one regulator and no aux regulator?
>

No, I want to skip regulator operation in set_power function iff both
regulator are not present.

Earlier vcc was assumed/mandatory if vcc_aux is present.
Now, regulator operation will be handled if either one of vcc/vcc_aux is present,

> Regards,
>
> Tony
>
>> @@ -280,11 +280,12 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>>   	 * chips/cards need an interface voltage rail too.
>>   	 */
>>   	if (power_on) {
>> -		ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
>> +		if (host->vcc)
>> +			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
>>   		/* Enable interface voltage rail, if needed */
>>   		if (ret == 0 && host->vcc_aux) {
>>   			ret = regulator_enable(host->vcc_aux);
>> -			if (ret < 0)
>> +			if (ret < 0 && host->vcc)
>>   				ret = mmc_regulator_set_ocr(host->mmc,
>>   							host->vcc, 0);
>>   		}
>> @@ -292,7 +293,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>>   		/* Shut down the rail */
>>   		if (host->vcc_aux)
>>   			ret = regulator_disable(host->vcc_aux);
>> -		if (!ret) {
>> +		if (host->vcc) {
>>   			/* Then proceed to shut down the local regulator */
>>   			ret = mmc_regulator_set_ocr(host->mmc,
>>   						host->vcc, 0);
>> --
>> 1.7.5.4
>>

