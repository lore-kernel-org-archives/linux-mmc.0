Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A865C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211EF2077B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGd2eC5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfLJJvY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:51:24 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45560 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfLJJvY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 04:51:24 -0500
Received: by mail-vk1-f193.google.com with SMTP id g7so5376255vkl.12
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 01:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i53YOPIF4tZH71cdZd3N/wfk/VGV4lMlcYM4QZMIJfo=;
        b=LGd2eC5lkimkmaZ3Njofp0kB/S8H0Wm9blwDIUXk+fSx60a/IysurK9R509dQNx75L
         3ObbamEzRKIneBG/3e6kK09eD6M2Xjzp9K/ttwArqlEEZT/mnrZDnp0Zb/Rf93Wkgb43
         asezSds8ySbKZxuyFt0Z6RA8liimQK7jgut6nQnarr9ChA7MWD58yvhdUEXtkrwzeClM
         Iv44zwEJgd4HJuTuihMbyT7O/fM9TzBF4NVCRmIbTyJR1rXtGskOFUHEbYFeHnT1pi0R
         j3wPfbEZ9HAoFj+r5+D3glWIVQNGFqGMBh9T3zE0S6+v99QRaz9o6BkDAb3QaNkokKGi
         aQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i53YOPIF4tZH71cdZd3N/wfk/VGV4lMlcYM4QZMIJfo=;
        b=rfWg23XF4EhAClDG6p73L1Br6/bM7QWIonsjMm/1RtlbMAB6Wdd4MGKzrplS5oQNeH
         zqQPe2J06MEBEX71vTnLCIZW2CN/G6N7QzwNQlTmXfrx4xTR9O/CGFNkdDqJeVvgYQ9E
         BDgg4QFUulVvg1k481PZdSJkhCiP0ZT3kLVWXfcONVsaaPHZ7mLyGl/Vj+dDWUwlYcsJ
         AQeD0VRkjkz4Lz95vAco0hjbI0xbO5WBJIh7gFXBtgkhBNgHj+n3EoOFo+6LI4aYCDr/
         2jQ8KrltmfFfOVA8cOXW4zc7AiUGTxU242PXOm0hMwIxqJDrRXom6b/QdmmJ7N0Jh6e7
         1ddQ==
X-Gm-Message-State: APjAAAVBIPg6DA0B1bL7sLRw+Rwd0M9UBPBJCQak2J7Q7Q2Qg/JK0adi
        dBxAjn8rOLN8WpUJ1kiS10zG4ShfL+/cQebUxjspwA==
X-Google-Smtp-Source: APXvYqwGViwBl874UU2PS2zg+6cNGxu0DAuVbaL/ZJ6A8w922cBIox0P2HENEKQLpaVxO7zmetO8tUwJQdTAEqPuVu8=
X-Received: by 2002:a05:6122:5b:: with SMTP id q27mr27979454vkn.43.1575971483143;
 Tue, 10 Dec 2019 01:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20191128074522.69706-1-ludovic.desroches@microchip.com>
In-Reply-To: <20191128074522.69706-1-ludovic.desroches@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 10:50:46 +0100
Message-ID: <CAPDyKFpCcOxh1+ZniZvxMR=bMCY0S6bk0FAzX2D=GMxMYea_bg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: sdhci-of-at91: new compatible string
 and update properties
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        claudiu.beznea@microchip.com, Eugen.Hristev@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 28 Nov 2019 at 08:45, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
>
> There is a new compatible string for the SAM9X60 sdhci device. It involves
> an update of the properties about the clocks stuff.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes:
> - v3: rebase due to conflict with Nicolas' patch
> - v2: remove the extra example and fix node label
>
>  .../devicetree/bindings/mmc/sdhci-atmel.txt         | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> index 503c6dbac1b2..69edfd4d3922 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> @@ -5,11 +5,16 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
>  sdhci-of-at91 driver.
>
>  Required properties:
> -- compatible:          Must be "atmel,sama5d2-sdhci".
> +- compatible:          Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
>  - clocks:              Phandlers to the clocks.
> -- clock-names:         Must be "hclock", "multclk", "baseclk";
> +- clock-names:         Must be "hclock", "multclk", "baseclk" for
> +                       "atmel,sama5d2-sdhci".
> +                       Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
>
>  Optional properties:
> +- assigned-clocks:     The same with "multclk".
> +- assigned-clock-rates The rate of "multclk" in order to not rely on the
> +                       gck configuration set by previous components.
>  - microchip,sdcal-inverted: when present, polarity on the SDCAL SoC pin is
>    inverted. The default polarity for this signal is described in the datasheet.
>    For instance on SAMA5D2, the pin is usually tied to the GND with a resistor
> @@ -17,10 +22,12 @@ Optional properties:
>
>  Example:
>
> -sdmmc0: sdio-host@a0000000 {
> +mmc0: sdio-host@a0000000 {
>         compatible = "atmel,sama5d2-sdhci";
>         reg = <0xa0000000 0x300>;
>         interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
>         clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
>         clock-names = "hclock", "multclk", "baseclk";
> +       assigned-clocks = <&sdmmc0_gclk>;
> +       assigned-clock-rates = <480000000>;
>  };
> --
> 2.24.0
>
