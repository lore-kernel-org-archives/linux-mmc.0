Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BA5C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Mar 2022 10:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiCQKPp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiCQKPS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2022 06:15:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC93DFF89
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 03:13:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id g24so5343805lja.7
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnzJ4R3KLBgCGUtvz6Z8ai5vtr7nz1kSOwqPL8Ayaaw=;
        b=CTdP6qZOO6TnN5KBR3y3d3JWIm2PswnJZCOT/l92IyeyfimF7vps9F13H9N8pEUph7
         RkF49la4z2bniULPRrEBDj/aogEUQG3fzkF9rC740b24PvyvGIQo5DLEChQSbByheues
         zkIbprxkER2EbDrREycgA/Yx6danFUti8PtmaG6Fg82pKcKvtFTkafknsQAqFSUp/Vi/
         +QP3Vni01REsGIVU5ZuGlaRoHM5eMAzVFnU6IFFE1CT83PW/blpcMM5WO+aJg+dJYIwi
         +g1hBBkJs4Pm2HWtHGOdkhONaSnypQosguI9Wo++KuSKI0mW2skCeAUA5Yv4XVxhtfFh
         3Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnzJ4R3KLBgCGUtvz6Z8ai5vtr7nz1kSOwqPL8Ayaaw=;
        b=ufQAIyZQgj7ptxMRJ5xMAX0stTYDJjwwyHZcSG8vyp8YrC5mlAv4DdSpMIOBa7R4rw
         WWqsi92HZ/9T6h8AYxZvOuVo7hMNBjkcvxYjG7/CBk+MEo1Fxv6p1R1eC68lCHzJC89F
         jKgdVCgSX0UOhnkPgO4N7mSTZt/1fpjfbqCttrUP37BJY71VUBFtMWfGAP99ZHRYKaeg
         5mpnbCuWD5w+9yaAT2pBxDv3X9I2r3ICZwDg8cLfbsolYefAGvqw8YFFMY0XooPt4KVx
         brZLWHwj2pREnwXAaOadQpgTu3Y21BBzce5Kqnp/a9yXb7wLDMDOTIUxatkmraOouIBU
         s7yw==
X-Gm-Message-State: AOAM531h6MR5JlGtJImuEIPqRIbt3aY/PgypIOR799It7l94QEsIj1xe
        wm9HJP8UW8TuIl2M5qjrhlNB4/QafBl9dS+C+/ZMQA==
X-Google-Smtp-Source: ABdhPJzIsMRtIDL4mo7GfoMxEHJSERS1YucG9RlwYxXl9OZnl3eqzU/VQExIBIC4OaM6vUIplPe1B2uC9PwmWV0SiCk=
X-Received: by 2002:a2e:5009:0:b0:247:d738:3e90 with SMTP id
 e9-20020a2e5009000000b00247d7383e90mr2424291ljb.229.1647512028390; Thu, 17
 Mar 2022 03:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220315220549.2749328-1-chris.packham@alliedtelesis.co.nz> <20220315220549.2749328-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20220315220549.2749328-2-chris.packham@alliedtelesis.co.nz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Mar 2022 11:13:12 +0100
Message-ID: <CAPDyKFpMnno1RjnSMhgUAZc=q4erdNGEFYOW=k13MMMPti7aQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: xenon: add AC5 compatible string
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     huziji@marvell.com, robh+dt@kernel.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Mar 2022 at 23:05, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Import binding documentation from the Marvell SDK which adds
> marvell,ac5-sdhci compatible string and documents the requirements for
> the for the Xenon SDHCI controller on the 98DX2530.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>
> Notes:
>     Changes in v3:
>     - Split from larger series
>     - Add review from Andrew
>     Changes in v2:
>     - New
>
>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)

Would you mind converting these bindings to the new yaml format, as
the first step?

Up until this point, I have accepted only very small changes to the
legacy txt based bindings, but I am starting to think that it's time
to reject those too. We need all bindings to move to yaml.

Sorry, if this causes additional churns for you.

Kind regards
Uffe

>
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> index c51a62d751dc..43df466f0cb3 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> @@ -14,6 +14,7 @@ Required Properties:
>    - "marvell,armada-ap806-sdhci": For controllers on Armada AP806.
>    - "marvell,armada-ap807-sdhci": For controllers on Armada AP807.
>    - "marvell,armada-cp110-sdhci": For controllers on Armada CP110.
> +  - "marvell,ac5-sdhci": For CnM on AC5, AC5X and derived.
>
>  - clocks:
>    Array of clocks required for SDHC.
> @@ -33,6 +34,13 @@ Required Properties:
>      in below.
>      Please also check property marvell,pad-type in below.
>
> +  * For "marvell,ac5-sdhci", one or two register areas.
> +    (reg-names "ctrl" & "decoder").
> +    The first one is mandatory for the Xenon IP registers.
> +    The second one is for systems where DMA mapping is required and is the
> +    related address decoder register (the value to configure is derived from
> +    the parent "dma-ranges").
> +
>    * For other compatible strings, one register area for Xenon IP.
>
>  Optional Properties:
> @@ -171,3 +179,47 @@ Example:
>
>                 marvell,pad-type = "sd";
>         };
> +
> +
> +- For eMMC with compatible "marvell,ac5-sdhci" with one reg range (no dma):
> +       sdhci0: sdhci@805c0000 {
> +               compatible = "marvell,ac5-sdhci";
> +               reg = <0x0 0x805c0000 0x0 0x300>;
> +               reg-names = "ctrl", "decoder";
> +               interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&core_clock>;
> +               clock-names = "core";
> +               status = "okay";
> +               bus-width = <8>;
> +               /*marvell,xenon-phy-slow-mode;*/
> +               non-removable;
> +               mmc-ddr-1_8v;
> +               mmc-hs200-1_8v;
> +               mmc-hs400-1_8v;
> +       };
> +
> +- For eMMC with compatible "marvell,ac5-sdhci" with two reg ranges (with dma):
> +       mmc_dma: mmc-dma-peripherals@80500000 {
> +               compatible = "simple-bus";
> +               #address-cells = <0x2>;
> +               #size-cells = <0x2>;
> +               ranges;
> +               dma-ranges = <0x2 0x0 0x2 0x80000000 0x1 0x0>;
> +               dma-coherent;
> +
> +               sdhci0: sdhci@805c0000 {
> +                       compatible = "marvell,ac5-sdhci", "marvell,armada-ap806-sdhci";
> +                       reg = <0x0 0x805c0000 0x0 0x300>, <0x0 0x80440230 0x0 0x4>;
> +                       reg-names = "ctrl", "decoder";
> +                       interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&core_clock>;
> +                       clock-names = "core";
> +                       status = "okay";
> +                       bus-width = <8>;
> +                       /*marvell,xenon-phy-slow-mode;*/
> +                       non-removable;
> +                       mmc-ddr-1_8v;
> +                       mmc-hs200-1_8v;
> +                       mmc-hs400-1_8v;
> +               };
> +       };
> --
> 2.35.1
>
