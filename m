Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794E4C2B9F8
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D18E61370
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhEXONa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhEXONR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:13:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F29C06138F
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id v8so35884027lft.8
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yZGsZDGj6VwJI2huNhq3QoEWnA9XjvVe/EfZq4y7IU=;
        b=pbgNUmfpmE+TUnwYGWa4+Cr8UT5p+RNDrrQf6fokKwwro+TbWKERs2VaUCqCAqsBxA
         I5TWFMPioWQdKlL+6MfKFR/wp6EmqQGuoA1C+6bhCqfstK6RzS/ZhkqYuPyoxo8WbNBc
         XlsOS3fFXH+dAkql4342osYDPx8Ey7GqFptWyAYbp/ASsmyS6WraUNbATVAUcgzJWo/K
         T6rVcFOxsVeIqWjoSbjOdE7Eb1irD5xl1pBziojPDGreqr1x00ExHeA284yUpteD6x6y
         euIdJh+5pr5YNBBWZJPQM0Fvc9Dg+KbpX6mRFnYuB28NPTOIu37uncKP0J3Z/9GJZ8gM
         63ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yZGsZDGj6VwJI2huNhq3QoEWnA9XjvVe/EfZq4y7IU=;
        b=K8Rx7KF3qohNgVUQAWVgsuAcZWyyUt+f01Td4Q93SENDxBddMiE8j2Q/me5WkHnN4l
         6gnyhOhdJsXDqm0R9P627Q0qeXO3UY3fN8tG7OHYdyU1wQYnfleMgJ7SBMvfyMQDUgxC
         q4fCenwazyeOAzz2DN4S/Lwuez6JFbprafBkPmbmUv2ZQSuOSQXLC/vgAd9KFJOih0vk
         2nHQX34sSLHzAGAvirgyhaFXXriCFNWAOOZ+JJf8Rn5+cm4w//LwH2659r8F4oUPrBpl
         cY31o6TA60RX/Ro6WLXTXAC7EwCL/ZKNzSGhK65I8faIlKAh3geguULyt6TiQkDlJw+4
         iqkA==
X-Gm-Message-State: AOAM530HJmBb1JPelKd34jfR/5lNZfHZ9plpD1b5IUseW7CdNkaeafzg
        YHiuC+z/57k/Q5RdZ9GaiOb4+/Ya+rV85Q5IykOZwg==
X-Google-Smtp-Source: ABdhPJw3DDszILd4fOwSk02DmS3LBF/6L9iWayO0ZEI9oK+oW8u6lCsJSES4QzzosVigXKy0dhQfIFXD4tnEHBmlMEw=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr11106312lfq.29.1621865507531;
 Mon, 24 May 2021 07:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210524073308.9328-1-steven_lee@aspeedtech.com> <20210524073308.9328-5-steven_lee@aspeedtech.com>
In-Reply-To: <20210524073308.9328-5-steven_lee@aspeedtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:11:08 +0200
Message-ID: <CAPDyKFqd+ZdPVuFKf-C7ztQp_aH9HOXByq6qwykkdU9Aku3pAA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mmc: sdhci-of-aspeed: Configure the SDHCIs as
 specified by the devicetree.
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        Hongweiz@ami.com, ryan_chen@aspeedtech.com,
        chin-ting_kuo@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 May 2021 at 09:33, Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> The hardware provides capability configuration registers for each SDHCI
> in the global configuration space for the SD controller. Writes to the
> global capability registers are mirrored to the capability registers in
> the associated SDHCI. Configuration of the capabilities must be written
> through the mirror registers prior to initialisation of the SDHCI.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied for next, thanks!

Kind regards
Uffe


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
