From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] arm64: dts: sun50i: add MMC nodes
Date: Wed, 4 Jan 2017 00:22:15 +0000
Message-ID: <6e90ad76-8f25-538a-433e-ab31e8fab526@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
 <CAGb2v65GJFTnQZtWHCS7CAtA+Dry94o77aakPLr938BpQksLog@mail.gmail.com>
 <d4c2233c-95aa-4d72-1501-9ecb62f6cd82@arm.com>
 <CAGb2v65GAvyDn1oMXy2cpOD5PFRoYYOk-VbsMPAX3SNFz2ukLg@mail.gmail.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBPUAWHBQKGQEWQWE3TA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v65GAvyDn1oMXy2cpOD5PFRoYYOk-VbsMPAX3SNFz2ukLg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 03/01/17 13:28, Chen-Yu Tsai wrote:
> On Tue, Jan 3, 2017 at 6:48 PM, Andr=C3=A9 Przywara <andre.przywara@arm.c=
om> wrote:
>> On 03/01/17 02:52, Chen-Yu Tsai wrote:

Hi Chen-Yu,

>>> On Tue, Jan 3, 2017 at 7:03 AM, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>=
 wrote:
>>>
>>> A commit message explaining the mmc controllers would be nice.
>>
>> OK.
>>
>>>> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
>>>> ---
>>>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 67 ++++++++++++++++++=
+++++++++
>>>>  1 file changed, 67 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-a64.dtsi
>>>> index e0dcab8..c680566 100644
>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>>> @@ -150,6 +150,32 @@
>>>>                                 pins =3D "PB8", "PB9";
>>>>                                 function =3D "uart0";
>>>>                         };
>>>> +
>>>> +                       mmc0_pins: mmc0@0 {
>>>> +                               pins =3D "PF0", "PF1", "PF2", "PF3", "=
PF4", "PF5";
>>>> +                               function =3D "mmc0";
>>>> +                               drive-strength =3D <30>;
>>>> +                       };
>>>> +
>>>> +                       mmc0_default_cd_pin: mmc0_cd_pin@0 {
>>>> +                               pins =3D "PF6";
>>>> +                               function =3D "gpio_in";
>>>> +                               bias-pull-up;
>>>> +                       };
>>>
>>> We are starting to drop pinmux nodes for gpio usage.
>>
>> And replacing them with what?
>> Or do you mean they go in the individual board .dts files?
>> In this case I believe having a default pin defined here would help to
>> define it in every .dts.
>=20
> Nope. I meant dropping them. Pinmux and gpio are orthogonal. One should n=
ot
> need to specify a gpio pinmux to use it as a gpio. We added them because =
in
> the past nothing was preventing someone from claiming an already muxed pi=
n
> as a gpio. On some platforms this is fine. For sunxi, this breaks the sys=
tem,
> as the gpio functions are muxed in.
>=20
> The idea moving forward is that these cases should be guarded in the driv=
er.

Ah, OK, you mean just referencing the pin like:
        cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
in the board DT is enough? And the driver claiming it will (eventually?)
prevent users from using them via the sysfs interface then?

> Of course we would have to deal with existing dtbs, but lets not add any =
more.
>=20
>>>> +
>>>> +                       mmc1_pins: mmc1@0 {
>>>> +                               pins =3D "PG0", "PG1", "PG2", "PG3", "=
PG4", "PG5";
>>>> +                               function =3D "mmc1";
>>>> +                               drive-strength =3D <30>;
>>>> +                       };
>>>> +
>>>> +                       mmc2_pins: mmc2@0 {
>>>> +                               pins =3D "PC1", "PC5", "PC6", "PC8", "=
PC9",
>>>> +                                      "PC10", "PC11", "PC12", "PC13",=
 "PC14",
>>>> +                                      "PC15", "PC16";
>>>> +                               function =3D "mmc2";
>>>> +                               drive-strength =3D <30>;
>>>> +                       };
>>>
>>> Moreover I think you should split out the pinmux nodes to a separate pa=
tch.
>>
>> I can surely do, just wondering what's the rationale is behind that?
>=20
> More or less the "do one thing in one patch" rationale. Of course you can
> claim these are the defaults used in the reference design and pretty much
> every board out there. Then it makes sense to do them together. :)

Mmmh, probably a misunderstanding, but:
Those pins are the possible pins that expose the MMC interface. Those
nodes here name them to allow easy and concise reference by a board DT
(as in the following patch).
And in fact in case of the A64 there are _no_ alternative muxes for the
three MMC controllers: SDC0 is only on PF0-5, SDC1 on PG0-PG5 and SDC2
on PC1-PC16.
So it's not a board design question, apart from using a controller or not.

That's why I rather keep them together with the MMC controller nodes.

>>>
>>>>                 };
>>>>
>>>>                 uart0: serial@1c28000 {
>>>> @@ -240,6 +266,47 @@
>>>>                         #size-cells =3D <0>;
>>>>                 };
>>>>
>>>> +               mmc0: mmc@1c0f000 {
>>>> +                       compatible =3D "allwinner,sun50i-a64-mmc",
>>>> +                                    "allwinner,sun5i-a13-mmc";
>>>
>>> Given that sun5i doesn't support mmc delay timings, and the A64 has
>>> calibration and delay timings, I wouldn't call them compatible.
>>>
>>> Or are you claiming that for the A64 has a delay of 0 for the
>>> currently supported speeds, so the calibration doesn't really
>>> matter? If so this should be mentioned in the commit message.
>>
>> Yes, that's my observation: Driving it with sun5-a13-mmc just works.
>> This sun5i driver version does not (and will never) support higher
>> transfer modes anyway, so for that subset they are compatible. This
>> opens up the door to other operating systems not having a particular
>> driver for the A64, for instance, also older Linux kernels.
>> I know that sunxi doesn't use this compatible feature much, but IMHO we
>> should really start thinking about the DT not just being Linux specific
>> - or even being specific to a certain Linux version. And this case here
>> is a good example: An A13 MMC driver can drive this device - if there is
>> no better driver (an A64 one) available.
>=20
> Cool. Please put this in the commit log. :)

Noted for a repost.

>>
>>>
>>>> +                       reg =3D <0x01c0f000 0x1000>;
>>>> +                       clocks =3D <&ccu 31>, <&ccu 75>;
>>>
>>> The clock / reset index macros are in the tree now.
>>> Please switch to them.
>>
>> The include file is in the tree, but it isn't used in the current HEAD
>> (as in #included and the actual macros being used in the .dtsi).
>> So I was wondering if there is a patch pending for that?
>=20
> Not yet I think. Perhaps Maxime will do one once he gets back from vacati=
on?

Seems like everybody hopes for it and nobody bothers with this rather
trivial patch ;-)
Frankly I am not overly keen on having all those defines in the DTs,
which rely on a bunch of include files scattered over the Linux include
tree. This makes it unnecessarily complicated to compile this out of
tree or move it over to some other piece of software (other OS, U-Boot).
Also it gives people the impression that it's fine to change the
definition in the include file at will (because it looks like Linux
territory).
Eventually some file has to hold the actual hardware information, I
don't see why this shouldn't be the one .dtsi file. Reading that the
clock for MMC controller 0 is MMC0_CLK isn't very informative.

Cheers,
Andre.

>>>> +                       clock-names =3D "ahb", "mmc";
>>>> +                       resets =3D <&ccu 8>;
>>>> +                       reset-names =3D "ahb";
>>>> +                       interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH=
>;
>>>> +                       status =3D "disabled";
>>>> +                       #address-cells =3D <1>;
>>>> +                       #size-cells =3D <0>;
>>>> +               };
>>>> +
>>>> +               mmc1: mmc@1c10000 {
>>>> +                       compatible =3D "allwinner,sun50i-a64-mmc",
>>>> +                                    "allwinner,sun5i-a13-mmc";
>>>> +                       reg =3D <0x01c10000 0x1000>;
>>>> +                       clocks =3D <&ccu 32>, <&ccu 76>;
>>>> +                       clock-names =3D "ahb", "mmc";
>>>> +                       resets =3D <&ccu 9>;
>>>> +                       reset-names =3D "ahb";
>>>> +                       interrupts =3D <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH=
>;
>>>> +                       status =3D "disabled";
>>>> +                       #address-cells =3D <1>;
>>>> +                       #size-cells =3D <0>;
>>>> +               };
>>>> +
>>>> +               mmc2: mmc@1c11000 {
>>>> +                       compatible =3D "allwinner,sun50i-a64-emmc";
>>>> +                       reg =3D <0x01c11000 0x1000>;
>>>> +                       clocks =3D <&ccu 33>, <&ccu 77>;
>>>> +                       clock-names =3D "ahb", "mmc";
>>>> +                       resets =3D <&ccu 10>;
>>>> +                       reset-names =3D "ahb";
>>>> +                       interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH=
>;
>>>> +                       status =3D "disabled";
>>>> +                       #address-cells =3D <1>;
>>>> +                       #size-cells =3D <0>;
>>>> +               };
>>>> +
>>>>                 gic: interrupt-controller@1c81000 {
>>>>                         compatible =3D "arm,gic-400";
>>>>                         reg =3D <0x01c81000 0x1000>,
>>>> --
>>>> 2.8.2
>>>>
>>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
