From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v4 4/8] ARM: dts: Specify clocks for SDHCIs on bcm11351
Date: Fri, 13 Dec 2013 00:22:33 -0800
Message-ID: <CAEPRUYrg9EQO5TnEprF0zeXmiaTOsb5Ht38AztLiWyUKJz072Q@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
	<1386271244-3927-5-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:61325 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab3LMIWe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Dec 2013 03:22:34 -0500
Received: by mail-ea0-f175.google.com with SMTP id z10so704676ead.20
        for <linux-mmc@vger.kernel.org>; Fri, 13 Dec 2013 00:22:33 -0800 (PST)
In-Reply-To: <1386271244-3927-5-git-send-email-tim.kryger@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Axel Lin <axel.lin@ingics.com>, Device Tree List <devicetree@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linaro Patches List <patches@linaro.org>

On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> Specify the external clock label in each SDHCI node.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  arch/arm/boot/dts/bcm11351.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index 9b99c52..25ca128 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -118,6 +118,7 @@
>                 compatible = "brcm,kona-sdhci";
>                 reg = <0x3f180000 0x10000>;
>                 interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&sdio1_clk>;
>                 status = "disabled";
>         };
>
> @@ -125,6 +126,7 @@
>                 compatible = "brcm,kona-sdhci";
>                 reg = <0x3f190000 0x10000>;
>                 interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&sdio2_clk>;
>                 status = "disabled";
>         };
>
> @@ -132,6 +134,7 @@
>                 compatible = "brcm,kona-sdhci";
>                 reg = <0x3f1a0000 0x10000>;
>                 interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&sdio3_clk>;
>                 status = "disabled";
>         };
>
> @@ -139,6 +142,7 @@
>                 compatible = "brcm,kona-sdhci";
>                 reg = <0x3f1b0000 0x10000>;
>                 interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&sdio4_clk>;
>                 status = "disabled";
>         };
>
> --
> 1.8.0.1
>
Reviewed-by: Christian Daudt <bcm@fixthebug.org>
