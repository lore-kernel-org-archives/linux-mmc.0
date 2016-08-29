From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/4] mmc: sdhci-of-arasan: Control clock for accessing
 syscon
Date: Mon, 29 Aug 2016 16:54:10 +0800
Message-ID: <fa7bea7d-b596-5784-4221-de3a8eaf5f17@rock-chips.com>
References: <1472457779-7194-1-git-send-email-shawn.lin@rock-chips.com>
 <1472457779-7194-3-git-send-email-shawn.lin@rock-chips.com>
 <8418661.gal5ZOtGyv@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8418661.gal5ZOtGyv@diego>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Heiko,

On 2016/8/29 16:25, Heiko Stübner wrote:
> Hi Shawn,
>
> Am Montag, 29. August 2016, 16:02:57 schrieb Shawn Lin:
>> In the eariler commit 65820199272d ("Documentation: mmc:
>> sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs"), we
>> introduced syscon to control corecfg_* stuff provided by
>> arasan. But given that we may need to ungate the clock for
>> accessing corecfg_*, it not so perfect as it depends on
>> whether specific clock driver disables it if not referenced.
>> Meanwhile, if we don't need arasan contoller to work anymore,
>> there is no reason to still enable it. So let's control this
>> clock when needed.
>>
>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>>  drivers/mmc/host/sdhci-of-arasan.c | 25 ++++++++++++++++++++++---
>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>> b/drivers/mmc/host/sdhci-of-arasan.c index 0b3a9cf..7ae3ae4 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -78,6 +78,7 @@ struct sdhci_arasan_soc_ctl_map {
>>   * struct sdhci_arasan_data
>>   * @host:		Pointer to the main SDHCI host structure.
>>   * @clk_ahb:		Pointer to the AHB clock
>> + * @clk_syscon:		Pointer to the optional clock for accessing syscon
>>   * @phy:		Pointer to the generic phy
>>   * @is_phy_on:		True if the PHY is on; false if not.
>>   * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
>> @@ -88,6 +89,7 @@ struct sdhci_arasan_soc_ctl_map {
>>  struct sdhci_arasan_data {
>>  	struct sdhci_host *host;
>>  	struct clk	*clk_ahb;
>> +	struct clk	*clk_syscon;
>>  	struct phy	*phy;
>>  	bool		is_phy_on;
>>
>> @@ -290,6 +292,7 @@ static int sdhci_arasan_suspend(struct device *dev)
>>
>>  	clk_disable(pltfm_host->clk);
>>  	clk_disable(sdhci_arasan->clk_ahb);
>> +	clk_disable(sdhci_arasan->clk_syscon);
>>
>>  	return 0;
>>  }
>> @@ -309,6 +312,12 @@ static int sdhci_arasan_resume(struct device *dev)
>>  	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>>  	int ret;
>>
>> +	ret = clk_enable(sdhci_arasan->clk_syscon);
>> +	if (ret) {
>> +		dev_err(dev, "Cannot enable syscon clock.\n");
>> +		return ret;
>> +	}
>> +
>>  	ret = clk_enable(sdhci_arasan->clk_ahb);
>>  	if (ret) {
>>  		dev_err(dev, "Cannot enable AHB clock.\n");
>> @@ -528,26 +537,33 @@ static int sdhci_arasan_probe(struct platform_device
>> *pdev) ret);
>>  			goto err_pltfm_free;
>>  		}
>> +
>> +		sdhci_arasan->clk_syscon = devm_clk_get(&pdev->dev,
>> +							"clk_syscon");
>> +		if (clk_prepare_enable(sdhci_arasan->clk_syscon)) {
>> +			dev_err(&pdev->dev, "Unable to enable syscon clock.\n");
>> +			goto err_pltfm_free;
>> +		}
>
> doesn't look very "optional" to me.
> clk_get specifies:
> "Returns a struct clk corresponding to the clock producer, or
> valid IS_ERR() condition containing errno."
>
> So later clk_* on that err_ptr will produce failures and the clock-framework
> could also request deferal.

Thanks for quick feedback.:)

It makes sense. I think it's just because clk_get request deferral, so
we could simply assign NULL to cly_syscon and let clk_* return 0
directly. So the deferral should be handle when getting other clks like
clk_ahb?

>
>
> Heiko
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
