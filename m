From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCHv8 4/5] ARM: dts: rockchip: unuse the slot-node and deprecated the supports-highspeed for dw-mmc
Date: Wed, 30 Jul 2014 14:23:03 +0200
Message-ID: <2543771.WCP4tgxD8T@diego>
References: <1406718310-32078-1-git-send-email-jh80.chung@samsung.com> <1406718310-32078-5-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406718310-32078-5-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Doug Anderson <dianders@google.com>, cpgs@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi,

Am Mittwoch, 30. Juli 2014, 20:05:09 schrieb Jaehoon Chung:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

we might get a conflict, with recent Rockchip-specific devicetree changes [0].
So depending on when the core changes of this series land, this patch
might use a respin.


Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=rockchip/dt&id=fcbbf965254ff1693c26a5646e4e62adc3a6118d
https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=rockchip/dt&id=b09e35a388ad23eb90497a352b8e5e5cb4b97bf2

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
