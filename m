From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/3]: Support cpu frequency scaling and power management
 for iMX6SL
Date: Tue, 17 Dec 2013 22:04:58 +0800
Message-ID: <20131217140448.GU6691@S2101-09.ap.freescale.net>
References: <CACUGKYPLSdih0_+Dt5LP2E1JACfU7NbAvtCibWftKbzTf6R8FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:40487 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752958Ab3LQOD7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 09:03:59 -0500
Content-Disposition: inline
In-Reply-To: <CACUGKYPLSdih0_+Dt5LP2E1JACfU7NbAvtCibWftKbzTf6R8FA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Chris Ball <cjb@laptop.org>

On Mon, Dec 16, 2013 at 05:40:15PM -0800, John Tobias wrote:
> iMX6SL device tree doesn't have a configuration settings to enable the
> frequency scaling and power management.
> 
> From: John Tobias <john.tobias.ph@gmail.com>

Please use 'git format-patch' and 'git send-email'.  Also, it's never
been a good idea to use the exactly same patch subject for 3 different
changes.

Shawn

> 
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 28558f1..0ad2f6a 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -38,6 +38,19 @@
>                         device_type = "cpu";
>                         reg = <0x0>;
>                         next-level-cache = <&L2>;
> +                       operating-points = <
> +                               /* kHz    uV */
> +                               1000000 1275000
> +                               792000  1150000
> +                       >;
> +                       clock-latency = <61036>; /* two CLK32 periods */
> +                       clocks = <&clks IMX6SL_CLK_ARM>, <&clks
> IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
> +                                <&clks IMX6SL_CLK_PLL1_SW>, <&clks
> IMX6SL_CLK_PLL1_SYS>;
> +                       clock-names = "arm", "pll2_pfd2_396m", "step",
> +                                     "pll1_sw", "pll1_sys";
> +                       arm-supply = <&reg_arm>;
> +                       pu-supply = <&reg_pu>;
> +                       soc-supply = <&reg_soc>;
>                 };
>         };

