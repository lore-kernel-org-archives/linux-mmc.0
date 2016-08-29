From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/4] mmc: sdhci-of-arasan: Control clock for accessing
 syscon
Date: Mon, 29 Aug 2016 17:20:46 +0800
Message-ID: <81f9b645-ced9-cdf9-c0be-2021c9a00fc2@rock-chips.com>
References: <1472457779-7194-1-git-send-email-shawn.lin@rock-chips.com>
 <8418661.gal5ZOtGyv@diego>
 <fa7bea7d-b596-5784-4221-de3a8eaf5f17@rock-chips.com>
 <1693211.KBN6GAFoI7@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:40975 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbcH2JVE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2016 05:21:04 -0400
In-Reply-To: <1693211.KBN6GAFoI7@diego>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: shawn.lin@rock-chips.com, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-kernel@vger.kernel.org

On 2016/8/29 17:10, Heiko Stübner wrote:
> Hi Shawn,
>
> Am Montag, 29. August 2016, 16:54:10 schrieb Shawn Lin:
>> On 2016/8/29 16:25, Heiko Stübner wrote:
>>> Am Montag, 29. August 2016, 16:02:57 schrieb Shawn Lin:
>>>> In the eariler commit 65820199272d ("Documentation: mmc:
>>>> sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs"), we
>>>> introduced syscon to control corecfg_* stuff provided by
>>>> arasan. But given that we may need to ungate the clock for
>>>> accessing corecfg_*, it not so perfect as it depends on
>>>> whether specific clock driver disables it if not referenced.
>>>> Meanwhile, if we don't need arasan contoller to work anymore,
>>>> there is no reason to still enable it. So let's control this
>>>> clock when needed.
>>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>> ---
>>>>
>>>>  drivers/mmc/host/sdhci-of-arasan.c | 25 ++++++++++++++++++++++---
>>>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>>>> b/drivers/mmc/host/sdhci-of-arasan.c index 0b3a9cf..7ae3ae4 100644
>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>> @@ -78,6 +78,7 @@ struct sdhci_arasan_soc_ctl_map {
>>>>
>>>>   * struct sdhci_arasan_data
>>>>   * @host:		Pointer to the main SDHCI host structure.
>>>>   * @clk_ahb:		Pointer to the AHB clock
>>>>
>>>> + * @clk_syscon:		Pointer to the optional clock for accessing syscon
>>>>
>>>>   * @phy:		Pointer to the generic phy
>>>>   * @is_phy_on:		True if the PHY is on; false if not.
>>>>   * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
>>>>
>>>> @@ -88,6 +89,7 @@ struct sdhci_arasan_soc_ctl_map {
>>>>
>>>>  struct sdhci_arasan_data {
>>>>
>>>>  	struct sdhci_host *host;
>>>>  	struct clk	*clk_ahb;
>>>>
>>>> +	struct clk	*clk_syscon;
>>>>
>>>>  	struct phy	*phy;
>>>>  	bool		is_phy_on;
>>>>
>>>> @@ -290,6 +292,7 @@ static int sdhci_arasan_suspend(struct device *dev)
>>>>
>>>>  	clk_disable(pltfm_host->clk);
>>>>  	clk_disable(sdhci_arasan->clk_ahb);
>>>>
>>>> +	clk_disable(sdhci_arasan->clk_syscon);
>>>>
>>>>  	return 0;
>>>>
>>>>  }
>>>>
>>>> @@ -309,6 +312,12 @@ static int sdhci_arasan_resume(struct device *dev)
>>>>
>>>>  	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>>>>  	int ret;
>>>>
>>>> +	ret = clk_enable(sdhci_arasan->clk_syscon);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Cannot enable syscon clock.\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>>
>>>>  	ret = clk_enable(sdhci_arasan->clk_ahb);
>>>>  	if (ret) {
>>>>  	
>>>>  		dev_err(dev, "Cannot enable AHB clock.\n");
>>>>
>>>> @@ -528,26 +537,33 @@ static int sdhci_arasan_probe(struct
>>>> platform_device
>>>> *pdev) ret);
>>>>
>>>>  			goto err_pltfm_free;
>>>>  		
>>>>  		}
>>>>
>>>> +
>>>> +		sdhci_arasan->clk_syscon = devm_clk_get(&pdev->dev,
>>>> +							"clk_syscon");
>>>> +		if (clk_prepare_enable(sdhci_arasan->clk_syscon)) {
>>>> +			dev_err(&pdev->dev, "Unable to enable syscon clock.\n");
>>>> +			goto err_pltfm_free;
>>>> +		}
>>>
>>> doesn't look very "optional" to me.
>>> clk_get specifies:
>>> "Returns a struct clk corresponding to the clock producer, or
>>> valid IS_ERR() condition containing errno."
>>>
>>> So later clk_* on that err_ptr will produce failures and the
>>> clock-framework could also request deferal.
>>
>> Thanks for quick feedback.:)
>>
>> It makes sense. I think it's just because clk_get request deferral, so
>> we could simply assign NULL to cly_syscon and let clk_* return 0
>> directly. So the deferral should be handle when getting other clks like
>> clk_ahb?
>
> nope, I think the position itself is fine, so just do something like
>
> if (IS_ERR(sdhci_arasan->clk_syscon)) {
> {
> 	if (PTR_ERR(sdhci_arasan->clk_syscon) == -EPROBE_DEFER)
> 		return -EPROBE_DEFER;
> 	else
> 		sdhci_arasan->clk_syscon = NULL;
> }
>
> as the syscon clk would only ever be necessary if the soc-ctl-syscon is
> actually defined. But there is no need to move that section I think.

except for other arasan's instances of some other venders who do have
soc-ctl-syscon but without any clk gate when accessing syscon,
possible? :)

>
>
>


-- 
Best Regards
Shawn Lin

