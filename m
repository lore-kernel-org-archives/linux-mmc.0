From: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv5 3/5] ARM: dts: socfpga: unuse the slot-node and
 deprecated the supports-highspeed for dw-mmc
Date: Wed, 16 Jul 2014 16:06:09 -0500
Message-ID: <1405544769.6107.1.camel@linux-builds1>
References: <1405050587-5577-1-git-send-email-jh80.chung@samsung.com>
	 <1405050587-5577-4-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405050587-5577-4-git-send-email-jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 2014-07-11 at 12:49 +0900, Jaehoon Chung wrote:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Reviewed-by: Tushar Behera <trblinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/socfpga_arria5.dtsi   |    9 +++------
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi |    9 +++------
>  arch/arm/boot/dts/socfpga_vt.dts        |    9 +++------
>  3 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
> index 12d1c2c..468fc4c 100644
> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
> @@ -29,13 +29,10 @@
>  
>  		dwmmc0@ff704000 {
>  			num-slots = <1>;
> -			supports-highspeed;
>  			broken-cd;
> -
> -			slot@0 {
> -				reg = <0>;
> -				bus-width = <4>;
> -			};
> +			bus-width = <4>;
> +			cap-mmc-highspeed;
> +			cap-sd-highspeed;
>  		};
>  
>  		sysmgr@ffd08000 {
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> index bf51182..1ee03c4 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> @@ -30,13 +30,10 @@
>  
>  		dwmmc0@ff704000 {
>  			num-slots = <1>;
> -			supports-highspeed;
>  			broken-cd;
> -
> -			slot@0 {
> -				reg = <0>;
> -				bus-width = <4>;
> -			};
> +			bus-width = <4>;
> +			cap-mmc-highspeed;
> +			cap-sd-highspeed;
>  		};
>  
>  		ethernet@ff702000 {
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> index 09792b4..f9345e0 100644
> --- a/arch/arm/boot/dts/socfpga_vt.dts
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -43,13 +43,10 @@
>  
>  		dwmmc0@ff704000 {
>  			num-slots = <1>;
> -			supports-highspeed;
>  			broken-cd;
> -
> -			slot@0 {
> -				reg = <0>;
> -				bus-width = <4>;
> -			};
> +			bus-width = <4>;
> +			cap-mmc-highspeed;
> +			cap-sd-highspeed;
>  		};
>  
>  		ethernet@ff700000 {

Acked-by: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>

Thanks,
Dinh


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
