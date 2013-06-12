From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 1/2] ARM: socfpga: dts: Add support for SD/MMC
Date: Tue, 11 Jun 2013 20:47:11 -0500
Message-ID: <51B7D31F.3030004@gmail.com>
References: <1370996924-23048-1-git-send-email-dinguyen@altera.com> <1370996924-23048-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:36878 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604Ab3FLBrO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 21:47:14 -0400
Received: by mail-oa0-f45.google.com with SMTP id j1so1569709oag.4
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jun 2013 18:47:13 -0700 (PDT)
In-Reply-To: <1370996924-23048-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, Pavel Machek <pavel@denx.de>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, cjb@laptop.org

On 06/11/2013 07:28 PM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.
> Add "syscon" to the "altr,sys-mgr" binding.

Not sure how I see syscon is related to SD? That is a pretty vague name
as well.

> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-mmc@vger.kernel.org
> CC: <linux@arm.linux.org.uk>
> 
> v2:
> - Add "syscon" to "altr,sys-mgr"
> - Remove pwr-en field
> ---
>  .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   60 ++++++++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |   13 ++++-
>  arch/arm/boot/dts/socfpga_cyclone5.dts             |   13 +++++
>  arch/arm/boot/dts/socfpga_vt.dts                   |   12 ++++
>  4 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> new file mode 100644
> index 0000000..9d7062c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> @@ -0,0 +1,60 @@
> +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> +  Storage Host Controller
> +
> +Required Properties:
> +
> +* compatible: should be
> +	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> +	  specific extentions.

s/extentions/extensions/

> +
> +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
> +  value is fixed at 3, which mean parent_clock/4.
> +
> +* altr,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
> +  in transmit mode and CIU clock phase shift value in receive mode for single
> +  data rate mode operation. Refer notes below for the order of the cells and the
> +  valid values.
> +
> +  Notes for the sdr-timing values:
> +
> +    The order of the cells should be
> +      - First Cell: CIU clock phase shift value for RX mode, smplsel bits in
> +	the system manager SDMMC control group.
> +      - Second Cell: CIU clock phase shift value for TX mode, drvsel bits in
> +	the system manager SDMMC control group.
> +
> +    Valid values for SDR CIU clock timing for SOCFPGA:
> +      - valid value for tx phase shift and rx phase shift is 0 to 7.
> +
> +Required properties for a slot:
> +
> +* bus-width: Data width for card slot. 4-bit or 8-bit data.
> +
> +Example:
> +
> +  The MSHC controller node can be split into two portions, SoC specific and
> +  board specific portions as listed below.
> +
> +	dwmmc0@ff704000 {
> +		compatible = "altr,socfpga-dw-mshc";
> +		reg = <0xff704000 0x1000>;
> +		interrupts = <0 139 4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	dwmmc0@ff704000 {
> +		num-slots = <1>;
> +		supports-highspeed;
> +		broken-cd;
> +		fifo-depth = <0x400>;

Are these already documented. If so, can you add a reference to the
binding doc.

> +		altr,dw-mshc-ciu-div = <3>;
> +      		altr,dw-mshc-sdr-timing = <0 3>;
> +
> +		slot@0 {
> +			reg = <0>;
> +			bus-width = <4>;
> +		};
> +	};
> +
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index bee62a2..dbf7f22 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -468,6 +468,17 @@
>  			cache-level = <2>;
>  		};
>  
> +		mmc: dwmmc0@ff704000 {
> +			compatible = "altr,socfpga-dw-mshc";
> +			reg = <0xff704000 0x1000>;
> +			interrupts = <0 139 4>;
> +			fifo-depth = <0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
> +			clock-names = "biu", "ciu";
> +		};
> +
>  		/* Local timer */
>  		timer@fffec600 {
>  			compatible = "arm,cortex-a9-twd-timer";
> @@ -521,7 +532,7 @@
>  			};
>  
>  		sysmgr@ffd08000 {
> -				compatible = "altr,sys-mgr";
> +				compatible = "altr,sys-mgr", "syscon";
>  				reg = <0xffd08000 0x4000>;
>  			};
>  	};
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
> index 973999d..1853cb1 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
> @@ -54,6 +54,19 @@
>  			status = "okay";
>  		};
>  
> +		dwmmc0@ff704000 {
> +			num-slots = <1>;
> +			supports-highspeed;
> +			broken-cd;
> +			altr,dw-mshc-ciu-div = <3>;
> +			altr,dw-mshc-sdr-timing = <0 3>;
> +
> +			slot@0 {
> +				reg = <0>;
> +				bus-width = <4>;
> +			};
> +		};
> +
>  		timer0@ffc08000 {
>  			clock-frequency = <100000000>;
>  		};
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> index d1ec0ca..d93deb0 100644
> --- a/arch/arm/boot/dts/socfpga_vt.dts
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -46,6 +46,18 @@
>  			status = "okay";
>  		};
>  
> +		dwmmc0@ff704000 {
> +			num-slots = <1>;
> +			supports-highspeed;
> +			broken-cd;
> +			altr,dw-mshc-ciu-div = <3>;
> +
> +			slot@0 {
> +				reg = <0>;
> +				bus-width = <4>;
> +			};
> +		};
> +
>  		timer0@ffc08000 {
>  			clock-frequency = <7000000>;
>  		};
> 

