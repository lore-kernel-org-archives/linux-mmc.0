From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] arm64: allwinner: h6: add device tree
 nodes for MMC controllers
Date: Fri, 27 Apr 2018 22:25:49 +0100
Message-ID: <8259b2d9-be02-68fb-90bb-bd0ebdee0b05@arm.com>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-3-icenowy@aosc.io>
 <9571735d-929f-a2ef-ed97-dc9193420b73@arm.com>
 <77DF7884-8DA8-4ED5-BB51-941CFDE4A123@aosc.io>
 <0ae1b6ce-c1cf-61e8-e09b-abec47b089b2@arm.com>
 <6EBD7D16-E985-4345-B2C2-D0CE7B32F8C5@aosc.io>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBYVKR3LQKGQEY7FEFOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <6EBD7D16-E985-4345-B2C2-D0CE7B32F8C5-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 27/04/18 10:23, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B44=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
5:18:23, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> =E5=86=99=E5=88=B0:
>> Hi,
>>
>> On 27/04/18 09:36, Icenowy Zheng wrote:
>>>
>>>
>>> =E4=BA=8E 2018=E5=B9=B44=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=
=8812:45:38, Andre Przywara
>> <andre.przywara-5wv7dgnIgG8@public.gmane.org> =E5=86=99=E5=88=B0:
>>>> Hi,
>>>>
>>>> On 26/04/18 15:07, Icenowy Zheng wrote:
>>>>> The Allwinner H6 SoC have 3 MMC controllers.
>>>>>
>>>>> Add device tree nodes for them.
>>>>>
>>>>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>>>>> ---
>>>>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 56
>>>> ++++++++++++++++++++++++++++
>>>>>  1 file changed, 56 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>>> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>>>> index 4debc3962830..3cbfc035c979 100644
>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>>>>> @@ -124,12 +124,68 @@
>>>>>  			interrupt-controller;
>>>>>  			#interrupt-cells =3D <3>;
>>>>> =20
>>>>> +			mmc0_pins: mmc0-pins {
>>>>> +				pins =3D "PF0", "PF1", "PF2", "PF3",
>>>>> +				       "PF4", "PF5";
>>>>> +				function =3D "mmc0";
>>>>> +				drive-strength =3D <30>;
>>>>> +				bias-pull-up;
>>>>> +			};
>>>>> +
>>>>> +			mmc2_pins: mmc2-pins {
>>>>> +				pins =3D "PC1", "PC4", "PC5", "PC6",
>>>>> +				       "PC7", "PC8", "PC9", "PC10",
>>>>> +				       "PC11", "PC12", "PC13", "PC14";
>>>>> +				function =3D "mmc2";
>>>>> +				drive-strength =3D <30>;
>>>>> +				bias-pull-up;
>>>>> +			};
>>>>> +
>>>>>  			uart0_ph_pins: uart0-ph {
>>>>>  				pins =3D "PH0", "PH1";
>>>>>  				function =3D "uart0";
>>>>>  			};
>>>>>  		};
>>>>> =20
>>>>> +		mmc0: mmc@4020000 {
>>>>> +			compatible =3D "allwinner,sun50i-h6-mmc";
>>>>
>>>> This should be:
>>>> 			compatible =3D "allwinner,sun50i-h6-mmc",
>>>> 				     "allwinner,sun50i-a64-mmc";
>>>
>>> I'm intended to not add A64 compatible, as
>>> H6 is a quite new design
>>> (new process) and there might be different behavior, even on mmc0/1.
>>
>> But as your patch proves, it is fully backwards compatible: An A64
>> driver works with this device.
>=20
> No, my patch only proves "the current A64 driver works
> with this device", not "Any A64 driver works with device", as
> the current driver doesn't fully use the capability provided
> by A64 MMC cobtrollers.

Good point, but I still believe every A64 driver would be capable of
driving an H6 MMC controller, ....

>> And this is what this compatible string list says: If your system does
>> not have a specific H6 driver, you can use an A64 driver.
>> You might not get all the (potentially) new features, but it covers
>> everything the A64 has.
>>
>> And a new silicon process doesn't matter here, since the software
>> interface is unchanged. *If* we find bugs, we can add quirks matching
>=20
> I think there's timing parameters for higher speed bins which
> are different among chips. As we have currently no support
> for speed bins higher than DDR50, they're not added yet.

True, but what are those differences? I compared the A64 and H6 manuals
side by side, the differences I found are:
SMHC_FIFOTH[+0x40]:
	BSIZE_OF_TRANS[30:28]:
	- H6 supports 16 transfers for SMHC0 also.
	other parameters:
	- H6 recommends better values for SMHC0 also
SMHC_CSDC[+0x54]:
	- H6 doesn't mention restriction to SMHC2
	(though this might be a mistake)
SMHC_NTSR_REG[+0x5C]:
	- H6 defines fields for bits[24:8]
SMHC_EMCE[+0x64] and SMHC_EMCE_DBG[+0x68]:
	- H6 adds, for EMCE support
EMMC_DDR_SBIT_DET_REG[0x10c]:
	- A64 doesn't mention restriction to SMHC2,
	  but I believe this is a mistake
SMHC_EMCE_BMn[0x150 + 0x4 * 0..31]
	- H6 adds, for EMCE support

All those pieces are only *additions* to the H6 over the A64, so don't
affect backwards compatibility.

>> on
>> the H6 compatible string - that's why we put it here already, despite
>> having a matching string in the kernel at the moment.
>=20
> Device tree is not driver data but hardware description, so
> it should follow "how the device is formed" rather than
> "how the device works".

True, but as shown above, the compatibility is really at the device level.
Unless you have any other information ...

Cheers,
Andre.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
