From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCHv2 2/5] ARM: dts: exynos: unuse the slot-node and deprecated
 the supports-highspeed for dw-mmc
Date: Mon, 07 Jul 2014 16:29:36 +0900
Message-ID: <000c01cf99b5$34ccc8c0$9e665a40$%jun@samsung.com>
References: <1404128960-27225-1-git-send-email-jh80.chung@samsung.com>
 <1404128960-27225-3-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49374 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbaGGH3j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jul 2014 03:29:39 -0400
In-reply-to: <1404128960-27225-3-git-send-email-jh80.chung@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, 'Mark Rutland' <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Jaehoon,

Please check one thing below.

On Mon, June 30, 2014, Jaehoon Chung wrote:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-
> octa.dts
> index 434fd9d..5f37b81 100644
> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> @@ -50,7 +50,6 @@
>  	mmc@12200000 {
>  		status = "okay";
>  		broken-cd;
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <0 4>;
> @@ -58,16 +57,12 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>  		vmmc-supply = <&ldo10_reg>;
> -
> -		slot@0 {
> -			reg = <0>;
> -			bus-width = <8>;
> -		};
> +		bus-width = <8>;
> +		cap-mmc-highspeed;
>  	};
> 
>  	mmc@12220000 {
>  		status = "okay";
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -75,11 +70,8 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>  		vmmc-supply = <&ldo10_reg>;
> -
> -		slot@0 {
> -			reg = <0>;
> -			bus-width = <4>;
> -		};
> +		bus-width = <8>;
<4> is correct?

> +		cap-mmc-highspeed;

Thanks,
Seungwon Jeon

