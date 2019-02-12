From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
Date: Tue, 12 Feb 2019 13:43:33 +0530
Message-ID: <2f0ccc6c-9d35-ccf1-7587-7ad0ebfe6e97@ti.com>
References: <20190211132342.31009-1-thomas.petazzoni@bootlin.com>
 <20190211132342.31009-3-thomas.petazzoni@bootlin.com>
 <0af919d0-3a35-7aa1-bdd1-4d42128809c9@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0af919d0-3a35-7aa1-bdd1-4d42128809c9@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>, Thierry Reding <treding@nvidia.com>
List-Id: linux-mmc@vger.kernel.org



On 12/02/19 1:41 PM, Adrian Hunter wrote:
> On 11/02/19 3:23 PM, Thomas Petazzoni wrote:
>> The SDHCI core is now properly checking for the state of a WP GPIO,
>> so there is no longer any need for the sdhci-omap code to implement
>> ->get_ro() using mmc_gpio_get_ro().
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
>> ---
>> Changes since v1:
>> - Added Reviewed-by from Thierry Reding
>> - Fix typo in commit log s/know/now/ noticed by Thierry Reding
>>
>> Note: this patch has only been compiled tested, as I don't have the
>> hardware to test it.
>> ---
>>  drivers/mmc/host/sdhci-omap.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>> index d264391616f9..c2a28930086f 100644
>> --- a/drivers/mmc/host/sdhci-omap.c
>> +++ b/drivers/mmc/host/sdhci-omap.c
>> @@ -987,7 +987,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>>  		goto err_put_sync;
>>  	}
>>  
>> -	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
>>  	host->mmc_host_ops.start_signal_voltage_switch =
>>  					sdhci_omap_start_signal_voltage_switch;
>>  	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
>>
> 
