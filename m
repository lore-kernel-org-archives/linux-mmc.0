From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [PATCH 2/3] arm64: allwinner: h6: add device tree
 nodes for MMC controllers
Date: Fri, 27 Apr 2018 16:36:26 +0800
Message-ID: <77DF7884-8DA8-4ED5-BB51-941CFDE4A123@aosc.io>
References: <20180426140728.43155-1-icenowy@aosc.io> <20180426140728.43155-3-icenowy@aosc.io> <9571735d-929f-a2ef-ed97-dc9193420b73@arm.com>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBKOCRPLQKGQEIZNMBWQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <9571735d-929f-a2ef-ed97-dc9193420b73-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



=E4=BA=8E 2018=E5=B9=B44=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=8812=
:45:38, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> =E5=86=99=E5=88=B0:
>Hi,
>
>On 26/04/18 15:07, Icenowy Zheng wrote:
>> The Allwinner H6 SoC have 3 MMC controllers.
>>=20
>> Add device tree nodes for them.
>>=20
>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 56
>++++++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> index 4debc3962830..3cbfc035c979 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -124,12 +124,68 @@
>>  			interrupt-controller;
>>  			#interrupt-cells =3D <3>;
>> =20
>> +			mmc0_pins: mmc0-pins {
>> +				pins =3D "PF0", "PF1", "PF2", "PF3",
>> +				       "PF4", "PF5";
>> +				function =3D "mmc0";
>> +				drive-strength =3D <30>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			mmc2_pins: mmc2-pins {
>> +				pins =3D "PC1", "PC4", "PC5", "PC6",
>> +				       "PC7", "PC8", "PC9", "PC10",
>> +				       "PC11", "PC12", "PC13", "PC14";
>> +				function =3D "mmc2";
>> +				drive-strength =3D <30>;
>> +				bias-pull-up;
>> +			};
>> +
>>  			uart0_ph_pins: uart0-ph {
>>  				pins =3D "PH0", "PH1";
>>  				function =3D "uart0";
>>  			};
>>  		};
>> =20
>> +		mmc0: mmc@4020000 {
>> +			compatible =3D "allwinner,sun50i-h6-mmc";
>
>This should be:
>			compatible =3D "allwinner,sun50i-h6-mmc",
>				     "allwinner,sun50i-a64-mmc";

I'm intended to not add A64 compatible, as
H6 is a quite new design
(new process) and there might be different behavior, even on mmc0/1.

>
>> +			reg =3D <0x04020000 0x1000>;
>> +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
>> +			clock-names =3D "ahb", "mmc";
>> +			resets =3D <&ccu RST_BUS_MMC0>;
>> +			reset-names =3D "ahb";
>> +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		mmc1: mmc@4021000 {
>> +			compatible =3D "allwinner,sun50i-h6-mmc";
>
>same here
>
>> +			reg =3D <0x04021000 0x1000>;
>> +			clocks =3D <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
>> +			clock-names =3D "ahb", "mmc";
>> +			resets =3D <&ccu RST_BUS_MMC1>;
>> +			reset-names =3D "ahb";
>> +			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		mmc2: mmc@4022000 {
>> +			compatible =3D "allwinner,sun50i-h6-emmc";
>
>and here:
>			compatible =3D "allwinner,sun50i-h6-emmc",
>				     "allwinner,sun50i-a64-emmc";

MMC2 on H6 has EMCE capability, so surely there should
only be H6 compatible, and no A64 one.

>
>The rest looks correct to me.
>
>Cheers,
>Andre.
>
>> +			reg =3D <0x04022000 0x1000>;
>> +			clocks =3D <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
>> +			clock-names =3D "ahb", "mmc";
>> +			resets =3D <&ccu RST_BUS_MMC2>;
>> +			reset-names =3D "ahb";
>> +			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>>  		uart0: serial@5000000 {
>>  			compatible =3D "snps,dw-apb-uart";
>>  			reg =3D <0x05000000 0x400>;
>>=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
