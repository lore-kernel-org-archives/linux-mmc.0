From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Wed, 10 Jun 2015 13:53:09 +0200
Message-ID: <CAPDyKFq=iHcsAXxQa0J0QEeG0c9LgpxaPUdo8KGL7NtbX6_eMA@mail.gmail.com>
References: <1433903088-14407-1-git-send-email-chaotian.jing@mediatek.com>
	<1433903088-14407-3-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36030 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbFJLxK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jun 2015 07:53:10 -0400
Received: by qgep100 with SMTP id p100so15143360qge.3
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2015 04:53:09 -0700 (PDT)
In-Reply-To: <1433903088-14407-3-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek

[...]

> +static int msdc_drv_probe(struct platform_device *pdev)
> +{
> +       struct mmc_host *mmc;
> +       struct msdc_host *host;
> +       struct resource *res;
> +       int ret;
> +
> +       if (!pdev->dev.of_node) {
> +               dev_err(&pdev->dev, "No DT found\n");
> +               return -EINVAL;
> +       }
> +       /* Allocate MMC host for this device */
> +       mmc = mmc_alloc_host(sizeof(struct msdc_host), &pdev->dev);
> +       if (!mmc)
> +               return -ENOMEM;
> +
> +       host = mmc_priv(mmc);
> +       ret = mmc_of_parse(mmc);
> +       if (ret)
> +               goto host_free;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       host->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(host->base)) {
> +               ret = PTR_ERR(host->base);
> +               goto host_free;
> +       }
> +
> +       ret = mmc_regulator_get_supply(mmc);
> +       if (ret == -EPROBE_DEFER)
> +               goto host_free;
> +
> +       host->src_clk = devm_clk_get(&pdev->dev, "source");
> +       if (IS_ERR(host->src_clk)) {
> +               ret = PTR_ERR(host->src_clk);
> +               goto host_free;
> +       }
> +
> +       host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> +       if (IS_ERR(host->h_clk)) {
> +               /* host->h_clk is optional, Only for MSDC0/3 at MT8173 */
> +               dev_dbg(&pdev->dev,
> +                               "Invalid hclk from the device tree!\n");
> +       }
> +
> +       host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq < 0) {
> +               ret = -EINVAL;
> +               goto host_free;
> +       }
> +
> +       host->pinctrl = devm_pinctrl_get(&pdev->dev);
> +       if (IS_ERR(host->pinctrl)) {
> +               ret = PTR_ERR(host->pinctrl);
> +               dev_err(&pdev->dev, "Cannot find pinctrl!\n");
> +               goto host_free;
> +       }
> +
> +       host->pins_default = pinctrl_lookup_state(host->pinctrl, "default");
> +       if (IS_ERR(host->pins_default)) {
> +               ret = PTR_ERR(host->pins_default);
> +               dev_err(&pdev->dev, "Cannot find pinctrl default!\n");
> +               goto host_free;
> +       }
> +
> +       host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
> +       if (IS_ERR(host->pins_uhs)) {
> +               ret = PTR_ERR(host->pins_uhs);
> +               dev_err(&pdev->dev, "Cannot find pinctrl uhs!\n");
> +               goto host_free;
> +       }
> +
> +       host->dev = &pdev->dev;
> +       host->mmc = mmc;
> +       host->hclk = clk_get_rate(host->src_clk);

This looks odd. The clock rate for the source clock is assigned as the
speed of hclk!? Why?

> +       /* Set host parameters to mmc */
> +       mmc->ops = &mt_msdc_ops;
> +       mmc->f_min = host->hclk / (4 * 255);
> +
> +       mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> +       /* MMC core transfer sizes tunable parameters */
> +       mmc->max_segs = MAX_BD_NUM;
> +       mmc->max_seg_size = BDMA_DESC_BUFLEN;
> +       mmc->max_blk_size = 2048;
> +       mmc->max_req_size = 512 * 1024;
> +       mmc->max_blk_count = mmc->max_req_size / 512;
> +       host->dma_mask = DMA_BIT_MASK(32);
> +       mmc_dev(mmc)->dma_mask = &host->dma_mask;
> +
> +       host->timeout_clks = 3 * 1048576;
> +       host->dma.gpd = dma_alloc_coherent(&pdev->dev,
> +                               sizeof(struct mt_gpdma_desc),
> +                               &host->dma.gpd_addr, GFP_KERNEL);
> +       host->dma.bd = dma_alloc_coherent(&pdev->dev,
> +                               MAX_BD_NUM * sizeof(struct mt_bdma_desc),
> +                               &host->dma.bd_addr, GFP_KERNEL);
> +       if (!host->dma.gpd || !host->dma.bd) {
> +               ret = -ENOMEM;
> +               goto release_mem;
> +       }
> +       msdc_init_gpd_bd(host, &host->dma);
> +       INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
> +       spin_lock_init(&host->lock);
> +
> +       platform_set_drvdata(pdev, mmc);
> +       msdc_ungate_clock(host);
> +       msdc_init_hw(host);
> +
> +       ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> +               IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
> +       if (ret)
> +               goto release;
> +
> +       ret = mmc_add_host(mmc);
> +       if (ret)
> +               goto release;
> +
> +       return 0;
> +
> +release:
> +       platform_set_drvdata(pdev, NULL);
> +       msdc_deinit_hw(host);
> +       msdc_gate_clock(host);
> +release_mem:
> +       if (host->dma.gpd)
> +               dma_free_coherent(&pdev->dev,
> +                       sizeof(struct mt_gpdma_desc),
> +                       host->dma.gpd, host->dma.gpd_addr);
> +       if (host->dma.bd)
> +               dma_free_coherent(&pdev->dev,
> +                       MAX_BD_NUM * sizeof(struct mt_bdma_desc),
> +                       host->dma.bd, host->dma.bd_addr);
> +host_free:
> +       mmc_free_host(mmc);
> +
> +       return ret;
> +}

[...]

Kind regards
Uffe
