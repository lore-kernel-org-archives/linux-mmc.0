Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A22DC04FCF
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 13:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576E061359
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 13:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhEJNbE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 May 2021 09:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbhEJL7d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 May 2021 07:59:33 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AF9C061574
        for <linux-mmc@vger.kernel.org>; Mon, 10 May 2021 04:58:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p12so20480043ljg.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 May 2021 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFRQ/drBdPg7ZZp1TCqbFVmnAdonsbp2deXEgt0fqmw=;
        b=vq5PpmaeU3MP6Sy8enG8y49x3jq0MrmAGFgas9S689VjzeIJJhbgOUnkK0h/sA3gLe
         zKv9EP40lHnoRD+F/p2BJfMPWO3JURaD0hyUxH7KKv6ipGN92GvQ+1DgFDf8nP4HZW91
         uQHm2dU4528BB5uBe4S3EGB8Ok/iqxN2+FiAFPPTgPqoLzrruDGnIllsVwmAxnlRcbiN
         tJxa/xAcTxsAiCAnGQSmFH91rA0/NHbv/HKqAp/2acCEsCLlxHezX11rT8zG+JZFAOa2
         /UX7wjiqccvw0ohdqZMNmmo9kbcdJdps0HZ70TYgc0PrhNCmOWFXv/SeMWCVjIrnKAwG
         /bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFRQ/drBdPg7ZZp1TCqbFVmnAdonsbp2deXEgt0fqmw=;
        b=mpGG0J5+fUbJp9VPfjiFYTNP9D7PmaMRuyhRQwFeBLxK17YzhYU1WMPtmXeedSu0ms
         +JNqijtnwDpdDERBgKFp9q6qGPyCei1Jlp4eM82iJdGIONXHFWo7rAjQQzHWXMnX1RHL
         bX3SKshVf+5KrsZ+LdB64axoK+244GiYXIdzjjVyzYiRnKJFjhMKjdm9kZgiUsDDj0EI
         T5NA0QObolxFq17hoV4wGXF2GAzewpt0ku2k/T1qWpgZItpH3CG0Y41zRSfxPOnAZxIV
         H1F9B4NShnguj9IarK0pyP7MWDOHP3XkSjpEv1nW0G0+d/E5V5HToyFogMdeSiApZ00x
         HVeA==
X-Gm-Message-State: AOAM5310I+8ePl2lrSUR7gdjLnzNPn5WgDbX1otVSe0X2/RnAaQooJHi
        7lOpMLtoziHT6YOC4WGdIclV9P40x5aZ5Ex8FYEIzg==
X-Google-Smtp-Source: ABdhPJz+qnPc2pLYqjAXrtHKfZd3fBdOtz1Tm6Tvo+o4U9Zg+CZ7jom1nqDxFJCpWbD7JQkfUcvWMQhXu1j/pp3thu0=
X-Received: by 2002:a2e:7f1c:: with SMTP id a28mr20039955ljd.341.1620647904669;
 Mon, 10 May 2021 04:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210414085121.28951-1-peng.zhou@mediatek.com> <20210414085121.28951-2-peng.zhou@mediatek.com>
In-Reply-To: <20210414085121.28951-2-peng.zhou@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 May 2021 13:57:48 +0200
Message-ID: <CAPDyKFpOzmYxstRwSrD6tWKLMwxFPvHNfpDPDCrogzRah5iZtA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 1/3] mmc: Mediatek: add Inline Crypto Engine support
To:     Peng Zhou <peng.zhou@mediatek.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wulin Li <wulin.li@mediatek.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 14 Apr 2021 at 11:12, Peng Zhou <peng.zhou@mediatek.com> wrote:
>
> From: Peng Zhou <Peng.Zhou@mediatek.com>
>
> 1. add crypto clock control and ungate it before CQHCI init
>
> 2. set MMC_CAP2_CRYPTO property of eMMC
>
> Signed-off-by: Peng Zhou <Peng.Zhou@mediatek.com>

As discussed [1], I think the ARM SMC call should be managed together
with the crypto clock, from a PM domain (a genpd provider).

These are the steps I think should help to get this supported:

1)
Add a new generic mmc DT property for crypto support. Make it being
parsed from mmc_of_parse() and let it set MMC_CAP2_CRYPTO.

2)
Start by adding a genpd provider in DT and implement support for it in
drivers/soc/*. See
Documentation/devicetree/bindings/power/power-domain.yaml, for generic
DT bindings.

If you already have a genpd provider for the device, you may either
extend it to cope with the below or implement a new and model the it
as a child (subdomain) of the existing one.

3)
To fetch the crypto clock during probe, the genpd provider should
implement the ->attach|detach_dev() callbacks. The ->attach_dev()
callback is invoked from genpd_add_device(), which is called while
probing the device. Vice verse for the ->detach_dev() callback.

4)
Ungating/gating the clock should be implemented from the genpd
provider's ->start|stop() callbacks. These callbacks are called from
genpd_runtime_suspend|resume(), thus when the device gets runtime
suspended/resumed. As the mmc host driver already supports runtime PM,
only a minor update in the driver's ->probe() is needed, which is to
call dev_pm_domain_start(). This turns on the crypto clock and allows
its registers to be accessed.

5)
Add also the ARM SMC calls to the genpd provider's ->start|stop()
callbacks. This means those gets called from SoC specific code, which
helps to keep the driver portable.

6)
Add the crypto clock DT binding for the mmc host.

7)
Wire up the mmc host device node in DT to be attached to the genpd
provider (see power-domains and power-domain-names properties). Make
sure to also specify the crypto clock and the new mmc crypto property
for it.

Please, just ask if there is anything unclear. I will do my best to help!

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-mmc/patch/20210309015750.6283-1-peng.zhou@mediatek.com/

> ---
>  drivers/mmc/host/mtk-sd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 898ed1b023df..1c90360d6cf2 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -442,6 +442,7 @@ struct msdc_host {
>         struct clk *src_clk_cg; /* msdc source clock control gate */
>         struct clk *sys_clk_cg; /* msdc subsys clock control gate */
>         struct clk_bulk_data bulk_clks[MSDC_NR_CLOCKS];
> +       struct clk *crypto_clk; /* msdc crypto clock */
>         u32 mclk;               /* mmc subsystem clock frequency */
>         u32 src_clk_freq;       /* source clock frequency */
>         unsigned char timing;
> @@ -802,6 +803,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
>
>  static void msdc_gate_clock(struct msdc_host *host)
>  {
> +       clk_disable_unprepare(host->crypto_clk);
>         clk_bulk_disable_unprepare(MSDC_NR_CLOCKS, host->bulk_clks);
>         clk_disable_unprepare(host->src_clk_cg);
>         clk_disable_unprepare(host->src_clk);
> @@ -822,6 +824,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
>                 dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
>                 return;
>         }
> +       clk_prepare_enable(host->crypto_clk);
>
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
> @@ -2512,6 +2515,15 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 goto host_free;
>         }
>
> +       /* only eMMC has crypto property */
> +       if ((mmc->caps2 & MMC_CAP2_NO_SD) && (mmc->caps2 & MMC_CAP2_NO_SDIO)) {
> +               host->crypto_clk = devm_clk_get(&pdev->dev, "crypto");
> +               if (IS_ERR(host->crypto_clk))
> +                       host->crypto_clk = NULL;
> +               else
> +                       mmc->caps2 |= MMC_CAP2_CRYPTO;
> +       }
> +
>         host->irq = platform_get_irq(pdev, 0);
>         if (host->irq < 0) {
>                 ret = -EINVAL;
> @@ -2582,6 +2594,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 host->dma_mask = DMA_BIT_MASK(32);
>         mmc_dev(mmc)->dma_mask = &host->dma_mask;
>
> +       /* here ungate due to cqhci init will access registers */
> +       msdc_ungate_clock(host);
>         if (mmc->caps2 & MMC_CAP2_CQE) {
>                 host->cq_host = devm_kzalloc(mmc->parent,
>                                              sizeof(*host->cq_host),
> @@ -2618,7 +2632,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         spin_lock_init(&host->lock);
>
>         platform_set_drvdata(pdev, mmc);
> -       msdc_ungate_clock(host);
>         msdc_init_hw(host);
>
>         ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> --
> 2.18.0
