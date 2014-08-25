From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv6 3/5] ARM: dts: socfpga: unuse the slot-node and
 deprecated the supports-highspeed for dw-mmc
Date: Mon, 25 Aug 2014 13:18:02 +0200
Message-ID: <20140825111802.GA13300@amd>
References: <1406250713-22604-1-git-send-email-jh80.chung@samsung.com>
 <1406250713-22604-4-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406250713-22604-4-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, kgene.kim@samsung.com, heiko@sntech.de, tgih.jun@samsung.com, Chris Ball <chris@printf.net>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dinguyen@altera.com
List-Id: linux-mmc@vger.kernel.org

On Fri 2014-07-25 10:11:51, Jaehoon Chung wrote:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> Acked-by: Dinh Nguyen <dinguyen@altera.com>

So, controller supports it, and slot representation makes sense, but
we move to less logical representation that will break when someone
actually does two slots?

NAK, for what it is worth. 
								Pavel

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

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
