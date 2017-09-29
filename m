From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix clock resource by adding an optional bus clock
Date: Fri, 29 Sep 2017 11:13:00 +0200
Message-ID: <87fub5hnqb.fsf@free-electrons.com>
References: <20170928150520.27616-1-gregory.clement@free-electrons.com>
        <20170929103943.3a6f2509@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929103943.3a6f2509-XW7BGIvHH6X931TTwiNRCw@public.gmane.org> (Jisheng Zhang's message
        of "Fri, 29 Sep 2017 10:39:43 +0800")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <Jisheng.Zhang-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Igal Liberman <igall-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian
List-Id: linux-mmc@vger.kernel.org

Hi Jisheng,
 
 On ven., sept. 29 2017, Jisheng Zhang <Jisheng.Zhang-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org> wrote:

> + DT maintainers
>
> On Thu, 28 Sep 2017 17:05:20 +0200 Gregory CLEMENT wrote:
>
>> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
>> is optional because not all the SoCs need them but at least for Armada
>> 7K/8K it is actually mandatory.
>> 
>> The binding documentation is updating accordingly.
>> 
>> Without this patch the kernel hand during boot if the mvpp2.2 network
>> driver was not present in the kernel. Indeed the clock needed by the
>> xenon controller was set by the network driver.
>> 
>> Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core
>> functionality)"
>> CC: Stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>> Hi Ulf and Adrian,
>> 
>> This patch should be merged in 4.14-rc, as it fixes real issues.
>> 
>> This patch maye looks like just as a nice clean-up but it is not. On
>> the earlier version of the series adding the support for the xenon
>> controller there was already this axi bus clock. But at this moment
>> the documentation for the clock on the Armada 7K/8K was missing and
>> there was no driver for it, so we just use the clock set by the
>> bootloader and never change them that's why it worked without any
>> visible problem.
>> 
>> Then as explained in the commit log the network driver enabled the
>> clock for us, and it happened that it was setup before the xenon
>> driver. It is only thanks the new information we received on the
>> clocks of the Sov and with more exhaustive testes that we found this
>> issue and the fix for it.
>> 
>> Thanks,
>> 
>> Gregory
>> 
>> 
>>  .../bindings/mmc/marvell,xenon-sdhci.txt           | 12 ++++++-----
>>  drivers/mmc/host/sdhci-xenon.c                     | 25 +++++++++++++++++++---
>>  drivers/mmc/host/sdhci-xenon.h                     |  1 +
>>  3 files changed, 30 insertions(+), 8 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>> index b878a1e305af..6f3db1f809ab 100644
>> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>> @@ -16,11 +16,13 @@ Required Properties:
>>  
>>  - clocks:
>>    Array of clocks required for SDHC.
>> -  Require at least input clock for Xenon IP core.
>> +  Require at least input clock for Xenon IP core. For Armada AP806 and
>> +  CP110, the AXI clock is also mandatory.
>>  
>>  - clock-names:
>>    Array of names corresponding to clocks property.
>>    The input clock for Xenon IP core should be named as "core".
>> +  The input clock for the AXI bus must be named as "axi".
>
> Is "bus" more suitable?

I find bus too vague.

>
>>  
>>  - reg:
>>    * For "marvell,armada-3700-sdhci", two register areas.
>> @@ -106,8 +108,8 @@ Example:
>>  		compatible = "marvell,armada-ap806-sdhci";
>>  		reg = <0xaa0000 0x1000>;
>>  		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
>> -		clocks = <&emmc_clk>;
>> -		clock-names = "core";
>> +		clocks = <&emmc_clk>,<&axi_clk>;
>> +		clock-names = "core","axi";
>>  		bus-width = <4>;
>>  		marvell,xenon-phy-slow-mode;
>>  		marvell,xenon-tun-count = <11>;
>> @@ -126,8 +128,8 @@ Example:
>>  		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
>>  		vqmmc-supply = <&sd_vqmmc_regulator>;
>>  		vmmc-supply = <&sd_vmmc_regulator>;
>> -		clocks = <&sdclk>;
>> -		clock-names = "core";
>> +		clocks = <&sdclk>,<&axi_clk>;
>> +		clock-names = "core","axi";
>>  		bus-width = <4>;
>>  		marvell,xenon-tun-count = <9>;
>>  	};
>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>> index 2eec2e652c53..845575593b59 100644
>> --- a/drivers/mmc/host/sdhci-xenon.c
>> +++ b/drivers/mmc/host/sdhci-xenon.c
>> @@ -466,6 +466,7 @@ static int xenon_probe(struct platform_device *pdev)
>>  {
>>  	struct sdhci_pltfm_host *pltfm_host;
>>  	struct sdhci_host *host;
>> +	struct xenon_priv *priv;
>>  	int err;
>>  
>>  	host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
>> @@ -474,6 +475,7 @@ static int xenon_probe(struct platform_device *pdev)
>>  		return PTR_ERR(host);
>>  
>>  	pltfm_host = sdhci_priv(host);
>> +	priv = sdhci_pltfm_priv(pltfm_host);
>>  
>>  	/*
>>  	 * Link Xenon specific mmc_host_ops function,
>> @@ -491,9 +493,20 @@ static int xenon_probe(struct platform_device *pdev)
>>  	if (err)
>>  		goto free_pltfm;
>>  
>> +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
>> +	if (IS_ERR(priv->axi_clk)) {
>> +		err = PTR_ERR(priv->axi_clk);
>> +		dev_err(&pdev->dev, "Failed to setup axi clk: %d\n", err);
>
> Since the bus clock is optional, can we remove this err msg?

I will change it in dev_info.

>
>> +		priv->axi_clk = NULL;
>> +	} else {
>> +		err = clk_prepare_enable(priv->axi_clk);
>> +		if (err)
>> +			goto err_clk;
>> +	}
>> +
>>  	err = mmc_of_parse(host->mmc);
>>  	if (err)
>> -		goto err_clk;
>> +		goto err_clk_axi;
>>  
>>  	sdhci_get_of_property(pdev);
>>  
>> @@ -502,11 +515,11 @@ static int xenon_probe(struct platform_device *pdev)
>>  	/* Xenon specific dt parse */
>>  	err = xenon_probe_dt(pdev);
>>  	if (err)
>> -		goto err_clk;
>> +		goto err_clk_axi;
>>  
>>  	err = xenon_sdhc_prepare(host);
>>  	if (err)
>> -		goto err_clk;
>> +		goto err_clk_axi;
>>  
>>  	pm_runtime_get_noresume(&pdev->dev);
>>  	pm_runtime_set_active(&pdev->dev);
>> @@ -527,6 +540,9 @@ static int xenon_probe(struct platform_device *pdev)
>>  	pm_runtime_disable(&pdev->dev);
>>  	pm_runtime_put_noidle(&pdev->dev);
>>  	xenon_sdhc_unprepare(host);
>> +err_clk_axi:
>> +	if (priv->axi_clk)
>
> clk_disable_unprepare() will do the check. So this check could be removed
> to simplify the err path

Right I removed it


>
>> +		clk_disable_unprepare(priv->axi_clk);
>>  err_clk:
>>  	clk_disable_unprepare(pltfm_host->clk);
>>  free_pltfm:
>> @@ -538,6 +554,7 @@ static int xenon_remove(struct platform_device *pdev)
>>  {
>>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>  
>>  	pm_runtime_get_sync(&pdev->dev);
>>  	pm_runtime_disable(&pdev->dev);
>> @@ -546,6 +563,8 @@ static int xenon_remove(struct platform_device *pdev)
>>  	sdhci_remove_host(host, 0);
>>  
>>  	xenon_sdhc_unprepare(host);
>> +	if (priv->axi_clk)
>> +		clk_disable_unprepare(priv->axi_clk);
>
> ditto

OK

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
