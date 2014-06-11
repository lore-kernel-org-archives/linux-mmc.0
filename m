From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv6 2/2] ARM: dts: unuse the slot-node and deprecated
 supports-highspeed for dw-mmc.
Date: Wed, 11 Jun 2014 15:49:17 +0900
Message-ID: <5397FBED.2020100@samsung.com>
References: <1402284855-3968-1-git-send-email-jh80.chung@samsung.com>
 <1402284855-3968-3-git-send-email-jh80.chung@samsung.com>
 <1402329181.9618.1.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:24500 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbaFKGtU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jun 2014 02:49:20 -0400
In-reply-to: <1402329181.9618.1.camel@linux-builds1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinguyen@altera.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, Heiko St?bner <heiko@sntech.de>, Mark Rutland <mark.rutland@arm.com>, Tushar Behera <tushar.behera@linaro.org>

Hi, Dinh.

Thanks for pointing out.
Will Fix it.

Best Regards,
Jaehoon Chung

On 06/10/2014 12:53 AM, Dinh Nguyen wrote:
> On Mon, 2014-06-09 at 12:34 +0900, Jaehoon Chung wrote:
>> dw-mmc controller can support multiple slots.
>> But, there are no use-cases anywhere. So we don't need to support the
>> slot-node for dw-mmc controller.
>> And "supports-highspeed" property in dw-mmc is deprecated.
>> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Reviewed-by: Tushar Behera <trblinux@gmail.com>
>> ---
>> Changelog V6:
>> 	- Add the missing property.
>> Changelog V5:
>> 	- Fix typo.
>> Changelog V4:
>> 	- Remove the slot-node.
>> 	- Rename Subject.
>> 		"[PATCHv3 4/4]ARM: dts: replace the slot property into slot sub-node for dwmmc"
>> Changelog V3:
>> 	- Merge "[PATCH 2/5] mmc: dw_mmc: rmove the "supports-highspeed" property"
>> Changelog V2:
>> 	- None
>>
>>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 ++++--------
>>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 ++++-----
>>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 ++++-----
>>  arch/arm/boot/dts/exynos4412-odroidx.dts           |    8 ++----
>>  arch/arm/boot/dts/exynos4412-origen.dts            |    8 ++----
>>  arch/arm/boot/dts/exynos4412-trats2.dts            |    8 ++----
>>  arch/arm/boot/dts/exynos5250-arndale.dts           |   18 ++++---------
>>  arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   28 ++++++--------------
>>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   18 ++++---------
>>  arch/arm/boot/dts/exynos5250-snow.dts              |    6 ++---
>>  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   16 +++--------
>>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   16 +++--------
>>  arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   16 +++--------
>>  arch/arm/boot/dts/socfpga_arria5.dtsi              |    5 ++--
>>  arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    9 +++----
>>  arch/arm/boot/dts/socfpga_vt.dts                   |    9 +++----
>>  16 files changed, 62 insertions(+), 144 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> index 532b1d4..4cdd283 100644
>> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> @@ -46,13 +46,14 @@ Required Properties:
>>        - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
>>          phase shift clocks should be 0.
>>  
>> -Required properties for a slot:
>> +Required properties for a slot (Deprecated - Recommend to use one slot per a host):
>>  
>>  * gpios: specifies a list of gpios used for command, clock and data bus. The
>>    first gpio is the command line and the second gpio is the clock line. The
>>    rest of the gpios (depending on the bus-width property) are the data lines in
>>    no particular order. The format of the gpio specifier depends on the gpio
>>    controller.
>> + (Deprecated - Refer to Documentaion/devicetree/binding/pinctrl/samsung-pinctrl.txt)
>>  
>>  Example:
>>  
>> @@ -69,21 +70,13 @@ Example:
>>  
>>  	dwmmc0@12200000 {
>>  		num-slots = <1>;
>> -		supports-highspeed;
>>  		broken-cd;
>> +		cap-mmc-highspeed;
>> +		cap-sd-highspeed;
>>  		fifo-depth = <0x80>;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>>  		samsung,dw-mshc-sdr-timing = <2 3>;
>>  		samsung,dw-mshc-ddr-timing = <1 2>;
>> -
>> -		slot@0 {
>> -			reg = <0>;
>> -			bus-width = <8>;
>> -			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
>> -				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
>> -				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
>> -				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
>> -				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
>> -		};
>> +		bus-width = <8>;
>>  	};
>> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> index b8653ea..514c0fc 100644
>> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> @@ -34,13 +34,11 @@ Example:
>>  		num-slots = <1>;
>>  		vmmc-supply = <&ldo12>;
>>  		fifo-depth = <0x100>;
>> -		supports-highspeed;
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
>> -		slot@0 {
>> -			reg = <0>;
>> -			bus-width = <4>;
>> -			disable-wp;
>> -			cd-gpios = <&gpio10 3 0>;
>> -		};
>> +		bus-width = <4>;
>> +		disable-wp;
>> +		cd-gpios = <&gpio10 3 0>;
>> +		cap-mmc-highspeed;
>> +		cap-sd-highspeed;
>>  	};
> 
> [snip]
> 
>>  
>>  		gpio-keys {
>> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
>> index 6c87b70..1da0e81 100644
>> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
>> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
>> @@ -29,12 +29,13 @@
>>  
>>  		dwmmc0@ff704000 {
>>  			num-slots = <1>;
>> -			supports-highspeed;
>> -			broken-cd;
>>  
>>  			slot@0 {
> 
> You can remove the slot@0 here too right?
> 
> Thanks,
> Dinh
> 
>>  				reg = <0>;
>>  				bus-width = <4>;
>> +				broken-cd;
>> +				cap-mmc-highspeed;
>> +				cap-sd-highspeed;
>>  			};
>>  		};
>>  
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
>> index ca41b0e..c4ebf65 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
>> @@ -30,13 +30,10 @@
>>  
>>  		dwmmc0@ff704000 {
>>  			num-slots = <1>;
>> -			supports-highspeed;
>>  			broken-cd;
>> -
>> -			slot@0 {
>> -				reg = <0>;
>> -				bus-width = <4>;
>> -			};
>> +			bus-width = <4>;
>> +			cap-mmc-highspeed;
>> +			cap-sd-highspeed;
>>  		};
>>  
>>  		ethernet@ff702000 {
>> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
>> index 87d6f75..07e7206 100644
>> --- a/arch/arm/boot/dts/socfpga_vt.dts
>> +++ b/arch/arm/boot/dts/socfpga_vt.dts
>> @@ -43,13 +43,10 @@
>>  
>>  		dwmmc0@ff704000 {
>>  			num-slots = <1>;
>> -			supports-highspeed;
>>  			broken-cd;
>> -
>> -			slot@0 {
>> -				reg = <0>;
>> -				bus-width = <4>;
>> -			};
>> +			bus-width = <4>;
>> +			cap-mmc-highspeed;
>> +			cap-sd-highspeed;
>>  		};
>>  
>>  		ethernet@ff700000 {
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

