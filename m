From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 9/9] mmc: dw_mmc: add support for exynos specific
 implementation of dw-mshc
Date: Mon, 27 Aug 2012 17:58:56 +0900
Message-ID: <503B36D0.4030208@samsung.com>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
 <1345981927-26359-10-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1345981927-26359-10-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, tgih.jun@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,

> +	gpio = of_get_named_gpio(slot_np, "wp-gpios", 0);
> +	if (gpio_is_valid(gpio)) {
> +		if (devm_gpio_request(host->dev, gpio, "dw-mci-wp"))
> +			dev_info(host->dev, "gpio [%d] request failed\n",
> +						gpio);
> +	} else {
> +		dev_info(host->dev, "wp gpio not available");
> +		host->pdata->quirks |= DW_MCI_QUIRK_NO_WRITE_PROTECT;
> +	}
> +
> +	if (host->pdata->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
> +		return 0;
> +
> +	gpio = of_get_named_gpio(slot_np, "samsung,cd-pinmux-gpio", 0);
> +	if (gpio_is_valid(gpio)) {
> +		if (devm_gpio_request(host->dev, gpio, "dw-mci-cd"))
I'm not sure, but i saw mmc_gpio_request_cd() into drivers/mmc/core/slot-gpio.c.
Can we use this? i think we can use them.
Just my opinion.

Best Regards,
Jaehoon Chung
> +			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
> +	} else {
> +		dev_info(host->dev, "cd gpio not available");
> +	}
> +
> +	return 0;
> +}
> +
> +/* Exynos5250 controller specific capabilities */
> +static unsigned long exynos5250_dwmmc_caps[4] = {
> +	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
> +		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
> +	MMC_CAP_CMD23,
> +	MMC_CAP_CMD23,
> +	MMC_CAP_CMD23,
> +};
> +
> +static struct dw_mci_drv_data exynos5250_drv_data = {
> +	.caps			= exynos5250_dwmmc_caps,
> +	.init			= dw_mci_exynos_priv_init,
> +	.prepare_command	= dw_mci_exynos_prepare_command,
> +	.set_ios		= dw_mci_exynos_set_ios,
> +	.parse_dt		= dw_mci_exynos_parse_dt,
> +	.setup_bus		= dw_mci_exynos_setup_bus,
> +};
> +
> +static const struct of_device_id dw_mci_exynos_match[] = {
> +	{ .compatible = "samsung,exynos5250-dw-mshc",
> +			.data = (void *)&exynos5250_drv_data, },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
> +
> +int dw_mci_exynos_probe(struct platform_device *pdev)
> +{
> +	struct dw_mci_drv_data *drv_data;
> +	const struct of_device_id *match;
> +
> +	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
> +	drv_data = match->data;
> +	return dw_mci_pltfm_register(pdev, drv_data);
> +}
> +
> +static struct platform_driver dw_mci_exynos_pltfm_driver = {
> +	.probe		= dw_mci_exynos_probe,
> +	.remove		= __exit_p(dw_mci_pltfm_remove),
> +	.driver		= {
> +		.name		= "dwmmc_exynos",
> +		.of_match_table	= of_match_ptr(dw_mci_exynos_match),
> +		.pm		= &dw_mci_pltfm_pmops,
> +	},
> +};
> +
> +module_platform_driver(dw_mci_exynos_pltfm_driver);
> +
> +MODULE_DESCRIPTION("Samsung Specific DW-MSHC Driver Extension");
> +MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:dwmmc-exynos");
> 
