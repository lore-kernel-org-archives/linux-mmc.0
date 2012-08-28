From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 9/9] mmc: dw_mmc: add support for exynos specific
 implementation of dw-mshc
Date: Tue, 28 Aug 2012 13:55:57 +0900
Message-ID: <503C4F5D.8050302@samsung.com>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
 <1345981927-26359-10-git-send-email-thomas.abraham@linaro.org>
 <503B36D0.4030208@samsung.com>
 <CAJuYYwTKXuJe-8N3kOkkUg_bCzAdG-cG4yjk67zF7dmrg+eGpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJuYYwTKXuJe-8N3kOkkUg_bCzAdG-cG4yjk67zF7dmrg+eGpw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, tgih.jun@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,

On 08/28/2012 01:48 PM, Thomas Abraham wrote:
> On 27 August 2012 14:28, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Thomas,
>>
>>> +     gpio = of_get_named_gpio(slot_np, "wp-gpios", 0);
>>> +     if (gpio_is_valid(gpio)) {
>>> +             if (devm_gpio_request(host->dev, gpio, "dw-mci-wp"))
>>> +                     dev_info(host->dev, "gpio [%d] request failed\n",
>>> +                                             gpio);
>>> +     } else {
>>> +             dev_info(host->dev, "wp gpio not available");
>>> +             host->pdata->quirks |= DW_MCI_QUIRK_NO_WRITE_PROTECT;
>>> +     }
>>> +
>>> +     if (host->pdata->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
>>> +             return 0;
>>> +
>>> +     gpio = of_get_named_gpio(slot_np, "samsung,cd-pinmux-gpio", 0);
>>> +     if (gpio_is_valid(gpio)) {
>>> +             if (devm_gpio_request(host->dev, gpio, "dw-mci-cd"))
>> I'm not sure, but i saw mmc_gpio_request_cd() into drivers/mmc/core/slot-gpio.c.
>> Can we use this? i think we can use them.
>> Just my opinion.
> 
> Thanks for letting me know about this, I was not aware of this.
> Looking into this code, it is usable for controllers that use a gpio
> (specified using cd-gpios property) as card-detect line. As you know,
> the dw-mmc driver does not support this feature yet. In case of
> exynos, the card-detect pin of the mmc slot is connected to the
> card-detect pad of the dw-mmc controller using pinmux, which is not
> considered as a gpio. Hence, mmc_gpio_request_cd() is not applicable
> in this case.
But In case of external card-detect-pin, we can use the mmc_gpio_request_cd().

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Thomas.
> 
> 
>>
>> Best Regards,
>> Jaehoon Chung
>>> +                     dev_err(host->dev, "gpio [%d] request failed\n", gpio);
>>> +     } else {
>>> +             dev_info(host->dev, "cd gpio not available");
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/* Exynos5250 controller specific capabilities */
>>> +static unsigned long exynos5250_dwmmc_caps[4] = {
>>> +     MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
>>> +             MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
>>> +     MMC_CAP_CMD23,
>>> +     MMC_CAP_CMD23,
>>> +     MMC_CAP_CMD23,
>>> +};
>>> +
>>> +static struct dw_mci_drv_data exynos5250_drv_data = {
>>> +     .caps                   = exynos5250_dwmmc_caps,
>>> +     .init                   = dw_mci_exynos_priv_init,
>>> +     .prepare_command        = dw_mci_exynos_prepare_command,
>>> +     .set_ios                = dw_mci_exynos_set_ios,
>>> +     .parse_dt               = dw_mci_exynos_parse_dt,
>>> +     .setup_bus              = dw_mci_exynos_setup_bus,
>>> +};
>>> +
>>> +static const struct of_device_id dw_mci_exynos_match[] = {
>>> +     { .compatible = "samsung,exynos5250-dw-mshc",
>>> +                     .data = (void *)&exynos5250_drv_data, },
>>> +     {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
>>> +
>>> +int dw_mci_exynos_probe(struct platform_device *pdev)
>>> +{
>>> +     struct dw_mci_drv_data *drv_data;
>>> +     const struct of_device_id *match;
>>> +
>>> +     match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
>>> +     drv_data = match->data;
>>> +     return dw_mci_pltfm_register(pdev, drv_data);
>>> +}
>>> +
>>> +static struct platform_driver dw_mci_exynos_pltfm_driver = {
>>> +     .probe          = dw_mci_exynos_probe,
>>> +     .remove         = __exit_p(dw_mci_pltfm_remove),
>>> +     .driver         = {
>>> +             .name           = "dwmmc_exynos",
>>> +             .of_match_table = of_match_ptr(dw_mci_exynos_match),
>>> +             .pm             = &dw_mci_pltfm_pmops,
>>> +     },
>>> +};
>>> +
>>> +module_platform_driver(dw_mci_exynos_pltfm_driver);
>>> +
>>> +MODULE_DESCRIPTION("Samsung Specific DW-MSHC Driver Extension");
>>> +MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com");
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_ALIAS("platform:dwmmc-exynos");
>>>
>>
> 
