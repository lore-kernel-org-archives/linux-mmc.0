From: Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH] mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
Date: Tue, 5 Jun 2018 07:58:43 -0400
Message-ID: <13e3239e-3cd5-70ab-ba37-94a938ba5acd@gmail.com>
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
 <20180605092801.GC20649@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605092801.GC20649@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Aapo Vienamo <avienamo@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On 06/05/2018 05:28 AM, Thierry Reding wrote:
> On Mon, Jun 04, 2018 at 06:35:40PM +0300, Aapo Vienamo wrote:
>> The sdhci get_max_clock callback is set to sdhci_pltfm_clk_get_max_clock
>> and tegra_sdhci_get_max_clock is removed. It appears that the
>> shdci-tegra specific callback was originally introduced due to the
>> requirement that the host clock has to be twice the bus clock on DDR50
>> mode. As far as I can tell the only effect the removal has on DDR50 mode
>> is in cases where the parent clock is unable to supply the requested
>> clock rate, causing the DDR50 mode to run at a lower frequency.
>> Currently the DDR50 mode isn't enabled on any of the SoCs and would also
>> require configuring the SDHCI clock divider register to function
>> properly.
>>
>> The problem with tegra_sdhci_get_max_clock is that it divides the clock
>> rate by two and thus artificially limits the maximum frequency of faster
>> signaling modes which don't have the host-bus frequency ratio requirement
>> of DDR50 such as SDR104 and HS200. Furthermore, the call to
>> clk_round_rate() may return an error which isn't handled by
>> tegra_sdhci_get_max_clock.
>>
>> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
>> ---
>>   drivers/mmc/host/sdhci-tegra.c | 15 ++-------------
>>   1 file changed, 2 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index 970d38f6..c8745b5 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -234,17 +234,6 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>>   	sdhci_set_uhs_signaling(host, timing);
>>   }
>>   
>> -static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
>> -{
>> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> -
>> -	/*
>> -	 * DDR modes require the host to run at double the card frequency, so
>> -	 * the maximum rate we can support is half of the module input clock.
>> -	 */
>> -	return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
>> -}
> 
> sdhci_pltfm_clk_get_max_clock() returns the current frequency of the
> clock, which may not be an accurate maximum.
> 
> Also, even if we don't support DDR modes now, we may want to enable them
> in the future, at which point we'll need to move to something similar to
> the above again, albeit maybe with some of the issues that you mentioned
> fixed.
> 
> I wonder if we have access to the target mode in this function, because
> it seems to me like we'd need to take that into account when determining
> the maximum clock rate. Or perhaps the double-rate aspect is already
> dealt with in other parts of the MMC subsystem, so the value we should
> return here may not even need to take the mode into account.
> 
> All of the above said, it is true that we don't enable DDR modes as of
> now, and this patch seems like it shouldn't break anything either, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> I also gave this a brief run on Jetson TK1 and things seem to work fine,
> so:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>
> 
I am currently testing this in my Ouya project, to see if it makes a 
difference in my eMMC stability above 30Mhz.
As a drop in replacement it works.
I'll be cranking up the speed later.
