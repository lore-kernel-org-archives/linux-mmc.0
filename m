From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 15/23] Alternative mmc structure to support pxa168,
 pxa910, mmp2 family SD
Date: Fri, 31 Dec 2010 14:46:26 +0800
Message-ID: <AANLkTik0YCSw19-Kyj7PFqgS+mJr6btcAzbrmAtiUL0=@mail.gmail.com>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
	<201012221510.36878.arnd@arndb.de>
	<037EAE31-B07C-4134-B810-A5A1E83517B8@marvell.com>
	<AANLkTikmZ=c8LnOwxLqx9w6cXV07eVL7AZ0qQmXKojs9@mail.gmail.com>
	<7E0D4C72-717F-495B-98FE-35F40C7CDCAE@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57283 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab0LaGq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Dec 2010 01:46:29 -0500
Received: by wwa36 with SMTP id 36so12196893wwa.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Dec 2010 22:46:28 -0800 (PST)
In-Reply-To: <7E0D4C72-717F-495B-98FE-35F40C7CDCAE@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <markb@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Dec 31, 2010 at 2:03 PM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On Dec 30, 2010, at 9:46 PM, Haojian Zhuang wrote:
>
>> On Thu, Dec 23, 2010 at 6:58 AM, Philip Rakity <prakity@marvell.com>=
 wrote:
>>>
>>> On Dec 22, 2010, at 6:10 AM, Arnd Bergmann wrote:
>>>
>>>> On Wednesday 22 December 2010 08:09:58 Philip Rakity wrote:
>>>>> The PXA168, PXA910, and MMP2 are not the same SOC. =A0The family
>>>>> of embedded processors have slightly different internal blocks
>>>>> for SD, I2C, etc. =A0Sometimes it is important to know which SOC
>>>>> is being used due to differences in the silicon. =A0Sometimes it
>>>>> is important to know evaluation boards should be selected based
>>>>> on the SOC on the board.
>>>>
>>>> This looks like you're moving in the wrong direction.
>>>>
>>>> If the chips are just slightly different, you'd certainly
>>>> want to make sure that you can detect the difference at runtime,
>>>> and be able to use the same kernel on all of the variants.
>>>
>>> MMP2 used PJ4 core --- PXA168/PXA910 use PJ1 so rather different ar=
chitecture.
>>>
>>> PXA168/PXA910 have slightly different internal peripherals with dif=
ferent quirks.
>>> Certainly possible to tell this apart at runtime but not all periph=
erals are the same
>>> and startup files ARE different.
>>>
>>>
>> MMP2 and PJ4 are different SoC silicons. But they're using similar S=
D
>> IP, so we can share same driver to them. Different quirks can be
>> handled by different flags in run time.
>>
>
> The SD IP is not the same. =A0One uses SD controller 3.0 and the othe=
r is 2.0.
>
> They are the same in the sense that they public registers adhere to t=
he appropriate SD spec 2.0/3.0 but
> these accesses are handled by sdhci.c. =A0(SD 3.0 extends the SD 2.0 =
spec by adding new registers and adding some bit definitions
> in a compatible manner inside the public space).
>
Yes, you confirmed that they're same in the sense. It's enough. User
needn't care whether it's SD2.0 or SD3.0. It's the business of silicon
engineer.

> The private registers that need to be programmed are not extensions b=
ut are at different locations and bit fields do not have exactly the sa=
me meaning.
>
> The code to handle the differences is rather small and is not NOT pla=
ced in arch/arm/ directory but rather in the
> drivers/mmc/host directory and follows the conventions to handle this=
=2E
>
In your patch, you divide them into silicon depedant files. I think
that putting them into arch/arm is better.

>
>> There's no reason to copy driver for each silicon
>
>>
>>>>
>>>> Instead, you promote each of the SOCs to a top-level family
>>>> in this patch, which makes it impossible to build a kernel
>>>> for more than one of them at a time.
>>>
>>> That was the intent to handle the case of development board selecti=
on.
>>> it is meaningless to select MMP2 development board with say PXA168 =
SoC.
>>>
>>> Open to other way to handle this problem. =A0Suggestions welcome.
>>>
>> Again, you did wrong. You couldn't make patch for top-level family. =
It
>> will introduce a lot of error to maintainers.
>
> The patch selects ARCH-MMP (as now) but adds the ability
> to also know which specific SoC was chosen. =A0(This is sort of done =
by choosing the development board today).
>
If you want to change mmc code, push it into mmc tree. If you want to
change pxa code, push it into pxa tree. If they're dependant, please
make sure the sequence is right.
>
>>
>> Your patches will make them mess.
>
> suggest a solution.
>
> The current mechanism of having the development board select the CPU =
does not seem right.
> One can select a development board for MMP2 and PXA168 and yet the ar=
ch files to support each CPU
> are different and not compatible. =A0(for example cache handling).
>
Only one SoC can be installed on one board. If silicons are
pin-compatible to one board, we can register different boards. For
example, we can divide saarb as saarb_pv and saarb_mg.

If MMP2 and PXA168 are both installed on one board, it means that you
must run two kernel images on two APs. Actually, I don't think anyone
will design system like this way. If so, why not adopt the above
policy? You can divide the board into two sub-board on naming policy.
>>
>> Thanks
>> Haojian
>>
>>>>
>>>> =A0 =A0 =A0 Arnd
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>
>
