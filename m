From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
Date: Tue, 1 May 2018 23:48:18 +0800
Message-ID: <CAGb2v64B6_Rb2VPoZ6563doeVGEZ2WUWE+pMg7-u9SKMq1xCfQ@mail.gmail.com>
References: <20180426140728.43155-1-icenowy@aosc.io> <20180426140728.43155-4-icenowy@aosc.io>
 <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com> <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
 <45956397-a593-e51e-8637-655178c5901c@arm.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBWMYULLQKGQE3X6TGHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <45956397-a593-e51e-8637-655178c5901c-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 30, 2018 at 5:47 PM, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> wr=
ote:
> Hi Icenowy,
>
> On 27/04/18 08:12, Icenowy Zheng wrote:
>>
>>
>> =E4=BA=8E 2018=E5=B9=B44=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=
=8812:46:26, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> =E5=86=99=E5=88=B0:
>>> Hi,
>>>
>>> On 26/04/18 15:07, Icenowy Zheng wrote:
>>>> The Pine H64 board have a MicroSD slot connected to MMC0 controller
>>> of
>>>> the H6 SoC and a eMMC slot connected to MMC2.
>>>>
>>>> Enable them in the device tree.
>>>>
>>>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
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
>>>>     chosen {
>>>>             stdout-path =3D "serial0:115200n8";
>>>>     };
>>>> +
>>>> +   reg_vcc3v3: vcc3v3 {
>>>> +           compatible =3D "regulator-fixed";
>>>> +           regulator-name =3D "vcc3v3";
>>>> +           regulator-min-microvolt =3D <3300000>;
>>>> +           regulator-max-microvolt =3D <3300000>;
>>>> +   };
>>>> +
>>>> +   reg_vcc1v8: vcc1v8 {
>>>> +           compatible =3D "regulator-fixed";
>>>> +           regulator-name =3D "vcc1v8";
>>>> +           regulator-min-microvolt =3D <1800000>;
>>>> +           regulator-max-microvolt =3D <1800000>;
>>>> +   };
>>>> +};
>>>> +
>>>> +&mmc0 {
>>>> +   pinctrl-names =3D "default";
>>>> +   pinctrl-0 =3D <&mmc0_pins>;
>>>> +   vmmc-supply =3D <&reg_vcc3v3>;
>>>
>>> So this is actually CLDO1 on the AXP, correct?
>>
>> I remember it's coupled between two LDOs, to provide enough power.
>>
>>>
>>>
>>>> +   cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
>>>> +   status =3D "okay";
>>>> +};
>>>> +
>>>> +&mmc2 {
>>>> +   pinctrl-names =3D "default";
>>>> +   pinctrl-0 =3D <&mmc2_pins>;
>>>> +   vmmc-supply =3D <&reg_vcc3v3>;
>>>> +   vqmmc-supply =3D <&reg_vcc1v8>;
>>>
>>> And this is BLDO2?
>>
>> Yes.
>>
>>>
>>> I am just asking because I want to avoid running into the same problem
>>> as with the A64 before: that future DTs become incompatible with older
>>> kernels, because we change the power supply to point to the AXP
>>> regulators, which this kernel does not support yet.
>>
>> The answer is just not to keep this compatibility, as it's not
>> supported option to update DT without updating kernel.
>
> Well, I recognise that statement.. ;-) and I understand that it's far
> easier to handle it this way. But:
> - Which .dtb are we going to write into the SPI flash? An older one,
> which covers all kernels, but lacks features? Or a newer one, which
> limits the bootable kernels to recent versions?
> - Which DT are we going to give to EFI applications?
> - Which DT are the BSDs suspected to take? They don't ship their own DTs
> (which is good!).
>
> So I understand that "shipping the DT with the kernel" is the old
> (embedded!) way of doing things, but I really believe we should stop
> relying on this and try to come up with backwards compatible DTs, which
> live in the firmware and get updated there. Because this is what the
> distros seem to expect from ARM64 boards these days.
>
>> P.S. I think the DT will update twice on the kernel side, the
>> first time keep reg_vcc3v3 (as it's coupled) but use real
>> regulator for reg_vcc1v8, the second time use the real
>> coupled regulator for reg_vcc3v3.
>>
>>>
>>> It looks like there are more users of those power rails, so we could
>>> keep those supplies connected to these fixed regulators here, even with
>>> AXP-805 support in the kernel.
>>
>> It's not a good choice.
>>
>>>
>>> Or we keep this back until we get proper AXP support in the kernel? I
>>> guess it's quite close to the existing PMICs, so it might be more a
>>> copy&paste exercise to support the AXP-805?
>>
>> It's not a reason to keep it back.
>
> So I compared the manuals of the AXP806 and the AXP805, the register
> interface looks identical to me. I only have a (somewhat) Chinese
> version of the AXP806 manual, so couldn't really find the difference
> between the two. Do you know more about it? Is it just maybe the
> packaging and the electrical properties (like max current supported)?

>From what I could tell, they are the same. I'm not sure about max current,
but that's something not described in the device tree right now. FYI,
the AXP221s and AXP221 differ slightly in that one has increased current
capability for one or two of the DC-DCs. We treat them as if they were
the same right now.

> If the I2C register interface is really the same, we could just add the
> DT nodes for the regulator and be done.

It is. However, we currently lack a "standalone operating mode" property.
This is different from "master mode".

ChenYu

> Cheers,
> Andre.
>
>>
>>>
>>> But apart from this this looks correct to me.
>>>
>>> Cheers,
>>> Andre.
>>>
>>>> +   non-removable;
>>>> +   cap-mmc-hw-reset;
>>>> +   status =3D "okay";
>>>>  };
>>>>
>>>>  &uart0 {
>>>>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
