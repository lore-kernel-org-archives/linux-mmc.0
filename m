Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B84C6379D
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F13920872
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0RKmm3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbgKXOZy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388682AbgKXOZx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:25:53 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C28BC061A4D
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:25:53 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id a186so519578vkh.9
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCesLYQPvcEflyfIUi3Jzcp8cmSSQAR6auenD/1XJUc=;
        b=k0RKmm3+Avs9KAotfN8HlMi+V5Uf/OM7WwUHNctM5x/DwImooVJdkD8YnZTbbnbWUi
         /UBIy53tGX7ZQHMKlDFWFJF95GBh2IoWCBz1cZIKUPXm1eukhDIv/kqKx++LRaOrRcrL
         4qfXQkhqHknSpOqq2qXCwwFNuSP33id6GdRaqPhNinbm7TNrI60erMgKozIBGd7WXZ+j
         Xrz/Frr2n2yUgn0SdpSmv9aH4sqg+YubtQK+M9HdU6h1YwjToRJKiNqZ5j/VWqyI079s
         l+oUaN9ZwTYKaT4Euj5ZN6riIji3/cQGiiiAUFLnhxpDwGGXen8zRq7UZX/FejD7b6Rx
         6d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCesLYQPvcEflyfIUi3Jzcp8cmSSQAR6auenD/1XJUc=;
        b=iDE6scNNTTGUf/JZ1Y1XRbF2z5E+FG8GUg29q+eq3QNYB/ov7dCA3rWNXYm64rLmTH
         /Ou7dix7gC4cZSTNe2crKiEN7aEcjOa8ywo1hKyKL1ojD871/LOX42Q0QRoDV5e58xFn
         x+kahRdg9qSbNuY/WmSiBFECWS74OT5sGtot7imW3laF1mJdhUXtejGXA+jF1ud8TcV0
         bwq95/Hw+mDHkNKxgoOLHjFLTvKVni/+lY//9Ww0EO39gYsG2ww0teWVscLPpq8x57nv
         2wGVfpcaV30qZxWlN5cN9pcSwl01QQxE0oaMmcQmekwUcio/Dhw810TgkFVBDNdnaky1
         9xNA==
X-Gm-Message-State: AOAM530pci6yI+3xDWVzcj4WMmvWfNeS5+FPPxiaPToINRCpvlHuEgiD
        5F4zhlz9OwUDfoSBnLaFgDNJgWSALIuOnGxhOCKe1g==
X-Google-Smtp-Source: ABdhPJzGbprwOOPsKb4waIjuvGsDDrtzIVrKJDs5hFpHm85kEr+oGt/ZWkeOKdeHSbO3ywPEKgrJU5kHBVxR8SJV9YU=
X-Received: by 2002:a1f:9889:: with SMTP id a131mr3881342vke.15.1606227952297;
 Tue, 24 Nov 2020 06:25:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com> <0556399f1ce8b1255d1f7961f04fcb95c96ab928.1605823502.git.cristian.ciocaltea@gmail.com>
In-Reply-To: <0556399f1ce8b1255d1f7961f04fcb95c96ab928.1605823502.git.cristian.ciocaltea@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:15 +0100
Message-ID: <CAPDyKFrBaiqmHbx0MKTv0uusDdLeeAwQuN8NMiVKgaAQBK0x1w@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] arm: dts: owl-s500: Add MMC support
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 20 Nov 2020 at 00:56, Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:
>
> Add MMC controller nodes for Actions Semi S500 SoC, in order to
> facilitate access to SD/EMMC/SDIO cards.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index b16172615db0..7af7c9e1119d 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -241,5 +241,38 @@ dma: dma-controller@b0260000 {
>                         clocks = <&cmu CLK_DMAC>;
>                         power-domains = <&sps S500_PD_DMA>;
>                 };
> +
> +               mmc0: mmc@b0230000 {
> +                       compatible = "actions,s500-mmc", "actions,owl-mmc";
> +                       reg = <0xb0230000 0x38>;
> +                       interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cmu CLK_SD0>;
> +                       resets = <&cmu RESET_SD0>;
> +                       dmas = <&dma 2>;
> +                       dma-names = "mmc";
> +                       status = "disabled";
> +               };
> +
> +               mmc1: mmc@b0234000 {
> +                       compatible = "actions,s500-mmc", "actions,owl-mmc";
> +                       reg = <0xb0234000 0x38>;
> +                       interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cmu CLK_SD1>;
> +                       resets = <&cmu RESET_SD1>;
> +                       dmas = <&dma 3>;
> +                       dma-names = "mmc";
> +                       status = "disabled";
> +               };
> +
> +               mmc2: mmc@b0238000 {
> +                       compatible = "actions,s500-mmc", "actions,owl-mmc";
> +                       reg = <0xb0238000 0x38>;
> +                       interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cmu CLK_SD2>;
> +                       resets = <&cmu RESET_SD2>;
> +                       dmas = <&dma 4>;
> +                       dma-names = "mmc";
> +                       status = "disabled";
> +               };
>         };
>  };
> --
> 2.29.2
>
