Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBF8C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D69B20B80
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTVqEOr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbgE1KO5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 06:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387765AbgE1KOu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 06:14:50 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0887C08C5C5
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:14:48 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id j28so6612947vkn.8
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yW+IZMKg5JfFJMCtNiUNXYczOaHQV0AlWP2cb6ww+2o=;
        b=VTVqEOr6mFaIVPNhNtawBK+MOEO6Zip8G1r98/95aKyBzU6AAcTYWgaHro383U4qM2
         bQ5+66X6utmIzRPHkTY40N+Of779nxqfEB0c0bJJVFGbAWTvM3SyFiUqj8zyczWBTJHK
         4pDHtK0XKMfnAWRKtfM5eVEfIcjiIUSWzvbjZ0HOdE5AnEwwj8nRWQmi0iRdnLAmAbgu
         NkRwXjaTqVNr4a9sYFqkcpseXCe0HVDnkMIVDvMeNWDBfQrUhTAaRMXQV/WTWZ7ezQq2
         5325jM7xywFyJqR+8ph9mciWMGrPrdPt4tezivjmocy4e7qQJPCJm63OQDrPGnE715XS
         HY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yW+IZMKg5JfFJMCtNiUNXYczOaHQV0AlWP2cb6ww+2o=;
        b=N0suV1dqKSIQ01DVeLdYJCU2Mx+HS1ApqU5sxQjerohbpk2oN2/40eN2TjzwJLX5h3
         27qgfxCgQ6ei69oOx2ZVi5B/iDLxuvSV5d8SCeKtZNnEdvGp2XjyHy3syZFVMg9hQIzH
         gmc2olwyj8S969iHUU5rLZe67taLWIqFFc49j7FptcQP7gZxR9xBnJhVOr93asfdnjQU
         813J44Uqrtdj3hRXXn7OAbp0EagoHlM1NhWwdI0UvPi+CN3E2D1bC8//Uc2ecZLC5Au2
         FlsXcSdXROJmd9+HG50nFN4XsK1eTiAKEbCGp/oX55AsW71Uw1JtVRsP+WKsAWN8Iaij
         v0eA==
X-Gm-Message-State: AOAM5301QmcJm4gewGRf52DIIiZQW4V3HP55DWLAj6Hs7Z7Mbj6FIoIG
        N+eKN7ytgo6JoCQSFGAWjtgJqPY8382GXr1WPJ0YdQ==
X-Google-Smtp-Source: ABdhPJz5IGENALXCmSdQWShSp8vql2GZi49pbi4SppKQwQNGlCylI2/mfwnx1tgNSliv7QU4ohjZ/zN0y1vcSxYkzhU=
X-Received: by 2002:a1f:25d7:: with SMTP id l206mr1519148vkl.53.1590660888103;
 Thu, 28 May 2020 03:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com> <20200526062758.17642-2-wan.ahmad.zainie.wan.mohamad@intel.com>
In-Reply-To: <20200526062758.17642-2-wan.ahmad.zainie.wan.mohamad@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:10 +0200
Message-ID: <CAPDyKFrVxFYEKFUSaeCj-+9O5onHjFexP9rrZXCCNq9XdUEDPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: arasan: Add compatible strings
 for Intel Keem Bay
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 May 2020 at 08:29, Wan Ahmad Zainie
<wan.ahmad.zainie.wan.mohamad@intel.com> wrote:
>
> Add new compatible strings in sdhci-of-arasan.c to support Intel Keem Bay
> eMMC/SD/SDIO controller, based on Arasan SDHCI 5.1.
>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt  | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 630fe707f5c4..f29bf7dd2ece 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -27,6 +27,12 @@ Required Properties:
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>      - "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1": Intel LGM SDXC PHY
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel Keem Bay eMMC
> +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "intel,keembay-sdhci-5.1-sd": Intel Keem Bay SD controller
> +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "intel,keembay-sdhci-5.1-sdio": Intel Keem Bay SDIO controller
> +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>
>    [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>
> @@ -148,3 +154,39 @@ Example:
>                 phy-names = "phy_arasan";
>                 arasan,soc-ctl-syscon = <&sysconf>;
>         };
> +
> +       mmc: mmc@33000000 {
> +               compatible = "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1";
> +               interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +               reg = <0x0 0x33000000 0x0 0x300>;
> +               clock-names = "clk_xin", "clk_ahb";
> +               clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>,
> +                        <&scmi_clk KEEM_BAY_PSS_EMMC>;
> +               phys = <&emmc_phy>;
> +               phy-names = "phy_arasan";
> +               assigned-clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>;
> +               assigned-clock-rates = <200000000>;
> +               clock-output-names = "emmc_cardclock";
> +               #clock-cells = <0>;
> +               arasan,soc-ctl-syscon = <&mmc_phy_syscon>;
> +       };
> +
> +       sd0: mmc@31000000 {
> +               compatible = "intel,keembay-sdhci-5.1-sd";
> +               interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +               reg = <0x0 0x31000000 0x0 0x300>;
> +               clock-names = "clk_xin", "clk_ahb";
> +               clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
> +                        <&scmi_clk KEEM_BAY_PSS_SD0>;
> +               arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
> +       };
> +
> +       sd1: mmc@32000000 {
> +               compatible = "intel,keembay-sdhci-5.1-sdio";
> +               interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +               reg = <0x0 0x32000000 0x0 0x300>;
> +               clock-names = "clk_xin", "clk_ahb";
> +               clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD1>,
> +                        <&scmi_clk KEEM_BAY_PSS_SD1>;
> +               arasan,soc-ctl-syscon = <&sd1_phy_syscon>;
> +       };
> --
> 2.17.1
>
