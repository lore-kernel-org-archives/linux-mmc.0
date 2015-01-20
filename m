From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 4/4] mmc: sdhci: host: add new f_sdh30
Date: Tue, 20 Jan 2015 09:43:18 +0100
Message-ID: <CAPDyKFr0a_tyP5UQXOxSZ-C+w7sXPZv6oNdTDvRMcfTimYtOPw@mail.gmail.com>
References: <1421741118-18743-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1421741118-18743-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:62789 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbbATInT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 03:43:19 -0500
Received: by mail-qc0-f181.google.com with SMTP id l6so21062789qcy.12
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 00:43:18 -0800 (PST)
In-Reply-To: <1421741118-18743-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Andy Green <andy.green@linaro.org>, Patch Tracking <patches@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>, Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>

On 20 January 2015 at 09:05, Vincent Yang
<vincent.yang.fujitsu@gmail.com> wrote:
> This patch adds new host controller driver for
> Fujitsu SDHCI controller f_sdh30.
>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>

Thanks! I have applied this patchset for next, with the below minor changes.

[...]

> +
> +static int sdhci_f_sdh30_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host;
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       int irq, ctrl = 0, ret = 0;
> +       struct f_sdhost_priv *priv;
> +       u32 reg = 0;
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(dev, "%s: no irq specified\n", __func__);
> +               return irq;
> +       }
> +
> +       host = sdhci_alloc_host(dev, sizeof(struct sdhci_host) +
> +                                               sizeof(struct f_sdhost_priv));
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       priv = sdhci_priv(host);
> +       priv->dev = dev;
> +
> +       host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +                      SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> +       host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
> +                       SDHCI_QUIRK2_TUNING_WORK_AROUND;
> +
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)
> +               goto err;
> +
> +       platform_set_drvdata(pdev, host);
> +
> +       sdhci_get_of_property(pdev);
> +       host->hw_name = "f_sdh30";
> +       host->ops = &sdhci_f_sdh30_ops;
> +       host->irq = irq;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       host->ioaddr = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(host->ioaddr)) {
> +               ret = PTR_ERR(host);
> +               goto err;
> +       }
> +
> +       priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
> +       if (IS_ERR(priv->clk_iface)) {
> +               ret = PTR_ERR(priv->clk_iface);
> +               dev_err(&pdev->dev, "iface clk setup failed (%d)\n", ret);

No need to print this.

> +               goto err;
> +       }
> +
> +       ret = clk_prepare_enable(priv->clk_iface);
> +       if (ret)
> +               goto err;
> +
> +       priv->clk = devm_clk_get(&pdev->dev, "core");
> +       if (IS_ERR(priv->clk)) {
> +               ret = PTR_ERR(priv->clk);
> +               dev_err(&pdev->dev, "core clk setup failed (%d)\n", ret);

No need to print this.

> +               goto err_clk;
> +       }
> +
> +       ret = clk_prepare_enable(priv->clk);
> +       if (ret)
> +               goto err_clk;
> +

[...]

Kind regards
Uffe
