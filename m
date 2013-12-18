From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/4] iMX6SL frequency table
Date: Wed, 18 Dec 2013 15:37:57 +0800
Message-ID: <20131218073755.GG6691@S2101-09.ap.freescale.net>
References: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:9227 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751149Ab3LRHgv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 02:36:51 -0500
Content-Disposition: inline
In-Reply-To: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, festevam@gmail.com, cjb@laptop.org

On Tue, Dec 17, 2013 at 05:17:28PM -0800, John Tobias wrote:
>     Device tree for iMX6SL doesn't have an existing cpu frequency table.

Drop these leading spaces.

> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

For such imx6sl dts changes, please put a prefix 'ARM: dts: imx6sl: ...'
on the patch subject.

> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 28558f1..0a2c73c 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -38,6 +38,20 @@
>  			device_type = "cpu";
>  			reg = <0x0>;
>  			next-level-cache = <&L2>;
> +			operating-points = <
> +				/* kHz    uV */
> +				996000  1250000 /* for consumer grade only */
> +				792000  1150000
> +				396000  1050000

Please see my reply to your previous patch.

> +			>;
> +			clock-latency = <61036>; /* two CLK32 periods */
> +			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
> +				 <&clks IMX6SL_CLK_PLL1_SW>, <&clks IMX6SL_CLK_PLL1_SYS>;

The lines are somehow too long.  The following one might be easier to
read.

			clocks = <&clks IMX6SL_CLK_ARM>,
				 <&clks IMX6SL_CLK_PLL2_PFD2>,
				 <&clks IMX6SL_CLK_STEP>,
				 <&clks IMX6SL_CLK_PLL1_SW>,
				 <&clks IMX6SL_CLK_PLL1_SYS>;

Shawn

> +			clock-names = "arm", "pll2_pfd2_396m", "step",
> +				      "pll1_sw", "pll1_sys";
> +			arm-supply = <&reg_arm>;
> +			pu-supply = <&reg_pu>;
> +			soc-supply = <&reg_soc>;
>  		};
>  	};
>  
> -- 
> 1.8.3.2
> 

