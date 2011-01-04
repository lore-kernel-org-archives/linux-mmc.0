From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 15/23] Alternative mmc structure to support pxa168,
 pxa910, mmp2 family SD
Date: Tue, 4 Jan 2011 01:10:22 -0500
Message-ID: <AANLkTim6Uda5+T-Fr6WuGJKhoV6EboSHjMKGCAzb3vTH@mail.gmail.com>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
	<201012221510.36878.arnd@arndb.de>
	<037EAE31-B07C-4134-B810-A5A1E83517B8@marvell.com>
	<AANLkTikmZ=c8LnOwxLqx9w6cXV07eVL7AZ0qQmXKojs9@mail.gmail.com>
	<7E0D4C72-717F-495B-98FE-35F40C7CDCAE@marvell.com>
	<AANLkTik0YCSw19-Kyj7PFqgS+mJr6btcAzbrmAtiUL0=@mail.gmail.com>
	<E5C4BC31-9A6C-4F51-ADCD-6755299DD122@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36667 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1ADGKZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 01:10:25 -0500
Received: by fxm20 with SMTP id 20so13810925fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jan 2011 22:10:23 -0800 (PST)
In-Reply-To: <E5C4BC31-9A6C-4F51-ADCD-6755299DD122@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <markb@marvell.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Philip Rakity <prakity@marvell.com>, Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Dec 31, 2010 at 5:08 PM, Mark Brown <markb@marvell.com> wrote:
> On Dec 31, 2010, at 1:46 AM, Haojian Zhuang wrote:
>
>> On Fri, Dec 31, 2010 at 2:03 PM, Philip Rakity <prakity@marvell.com>=
 wrote:
>>>
>>> On Dec 30, 2010, at 9:46 PM, Haojian Zhuang wrote:
>>>
>>>> On Thu, Dec 23, 2010 at 6:58 AM, Philip Rakity <prakity@marvell.co=
m> wrote:
>>>>>
>>>>> On Dec 22, 2010, at 6:10 AM, Arnd Bergmann wrote:
>>>>>
>>>>>> On Wednesday 22 December 2010 08:09:58 Philip Rakity wrote:
>>>>>>> The PXA168, PXA910, and MMP2 are not the same SOC. =A0The famil=
y
>>>>>>> of embedded processors have slightly different internal blocks
>>>>>>> for SD, I2C, etc. =A0Sometimes it is important to know which SO=
C
>>>>>>> is being used due to differences in the silicon. =A0Sometimes i=
t
>>>>>>> is important to know evaluation boards should be selected based
>>>>>>> on the SOC on the board.
>>>>>>
>>>>>> This looks like you're moving in the wrong direction.
>>>>>>
>>>>>> If the chips are just slightly different, you'd certainly
>>>>>> want to make sure that you can detect the difference at runtime,
>>>>>> and be able to use the same kernel on all of the variants.
>>>>>
>>>>> MMP2 used PJ4 core --- PXA168/PXA910 use PJ1 so rather different =
architecture.
>>>>>
>>>>> PXA168/PXA910 have slightly different internal peripherals with d=
ifferent quirks.
>>>>> Certainly possible to tell this apart at runtime but not all peri=
pherals are the same
>>>>> and startup files ARE different.
>>>>>
>>>>>
>>>> MMP2 and PJ4 are different SoC silicons. But they're using similar=
 SD
>
> I think you meant MMP2 and PJ1 there. MMP2 is a PJ4 core.
>
>>>> IP, so we can share same driver to them. Different quirks can be
>>>> handled by different flags in run time.
>
> Technically all of these SDHCI controllers are extremely similar. The=
 point of the SDHCI-* family of drivers
> are there to specify the implementation differences.
>
> sdhci-pxa codebase is currently minimal it performs two operations:
> 1. Register sdhci instance using platform data.
> 2. Define common quirks.
> 3. Provides clock control callback
>
> The PXA168/PXA910 (PJ1) versions would have specific needs:
> 1. There is a difference in clock control and power up sequencing
> 2. There is a specific I/O accessor needed to access registers
> 3. There are workarounds for SDIO that are needed.
> 4. There specific quirks needed for the PXA168/PXA910.

=46or mmp2 and pxa910, they are same ip in fact, same silicon bug, and
same workaround, and fixed together in updated version.
That's the reason they worked well in currently code base with same
quirk, same driver.
pxa168 may be different since no future stepping.

It is true, one is v2, the other is v3, but this is handled in sdhci.c
and transparent for specific driver.
The only difference is different private register, that may because
when define v2 and can not foresee v3 definition.
Still not find strong reason to add more specific driver only handle
different private register, if so more driver will be added for mmp2x,
for example, though same ip are used.

BTW, brownstone with mmc support is already added if work based on
pxa-linux-2.6.git, devel branch.

>
> Even if we were to write a separate driver for PXA168/910 and MMP2 th=
ere would be no code duplication except for
> the code to interpret the platform data.
>
> In Philip's code he took the duplication into account and further abs=
tracted it so that the platform data interpretation is done in
> sdhci-pxa.c and the differences are exposed in the sdhci-pxa168 and s=
dhci-mmp2 modules.
>
> There is already precedence for this already in sdhci-of-* implementa=
tion.
>
> I am not sure why people think combining all of these differences int=
o one massive sdhci-pxa driver would make maintenance simpler when the
> relevant commonality is already abstracted away in sdhci.c.
>
>>>>
>>>
>>> The SD IP is not the same. =A0One uses SD controller 3.0 and the ot=
her is 2.0.
>>>
>>> They are the same in the sense that they public registers adhere to=
 the appropriate SD spec 2.0/3.0 but
>>> these accesses are handled by sdhci.c. =A0(SD 3.0 extends the SD 2.=
0 spec by adding new registers and adding some bit definitions
>>> in a compatible manner inside the public space).
>>>
>> Yes, you confirmed that they're same in the sense. It's enough. User
>> needn't care whether it's SD2.0 or SD3.0. It's the business of silic=
on
>> engineer.
>>
>>> The private registers that need to be programmed are not extensions=
 but are at different locations and bit fields do not have exactly the =
same meaning.
>>>
>>> The code to handle the differences is rather small and is not NOT p=
laced in arch/arm/ directory but rather in the
>>> drivers/mmc/host directory and follows the conventions to handle th=
is.
>>>
>> In your patch, you divide them into silicon depedant files. I think
>> that putting them into arch/arm is better.
>>
>>>
>>>> There's no reason to copy driver for each silicon
>>>
>>>>
>>>>>>
>>>>>> Instead, you promote each of the SOCs to a top-level family
>>>>>> in this patch, which makes it impossible to build a kernel
>>>>>> for more than one of them at a time.
>>>>>
>>>>> That was the intent to handle the case of development board selec=
tion.
>>>>> it is meaningless to select MMP2 development board with say PXA16=
8 SoC.
>>>>>
>>>>> Open to other way to handle this problem. =A0Suggestions welcome.
>>>>>
>>>> Again, you did wrong. You couldn't make patch for top-level family=
=2E It
>>>> will introduce a lot of error to maintainers.
>>>
>>> The patch selects ARCH-MMP (as now) but adds the ability
>>> to also know which specific SoC was chosen. =A0(This is sort of don=
e by choosing the development board today).
>>>
>> If you want to change mmc code, push it into mmc tree. If you want t=
o
>> change pxa code, push it into pxa tree. If they're dependant, please
>> make sure the sequence is right.
>>>
>>>>
>>>> Your patches will make them mess.
>>>
>>> suggest a solution.
>>>
>>> The current mechanism of having the development board select the CP=
U does not seem right.
>>> One can select a development board for MMP2 and PXA168 and yet the =
arch files to support each CPU
>>> are different and not compatible. =A0(for example cache handling).
>>>
>> Only one SoC can be installed on one board. If silicons are
>> pin-compatible to one board, we can register different boards. For
>> example, we can divide saarb as saarb_pv and saarb_mg.
>>
>> If MMP2 and PXA168 are both installed on one board, it means that yo=
u
>> must run two kernel images on two APs. Actually, I don't think anyon=
e
>> will design system like this way. If so, why not adopt the above
>> policy? You can divide the board into two sub-board on naming policy=
=2E
>>>>
>>>> Thanks
>>>> Haojian
>>>>
>>>>>>
>>>>>> =A0 =A0 =A0 Arnd
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>
>>>
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
