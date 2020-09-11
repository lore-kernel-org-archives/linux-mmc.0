Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41ABC43461
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 02:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F075121941
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 02:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="QOgC4b/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKCDP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKCDO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2020 22:03:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4BC061573;
        Thu, 10 Sep 2020 19:03:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gr14so11677175ejb.1;
        Thu, 10 Sep 2020 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEZPiPwvSp1+pr7dCzwJ1u9bYXlu8VKtXAOvnlFbehc=;
        b=QOgC4b/s6UykHTFkdZSAELfdpJak5EwbEkSLC8zeYoeRsrtocmxmU5gI2W3P9dq5ja
         4s9sg8N+OKylTMi8wRh6VF/FZIJ9FD9XJSyTb2IJ9ue4h9P466cUntPUQuc3M2vsZwHJ
         6tk5tH87LY7SeSUv6qWBnPlG/rMpjxc4crgdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEZPiPwvSp1+pr7dCzwJ1u9bYXlu8VKtXAOvnlFbehc=;
        b=DOB7bk/GHWN9qOpFp9hum9InqgcaX9N+G0iPG5so94b8LxwEa8hPSkaAkf2yxR+LpB
         q4qWrrw1SqPKRY6rMpkDjRYNn4LFiYrNEDoct1YewXpUysPJVXrXjwEp4hFZLerNCfSZ
         vg0tSY0b/5aPW3smNsTJ4K8B8A8jhOm3exNsjCE4QRk4CQZ6IayNPGxkWTfWEDVjpiOR
         N8ZMRPPjEctT9pQiX5o4JrzEwhvhso+NirMMsKibJNu8AYqcuPF7z0W71sAMOpTjqo2M
         oqQmNMs7pRKtcQsH/AOKvficlU08xFc2O16SirvV+Y31ZtNB8P/BGE5iUn/oNj+FZKnq
         9WRw==
X-Gm-Message-State: AOAM532djheDa+VSIRe8IVn3BdzCMXEHuIpBM5wpH0WSqTavap9Maydu
        GB6ukpvSe5XxtXn2eXNGK7VS+RAPNhR59ZP4qC0=
X-Google-Smtp-Source: ABdhPJwhEp9Qyfs+QXTGM95VkwxGCWqdOgLu52PLOzdk6GKHUhYEku+GPwNJ2oQe7RPCCtvX80JXo/BoPO/gmhz/GJY=
X-Received: by 2002:a17:906:e918:: with SMTP id ju24mr11535634ejb.442.1599789790428;
 Thu, 10 Sep 2020 19:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200910105440.3087723-1-andrew@aj.id.au> <20200910105440.3087723-3-andrew@aj.id.au>
In-Reply-To: <20200910105440.3087723-3-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Sep 2020 02:02:58 +0000
Message-ID: <CACPK8Xf-jys=F0Uqg-hYH-eDThmd5yOSNeC7+vLhra3GdOK1Zw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-aspeed: Expose data sample phase delay tuning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 10 Sep 2020 at 10:55, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Allow sample phase adjustment to deal with layout or tolerance issues.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 137 +++++++++++++++++++++++++++--
>  1 file changed, 132 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 4f008ba3280e..641accbfcde4 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -16,9 +16,18 @@
>
>  #include "sdhci-pltfm.h"
>
> -#define ASPEED_SDC_INFO                0x00
> -#define   ASPEED_SDC_S1MMC8    BIT(25)
> -#define   ASPEED_SDC_S0MMC8    BIT(24)
> +#define ASPEED_SDC_INFO                        0x00
> +#define   ASPEED_SDC_S1_MMC8           BIT(25)
> +#define   ASPEED_SDC_S0_MMC8           BIT(24)
> +#define ASPEED_SDC_PHASE               0xf4
> +#define   ASPEED_SDC_S1_PHASE_IN       GENMASK(25, 21)
> +#define   ASPEED_SDC_S0_PHASE_IN       GENMASK(20, 16)
> +#define   ASPEED_SDC_S1_PHASE_OUT      GENMASK(15, 11)
> +#define   ASPEED_SDC_S1_PHASE_IN_EN    BIT(10)
> +#define   ASPEED_SDC_S1_PHASE_OUT_EN   GENMASK(9, 8)
> +#define   ASPEED_SDC_S0_PHASE_OUT      GENMASK(7, 3)
> +#define   ASPEED_SDC_S0_PHASE_IN_EN    BIT(2)
> +#define   ASPEED_SDC_S0_PHASE_OUT_EN   GENMASK(1, 0)
>
>  struct aspeed_sdc {
>         struct clk *clk;
> @@ -28,9 +37,21 @@ struct aspeed_sdc {
>         void __iomem *regs;
>  };
>
> +struct aspeed_sdhci_phase_desc {
> +       u32 value_mask;
> +       u32 enable_mask;
> +       u8 enable_value;
> +};
> +
> +struct aspeed_sdhci_phase {
> +       struct aspeed_sdhci_phase_desc in;
> +       struct aspeed_sdhci_phase_desc out;
> +};
> +
>  struct aspeed_sdhci {
>         struct aspeed_sdc *parent;
>         u32 width_mask;
> +       const struct aspeed_sdhci_phase *phase;
>  };
>
>  static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
> @@ -50,6 +71,25 @@ static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
>         spin_unlock(&sdc->lock);
>  }
>
> +static void
> +aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
> +                          const struct aspeed_sdhci_phase_desc *phase,
> +                          uint8_t value, bool enable)
> +{
> +       u32 reg;
> +
> +       spin_lock(&sdc->lock);

What is the lock protecting against?

We call this in the ->probe, so there should be no concurrent access going on.


> +       reg = readl(sdc->regs + ASPEED_SDC_PHASE);
> +       reg &= ~phase->enable_mask;
> +       if (enable) {
> +               reg &= ~phase->value_mask;
> +               reg |= value << __ffs(phase->value_mask);
> +               reg |= phase->enable_value << __ffs(phase->enable_mask);
> +       }
> +       writel(reg, sdc->regs + ASPEED_SDC_PHASE);
> +       spin_unlock(&sdc->lock);
> +}
> +
>  static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pltfm_host *pltfm_host;
> @@ -155,8 +195,58 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
>         return (delta / 0x100) - 1;
>  }
>
> +static int aspeed_sdhci_configure_of(struct platform_device *pdev,
> +                                    struct aspeed_sdhci *sdhci)
> +{
> +       u32 iphase, ophase;
> +       struct device_node *np;
> +       struct device *dev;
> +       int ret;
> +
> +       if (!sdhci->phase)
> +               return 0;
> +
> +       dev = &pdev->dev;
> +       np = dev->of_node;
> +
> +       ret = of_property_read_u32(np, "aspeed,input-phase", &iphase);
> +       if (ret < 0) {
> +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in, 0,
> +                                          false);

Will this clear any value that eg. u-boot writes?

The register should be left alone if the kernel doesn't have a
configuration of it's own, otherwise we may end up breaking an
otherwise working system.

> +               dev_dbg(dev, "Input phase configuration disabled");
> +       } else if (iphase >= (1 << 5)) {
> +               dev_err(dev,
> +                       "Input phase value exceeds field range (5 bits): %u",
> +                       iphase);
> +               return -ERANGE;
> +       } else {
> +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in,
> +                                          iphase, true);
> +               dev_info(dev, "Input phase relationship: %u", iphase);

Make theis _dbg, on a normal boot we don't need this chatter in the logs.

The same comments apply for the output.

> +       }
> +
> +       ret = of_property_read_u32(np, "aspeed,output-phase", &ophase);
> +       if (ret < 0) {
> +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->out, 0,
> +                                          false);
> +               dev_dbg(dev, "Output phase configuration disabled");
> +       } else if (ophase >= (1 << 5)) {
> +               dev_err(dev,
> +                       "Output phase value exceeds field range (5 bits): %u",
> +                       iphase);
> +               return -ERANGE;

This will cause the driver to fail to probe. I think skipping setting
of the phase is a better option.


> +       } else {
> +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->out,
> +                                          ophase, true);
> +               dev_info(dev, "Output phase relationship: %u", ophase);
> +       }
> +
> +       return 0;
> +}
> +
>  static int aspeed_sdhci_probe(struct platform_device *pdev)
>  {
> +       const struct aspeed_sdhci_phase *phase;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct aspeed_sdhci *dev;
>         struct sdhci_host *host;
> @@ -181,7 +271,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>                 return -EINVAL;
>
>         dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
> -       dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
> +       dev->width_mask = !slot ? ASPEED_SDC_S0_MMC8 : ASPEED_SDC_S1_MMC8;
> +       phase = of_device_get_match_data(&pdev->dev);
> +       if (phase)
> +               dev->phase = &phase[slot];
>
>         sdhci_get_of_property(pdev);
>
> @@ -195,6 +288,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>                 goto err_pltfm_free;
>         }
>
> +       ret = aspeed_sdhci_configure_of(pdev, dev);
> +       if (ret)
> +               goto err_sdhci_add;
> +
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
>                 goto err_sdhci_add;
> @@ -230,10 +327,40 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static const struct aspeed_sdhci_phase ast2600_sdhci_phase[] = {
> +       /* SDHCI/Slot 0 */
> +       [0] = {
> +               .in = {
> +                       .value_mask = ASPEED_SDC_S0_PHASE_IN,
> +                       .enable_mask = ASPEED_SDC_S0_PHASE_IN_EN,
> +                       .enable_value = 1,
> +               },
> +               .out = {
> +                       .value_mask = ASPEED_SDC_S0_PHASE_OUT,
> +                       .enable_mask = ASPEED_SDC_S0_PHASE_OUT_EN,
> +                       .enable_value = 3,
> +               },
> +       },
> +       /* SDHCI/Slot 1 */
> +       [1] = {
> +               .in = {
> +                       .value_mask = ASPEED_SDC_S1_PHASE_IN,
> +                       .enable_mask = ASPEED_SDC_S1_PHASE_IN_EN,
> +                       .enable_value = 1,
> +               },
> +               .out = {
> +                       .value_mask = ASPEED_SDC_S1_PHASE_OUT,
> +                       .enable_mask = ASPEED_SDC_S1_PHASE_OUT_EN,

Is there any value in splitting the input and output phase values
up? (instead of taking the property from the device tree and putting
it in the hardware).

> +                       .enable_value = 3,
> +               },
> +       },
> +};
> +
> +/* If supported, phase adjustment fields are stored in the data pointer */
>  static const struct of_device_id aspeed_sdhci_of_match[] = {
>         { .compatible = "aspeed,ast2400-sdhci", },
>         { .compatible = "aspeed,ast2500-sdhci", },
> -       { .compatible = "aspeed,ast2600-sdhci", },
> +       { .compatible = "aspeed,ast2600-sdhci", .data = ast2600_sdhci_phase },
>         { }
>  };
>
> --
> 2.25.1
>
