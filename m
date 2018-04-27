From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] arm64: allwinner: h6: add device tree
 nodes for MMC controllers
Date: Fri, 27 Apr 2018 10:18:23 +0100
Message-ID: <0ae1b6ce-c1cf-61e8-e09b-abec47b089b2@arm.com>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-3-icenowy@aosc.io>
 <9571735d-929f-a2ef-ed97-dc9193420b73@arm.com>
 <77DF7884-8DA8-4ED5-BB51-941CFDE4A123@aosc.io>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDNZNK75ZIKRB6GVRPLQKGQEHETIRUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <77DF7884-8DA8-4ED5-BB51-941CFDE4A123-h8G6r0blFSE@public.gmane.org>
Content-Language: en-GB
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 27/04/18 09:36, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B44=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=88=
12:45:38, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> =E5=86=99=E5=88=B0:
>> Hi,
>>
>> On 26/04/18 15:07, Icenowy Zheng wrote:
>>> The Allwinner H6 SoC have 3 MMC controllers.
>>>
>>> Add device tree nodes for them.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>>> ---
>>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 56
>> ++++++++++++++++++++++++++++
>>>  1 file changed, 56 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>> index 4debc3962830..3cbfc035c979 100644
>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>> @@ -124,12 +124,68 @@
>>>  			interrupt-controller;
>>>  			#interrupt-cells =3D <3>;
>>> =20
>>> +			mmc0_pins: mmc0-pins {
>>> +				pins =3D "PF0", "PF1", "PF2", "PF3",
>>> +				       "PF4", "PF5";
>>> +				function =3D "mmc0";
>>> +				drive-strength =3D <30>;
>>> +				bias-pull-up;
>>> +			};
>>> +
>>> +			mmc2_pins: mmc2-pins {
>>> +				pins =3D "PC1", "PC4", "PC5", "PC6",
>>> +				       "PC7", "PC8", "PC9", "PC10",
>>> +				       "PC11", "PC12", "PC13", "PC14";
>>> +				function =3D "mmc2";
>>> +				drive-strength =3D <30>;
>>> +				bias-pull-up;
>>> +			};
>>> +
>>>  			uart0_ph_pins: uart0-ph {
>>>  				pins =3D "PH0", "PH1";
>>>  				function =3D "uart0";
>>>  			};
>>>  		};
>>> =20
>>> +		mmc0: mmc@4020000 {
>>> +			compatible =3D "allwinner,sun50i-h6-mmc";
>>
>> This should be:
>> 			compatible =3D "allwinner,sun50i-h6-mmc",
>> 				     "allwinner,sun50i-a64-mmc";
>=20
> I'm intended to not add A64 compatible, as
> H6 is a quite new design
> (new process) and there might be different behavior, even on mmc0/1.

But as your patch proves, it is fully backwards compatible: An A64
driver works with this device.
And this is what this compatible string list says: If your system does
not have a specific H6 driver, you can use an A64 driver.
You might not get all the (potentially) new features, but it covers
everything the A64 has.

And a new silicon process doesn't matter here, since the software
interface is unchanged. *If* we find bugs, we can add quirks matching on
the H6 compatible string - that's why we put it here already, despite
having a matching string in the kernel at the moment.

>>> +			reg =3D <0x04020000 0x1000>;
>>> +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
>>> +			clock-names =3D "ahb", "mmc";
>>> +			resets =3D <&ccu RST_BUS_MMC0>;
>>> +			reset-names =3D "ahb";
>>> +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>>> +			status =3D "disabled";
>>> +			#address-cells =3D <1>;
>>> +			#size-cells =3D <0>;
>>> +		};
>>> +
>>> +		mmc1: mmc@4021000 {
>>> +			compatible =3D "allwinner,sun50i-h6-mmc";
>>
>> same here
>>
>>> +			reg =3D <0x04021000 0x1000>;
>>> +			clocks =3D <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
>>> +			clock-names =3D "ahb", "mmc";
>>> +			resets =3D <&ccu RST_BUS_MMC1>;
>>> +			reset-names =3D "ahb";
>>> +			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>> +			status =3D "disabled";
>>> +			#address-cells =3D <1>;
>>> +			#size-cells =3D <0>;
>>> +		};
>>> +
>>> +		mmc2: mmc@4022000 {
>>> +			compatible =3D "allwinner,sun50i-h6-emmc";
>>
>> and here:
>> 			compatible =3D "allwinner,sun50i-h6-emmc",
>> 				     "allwinner,sun50i-a64-emmc";
>=20
> MMC2 on H6 has EMCE capability, so surely there should
> only be H6 compatible, and no A64 one.

Same as above, the A64 eMMC is a subset of the H6 eMMC, so the A64 eMMC
driver can drive the H6 as well. And again your code proves that,
because it behaves exactly the same as for the A64.
In case we ever get support for the EMCE, we add the new compatible
string to the driver and tie it to the new feature. So newer kernels can
use this feature, older kernel will just not, but can happily use the
eMMC anyway.

Cheers,
Andre.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
