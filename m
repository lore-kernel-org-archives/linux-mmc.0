From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 2/2] ARM: dts: Add HS400 support for exynos5420 and
 exynos5800
Date: Wed, 21 Jan 2015 08:02:52 +0900
Message-ID: <54BEDE9C.5060501@samsung.com>
References: <1421231446-4776-1-git-send-email-alim.akhtar@samsung.com>
 <1421231446-4776-3-git-send-email-alim.akhtar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1421231446-4776-3-git-send-email-alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alim.akhtar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

If you want to enable the hs400 mode, need to add "mmc-hs400-1_8v" or "mmc-hs400-1_2v".
But this patch didn't add them. do you have any other plan?

On 01/14/2015 07:30 PM, Alim Akhtar wrote:
> From: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> HS400 timing values are added for SMDK5420, exynos5420-peach-pit
> and exynos5800-peach-pi boards.
> This also adds RCLK GPIO line, this gpio should be in pull-down
> state.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> [Alim: addressed review comments]
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |    4 +++-
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi  |    7 +++++++
>  arch/arm/boot/dts/exynos5420-smdk5420.dts  |    4 +++-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  |    4 +++-
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 9a050e1..7ffaba8 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -569,8 +569,10 @@
>  	samsung,dw-mshc-ciu-div = <3>;
>  	samsung,dw-mshc-sdr-timing = <0 4>;
>  	samsung,dw-mshc-ddr-timing = <0 2>;
> +	samsung,dw-mshc-hs400-timing = <0 2>;
> +	read-strobe-delay = <90>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> +	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>  	bus-width = <8>;
>  };
>  
> diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> index ba686e4..8b15316 100644
> --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> @@ -201,6 +201,13 @@
>  			samsung,pin-drv = <3>;
>  		};
>  
> +		sd0_rclk: sd0-rclk {

I know it used to "sd0_rdqs", not "sd0_rclk".
Change name.

Best Regards,
Jaehoon Chung
> +			samsung,pins = "gpc0-7";
> +			samsung,pin-function = <2>;
> +			samsung,pin-pud = <1>;
> +			samsung,pin-drv = <3>;
> +		};
> +
>  		sd1_cmd: sd1-cmd {
>  			samsung,pins = "gpc1-1";
>  			samsung,pin-function = <2>;
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 8be3d7b..5290e79 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -80,8 +80,10 @@
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <0 4>;
>  		samsung,dw-mshc-ddr-timing = <0 2>;
> +		samsung,dw-mshc-hs400-timing = <0 2>;
> +		read-strobe-delay = <90>;
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> +		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>  		bus-width = <8>;
>  		cap-mmc-highspeed;
>  	};
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index e8fdda8..fa1c858 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -557,8 +557,10 @@
>  	samsung,dw-mshc-ciu-div = <3>;
>  	samsung,dw-mshc-sdr-timing = <0 4>;
>  	samsung,dw-mshc-ddr-timing = <0 2>;
> +	samsung,dw-mshc-hs400-timing = <0 2>;
> +	read-strobe-delay = <90>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> +	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>  	bus-width = <8>;
>  };
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
