Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3CDC11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 15:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B2D613EF
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 15:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhF3PSj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhF3PSj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 11:18:39 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484EAC061756
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 08:16:09 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id h5so147610vsg.12
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EX0yD5vyB2JSovF9JbqRbMIPNXB/HidlyJdS3p9zVkY=;
        b=Ta1z4y0NySMB0lQKyEp9yrCuqF1iGPI9+BDkSN1EMNKrjmn7ilgHL+GKD2jqaXCSzP
         NarV5UlnWQ+KQ/SNGaipD91wHpM3B0NX1/Vm+ed1W9M6eg/hIRQ2xeaFAYRLihv/ys+2
         mzEXU2C9X/+gG6+SHXQwtG+vV9xdIpTyhdWTTGeUCoffdhbks+SUCXsF/q9IcNI06xfd
         joP4w1y3OWZa1G2KYSS15kVFYtyaL7+KmSL3J9zvWRv3oeFEq+0ZZ2b7Wd46l1CZ9/tU
         rS6p0LqJj83xXBFKHdlSHO/PF53gufvAokK9UkXkvTvBnBEiBX94L6m6sfA4vHowkpLp
         CvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EX0yD5vyB2JSovF9JbqRbMIPNXB/HidlyJdS3p9zVkY=;
        b=ntEKnqdqAyo3WjnGXRpV5umIGmymyOq/QyzflgjbhS8tn74HmrvUsdFxXFe9OAjrI8
         E48e5KJWXxqCfhedPllqUiSEYRPZwR0MqXeVAPQNxZ4BRDsu3IwpdmxAWpmIzx7fN2mt
         QRhr1f7/r5937banxgFzI79oK2XwJyUqqjeqI195ZRcjw1HjgArSATv7tMog9imD7q4h
         INsUo8iK4Q9HdBAOPuQ4LeloXEmBtWj6qFYPlbGFmV0F7r5sC5R02rEAELi3eXEJUpSE
         vGneROTRnn3J8ty8gysY/upXoUzvLfu7sby4mpqkO6hBWLShlT/eits/28z6j6GQTsY2
         grvQ==
X-Gm-Message-State: AOAM533/49dyA8ITzq2b0mueTLUzKLTONNkgamhArkoK8IcKjwmCYGq1
        gStj/L4+CRCuMTH0wtaNzpIluu/uIBYDBmNdgxC1pw==
X-Google-Smtp-Source: ABdhPJyJA5xUuemu6r/8anRVrrPBaVlut++DKAHCudMJgFLdL6Ct9WZkcsWDS5S65+Y6Y0GWzMVNFebGBgSMk0IO5Rg=
X-Received: by 2002:a05:6102:3a70:: with SMTP id bf16mr32576862vsb.48.1625066168121;
 Wed, 30 Jun 2021 08:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210624025647.101387-1-reniuschengl@gmail.com>
In-Reply-To: <20210624025647.101387-1-reniuschengl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jun 2021 17:15:31 +0200
Message-ID: <CAPDyKFoQNDTe8__eUmmbE=98HgjERYudzjyRu1fr2ZCyWXuqew@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Finetune GL9763E L1 Entry Delay
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 24 Jun 2021 at 04:56, Renius Chen <reniuschengl@gmail.com> wrote:
>
> Finetune the L1 entry delay to 20us for better balance of performance and
> battery life.
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 302a7579a9b3..4e3c0561354d 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -90,7 +90,7 @@
>
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> -#define   GLI_9763E_CFG2_L1DLY_MID 0x54
> +#define   GLI_9763E_CFG2_L1DLY_MID 0x50

We just changed from 21us to 20us. Really, how big of a difference can
this make?

Moreover, I suppose the difference is related to the running use case. No?

If you really want this, at least I want an ack from Ben for it, then
let's be done with it.

Kind regards
Uffe

>
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
> @@ -810,7 +810,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
>         value &= ~GLI_9763E_CFG2_L1DLY;
> -       /* set ASPM L1 entry delay to 21us */
> +       /* set ASPM L1 entry delay to 20us */
>         value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>
> --
> 2.27.0
>
