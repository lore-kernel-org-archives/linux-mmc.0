Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE5DC433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 21 May 2021 01:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFA961355
	for <linux-mmc@archiver.kernel.org>; Fri, 21 May 2021 01:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbhEUB3j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 May 2021 21:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbhEUB3i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 21:29:38 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D9CC061574;
        Thu, 20 May 2021 18:28:16 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 82so6894974qki.8;
        Thu, 20 May 2021 18:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rs6thmgUaHVj6lO+92UyZl2hfWUhp6SVg7wcSk1xLCw=;
        b=Sl1Wz/gv5tJHWD0z4jeICdsW+RE8XAfqAOSO/1BC93sOBPkZYhRKmHxgOZgzUDMmw2
         GEnDmKkh8xIziJalEyTy5SClAFAcPCw92c1GMJwPWarH/4sMOE3DtXO8J23dTlKY6tws
         ahB/4m7ZvKuIF53WudkhcLTgr4aE8oJS9ElOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rs6thmgUaHVj6lO+92UyZl2hfWUhp6SVg7wcSk1xLCw=;
        b=rk4+xXjrKmYGls5IEz+T48qTavwIQo8UOuJzckNOoWCjMsDOusIHRYPLEfclI2cB9v
         Jei56cWfL2mxKyA7zMazVGvQSAEWL8vG2tKgfyOlXV5fwT9MGXOJ9k/W72G5lxK+6H2g
         BGAQJXgrUpzAsACx1ep2LUGLgJ0RT3qbTFK30x/fXFzsoXsZYb0c7MhMdxydtU6Bw/Qy
         8fJNYb7RfnRBwAj9cFqxu2jqkKTc1o9iU9/V5uETOFkMTtwxjxviVmI13K+FqzW3rWNe
         LJsD3m5iijNByjOszH3Hj+F5rGWqk99pqYMDOb6NDrxMIdQVixW1N6CeYwP/OE2JIkq4
         LbJQ==
X-Gm-Message-State: AOAM531cVodtlzS0jochiGRicN5u5xryB9vTyeEfpVMNaFtQHwCPkO43
        djRK55TOa3xrJOsLpHMvBC4v4uh52b7PZMJtra8=
X-Google-Smtp-Source: ABdhPJy4l49xEG6HNUsRy/adcsP5Eli0FTi8QH22aHxqC4c1gU4AN7/BSZ7Emt8VD9GxZPcrBMLUTFfORw5nqV3HKo0=
X-Received: by 2002:a05:620a:704:: with SMTP id 4mr7956453qkc.66.1621560495404;
 Thu, 20 May 2021 18:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210520101346.16772-1-steven_lee@aspeedtech.com> <20210520101346.16772-4-steven_lee@aspeedtech.com>
In-Reply-To: <20210520101346.16772-4-steven_lee@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 21 May 2021 01:28:03 +0000
Message-ID: <CACPK8XfbNyAswQtpbc=Ymv2wNmh0MbJqQEibD1R-cU+FWcckMA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mmc: sdhci-of-aspeed: Configure the SDHCIs as
 specified by the devicetree.
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 May 2021 at 10:16, Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> The hardware provides capability configuration registers for each SDHCI
> in the global configuration space for the SD controller. Writes to the
> global capability registers are mirrored to the capability registers in
> the associated SDHCI. Configuration of the capabilities must be written
> through the mirror registers prior to initialisation of the SDHCI.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

MMC maintainers, please ignore my other mail about taking the dts
patch through your tree. I didn't realise there were two dts patches;
I'll take them both through the aspeed tree once they are ready.
Please don't let that review stop you from applying this patch.

Cheers,

Joel

> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 48 ++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index d001c51074a0..65b5685f6c15 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -31,6 +31,11 @@
>  #define   ASPEED_SDC_S0_PHASE_OUT_EN   GENMASK(1, 0)
>  #define   ASPEED_SDC_PHASE_MAX         31
>
> +/* SDIO{10,20} */
> +#define ASPEED_SDC_CAP1_1_8V           (0 * 32 + 26)
> +/* SDIO{14,24} */
> +#define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
> +
>  struct aspeed_sdc {
>         struct clk *clk;
>         struct resource *res;
> @@ -72,6 +77,37 @@ struct aspeed_sdhci {
>         const struct aspeed_sdhci_phase_desc *phase_desc;
>  };
>
> +/*
> + * The function sets the mirror register for updating
> + * capbilities of the current slot.
> + *
> + *   slot | capability  | caps_reg | mirror_reg
> + *   -----|-------------|----------|------------
> + *     0  | CAP1_1_8V   | SDIO140  |   SDIO10
> + *     0  | CAP2_SDR104 | SDIO144  |   SDIO14
> + *     1  | CAP1_1_8V   | SDIO240  |   SDIO20
> + *     1  | CAP2_SDR104 | SDIO244  |   SDIO24
> + */
> +static void aspeed_sdc_set_slot_capability(struct sdhci_host *host, struct aspeed_sdc *sdc,
> +                                          int capability, bool enable, u8 slot)
> +{
> +       u32 mirror_reg_offset;
> +       u32 cap_val;
> +       u8 cap_reg;
> +
> +       if (slot > 1)
> +               return;
> +
> +       cap_reg = capability / 32;
> +       cap_val = sdhci_readl(host, 0x40 + (cap_reg * 4));
> +       if (enable)
> +               cap_val |= BIT(capability % 32);
> +       else
> +               cap_val &= ~BIT(capability % 32);
> +       mirror_reg_offset = ((slot + 1) * 0x10) + (cap_reg * 4);
> +       writel(cap_val, sdc->regs + mirror_reg_offset);
> +}
> +
>  static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
>                                            struct aspeed_sdhci *sdhci,
>                                            bool bus8)
> @@ -328,6 +364,7 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
>  static int aspeed_sdhci_probe(struct platform_device *pdev)
>  {
>         const struct aspeed_sdhci_pdata *aspeed_pdata;
> +       struct device_node *np = pdev->dev.of_node;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct aspeed_sdhci *dev;
>         struct sdhci_host *host;
> @@ -372,6 +409,17 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>
>         sdhci_get_of_property(pdev);
>
> +       if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
> +           of_property_read_bool(np, "sd-uhs-sdr104")) {
> +               aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP1_1_8V,
> +                                              true, slot);
> +       }
> +
> +       if (of_property_read_bool(np, "sd-uhs-sdr104")) {
> +               aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP2_SDR104,
> +                                              true, slot);
> +       }
> +
>         pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(pltfm_host->clk))
>                 return PTR_ERR(pltfm_host->clk);
> --
> 2.17.1
>
