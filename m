From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v3 3/6] ARM: dts: imx7d-sdb: add eMMC5.0 support
Date: Fri, 31 Jul 2015 22:46:06 +0800
Message-ID: <20150731144605.GD27806@shlinux1.ap.freescale.net>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-4-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438160637-28061-4-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, johan.derycke@barco.com, fabio.estevam@freescale.com, b29396@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 29, 2015 at 05:03:54PM +0800, Haibo Chen wrote:
> imx7d-sdb board has a eMMC5.0 on usdhc3. This eMMC support HS400.
> This patch add usdhc3 support for HS400
> 

It seems this patch should be after
[PATCH v3 4/6] mmc: sdhci-esdhc-imx: add compatible string in bingding doc

Regards
Dong Aisheng

> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  arch/arm/boot/dts/imx7d-sdb.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index fdd1d7c..8059458 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -241,6 +241,19 @@
>  	status = "okay";
>  };
>  
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
> +	assigned-clock-rates = <400000000>;
> +	bus-width = <8>;
> +	fsl,tuning-step = <2>;
> +	non-removable;
> +	status = "okay";
> +};
> +
>  &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
> -- 
> 1.9.1
> 
