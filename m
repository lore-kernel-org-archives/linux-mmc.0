From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH V2] ARM: dts: Add dwmmc DT nodes for exynos5420 SOC
Date: Wed, 21 Aug 2013 12:30:41 +0200
Message-ID: <1382155.lZhuLK0WA6@amdc1227>
References: <1377067433-28373-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1377067433-28373-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Yuvaraj,

On Wednesday 21 of August 2013 12:13:53 Yuvaraj Kumar C D wrote:
> This patch adds the device tree node entries for exynos5420 SOC.
> Exynos5420 has a different version of DWMMC controller,so a new
> compatible string is used to distinguish it from the prior SOC's.

What are the difference between both versions? Is there a patch adding the 
new compatible to the driver somewhere?

> changes since V1:
> 	1.disable node by status = disabled in SOC file
> 	2.enable node by status = okay in board specific file

Ahh, so you fixed this already in this version, thanks. Haven't noticed 
this patch at first and commented on previous one. Sorry for the noise.

> 
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    2 ++
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   38
> ++++++++++++++++++++ arch/arm/boot/dts/exynos5420.dtsi                 
> |   36 +++++++++++++++++++ 3 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt index
> 6d1c098..84cd56f 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -16,6 +16,8 @@ Required Properties:
>  	  specific extensions.
>  	- "samsung,exynos5250-dw-mshc": for controllers with Samsung Exynos5250
> specific extensions.
> +	- "samsung,exynos5420-dw-mshc": for controllers with Samsung Exynos5420
> +	  specific extensions.
> 
>  * samsung,dw-mshc-ciu-div: Specifies the divider value for the card
> interface unit (ciu) clock. This property is applicable only for Exynos5
> SoC's and diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> b/arch/arm/boot/dts/exynos5420-smdk5420.dts index bafba25..6e65278
> 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -31,6 +31,44 @@
>  		};
>  	};
> 
> +	dwmmc0@12200000 {
> +		status = "okay";
> +		num-slots = <1>;

You don't have to specify this property if there is only one slot. Also are 
you sure that this is a board specific property?

> +		broken-cd;
> +		bypass-smu;

This property doesn't seem to be documented nor used anywhere.

> +		supports-highspeed;

Is it a board specific property?

> +		fifo-depth = <0x80>;

Ditto.

> +		card-detect-delay = <200>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <0 4>;
> +		samsung,dw-mshc-ddr-timing = <0 2>;

Are the above three properties really board-specific?

Same for remaining nodes.

Best regards,
Tomasz
