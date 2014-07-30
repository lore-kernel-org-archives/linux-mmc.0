From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCHv8 2/5] ARM: dts: exynos: unuse the slot-node and
 deprecated the supports-highspeed for dw-mmc
Date: Wed, 30 Jul 2014 09:02:00 -0700
Message-ID: <CAD=FV=X3rZGfKHTTYHj5Va0e3X4Ebteo9GMtVPBYeY=v2yoPww@mail.gmail.com>
References: <1406718310-32078-1-git-send-email-jh80.chung@samsung.com>
	<1406718310-32078-3-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:32835 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbaG3QCA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jul 2014 12:02:00 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so2145512vcb.30
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jul 2014 09:02:00 -0700 (PDT)
In-Reply-To: <1406718310-32078-3-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dinh Nguyen <dinguyen@altera.com>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpgs ." <cpgs@samsung.com>

Jaehoon,

On Wed, Jul 30, 2014 at 4:05 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index d0de1f5..42a3590 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -401,7 +401,6 @@
>         mmc_0: mmc@12200000 {
>                 status = "okay";
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
> @@ -410,17 +409,13 @@
>                 vmmc-supply = <&mmc_reg>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;
>         };
>
>         mmc_2: mmc@12220000 {
>                 status = "okay";
>                 num-slots = <1>;
> -               supports-highspeed;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -428,12 +423,9 @@
>                 vmmc-supply = <&mmc_reg>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -
> -               slot@0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -                       disable-wp;
> -               };
> +               bus-width = <4>;
> +               disable-wp;
> +               cap-sd-highspeed;

It seems like you ought to include cap-mmc-highspeed in addition to
cap-sd-highspeed, but I could be wrong.  I know that I have some
full-sized MMC cards (not eMMC) that can be plugged into an SD card
slot.  I know that the SD/MMC slot on this port only has 4 pins on
exynos5250, but I think you can still run MMC highspeed on 4 pins,
right?

-Doug
