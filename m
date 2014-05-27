From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv2 3/3] ARM: dts: replace the broken-cd property into slot
 node for dwmmc.
Date: Tue, 27 May 2014 19:08:47 +0900
Message-ID: <5384642F.50406@samsung.com>
References: <1401104107-17651-1-git-send-email-jh80.chung@samsung.com>
 <1401104107-17651-4-git-send-email-jh80.chung@samsung.com>
 <002f01cf7990$fb20b530$f1621f90$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <002f01cf7990$fb20b530$f1621f90$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cpgs@samsung.com
List-Id: linux-mmc@vger.kernel.org

On 05/27/2014 06:49 PM, Seungwon Jeon wrote:
> Can this be merged with your another patch, " [PATCH 2/5] mmc: dw_mmc: remove the "supports-highspeed" property."?

Sure..

> 
> On Mon, May 26, 2014, Jaehoon Chung wrote:
>> dw-mmc controller can be support the multiple slot.
> can support, it would be better to correct the above message.

Fix it.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
> 
>> So each slot's property can be difference.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog V2:
>> 	- None
>>
>>  arch/arm/boot/dts/exynos4412-odroidx.dts      |    2 +-
>>  arch/arm/boot/dts/exynos4412-origen.dts       |    2 +-
>>  arch/arm/boot/dts/exynos4412-trats2.dts       |    4 ++--
>>  arch/arm/boot/dts/exynos5250-arndale.dts      |    2 +-
>>  arch/arm/boot/dts/exynos5250-cros-common.dtsi |    4 ++--
>>  arch/arm/boot/dts/exynos5250-smdk5250.dts     |    2 +-
>>  arch/arm/boot/dts/exynos5420-arndale-octa.dts |    2 +-
>>  arch/arm/boot/dts/rk3066a-bqcurie2.dts        |    2 +-
>>  arch/arm/boot/dts/socfpga_arria5.dtsi         |    2 +-
>>  arch/arm/boot/dts/socfpga_cyclone5.dtsi       |    2 +-
>>  arch/arm/boot/dts/socfpga_vt.dts              |    2 +-
>>  11 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
>> index 31db28a..24ec351 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroidx.dts
>> +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
>> @@ -46,7 +46,6 @@
>>
>>  		num-slots = <1>;
>>  		supports-highspeed;
>> -		broken-cd;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>>  		samsung,dw-mshc-sdr-timing = <2 3>;
>> @@ -55,6 +54,7 @@
>>  		slot@0 {
>>  			reg = <0>;
>>  			bus-width = <8>;
>> +			broken-cd;
>>  		};
>>  	};
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
>> index e2c0dca..ed712a6 100644
>> --- a/arch/arm/boot/dts/exynos4412-origen.dts
>> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
>> @@ -129,7 +129,6 @@
>>
>>  		num-slots = <1>;
>>  		supports-highspeed;
>> -		broken-cd;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>>  		samsung,dw-mshc-sdr-timing = <2 3>;
>> @@ -138,6 +137,7 @@
>>  		slot@0 {
>>  			reg = <0>;
>>  			bus-width = <8>;
>> +			broken-cd;
>>  		};
>>  	};
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
>> index 73be464..37c3cb3 100644
>> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
>> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
>> @@ -460,8 +460,6 @@
>>  	mmc@12550000 {
>>  		num-slots = <1>;
>>  		supports-highspeed;
>> -		broken-cd;
>> -		non-removable;
>>  		card-detect-delay = <200>;
>>  		vmmc-supply = <&vemmc_reg>;
>>  		clock-frequency = <400000000>;
>> @@ -475,6 +473,8 @@
>>  		slot@0 {
>>  			reg = <0>;
>>  			bus-width = <8>;
>> +			non-removable;
>> +			broken-cd;
>>  		};
>>  	};
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
>> index 090f983..0c9a7da 100644
>> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
>> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
>> @@ -400,7 +400,6 @@
>>  		status = "okay";
>>  		num-slots = <1>;
>>  		supports-highspeed;
>> -		broken-cd;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>>  		samsung,dw-mshc-sdr-timing = <2 3>;
>> @@ -412,6 +411,7 @@
>>  		slot@0 {
>>  			reg = <0>;
>>  			bus-width = <8>;
>> +			broken-cd;
>>  		};
>>  	};
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-
>> common.dtsi
>> index 2c1560d..7ab3b94 100644
>> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>> @@ -249,7 +249,6 @@
>>  	mmc@12200000 {
>>  		num-slots = <1>;
>>  		supports-highspeed;
>> -		broken-cd;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>>  		samsung,dw-mshc-sdr-timing = <2 3>;
>> @@ -260,6 +259,7 @@
>>  		slot@0 {
>>  			reg = <0>;
>>  			bus-width = <8>;
>> +			broken-cd;
>>  		};
>>  	};
>>
>> @@ -283,7 +283,6 @@
>>  	mmc@12230000 {
>>  		num-slots = <1>;
>>  		supports-highspeed;
>> -		broken-cd;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>>  		samsung,dw-mshc-sdr-timing = <2 3>;
>> @@ -293,6 +292,7 @@
>>  		slot@0 {
>>  			reg = <0>;
>>  			bus-width = <4>;
>> +			broken-cd;
>>  		};
>>  	};
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> index a794a70..feffe24 100644
>> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>> @@ -283,7 +283,6 @@
>>  		status = "okay";
>>  		num-slots = <1>;
>>  		supports-highspeed;
>> -		broken-cd;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>>  		samsung,dw-mshc-sdr-timing = <2 3>;
>> @@ -294,6 +293,7 @@
>>  		slot@0 {
>>  			reg = <0>;
>>  			bus-width = <8>;
>> +			broken-cd;
>>  		};
>>  	};
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-
>> octa.dts
>> index 80a3bf4..0d3b467 100644
>> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> @@ -39,7 +39,6 @@
>>
>>  	mmc@12200000 {
>>  		status = "okay";
>> -		broken-cd;
>>  		supports-highspeed;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>> @@ -52,6 +51,7 @@
>>  		slot@0 {
>>  			reg = <0>;
>>  			bus-width = <8>;
>> +			broken-cd;
>>  		};
>>  	};
>>
>> diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
>> index 035df40..62c7484 100644
>> --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
>> +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
>> @@ -69,7 +69,6 @@
>>  		dwmmc@10218000 { /* wifi */
>>  			num-slots = <1>;
>>  			status = "okay";
>> -			non-removable;
>>
>>  			pinctrl-names = "default";
>>  			pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
>> @@ -78,6 +77,7 @@
>>  				reg = <0>;
>>  				bus-width = <4>;
>>  				disable-wp;
>> +				non-removable;
>>  			};
>>  		};
>>
>> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
>> index 6c87b70..9c2b933 100644
>> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
>> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
>> @@ -30,11 +30,11 @@
>>  		dwmmc0@ff704000 {
>>  			num-slots = <1>;
>>  			supports-highspeed;
>> -			broken-cd;
>>
>>  			slot@0 {
>>  				reg = <0>;
>>  				bus-width = <4>;
>> +				broken-cd;
>>  			};
>>  		};
>>
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
>> index ca41b0e..c5c7b5f 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
>> @@ -31,11 +31,11 @@
>>  		dwmmc0@ff704000 {
>>  			num-slots = <1>;
>>  			supports-highspeed;
>> -			broken-cd;
>>
>>  			slot@0 {
>>  				reg = <0>;
>>  				bus-width = <4>;
>> +				broken-cd;
>>  			};
>>  		};
>>
>> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
>> index 87d6f75..ff1111e 100644
>> --- a/arch/arm/boot/dts/socfpga_vt.dts
>> +++ b/arch/arm/boot/dts/socfpga_vt.dts
>> @@ -44,11 +44,11 @@
>>  		dwmmc0@ff704000 {
>>  			num-slots = <1>;
>>  			supports-highspeed;
>> -			broken-cd;
>>
>>  			slot@0 {
>>  				reg = <0>;
>>  				bus-width = <4>;
>> +				broken-cd;
>>  			};
>>  		};
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
