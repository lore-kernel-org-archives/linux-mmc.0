From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCHv2 4/5] ARM: dts: rockchip: unuse the slot-node and deprecated the supports-highspeed for dw-mmc
Date: Fri, 04 Jul 2014 13:19:49 +0200
Message-ID: <1641373.ldKZaK4qer@diego>
References: <1404128960-27225-1-git-send-email-jh80.chung@samsung.com> <1404128960-27225-5-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1404128960-27225-5-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Am Montag, 30. Juni 2014, 20:49:18 schrieb Jaehoon Chung:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts |   16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> b/arch/arm/boot/dts/rk3066a-bqcurie2.dts index afb3273..ecea889 100644
> --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> @@ -59,12 +59,8 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
>  			vmmc-supply = <&vcc_sd0>;
> -
> -			slot@0 {
> -				reg = <0>;
> -				bus-width = <4>;
> -				disable-wp;
> -			};
> +			bus-width = <4>;
> +			disable-wp;
>  		};
> 
>  		dwmmc@10218000 { /* wifi */
> @@ -74,12 +70,8 @@
> 
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
> -
> -			slot@0 {
> -				reg = <0>;
> -				bus-width = <4>;
> -				disable-wp;
> -			};
> +			bus-width = <4>;
> +			disable-wp;
>  		};
> 
>  		gpio-keys {
