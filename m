From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-s3c: use the sdhci-pltfm for Samsung-SoC
Date: Fri, 02 Mar 2012 14:07:58 +0900
Message-ID: <4F5055AE.8090904@samsung.com>
References: <4F4B3798.2000003@samsung.com>
 <001701ccf6ab$fd136910$f73a3b30$%jun@samsung.com>
 <4F500D3D.2000902@samsung.com>
 <004601ccf81a$545645c0$fd02d140$%jun@samsung.com>
 <4F50358C.5060206@samsung.com>
 <004a01ccf82f$b51a68e0$1f4f3aa0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <004a01ccf82f$b51a68e0$1f4f3aa0$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>
List-Id: linux-mmc@vger.kernel.org

>>>>>>  		sc->clk_bus[ptr] = clk;

>>>>>> @@ -613,7 +609,10 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>>>>  		 * save current clock index to know which clock bus
>>>>>>  		 * is used later in overriding functions.
>>>>>>  		 */
>>>>>> -		sc->cur_clk = ptr;
>>>>>> +		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
>>>>>> +			pltfm_host->clk = clk;
>>>>>> +		else
>>>>> We need to keep below?
>>>>> According to two commits, this seems to be relevant to SDHCI_QUIRK_NONSTANDARD_CLOCK.
>>>>>   mmc: sdhci-s3c: Support controllers with no internal clock divider(253e0a7c3dc4b)
>>>>>   mmc: sdhci-s3c: Remove usage of clk_type member in platform data(b77d777eeb0a086)
>>>>
>>>> Right, it's related with them.
>>>> I want to remove the sc->cur_clk.But in c110 case, it seems to need them.
>>>> In c110, clk_src is used the one of four.
>>>> If you want to remove the quirks, i will use only sc->cur_clk.
>>>> How about this?
>>> I mean "sc->cur_clk = ptr" can be removed here.
>>
>> I think that can remove "sc->cur_clk = ptr" at first time.
>> But in sdhci_s3c_set_clock(), it's used for selecting the new clock sources.
>> (If my understanding is wrong, i will also check this.)
> 
> As we know, ptr indicates the index of clock candidates if not SDHCI_QUIRK_NONSTANDARD_CLOCK.
> cur_clk is just updated during loop and finally it will be finished by last ptr.
> I wonder if this is a selected index.

You're right. i have considered too much about this.
It can be removed. Then it needs not to use SDHCI_QUIRK_NONSTANDARD_CLOCK.

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Seungwon Jeon.
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>> And about quirks..., I think compatibility should be considered.
>>>
>>> Thanks,
>>> Seungwon Jeon.
>>>>
>>>> And any comment?
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>>>>>
>>>>> Thanks,
>>>>> Seungwon Jeon.
>>>>>
>>>>>> +			sc->cur_clk = ptr;
>>>>>>
>>>>>>  		clk_enable(clk);
>>>>>>
>>>>>> @@ -627,63 +626,25 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>>>>  		goto err_no_busclks;
>>>>>>  	}
>>>>>>
>>>>>> -	sc->ioarea = request_mem_region(res->start, resource_size(res),
>>>>>> -					mmc_hostname(host->mmc));
>>>>>> -	if (!sc->ioarea) {
>>>>>> -		dev_err(dev, "failed to reserve register area\n");
>>>>>> -		ret = -ENXIO;
>>>>>> -		goto err_req_regs;
>>>>>> -	}
>>>>>> -
>>>>>> -	host->ioaddr = ioremap_nocache(res->start, resource_size(res));
>>>>>> -	if (!host->ioaddr) {
>>>>>> -		dev_err(dev, "failed to map registers\n");
>>>>>> -		ret = -ENXIO;
>>>>>> -		goto err_req_regs;
>>>>>> -	}
>>>>>> -
>>>>>>  	/* Ensure we have minimal gpio selected CMD/CLK/Detect */
>>>>>> -	if (pdata->cfg_gpio)
>>>>>> -		pdata->cfg_gpio(pdev, pdata->max_width);
>>>>>> -
>>>>>> -	host->hw_name = "samsung-hsmmc";
>>>>>> -	host->ops = &sdhci_s3c_ops;
>>>>>> -	host->quirks = 0;
>>>>>> -	host->irq = irq;
>>>>>> -
>>>>>> -	/* Setup quirks for the controller */
>>>>>> -	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>>>>>> -	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>>>>>> -	if (drv_data)
>>>>>> -		host->quirks |= drv_data->sdhci_quirks;
>>>>>> +	if (sc->pdata->cfg_gpio)
>>>>>> +		sc->pdata->cfg_gpio(pdev, sc->pdata->max_width);
>>>>>>
>>>>>>  #ifndef CONFIG_MMC_SDHCI_S3C_DMA
>>>>>> -
>>>>>>  	/* we currently see overruns on errors, so disable the SDMA
>>>>>>  	 * support as well. */
>>>>>>  	host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>>>>>>
>>>>>>  #endif /* CONFIG_MMC_SDHCI_S3C_DMA */
>>>>>>
>>>>>> -	/* It seems we do not get an DATA transfer complete on non-busy
>>>>>> -	 * transfers, not sure if this is a problem with this specific
>>>>>> -	 * SDHCI block, or a missing configuration that needs to be set. */
>>>>>> -	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
>>>>>> -
>>>>>> -	/* This host supports the Auto CMD12 */
>>>>>> -	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>>>>>> -
>>>>>> -	/* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
>>>>>> -	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
>>>>>> -
>>>>>> -	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
>>>>>> -	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>>>>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_NONE ||
>>>>>> +	    sc->pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>>>>>  		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>>>>>>
>>>>>> -	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>>>>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>>>>>>  		host->mmc->caps = MMC_CAP_NONREMOVABLE;
>>>>>>
>>>>>> -	switch (pdata->max_width) {
>>>>>> +	switch (sc->pdata->max_width) {
>>>>>>  	case 8:
>>>>>>  		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>>>>>>  	case 4:
>>>>>> @@ -691,17 +652,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>>>>  		break;
>>>>>>  	}
>>>>>>
>>>>>> -	if (pdata->host_caps)
>>>>>> -		host->mmc->caps |= pdata->host_caps;
>>>>>> -
>>>>>> -	if (pdata->pm_caps)
>>>>>> -		host->mmc->pm_caps |= pdata->pm_caps;
>>>>>> -
>>>>>> -	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>>>>>> -			 SDHCI_QUIRK_32BIT_DMA_SIZE);
>>>>>> +	/* It supports additional host capabilities if needed */
>>>>>> +	if (sc->pdata->host_caps)
>>>>>> +		host->mmc->caps |= sc->pdata->host_caps;
>>>>>>
>>>>>> -	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
>>>>>> -	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
>>>>>> +	if (sc->pdata->pm_caps)
>>>>>> +		host->mmc->pm_caps |= sc->pdata->pm_caps;
>>>>>>
>>>>>>  	/*
>>>>>>  	 * If controller does not have internal clock divider,
>>>>>> @@ -713,10 +669,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>>>>  		sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
>>>>>>  	}
>>>>>>
>>>>>> -	/* It supports additional host capabilities if needed */
>>>>>> -	if (pdata->host_caps)
>>>>>> -		host->mmc->caps |= pdata->host_caps;
>>>>>> -
>>>>>>  	ret = sdhci_add_host(host);
>>>>>>  	if (ret) {
>>>>>>  		dev_err(dev, "sdhci_add_host() failed\n");
>>>>>> @@ -726,38 +678,35 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>>>>  	/* The following two methods of card detection might call
>>>>>>  	   sdhci_s3c_notify_change() immediately, so they can be called
>>>>>>  	   only after sdhci_add_host(). Setup errors are ignored. */
>>>>>> -	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init)
>>>>>> -		pdata->ext_cd_init(&sdhci_s3c_notify_change);
>>>>>> -	if (pdata->cd_type == S3C_SDHCI_CD_GPIO &&
>>>>>> -	    gpio_is_valid(pdata->ext_cd_gpio))
>>>>>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_EXTERNAL &&
>>>>>> +			sc->pdata->ext_cd_init)
>>>>>> +		sc->pdata->ext_cd_init(&sdhci_s3c_notify_change);
>>>>>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_GPIO &&
>>>>>> +	    gpio_is_valid(sc->pdata->ext_cd_gpio))
>>>>>>  		sdhci_s3c_setup_card_detect_gpio(sc);
>>>>>>
>>>>>>  	return 0;
>>>>>>
>>>>>> - err_add_host:
>>>>>> -	release_resource(sc->ioarea);
>>>>>> -	kfree(sc->ioarea);
>>>>>> -
>>>>>> - err_req_regs:
>>>>>> +err_add_host:
>>>>>>  	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>>>>>>  		if (sc->clk_bus[ptr]) {
>>>>>>  			clk_disable(sc->clk_bus[ptr]);
>>>>>>  			clk_put(sc->clk_bus[ptr]);
>>>>>>  		}
>>>>>>  	}
>>>>>> -
>>>>>> - err_no_busclks:
>>>>>> +err_no_busclks:
>>>>>>  	clk_disable(sc->clk_io);
>>>>>>  	clk_put(sc->clk_io);
>>>>>>
>>>>>> - err_io_clk:
>>>>>> +err_io_clk:
>>>>>>  	for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
>>>>>>  		gpio_free(sc->gpios[ptr]);
>>>>>> -	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
>>>>>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_INTERNAL)
>>>>>>  		gpio_free(sc->ext_cd_gpio);
>>>>>>
>>>>>> - err_pdata:
>>>>>> -	sdhci_free_host(host);
>>>>>> +err_alloc_host:
>>>>>> +	sdhci_pltfm_free(pdev);
>>>>>> +	dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
>>>>>>
>>>>>>  	return ret;
>>>>>>  }
>>>>>> @@ -765,12 +714,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>>>>>  static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>>>>>  {
>>>>>>  	struct sdhci_host *host =  platform_get_drvdata(pdev);
>>>>>> -	struct sdhci_s3c *sc = sdhci_priv(host);
>>>>>> -	struct s3c_sdhci_platdata *pdata = sc->pdata;
>>>>>> -	int ptr;
>>>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>> +	struct sdhci_s3c *sc = pltfm_host->priv;
>>>>>> +	int ptr, ret;
>>>>>>
>>>>>> -	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
>>>>>> -		pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
>>>>>> +	if (sc->pdata->cd_type == S3C_SDHCI_CD_EXTERNAL &&
>>>>>> +			sc->pdata->ext_cd_cleanup)
>>>>>> +		sc->pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
>>>>>>
>>>>>>  	if (sc->ext_cd_irq)
>>>>>>  		free_irq(sc->ext_cd_irq, sc);
>>>>>> @@ -778,9 +728,9 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>>>>>  	if (gpio_is_valid(sc->ext_cd_gpio))
>>>>>>  		gpio_free(sc->ext_cd_gpio);
>>>>>>
>>>>>> -	sdhci_remove_host(host, 1);
>>>>>> +	ret = sdhci_pltfm_unregister(pdev);
>>>>>>
>>>>>> -	for (ptr = 0; ptr < 3; ptr++) {
>>>>>> +	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>>>>>>  		if (sc->clk_bus[ptr]) {
>>>>>>  			clk_disable(sc->clk_bus[ptr]);
>>>>>>  			clk_put(sc->clk_bus[ptr]);
>>>>>> @@ -789,48 +739,14 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>>>>>>  	clk_disable(sc->clk_io);
>>>>>>  	clk_put(sc->clk_io);
>>>>>>
>>>>>> -	iounmap(host->ioaddr);
>>>>>> -	release_resource(sc->ioarea);
>>>>>> -	kfree(sc->ioarea);
>>>>>> -
>>>>>>  	if (pdev->dev.of_node) {
>>>>>>  		for (ptr = 0; ptr < NUM_GPIOS(sc->pdata->max_width); ptr++)
>>>>>>  			gpio_free(sc->gpios[ptr]);
>>>>>>  	}
>>>>>>
>>>>>> -	sdhci_free_host(host);
>>>>>> -	platform_set_drvdata(pdev, NULL);
>>>>>> -
>>>>>> -	return 0;
>>>>>> -}
>>>>>> -
>>>>>> -#ifdef CONFIG_PM
>>>>>> -
>>>>>> -static int sdhci_s3c_suspend(struct device *dev)
>>>>>> -{
>>>>>> -	struct sdhci_host *host = dev_get_drvdata(dev);
>>>>>> -
>>>>>> -	return sdhci_suspend_host(host);
>>>>>> -}
>>>>>> -
>>>>>> -static int sdhci_s3c_resume(struct device *dev)
>>>>>> -{
>>>>>> -	struct sdhci_host *host = dev_get_drvdata(dev);
>>>>>> -
>>>>>> -	return sdhci_resume_host(host);
>>>>>> +	return ret;
>>>>>>  }
>>>>>>
>>>>>> -static const struct dev_pm_ops sdhci_s3c_pmops = {
>>>>>> -	.suspend	= sdhci_s3c_suspend,
>>>>>> -	.resume		= sdhci_s3c_resume,
>>>>>> -};
>>>>>> -
>>>>>> -#define SDHCI_S3C_PMOPS (&sdhci_s3c_pmops)
>>>>>> -
>>>>>> -#else
>>>>>> -#define SDHCI_S3C_PMOPS NULL
>>>>>> -#endif
>>>>>> -
>>>>>>  #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
>>>>>>  static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
>>>>>>  	.sdhci_quirks = SDHCI_QUIRK_NONSTANDARD_CLOCK,
>>>>>> @@ -870,7 +786,7 @@ static struct platform_driver sdhci_s3c_driver = {
>>>>>>  		.owner	= THIS_MODULE,
>>>>>>  		.name	= "s3c-sdhci",
>>>>>>  		.of_match_table = of_match_ptr(sdhci_s3c_dt_match),
>>>>>> -		.pm	= SDHCI_S3C_PMOPS,
>>>>>> +		.pm	= SDHCI_PLTFM_PMOPS,
>>>>>>  	},
>>>>>>  };
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
