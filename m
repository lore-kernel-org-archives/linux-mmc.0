From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-pxav3: Fix tabbing issue
Date: Wed, 2 Sep 2015 11:59:14 +0530
Message-ID: <55E6973A.20305@linaro.org>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135454-6902-2-git-send-email-vaibhav.hiremath@linaro.org>
 <1441139486.12163.3.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441139486.12163.3.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org



On Wednesday 02 September 2015 02:01 AM, Joe Perches wrote:
> On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
>> There were some coding style issues where spaces have been used instead
>> of tabs, for example, in macro definitions, alignment of function
>> declarations/definitions, etc...
>>
>> This patch fixes all such occurrences in the code.
>> And also use BIT for bit definitions.
>
> Please send 2 patches instead.
>

Really?

I had two separate patches earlier, but after looking at the changes
squahsed them. Anyway, I do not have any strong opinion on this, so
will separate it in next version.


>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> []
>> @@ -128,7 +133,7 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>>   }
>>
>>   static int armada_38x_quirks(struct platform_device *pdev,
>> -			     struct sdhci_host *host)
>> +			struct sdhci_host *host)
>
> This is not an improvement.
>
> The old code is aligned to the open parenthesis
> and is fine.
>

Ok,
Same here, I always use tabs. No strong opinion, so will remove it.

>> @@ -284,10 +288,10 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>   	 * FE-2946959
>>   	 */
>>   	if (pxa->sdio3_conf_reg) {
>> -		u8 reg_val  = readb(pxa->sdio3_conf_reg);
>> +		u8 reg_val = readb(pxa->sdio3_conf_reg);
>>
>>   		if (uhs == MMC_TIMING_UHS_SDR50 ||
>> -		    uhs == MMC_TIMING_UHS_DDR50) {
>> +				uhs == MMC_TIMING_UHS_DDR50) {
>
> Also not an improvement.
>
>> @@ -304,20 +308,20 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>   }
>>
>>   static const struct sdhci_ops pxav3_sdhci_ops = {
>> -	.set_clock = sdhci_set_clock,
>> -	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
>> -	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>> -	.set_bus_width = sdhci_set_bus_width,
>> -	.reset = pxav3_reset,
>> -	.set_uhs_signaling = pxav3_set_uhs_signaling,
>> +	.set_clock			= sdhci_set_clock,
>> +	.platform_send_init_74_clocks	= pxav3_gen_init_74_clocks,
>> +	.get_max_clock			= sdhci_pltfm_clk_get_max_clock,
>> +	.set_bus_width			= sdhci_set_bus_width,
>> +	.reset				= pxav3_reset,
>> +	.set_uhs_signaling		= pxav3_set_uhs_signaling,
>
> <shrug>  If you want.

Please clarify.

Thanks,
Vaibhav
