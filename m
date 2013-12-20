From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v6 5/7] ARM: dts: add pbias dt node
Date: Fri, 20 Dec 2013 17:10:00 +0530
Message-ID: <52B42C90.2080004@ti.com>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com> <1387456720-7202-1-git-send-email-balajitk@ti.com> <1387456720-7202-6-git-send-email-balajitk@ti.com> <20131219163356.GL27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37629 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755929Ab3LTLkJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Dec 2013 06:40:09 -0500
In-Reply-To: <20131219163356.GL27438@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org

On Thursday 19 December 2013 10:03 PM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [131219 04:40]:
>> @@ -485,6 +503,7 @@
>>   			dmas = <&sdma 61>, <&sdma 62>;
>>   			dma-names = "tx", "rx";
>>   			status = "disabled";
>> +			pbias-supply = <&pbias_mmc_reg>;
>>   		};
>>
>>   		mmc2: mmc@480b4000 {
>> diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
>> index d624345..f127901 100644
>> --- a/arch/arm/boot/dts/omap2430.dtsi
>> +++ b/arch/arm/boot/dts/omap2430.dtsi
>> @@ -29,6 +29,24 @@
>>   			pinctrl-single,function-mask = <0x3f>;
>>   		};
>>
>> +		omap2_scm_general: tisyscon@49002270 {
>> +			compatible = "ti,control-syscon", "syscon", "simple-bus";
>> +			reg = <0x49002270 0x240>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			pbias_regulator: pbias_regulator {
>> +				compatible = "ti,pbias-omap";
>> +				reg = <0x230 0x4>;
>> +				pbias_mmc_reg: pbias_mmc_omap3 {
>> +					regulator-name = "pbias_mmc_omap3";
>> +					regulator-min-microvolt = <1800000>;
>> +					regulator-max-microvolt = <3000000>;
>> +					regulator-enable-ramp-delay = <100>;
>> +				};
>> +			};
>> +		};
>> +
>>   		gpio1: gpio@4900c000 {
>>   			compatible = "ti,omap2-gpio";
>>   			reg = <0x4900c000 0x200>;
>
> Here too you may need to set up pbias_mmc_omap2430?
>

2430 pbias reg config is same as 3430/3630 w.r.t to mmc pbias i/o,
hence using the same name, if you think regulator name needs to be changed
let me know the more appropriate one.
