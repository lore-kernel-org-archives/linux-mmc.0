From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 12/14] mmc: sdhci-pic32: Add PIC32 SDHCI host
 controller driver
Date: Wed, 16 Dec 2015 11:48:16 +0100
Message-ID: <CAPDyKFpQeq-9G_=n62c8uE+Tkiz3o9jManiOuCZG2qNKwkZ5EQ@mail.gmail.com>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
	<1450133093-7053-13-git-send-email-joshua.henderson@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36275 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbLPKsR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2015 05:48:17 -0500
Received: by mail-qk0-f172.google.com with SMTP id t125so56986949qkh.3
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2015 02:48:16 -0800 (PST)
In-Reply-To: <1450133093-7053-13-git-send-email-joshua.henderson@microchip.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joshua Henderson <joshua.henderson@microchip.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Andrei Pistirica <andrei.pistirica@microchip.com>, Jean Delvare <jdelvare@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Corneliu Doban <cdoban@broadcom.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Luis de Bethencourt <luisbg@osg.samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Lokesh Vutla <lokeshvutla@ti.com>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, yangbo lu <yangbo.lu@freescale.com>, Kevin Hao <haokexin@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Andy Green <andy.green@linaro.org>linux-mmc <linux-m>

[...]

> +static int pic32_sdhci_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct sdhci_host *host;
> +       struct resource *iomem;
> +       struct pic32_sdhci_pdata *sdhci_pdata;
> +       struct pic32_sdhci_platform_data *plat_data;
> +       unsigned int clk_rate = 0;
> +       int ret;
> +       struct pinctrl *pinctrl;
> +
> +       host = sdhci_alloc_host(dev, sizeof(*sdhci_pdata));
> +       if (IS_ERR(host)) {
> +               ret = PTR_ERR(host);
> +               dev_err(&pdev->dev, "cannot allocate memory for sdhci\n");
> +               goto err;
> +       }
> +
> +       sdhci_pdata = sdhci_priv(host);
> +       sdhci_pdata->pdev = pdev;
> +       platform_set_drvdata(pdev, host);
> +
> +       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       host->ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
> +       if (IS_ERR(host->ioaddr)) {
> +               ret = PTR_ERR(host->ioaddr);
> +               dev_err(&pdev->dev, "unable to map iomem: %d\n", ret);
> +               goto err_host;
> +       }
> +
> +       plat_data = pdev->dev.platform_data;
> +       if (plat_data && plat_data->setup_dma) {
> +               ret = plat_data->setup_dma(ADMA_FIFO_RD_THSHLD,
> +                                          ADMA_FIFO_WR_THSHLD);
> +               if (ret)
> +                       goto err_host;
> +       }
> +
> +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);

This isn't need as it's already handled by the PM core.

> +       if (IS_ERR(pinctrl)) {
> +               ret = PTR_ERR(pinctrl);
> +               dev_warn(&pdev->dev, "No pinctrl provided %d\n", ret);
> +               if (ret == -EPROBE_DEFER)
> +                       goto err_host;
> +       }
> +
> +       host->ops = &pic32_sdhci_ops;
> +       host->irq = platform_get_irq(pdev, 0);
> +
> +       sdhci_pdata->sys_clk = devm_clk_get(&pdev->dev, "sys_clk");
> +       if (IS_ERR(sdhci_pdata->sys_clk)) {
> +               ret = PTR_ERR(sdhci_pdata->sys_clk);
> +               dev_err(&pdev->dev, "Error getting clock\n");
> +               goto err_host;
> +       }
> +
> +       /* Enable clock when available! */
> +       ret = clk_prepare_enable(sdhci_pdata->sys_clk);
> +       if (ret) {
> +               dev_dbg(&pdev->dev, "Error enabling clock\n");
> +               goto err_host;
> +       }
> +
> +       /* SDH CLK enable */
> +       sdhci_pdata->base_clk = devm_clk_get(&pdev->dev, "base_clk");
> +       if (IS_ERR(sdhci_pdata->base_clk)) {
> +               ret = PTR_ERR(sdhci_pdata->base_clk);
> +               dev_err(&pdev->dev, "Error getting clock\n");
> +               goto err_host;
> +       }
> +
> +       /* Enable clock when available! */
> +       ret = clk_prepare_enable(sdhci_pdata->base_clk);
> +       if (ret) {
> +               dev_dbg(&pdev->dev, "Error enabling clock\n");
> +               goto err_host;
> +       }
> +
> +       clk_rate = clk_get_rate(sdhci_pdata->base_clk);
> +       dev_dbg(&pdev->dev, "base clock at: %u\n", clk_rate);
> +       clk_rate = clk_get_rate(sdhci_pdata->sys_clk);
> +       dev_dbg(&pdev->dev, "sys clock at: %u\n", clk_rate);

This looks like some leftover from a debugging task. Can you remove them?

> +
> +       host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> +
> +       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)

>From this point, the error handling doesn't undo clk_prepare_enable().
Please add that.

> +               goto err_host;
> +
> +       ret = pic32_sdhci_probe_platform(pdev, sdhci_pdata);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to probe platform!\n");
> +               goto err_host;
> +       }
> +
> +       ret = sdhci_add_host(host);
> +       if (ret) {
> +               dev_dbg(&pdev->dev, "error adding host\n");
> +               goto err_host;
> +       }
> +
> +       dev_info(&pdev->dev, "Successfully added sdhci host\n");
> +       return 0;
> +
> +err_host:
> +       sdhci_free_host(host);
> +err:
> +       dev_err(&pdev->dev, "pic32-sdhci probe failed: %d\n", ret);
> +       return ret;

A general comment for the ->probe() and the below ->remove() callback,
is that you should probably be able to convert to use
sdhci_pltfm_init() and sdhci_pltfm_free() in favor of
sdhci_alloc_host() and sdhci_free_host().

I think that could simplify the code a bit.

> +}
> +
> +static int pic32_sdhci_remove(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct pic32_sdhci_pdata *sdhci_pdata = sdhci_priv(host);
> +       int dead = 0;
> +       u32 scratch;
> +
> +       scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
> +       if (scratch == (u32)-1)
> +               dead = 1;
> +
> +       sdhci_remove_host(host, dead);
> +       clk_disable_unprepare(sdhci_pdata->base_clk);
> +       clk_disable_unprepare(sdhci_pdata->sys_clk);
> +       sdhci_free_host(host);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id pic32_sdhci_id_table[] = {
> +       { .compatible = "microchip,pic32mzda-sdhci" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, pic32_sdhci_id_table);
> +
> +static struct platform_driver pic32_sdhci_driver = {
> +       .driver = {
> +               .name   = DEV_NAME,
> +               .owner  = THIS_MODULE,
> +               .of_match_table = of_match_ptr(pic32_sdhci_id_table),
> +       },
> +       .probe          = pic32_sdhci_probe,
> +       .remove         = pic32_sdhci_remove,
> +};
> +
> +module_platform_driver(pic32_sdhci_driver);
> +
> +MODULE_DESCRIPTION("Microchip PIC32 SDHCI driver");
> +MODULE_AUTHOR("Pistirica Sorin Andrei & Sandeep Sheriker");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.9.5
>

Kind regards
Uffe
