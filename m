From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>
Subject: Re: [PATCH 03/14] ARM: sunxi: sun5i: Enforce max frequency on PLL6
Date: Thu, 17 Jul 2014 13:19:34 -0300
Message-ID: <53C7F796.2050303@elopez.com.ar>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com> <1405588134-2396-4-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from yotta.elopez.com.ar ([31.220.24.173]:41033 "EHLO
	yotta.elopez.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933607AbaGQQTs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jul 2014 12:19:48 -0400
In-Reply-To: <1405588134-2396-4-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi Maxime,

El 17/07/14 06:08, Maxime Ripard escribi=F3:
> PLL6 out of reset is running at 2.4GHz, which is outside of its opera=
ting
> boundaries.
>
> Enforce its maximum frequency as set in the datasheet to make sure we=
 stays
> within these bounds.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   arch/arm/boot/dts/sun5i-a13.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun=
5i-a13.dtsi
> index bf86e65dd167..de89edc5e5b3 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -97,6 +97,7 @@
>   			reg =3D <0x01c20028 0x4>;
>   			clocks =3D <&osc24M>;
>   			clock-output-names =3D "pll6_sata", "pll6_other", "pll6";
> +			clock-max-frequency =3D <1200000000>;
>   		};
>
>   		/* dummy is 200M */
>

This patch itself is ok, but I'm not seeing so far where is=20
"clock-max-frequency" read from the DT and passed to the clock for late=
r=20
verification. Did you leave that out by mistake when shuffling patches?

Cheers!

Emilio
