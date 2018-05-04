From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
Date: Fri, 4 May 2018 10:44:02 +0800
Message-ID: <CAGb2v651pi+Qh1eCuq9Ea6XfbWyOwDt=-qeu03StVd9Es0feKw@mail.gmail.com>
References: <20180426140728.43155-1-icenowy@aosc.io> <20180426140728.43155-4-icenowy@aosc.io>
 <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com> <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
 <45956397-a593-e51e-8637-655178c5901c@arm.com> <CDCEAF85-ACD3-4884-8727-3AB1BFF670FE@aosc.io>
 <c70beee6-3524-a322-9668-45cb27fc365c@arm.com> <CAGb2v6783ERJHPd5ov3Ebf+V5LNm+bL=ypAgetPLigSyW6_niQ@mail.gmail.com>
 <add8a505-9daa-43d6-eada-b5925d58f1a1@arm.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBCMSV7LQKGQESXO5HMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <add8a505-9daa-43d6-eada-b5925d58f1a1-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, May 2, 2018 at 7:01 PM, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> wro=
te:
> Hi,
>
> On 01/05/18 16:52, Chen-Yu Tsai wrote:
>> On Mon, Apr 30, 2018 at 6:44 PM, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>=
 wrote:
>>> Hi,
>>>
>>> On 30/04/18 10:51, Icenowy Zheng wrote:
>>>>
>>>>
>>>> =E4=BA=8E 2018=E5=B9=B44=E6=9C=8830=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=885:47:35, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> =E5=86=99=E5=88=B0:
>>>>> Hi Icenowy,
>>>>>
>>>>> On 27/04/18 08:12, Icenowy Zheng wrote:
>>>>>>
>>>>>>
>>>>>> =E4=BA=8E 2018=E5=B9=B44=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=
=8D=8812:46:26, Andre Przywara
>>>>> <andre.przywara-5wv7dgnIgG8@public.gmane.org> =E5=86=99=E5=88=B0:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 26/04/18 15:07, Icenowy Zheng wrote:
>>>>>>>> The Pine H64 board have a MicroSD slot connected to MMC0 controlle=
r
>>>>>>> of
>>>>>>>> the H6 SoC and a eMMC slot connected to MMC2.
>>>>>>>>
>>>>>>>> Enable them in the device tree.
>>>>>>>>
>>>>>>>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>>>>>>>> ---
>>>>>>>>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 32
>>>>>>> ++++++++++++++++++++++
>>>>>>>>  1 file changed, 32 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>>>>> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>>>>>> index d36de5eb81f3..78b1cd54687c 100644
>>>>>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
>>>>>>>> @@ -20,6 +20,38 @@
>>>>>>>>   chosen {
>>>>>>>>           stdout-path =3D "serial0:115200n8";
>>>>>>>>   };
>>>>>>>> +
>>>>>>>> + reg_vcc3v3: vcc3v3 {
>>>>>>>> +         compatible =3D "regulator-fixed";
>>>>>>>> +         regulator-name =3D "vcc3v3";
>>>>>>>> +         regulator-min-microvolt =3D <3300000>;
>>>>>>>> +         regulator-max-microvolt =3D <3300000>;
>>>>>>>> + };
>>>>>>>> +
>>>>>>>> + reg_vcc1v8: vcc1v8 {
>>>>>>>> +         compatible =3D "regulator-fixed";
>>>>>>>> +         regulator-name =3D "vcc1v8";
>>>>>>>> +         regulator-min-microvolt =3D <1800000>;
>>>>>>>> +         regulator-max-microvolt =3D <1800000>;
>>>>>>>> + };
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +&mmc0 {
>>>>>>>> + pinctrl-names =3D "default";
>>>>>>>> + pinctrl-0 =3D <&mmc0_pins>;
>>>>>>>> + vmmc-supply =3D <&reg_vcc3v3>;
>>>>>>>
>>>>>>> So this is actually CLDO1 on the AXP, correct?
>>>>>>
>>>>>> I remember it's coupled between two LDOs, to provide enough power.
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> + cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
>>>>>>>> + status =3D "okay";
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +&mmc2 {
>>>>>>>> + pinctrl-names =3D "default";
>>>>>>>> + pinctrl-0 =3D <&mmc2_pins>;
>>>>>>>> + vmmc-supply =3D <&reg_vcc3v3>;
>>>>>>>> + vqmmc-supply =3D <&reg_vcc1v8>;
>>>>>>>
>>>>>>> And this is BLDO2?
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>>
>>>>>>> I am just asking because I want to avoid running into the same
>>>>> problem
>>>>>>> as with the A64 before: that future DTs become incompatible with
>>>>> older
>>>>>>> kernels, because we change the power supply to point to the AXP
>>>>>>> regulators, which this kernel does not support yet.
>>>>>>
>>>>>> The answer is just not to keep this compatibility, as it's not
>>>>>> supported option to update DT without updating kernel.
>>>>>
>>>>> Well, I recognise that statement.. ;-) and I understand that it's far
>>>>> easier to handle it this way. But:
>>>>> - Which .dtb are we going to write into the SPI flash? An older one,
>>>>> which covers all kernels, but lacks features? Or a newer one, which
>>>>> limits the bootable kernels to recent versions?
>>>>> - Which DT are we going to give to EFI applications?
>>>>> - Which DT are the BSDs suspected to take? They don't ship their own
>>>>> DTs
>>>>> (which is good!).
>>>>>
>>>>> So I understand that "shipping the DT with the kernel" is the old
>>>>> (embedded!) way of doing things, but I really believe we should stop
>>>>> relying on this and try to come up with backwards compatible DTs, whi=
ch
>>>>> live in the firmware and get updated there. Because this is what the
>>>>> distros seem to expect from ARM64 boards these days.
>>>>
>>>> I think in this way we should change the way to submit
>>>> patches -- let DT binding patch be merged when it's ready,
>>>> and do not wait for driver.
>>>
>>> Yes, I agree. Ideally we would look at the hardware description, create
>>> a binding just based on that and submit it.
>>>
>>> Then the actual DTs and the drivers (for Linux, U-Boot, *BSD,
>>> you-name-it) could be done independently from each other.
>>>
>>> I think we should really aim for that. The only question is whether thi=
s
>>> is really practical, since the documentation is sometimes lacking and w=
e
>>> may discover missing properties during driver development.
>>> So when we meanwhile do hand-in-hand development, we should make sure w=
e
>>> don't break anything in the future.
>>
>> We could do that, but for critical regulators it's a bit tricky. Like th=
e
>> issue with vmmc and vqmmc, where the driver for the regulator is missing=
,
>> leading to an unusable system.
>
> Yes, that was my original point. We can already anticipate that we will
> break forward compatibility, so we can try to do something about that
> now to avoid that, either by staying with fixed regulators, or by adding
> the PMIC early.
>
>>>>>> P.S. I think the DT will update twice on the kernel side, the
>>>>>> first time keep reg_vcc3v3 (as it's coupled) but use real
>>>>>> regulator for reg_vcc1v8, the second time use the real
>>>>>> coupled regulator for reg_vcc3v3.
>>>>>>
>>>>>>>
>>>>>>> It looks like there are more users of those power rails, so we coul=
d
>>>>>>> keep those supplies connected to these fixed regulators here, even
>>>>> with
>>>>>>> AXP-805 support in the kernel.
>>>>>>
>>>>>> It's not a good choice.
>>>>>>
>>>>>>>
>>>>>>> Or we keep this back until we get proper AXP support in the kernel?
>>>>> I
>>>>>>> guess it's quite close to the existing PMICs, so it might be more a
>>>>>>> copy&paste exercise to support the AXP-805?
>>>>>>
>>>>>> It's not a reason to keep it back.
>>>>>
>>>>> So I compared the manuals of the AXP806 and the AXP805, the register
>>>>> interface looks identical to me. I only have a (somewhat) Chinese
>>>>> version of the AXP806 manual, so couldn't really find the difference
>>>>> between the two. Do you know more about it? Is it just maybe the
>>>>> packaging and the electrical properties (like max current supported)?
>>>>>
>>>>> If the I2C register interface is really the same, we could just add t=
he
>>>>> DT nodes for the regulator and be done.
>>>>
>>>> They're the same. My following patchset adds AXP805
>>>> compatible just to use AXP806 code. I have asked Wink
>>>> and the answer is that they have only preset difference.
>>>
>>> Ah, thanks for that, that's good info!
>>> So in this case we don't even need to add the compatible name to the
>>> driver, just add it to the binding doc and create (or copy) the DT
>>> snippets. See last week's discussion ;-)
>>
>> We need to add the compatible to the I2C side of the AXP driver.
>
> Why? If it's really 100% compatible, we just add it to the binding doc
> and use compatible =3D "x-powers,axp805", "x-powers,axp806"; in the DT.
> That would immediately enable other OSes, for instance.

I meant the implementation side, not the DT. The AXP I2C driver only
binds to the earlier (up to AXP221) PMICs. So just having the device
tree correctly set up does not guarantee a working system for the
current release, or the one in -rc.

>> Also the property for "standalone mode".
>
> Are you referring to what the manual refers to as "self-work" mode?
> In this case I don't see why we need a property: this mode is set up on
> the board side by leaving the MODESET pin floating. And it can be
> queried by checking bits[7:6] of REG 00, so doesn't need a DT property.
> If we care about this mode (do we?), we can check for this in the driver.
>
> (Curious if you meant something else ...)

Yes this is what I was referring to. If you look at the last two registers
you'll see that self-work mode, along with master mode, require the address
extension register be programmed before access to any other register can
happen.

We already have the "x-powers,master-mode" property. The driver will progra=
m
the registers correctly when it sees this property. I'm arguing that we
should have another "x-powers,self-work-mode", because these two modes are
not the same: The enable pin works as a power key under self-work mode, whi=
le
it acts as a level triggered enable pi, as the name describes. There are
some other minor differences described in the datasheet. The device tree,
being a hardware description, should not conflate the two and leave it up
to the driver to figure things out.

ChenYu

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
