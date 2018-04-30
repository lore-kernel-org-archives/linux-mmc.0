From: Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [linux-sunxi] [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on Pine H64
Date: Mon, 30 Apr 2018 17:51:58 +0800
Message-ID: <CDCEAF85-ACD3-4884-8727-3AB1BFF670FE@aosc.io>
References: <20180426140728.43155-1-icenowy@aosc.io> <20180426140728.43155-4-icenowy@aosc.io> <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com> <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io> <45956397-a593-e51e-8637-655178c5901c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45956397-a593-e51e-8637-655178c5901c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andre.przywara@arm.comAndre Przywara <andre.przywara@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org



于 2018年4月30日 GMT+08:00 下午5:47:35, Andre Przywara <andre.przywara@arm.com> 写到:
>Hi Icenowy,
>
>On 27/04/18 08:12, Icenowy Zheng wrote:
>> 
>> 
>> 于 2018年4月27日 GMT+08:00 上午12:46:26, Andre Przywara
><andre.przywara@arm.com> 写到:
>>> Hi,
>>>
>>> On 26/04/18 15:07, Icenowy Zheng wrote:
>>>> The Pine H64 board have a MicroSD slot connected to MMC0 controller
>>> of
>>>> the H6 SoC and a eMMC slot connected to MMC2.
>>>>
>>>> Enable them in the device tree.
>>>>
>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> ---
>>>>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 32
>>> ++++++++++++++++++++++
>>>>  1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>> index d36de5eb81f3..78b1cd54687c 100644
>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>> @@ -20,6 +20,38 @@
>>>>  	chosen {
>>>>  		stdout-path = "serial0:115200n8";
>>>>  	};
>>>> +
>>>> +	reg_vcc3v3: vcc3v3 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "vcc3v3";
>>>> +		regulator-min-microvolt = <3300000>;
>>>> +		regulator-max-microvolt = <3300000>;
>>>> +	};
>>>> +
>>>> +	reg_vcc1v8: vcc1v8 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "vcc1v8";
>>>> +		regulator-min-microvolt = <1800000>;
>>>> +		regulator-max-microvolt = <1800000>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&mmc0 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&mmc0_pins>;
>>>> +	vmmc-supply = <&reg_vcc3v3>;
>>>
>>> So this is actually CLDO1 on the AXP, correct?
>> 
>> I remember it's coupled between two LDOs, to provide enough power.
>> 
>>>
>>>
>>>> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&mmc2 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&mmc2_pins>;
>>>> +	vmmc-supply = <&reg_vcc3v3>;
>>>> +	vqmmc-supply = <&reg_vcc1v8>;
>>>
>>> And this is BLDO2?
>> 
>> Yes.
>> 
>>>
>>> I am just asking because I want to avoid running into the same
>problem
>>> as with the A64 before: that future DTs become incompatible with
>older
>>> kernels, because we change the power supply to point to the AXP
>>> regulators, which this kernel does not support yet.
>> 
>> The answer is just not to keep this compatibility, as it's not
>> supported option to update DT without updating kernel.
>
>Well, I recognise that statement.. ;-) and I understand that it's far
>easier to handle it this way. But:
>- Which .dtb are we going to write into the SPI flash? An older one,
>which covers all kernels, but lacks features? Or a newer one, which
>limits the bootable kernels to recent versions?
>- Which DT are we going to give to EFI applications?
>- Which DT are the BSDs suspected to take? They don't ship their own
>DTs
>(which is good!).
>
>So I understand that "shipping the DT with the kernel" is the old
>(embedded!) way of doing things, but I really believe we should stop
>relying on this and try to come up with backwards compatible DTs, which
>live in the firmware and get updated there. Because this is what the
>distros seem to expect from ARM64 boards these days.

I think in this way we should change the way to submit
patches -- let DT binding patch be merged when it's ready,
and do not wait for driver.

>
>> P.S. I think the DT will update twice on the kernel side, the
>> first time keep reg_vcc3v3 (as it's coupled) but use real
>> regulator for reg_vcc1v8, the second time use the real
>> coupled regulator for reg_vcc3v3.
>> 
>>>
>>> It looks like there are more users of those power rails, so we could
>>> keep those supplies connected to these fixed regulators here, even
>with
>>> AXP-805 support in the kernel.
>> 
>> It's not a good choice.
>> 
>>>
>>> Or we keep this back until we get proper AXP support in the kernel?
>I
>>> guess it's quite close to the existing PMICs, so it might be more a
>>> copy&paste exercise to support the AXP-805?
>> 
>> It's not a reason to keep it back.
>
>So I compared the manuals of the AXP806 and the AXP805, the register
>interface looks identical to me. I only have a (somewhat) Chinese
>version of the AXP806 manual, so couldn't really find the difference
>between the two. Do you know more about it? Is it just maybe the
>packaging and the electrical properties (like max current supported)?
>
>If the I2C register interface is really the same, we could just add the
>DT nodes for the regulator and be done.

They're the same. My following patchset adds AXP805
compatible just to use AXP806 code. I have asked Wink
and the answer is that they have only preset difference.

>
>Cheers,
>Andre.
>
>> 
>>>
>>> But apart from this this looks correct to me.
>>>
>>> Cheers,
>>> Andre.
>>>
>>>> +	non-removable;
>>>> +	cap-mmc-hw-reset;
>>>> +	status = "okay";
>>>>  };
>>>>  
>>>>  &uart0 {
>>>>
