From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v4 8/8] ARM: dts: Specify clocks for timer on bcm11351
Date: Fri, 13 Dec 2013 00:06:45 -0800
Message-ID: <CAEPRUYrqr_fYM1cmr46_KkPjkHGVZ4n6ZaGSE0tmufwA+t_+xg@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
	<1386271244-3927-9-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:45300 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3LMIGq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Dec 2013 03:06:46 -0500
Received: by mail-ee0-f42.google.com with SMTP id e53so690380eek.29
        for <linux-mmc@vger.kernel.org>; Fri, 13 Dec 2013 00:06:45 -0800 (PST)
In-Reply-To: <1386271244-3927-9-git-send-email-tim.kryger@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Axel Lin <axel.lin@ingics.com>, Device Tree List <devicetree@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linaro Patches List <patches@linaro.org>

On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> Specify the external clock label in the timer node.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  arch/arm/boot/dts/bcm11351.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index 25ca128..1246885 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -95,7 +95,7 @@
>                 compatible = "brcm,kona-timer";
>                 reg = <0x35006000 0x1000>;
>                 interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -               clock-frequency = <32768>;
> +               clocks = <&hub_timer_clk>;
>         };
>
>         gpio: gpio@35003000 {
> --
> 1.8.0.1
>
Reviewed-by: Christian Daudt <bcm@fixthebug.org>
