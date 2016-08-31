From: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: rockchip: add clk_syscon for sdhci on
 rk3399
Date: Wed, 31 Aug 2016 11:19:35 +0800
Message-ID: <c2221946-fbaf-ef86-c673-67c07e456053@rock-chips.com>
References: <1472607448-4462-1-git-send-email-shawn.lin@rock-chips.com>
 <1472607448-4462-4-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472607448-4462-4-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,


On 2016年08月31日 09:37, Shawn Lin wrote:
> We are intent on letting the sdhci variant driver handle this
> optional clock on rk3399 platform now.
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---

Thanks for your patch, we can gate aclk_emmcgrf now as soon as sdhci 
driver suspend.

Reviewed-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Tested-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

>
> Changes in v2: None
>
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index bc86e8c..d26c6ad 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -233,8 +233,9 @@
>   		arasan,soc-ctl-syscon = <&grf>;
>   		assigned-clocks = <&cru SCLK_EMMC>;
>   		assigned-clock-rates = <200000000>;
> -		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> -		clock-names = "clk_xin", "clk_ahb";
> +		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>,
> +			 <&cru ACLK_EMMC_GRF>;
> +		clock-names = "clk_xin", "clk_ahb", "clk_syscon";
>   		clock-output-names = "emmc_cardclock";
>   		#clock-cells = <0>;
>   		phys = <&emmc_phy>;


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
