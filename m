From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/6] ARM: dts: rockchip: add basic dtsi file for RK3229 SoC
Date: Sat, 17 Jun 2017 20:12:19 +0200
Message-ID: <18070472.si2qlgbqtt@phil>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com> <1497510980-23207-2-git-send-email-frank.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497510980-23207-2-git-send-email-frank.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Wang <frank.wang@rock-chips.com>
Cc: robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, wmc@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Am Donnerstag, 15. Juni 2017, 15:16:15 CEST schrieb Frank Wang:
> Due to some tiny differences between RK3228 and RK3229, this patch
> adds a basic dtsi file which includes a new CPU opp table and PSCI
> brought up support for RK3229.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3229-evb.dts |   2 +-
>  arch/arm/boot/dts/rk3229.dtsi    | 110 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/rk3229.dtsi
> 
> diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
> index 1b55192..82e8a53 100644
> --- a/arch/arm/boot/dts/rk3229-evb.dts
> +++ b/arch/arm/boot/dts/rk3229-evb.dts
> @@ -40,7 +40,7 @@
>  
>  /dts-v1/;
>  
> -#include "rk322x.dtsi"
> +#include "rk3229.dtsi"
>  
>  / {
>  	model = "Rockchip RK3229 Evaluation board";
> diff --git a/arch/arm/boot/dts/rk3229.dtsi b/arch/arm/boot/dts/rk3229.dtsi
> new file mode 100644
> index 0000000..d43d133
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3229.dtsi
> @@ -0,0 +1,110 @@
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *  Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include "rk322x.dtsi"
> +
> +/ {
> +	compatible = "rockchip,rk3229";
> +
> +	/delete-node/ opp-table0;
> +
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <950000>;
> +			clock-latency-ns = <40000>;
> +			opp-suspend;
> +		};
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <975000>;
> +		};
> +		opp-816000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <1000000>;
> +		};
> +		opp-1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <1175000>;
> +		};
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1275000>;
> +		};
> +		opp-1296000000 {
> +			opp-hz = /bits/ 64 <1296000000>;
> +			opp-microvolt = <1325000>;
> +		};
> +		opp-1392000000 {
> +			opp-hz = /bits/ 64 <1392000000>;
> +			opp-microvolt = <1375000>;
> +		};
> +		opp-1464000000 {
> +			opp-hz = /bits/ 64 <1464000000>;
> +			opp-microvolt = <1400000>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
> +		method = "smc";
> +	};
> +};
> +
> +&cpu0 {
> +	enable-method = "psci";
> +};

Hmm, I don't really understand this.
What method of core-bringup does the rk3228 use? In the current
rk322x.dtsi there is no enable-method at all defined.

So is the rk3228 firmware using a different method than the rk3229?

And out of curiosity as this is a arm32 without atf, is the psci
implementation (for uboot?) you're using available somewhere?


Thanks
Heiko

> +
> +&cpu1 {
> +	enable-method = "psci";
> +};
> +
> +&cpu2 {
> +	enable-method = "psci";
> +};
> +
> +&cpu3 {
> +	enable-method = "psci";
> +};
> 
