Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040A8C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 12:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9AB608FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 12:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhFHMo3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:44:29 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:40952 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhFHMo3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 08:44:29 -0400
Received: by mail-ua1-f45.google.com with SMTP id d18so279460ual.7
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mcc8OYc1xINsDjGaAzn2LnDPNNAqALk30CWabYfEJ5Y=;
        b=ae0mnRjOIMn1cVt/lfPKFZ+dihY+iVQiOB120cuEUj9cs4YROrh3apZGQSzDgRbtlQ
         6VMqpdt+vo7uIubvyFJ/Gx8sXMH/cCATEK4+QHruCfTWpe/arCeuwdIsjxRCeGuxCy/T
         3/l9qXGBLWYlUf0UO1fouktqbEeWW0bhbJn4a9o5sPOB9J/ev9MesoPHr9U1j2NAxzKy
         fWLwR7FRoH4KaROXLt+TtwVt/t1rNDMycHYALf5xLoDJRfmpceC9CP5luc1gX3BMBtw9
         OfM8ymR4sp3l5h+b6rYCj4WUoUF0xGfhCxVD6Kn0RP4vW8YwWgb6yEc53dzg+868y8+Y
         un7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mcc8OYc1xINsDjGaAzn2LnDPNNAqALk30CWabYfEJ5Y=;
        b=WHCqM7QX4T4CWon5WgNdFIzf8XibjLZPvoaFd9dQAdJuH9C/dHoyoD6rZMtkc+urXB
         r2+jw5CZQQR++F0nc8lVOj51u6b6VVAMsJGT939Wm3vUwg1DmTf3RaYD3NxEWyDcB7o/
         8VPMRTGIODEaEwQYAMk+MjGrT1hvmj8Y1YBLm1u8Urv+7RE3AfnSv/TVqfN7/ru0soF8
         aGcNpx20J4e4v3MD6WvdHmw0n0jmmIWykAmNte2kjcvCmBLRVNcrWEvEBhrVIqv6UAa1
         V2g1+iugJQOVCpA5ZcisQP8ZUO8uB2p0FV2H1+5Ay1SXGa4xRM8ssap5H91wwV6xNkSc
         SwlA==
X-Gm-Message-State: AOAM531jP2GJc5mDLq/o/KSqlXb2eA91AXoK5blCZRxGvgyImw8g29Tw
        gevVv7yqWqjBP7sW96kH6QhHOiGSU+cA4QNDR8SsJQ==
X-Google-Smtp-Source: ABdhPJxaPShcDb8weegxYcT+6lqT0m9ossZqMq8qD5rdHUJ1HszEh+p7p3IuISUl9zNHrKvoARqbkguEnZU/w/ywjho=
X-Received: by 2002:ab0:7c5b:: with SMTP id d27mr12310573uaw.15.1623156082979;
 Tue, 08 Jun 2021 05:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210602192758.38735-1-alcooperx@gmail.com> <20210602192758.38735-2-alcooperx@gmail.com>
In-Reply-To: <20210602192758.38735-2-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 14:40:46 +0200
Message-ID: <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
>
> Add support for the legacy Arasan sdhci controller on the BCM7211 and
> related SoC's. This includes adding a .shutdown callback to increase
> the power savings during S5.

Please split this into two separate changes.

May I also ask about the ->shutdown() callback and in relation to S5.
What makes the ->shutdown callback only being invoked for S5?

Kind regards
Uffe

>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/mmc/host/Kconfig       |  2 +-
>  drivers/mmc/host/sdhci-iproc.c | 30 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h       |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index a4d4c757eea0..561184fa7eb9 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -412,7 +412,7 @@ config MMC_SDHCI_MILBEAUT
>
>  config MMC_SDHCI_IPROC
>         tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
> -       depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
> +       depends on ARCH_BCM2835 || ARCH_BCM_IPROC || ARCH_BRCMSTB || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         depends on OF || ACPI
>         default ARCH_BCM_IPROC
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index ddeaf8e1f72f..cce390fe9cf3 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -286,11 +286,35 @@ static const struct sdhci_iproc_data bcm2711_data = {
>         .mmc_caps = MMC_CAP_3_3V_DDR,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_bcm7211a0_pltfm_data = {
> +       .quirks = SDHCI_QUIRK_MISSING_CAPS |
> +               SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +               SDHCI_QUIRK_BROKEN_DMA |
> +               SDHCI_QUIRK_BROKEN_ADMA,
> +       .ops = &sdhci_iproc_ops,
> +};
> +
> +#define BCM7211A0_BASE_CLK_MHZ 100
> +static const struct sdhci_iproc_data bcm7211a0_data = {
> +       .pdata = &sdhci_bcm7211a0_pltfm_data,
> +       .caps = ((BCM7211A0_BASE_CLK_MHZ / 2) << SDHCI_TIMEOUT_CLK_SHIFT) |
> +               (BCM7211A0_BASE_CLK_MHZ << SDHCI_CLOCK_BASE_SHIFT) |
> +               ((0x2 << SDHCI_MAX_BLOCK_SHIFT)
> +                       & SDHCI_MAX_BLOCK_MASK) |
> +               SDHCI_CAN_VDD_330 |
> +               SDHCI_CAN_VDD_180 |
> +               SDHCI_CAN_DO_SUSPEND |
> +               SDHCI_CAN_DO_HISPD,
> +       .caps1 = SDHCI_DRIVER_TYPE_C |
> +                SDHCI_DRIVER_TYPE_D,
> +};
> +
>  static const struct of_device_id sdhci_iproc_of_match[] = {
>         { .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
>         { .compatible = "brcm,bcm2711-emmc2", .data = &bcm2711_data },
>         { .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
>         { .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
> +       { .compatible = "brcm,bcm7211a0-sdhci", .data = &bcm7211a0_data },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
> @@ -384,6 +408,11 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> +static void sdhci_iproc_shutdown(struct platform_device *pdev)
> +{
> +       sdhci_pltfm_suspend(&pdev->dev);
> +}
> +
>  static struct platform_driver sdhci_iproc_driver = {
>         .driver = {
>                 .name = "sdhci-iproc",
> @@ -394,6 +423,7 @@ static struct platform_driver sdhci_iproc_driver = {
>         },
>         .probe = sdhci_iproc_probe,
>         .remove = sdhci_pltfm_unregister,
> +       .shutdown = sdhci_iproc_shutdown,
>  };
>  module_platform_driver(sdhci_iproc_driver);
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0770c036e2ff..c35ed4be75b7 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -201,8 +201,10 @@
>
>  #define SDHCI_CAPABILITIES     0x40
>  #define  SDHCI_TIMEOUT_CLK_MASK                GENMASK(5, 0)
> +#define  SDHCI_TIMEOUT_CLK_SHIFT 0
>  #define  SDHCI_TIMEOUT_CLK_UNIT        0x00000080
>  #define  SDHCI_CLOCK_BASE_MASK         GENMASK(13, 8)
> +#define  SDHCI_CLOCK_BASE_SHIFT        8
>  #define  SDHCI_CLOCK_V3_BASE_MASK      GENMASK(15, 8)
>  #define  SDHCI_MAX_BLOCK_MASK  0x00030000
>  #define  SDHCI_MAX_BLOCK_SHIFT  16
> --
> 2.17.1
>
