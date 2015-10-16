From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/5] mmc: sdhci-pxav3: fix optional clock name
Date: Fri, 16 Oct 2015 21:58:49 +0200
Message-ID: <562156F9.9040200@gmail.com>
References: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
 <1444628796-5484-2-git-send-email-jszhang@marvell.com>
 <56201D82.6080106@gmail.com> <20151016194032.76514a5e@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151016194032.76514a5e@xhacker>
Sender: linux-clk-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 16.10.2015 13:40, Jisheng Zhang wrote:
> On Thu, 15 Oct 2015 23:41:22 +0200
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>> On 12.10.2015 07:46, Jisheng Zhang wrote:
>>> Commit 8afdc9cca27f ("mmc: sdhci-pxav3: Get optional core clock") adds
>>> additional optional clock support, but the clock names  isn't correct.
>>> The current "io" clock is really the PXAv3 SDHCI IP's "core" clock
>>> which is manadatory. The current "core" clock is really the IP's "axi"
>>> clock which is optional.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>>> ---
[...]
>> Please split the DT changes from the driver changes.
>
> Such split will break berlin SDHC functionality, I'm not sure whether this is
> acceptable.

I am not going to funnel any driver stuff through berlin-tree anymore
if it isn't really neccessary.

[...]
>>>    - clocks: Array of clocks required for SDHCI; requires at least one for
>>> -    I/O clock.
>>> +    core clock.
>>>    - clock-names: Array of names corresponding to clocks property; shall be
>>> -    "io" for I/O clock and "core" for optional core clock.
>>> +    "core" for core clock and "axi" for optional axi clock.
>>
>> s/axi/bus/ ?
>
> HW call this clk as axi, "bus" seems more generic, right?

Yes, please pick the generic name. Given the age of that IP,
I guess it will run on AHB instead of AXI on PXA.

[...]
>>> -	pxa->clk_io = devm_clk_get(dev, "io");
>>> -	if (IS_ERR(pxa->clk_io))
>>> -		pxa->clk_io = devm_clk_get(dev, NULL);
>>> -	if (IS_ERR(pxa->clk_io)) {
>>> -		dev_err(dev, "failed to get io clock\n");
>>> -		ret = PTR_ERR(pxa->clk_io);
>>> +	pxa->clk_core = devm_clk_get(dev, "core");
>>
>> To maintain backward compatibility, we should still
>
> I just grep the kernel source, found that only mrvl berlin SoCs have two clks,
> other SoCs just have one clk and don't provide clock name. So the question
> here is whether we can break linux backward compatibility for mrvl berlin
> SoCs. I think we could for the following reason:

That is the point: do not break it on purpose.

Try to separate DT and driver changes without breaking the tree
in between.

Sebastian

> 1. rare boards outside mrvl can boot user self-built kernel, most boards should
> be protected by trust-chainloader mechanism.
>
> 2. mrvl berlin SoCs upgrade linux kernel and dtb at the same time
>
> what do you think?
>
> Is it better to refine patch 2, 3, 4, 5 to make use current "io","core" binding
> to clean up the clk's CLK_IGNORE_UNUSED flags? In fact, they doesn't depend
> on patch1. Could you please kindly give advice?
>
> Thanks in advance,
> Jisheng
>
>
>
>> devm_clk_get(dev, "io") here - or even better, first
>> probe for "io" to catch old binding semantics including
>> old "core"/"bus" misnaming.
>>
>> If we detected old semantics, print a warning that
>> firmware should be updated.
>>
>> Sebastian
>>
>>> +	if (IS_ERR(pxa->clk_core))
>>> +		pxa->clk_core = devm_clk_get(dev, NULL);
>>> +	if (IS_ERR(pxa->clk_core)) {
>>> +		dev_err(dev, "failed to get core clock\n");
>>> +		ret = PTR_ERR(pxa->clk_core);
>>>    		goto err_clk_get;
>>>    	}
>>> -	pltfm_host->clk = pxa->clk_io;
>>> -	clk_prepare_enable(pxa->clk_io);
>>> +	pltfm_host->clk = pxa->clk_core;
>>> +	clk_prepare_enable(pxa->clk_core);
>>>
>>> -	pxa->clk_core = devm_clk_get(dev, "core");
>>> -	if (!IS_ERR(pxa->clk_core))
>>> -		clk_prepare_enable(pxa->clk_core);
>>> +	pxa->clk_axi = devm_clk_get(dev, "axi");
>>> +	if (!IS_ERR(pxa->clk_axi))
>>> +		clk_prepare_enable(pxa->clk_axi);
>>>
>>>    	/* enable 1/8V DDR capable */
>>>    	host->mmc->caps |= MMC_CAP_1_8V_DDR;
>>> @@ -475,8 +475,8 @@ err_add_host:
>>>    err_of_parse:
>>>    err_cd_req:
>>>    err_mbus_win:
>>> -	clk_disable_unprepare(pxa->clk_io);
>>>    	clk_disable_unprepare(pxa->clk_core);
>>> +	clk_disable_unprepare(pxa->clk_axi);
>>>    err_clk_get:
>>>    	sdhci_pltfm_free(pdev);
>>>    	return ret;
>>> @@ -494,8 +494,8 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
>>>
>>>    	sdhci_remove_host(host, 1);
>>>
>>> -	clk_disable_unprepare(pxa->clk_io);
>>>    	clk_disable_unprepare(pxa->clk_core);
>>> +	clk_disable_unprepare(pxa->clk_axi);
>>>
>>>    	sdhci_pltfm_free(pdev);
>>>
>>> @@ -542,9 +542,9 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
>>>    	if (ret)
>>>    		return ret;
>>>
>>> -	clk_disable_unprepare(pxa->clk_io);
>>> -	if (!IS_ERR(pxa->clk_core))
>>> -		clk_disable_unprepare(pxa->clk_core);
>>> +	clk_disable_unprepare(pxa->clk_core);
>>> +	if (!IS_ERR(pxa->clk_axi))
>>> +		clk_disable_unprepare(pxa->clk_axi);
>>>
>>>    	return 0;
>>>    }
>>> @@ -555,9 +555,9 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
>>>    	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>    	struct sdhci_pxa *pxa = pltfm_host->priv;
>>>
>>> -	clk_prepare_enable(pxa->clk_io);
>>> -	if (!IS_ERR(pxa->clk_core))
>>> -		clk_prepare_enable(pxa->clk_core);
>>> +	clk_prepare_enable(pxa->clk_core);
>>> +	if (!IS_ERR(pxa->clk_axi))
>>> +		clk_prepare_enable(pxa->clk_axi);
>>>
>>>    	return sdhci_runtime_resume_host(host);
>>>    }
>>>
>>
>

