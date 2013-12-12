From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v5 3/7] regulator: add pbias regulator support
Date: Thu, 12 Dec 2013 20:42:11 +0530
Message-ID: <52A9D24B.6040902@ti.com>
References: <20131210104005.GB29268@sirena.org.uk> <1386686098-7779-1-git-send-email-balajitk@ti.com> <20131210183330.GK13171@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20131210183330.GK13171@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday 11 December 2013 12:03 AM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [131210 06:36]:
>> pbias register controls internal power supply to sd card i/o pads
>> in most OMAPs (OMAP2-5, DRA7).
>> Control bits for selecting voltage level and
>> enabling/disabling are in the same PBIAS register.
>
> Good to see this, few comments below.
>
>> +++ lo/Documentation/devicetree/bindings/regulator/pbias-regulator.txt	2013-12-10 16:58:28.907927745 +0530
>> @@ -0,0 +1,21 @@
>> +PBIAS internal regulator for SD card i/o pads on OMAP SoCs.
>> +
>> +Required properties:
>> +- compatible:
>> +  - "regulator-pbias-omap2" for OMAP2
>> +  - "regulator-pbias-omap3" for OMAP3
>> +  - "regulator-pbias-omap4" for OMAP4
>> +  - "regulator-pbias-omap5" for OMAP5, DRA7
>> +- pbias-reg-offset: PBIAS control register offset from syscon base address
>> +
>> +Optional properties:
>> +- Any optional property defined in bindings/regulator/regulator.txt
>> +
>> +Example:
>> +
>> +		pbias_regulator: pbias_regulator {
>> +			pbias-reg-offset = <0>;
>> +			regulator-name = "pbias_regulator";
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <3000000>;
>> +	};
>
> This does not seem to support the other PBIAS controls the same
> register has?
>
Hi Tony,
Thanks for the comments,

>> @@ -369,6 +369,15 @@ config REGULATOR_PALMAS
>>   	  on the muxing. This is handled automatically in the driver by
>>   	  reading the mux info from OTP.
>>
>> +config REGULATOR_PBIAS
>> +	tristate "PBIAS OMAP regulator driver"
>> +	depends on (ARCH_OMAP || COMPILE_TEST) && MFD_SYSCON
>> +	help
>> +	 Say y here to support pbias regulator for mmc1:SD card i/o
>> +	 on OMAP SoCs.
>> +	 This driver provides support for OMAP pbias modelled
>> +	 regulators.
>> +
>
> The PBIAS register is not just for MMC. Depending on the SoC revision,

yes, SIM pbias bit mapping are similar to MMC.
I will try to add sim pbias to my next version.

> you may also have 2 - 3 PBIAS devices in the same register. Please check
> the 2430 TRM, it has also I2C secondary pulls in this same register. And

This regulator driver will only control bits related to voltage settings
and is not touching other bits by using masks.

> on 3430, there PBIAS register has also SIM voltage bits.
>
> Certainly nothing stops from intially implementing the MMC pieces
> as those are needed badly, but it should be done in a way where adding
> support for the other PBIAS bits can be done easily.
>

yes, It can be easily done for SIM pbias control.

> You're also missing the PBIAS interrupts, so it might be worth checking
> the code from that point of view also to make sure adding the support
> for interrupts won't require massive changes to the driver.
>

PBIAS interrupts were never used in non-dt case, so did not consider
while adapting for DT. However it can be added later on.

Thanks and Regards,
Balaji T K
