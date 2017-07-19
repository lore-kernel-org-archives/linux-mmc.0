From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Documentation: dw-mshc: deprecate num-slots
Date: Wed, 19 Jul 2017 19:29:26 +0900
Message-ID: <cf3c6814-227a-3da7-47fc-2f353a833a65@samsung.com>
References: <CGME20170718083221epcas4p15af5a6c253dc83a58c39e431dc536bc1@epcas4p1.samsung.com>
        <1500366698-117167-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19218 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753526AbdGSK3a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jul 2017 06:29:30 -0400
In-reply-to: <1500366698-117167-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

Dear Shawn,

On 07/18/2017 05:31 PM, Shawn Lin wrote:
> dwmmc host driver already deprecate it in the driver
> but didn't modify the documentation to reflect the fact.
> This patch deprecates it and clean up num-slots from the
> examples of all variant host drivers.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks you for sending patch! 

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
> 
>  Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt |  1 -
>  Documentation/devicetree/bindings/mmc/img-dw-mshc.txt    |  1 -
>  Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt     |  2 --
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt         | 16 +++++++---------
>  Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt     |  1 -
>  5 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index aad9844..a58c173 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -78,7 +78,6 @@ Example:
>  	};
>  
>  	dwmmc0@12200000 {
> -		num-slots = <1>;
>  		cap-mmc-highspeed;
>  		cap-sd-highspeed;
>  		broken-cd;
> diff --git a/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
> index 85de99f..c54e577 100644
> --- a/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
> @@ -24,6 +24,5 @@ Example:
>  
>  		fifo-depth = <0x20>;
>  		bus-width = <4>;
> -		num-slots = <1>;
>  		disable-wp;
>  	};
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> index 8af1afc..07242d1 100644
> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -36,7 +36,6 @@ Example:
>  
>  	/* Board portion */
>  	dwmmc0@fcd03000 {
> -		num-slots = <1>;
>  		vmmc-supply = <&ldo12>;
>  		fifo-depth = <0x100>;
>  		pinctrl-names = "default";
> @@ -52,7 +51,6 @@ Example:
>  
>  	dwmmc_1: dwmmc1@f723e000 {
>  		compatible = "hisilicon,hi6220-dw-mshc";
> -		num-slots = <0x1>;
>  		bus-width = <0x4>;
>  		disable-wp;
>  		cap-sd-highspeed;
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 9cb55ca..ef3e5f1 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -12,12 +12,12 @@ Required Properties:
>  * #address-cells: should be 1.
>  * #size-cells: should be 0.
>  
> -# Slots: The slot specific information are contained within child-nodes with
> -  each child-node representing a supported slot. There should be atleast one
> -  child node representing a card slot. The name of the child node representing
> -  the slot is recommended to be slot@n where n is the unique number of the slot
> -  connected to the controller. The following are optional properties which
> -  can be included in the slot child node.
> +# Slots (DEPRECATED): The slot specific information are contained within
> +  child-nodes with each child-node representing a supported slot. There should
> +  be atleast one child node representing a card slot. The name of the child node
> +  representing the slot is recommended to be slot@n where n is the unique number
> +  of the slot connected to the controller. The following are optional properties
> +  which can be included in the slot child node.
>  
>  	* reg: specifies the physical slot number. The valid values of this
>  	  property is 0 to (num-slots -1), where num-slots is the value
> @@ -63,7 +63,7 @@ Optional properties:
>    clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz by default.
>  	  (Use the "max-frequency" instead of "clock-freq-min-max".)
>  
> -* num-slots: specifies the number of slots supported by the controller.
> +* num-slots (DEPRECATED): specifies the number of slots supported by the controller.
>    The number of physical slots actually used could be equal or less than the
>    value specified by num-slots. If this property is not specified, the value
>    of num-slot property is assumed to be 1.
> @@ -124,7 +124,6 @@ board specific portions as listed below.
>  	dwmmc0@12200000 {
>  		clock-frequency = <400000000>;
>  		clock-freq-min-max = <400000 200000000>;
> -		num-slots = <1>;
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> @@ -139,7 +138,6 @@ board specific portions as listed below.
>  	dwmmc0@12200000 {
>  		clock-frequency = <400000000>;
>  		clock-freq-min-max = <400000 200000000>;
> -		num-slots = <1>;
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
> index eaade0e..906819a 100644
> --- a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
> @@ -25,7 +25,6 @@ Example:
>  		clock-frequency = <50000000>;
>  		clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
>  		clock-names = "biu", "ciu";
> -		num-slots = <1>;
>  		max-frequency = <50000000>;
>  		cap-sdio-irq;
>  		cap-sd-highspeed;
> 

