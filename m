From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: exynos: Define vqmmc for eMMC card on
 Odroid X/X2/U3
Date: Thu, 28 Apr 2016 07:50:18 +0200
Message-ID: <5721A49A.1020401@samsung.com>
References: <1461765620-6833-1-git-send-email-k.kozlowski@samsung.com>
 <1461765620-6833-2-git-send-email-k.kozlowski@samsung.com>
 <bca8c1c9-41ac-c7e8-9313-ff96058376be@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <bca8c1c9-41ac-c7e8-9313-ff96058376be@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux.amoon@gmail.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 04/27/2016 11:29 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 04/27/2016 10:00 AM, Krzysztof Kozlowski wrote:
>> The eMMC card vmmc-supply contained incorrectly two regulators: LDO20
>> and buck8. The second one is ignored. Additionally the buck8 is a vqmmc
>> supply only on X and X2. On U3 the buck8 is providing power to the LAN
>> (SMSC95xx) so instead the LDO22 should be used.
>>
>> Fix this by defining proper vmmc and vqmmc supplies for respective
>> boards.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> ---
>>
>> Changes since v1:
>> 1. buck8 is used on X/X2 so differentiate the configuration (hint by
>>    Tobias Jakobi).
>> ---
>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 13 ++++++++++---
>>  arch/arm/boot/dts/exynos4412-odroidu3.dts       | 18 ++++++++++++++++++
>>  arch/arm/boot/dts/exynos4412-odroidx.dts        | 11 +++++++++++
>>  arch/arm/boot/dts/exynos4412-odroidx2.dts       | 11 +++++++++++
>>  4 files changed, 50 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> index 3d0d44581fbd..34a5b3daced0 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> @@ -347,6 +347,13 @@
>>  				regulator-boot-on;
>>  			};
>>  
>> +			ldo22_reg: LDO22 {
>> +				regulator-name = "LDO22";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <3950000>;
>> +				regulator-boot-on;
>> +			};
>> +
> 
> I don't have a datasheet for the max77686 but I guess these min and max
> values are the actual voltage range that the ldo22 regulator can support?

Yes.

> If that's the case, then I don't think setting these are correct since the
> DT binding says that the regulator-{min,max}-microvolt properties describe
> the voltage range that consumers may set. I've seen Mark mention this many
> times, the last one I remember is at [0].

For LDO22 there is no consumer so these are the constraints. Leaving
them undefined (here and in DTS for X/X2) would result in the same
effect. The point is that these values are valid constraints. Please
have in mind that the binding describe this as "smallest/largest voltage
consumer may set" which is true for the code above.

> 
> Probably would be better to leave the ldo22_reg definition to odroidu3.dts
> to avoid setting these constraint in a .dtsi file.

What about X/X2?

>>  			ldo25_reg: LDO25 {
>>  				regulator-name = "VDDQ_LCD_1.8V";
>>  				regulator-min-microvolt = <1800000>;
>> @@ -411,8 +418,8 @@
>>  
>>  			buck8_reg: BUCK8 {
>>  				regulator-name = "BUCK8_2.8V";
>> -				regulator-min-microvolt = <2800000>;
>> -				regulator-max-microvolt = <2800000>;
>> +				regulator-min-microvolt = <750000>;
>> +				regulator-max-microvolt = <3900000>;
> 
> Same here, since not all boards have the same constraint for this regulator,
> it would be better to remove it from the .dtsi and let each dts to define it.

Since all of the boards define them, it does not bring any difference
having it here... so I can remove them.


>>  			};
>>  		};
>>  	};
>> @@ -456,7 +463,7 @@
>>  &mshc_0 {
>>  	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
>>  	pinctrl-names = "default";
>> -	vmmc-supply = <&ldo20_reg &buck8_reg>;
>> +	vmmc-supply = <&ldo20_reg>;
>>  	mmc-pwrseq = <&emmc_pwrseq>;
>>  	status = "okay";
>>  
>> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
>> index dd89f7b37c9f..d73aa6c58fe3 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
>> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
>> @@ -69,6 +69,24 @@
>>  	};
>>  };
>>  
>> +/* Supply for LAN9730/SMSC95xx */
>> +&buck8_reg {
>> +	regulator-name = "BUCK8_P3V3";
> 
> I think it would be better to name it "BUCK8_3.3V" for consistency. 

Consistency of naming is nice but in the same time we want the regulator
names to match the hardware because it is easier to read the code and
check the schematics. On the schematics this is unfortunately called
P3V3. :)

> 
>> +	regulator-min-microvolt = <3300000>;
>> +	regulator-max-microvolt = <3300000>;
>> +};
>> +
>> +/* VDDQ for MSHC (eMMC card) */
>> +&ldo22_reg {
>> +	regulator-name = "LDO22_VDDQ_MMC4_2.8V";
>> +	regulator-min-microvolt = <2800000>;
>> +	regulator-max-microvolt = <2800000>;
>> +};
>> +
>> +&mshc_0 {
>> +	vqmmc-supply = <&ldo22_reg>;
>> +};
>> +
>>  &pwm {
>>  	pinctrl-0 = <&pwm0_out>;
>>  	pinctrl-names = "default";
>> diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
>> index bf7b21b817e4..2af235151301 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroidx.dts
>> +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
>> @@ -63,12 +63,23 @@
>>  	};
>>  };
>>  
>> +/* VDDQ for MSHC (eMMC card) */
>> +&buck8_reg {
>> +	regulator-name = "BUCK8_VDDQ_MMC4_2.8V";
>> +	regulator-min-microvolt = <2800000>;
>> +	regulator-max-microvolt = <2800000>;
>> +};
>> +
>>  &ehci {
>>  	port@1 {
>>  		status = "okay";
>>  	};
>>  };
>>  
>> +&mshc_0 {
>> +	vqmmc-supply = <&buck8_reg>;
>> +};
>> +
>>  &pinctrl_1 {
>>  	gpio_home_key: home_key {
>>  		samsung,pins = "gpx2-2";
>> diff --git a/arch/arm/boot/dts/exynos4412-odroidx2.dts b/arch/arm/boot/dts/exynos4412-odroidx2.dts
>> index 6e33678562ae..3e3584270e00 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroidx2.dts
>> +++ b/arch/arm/boot/dts/exynos4412-odroidx2.dts
>> @@ -22,6 +22,17 @@
>>  	};
>>  };
>>  
>> +/* VDDQ for MSHC (eMMC card) */
>> +&buck8_reg {
>> +	regulator-name = "BUCK8_VDDQ_MMC4_2.8V";
>> +	regulator-min-microvolt = <2800000>;
>> +	regulator-max-microvolt = <2800000>;
>> +};
>> +
>> +&mshc_0 {
>> +	vqmmc-supply = <&buck8_reg>;
>> +};
>> +
>>  &sound {
>>  	simple-audio-card,name = "Odroid-X2";
>>  	simple-audio-card,widgets =
>>
> 
> Rest looks good, so if you do those changes feel free to add:
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> [0]: http://www.spinics.net/lists/linux-omap/msg127035.html

Thanks for feedback!

Krzysztof
