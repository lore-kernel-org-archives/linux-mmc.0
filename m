From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time. Change Kconfig
Date: Mon, 22 Nov 2010 23:38:31 -0500
Message-ID: <AANLkTik7XO6baq7=3VimymqzKB6XG6phCxJPN=AB-X-y@mail.gmail.com>
References: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com>
	<AANLkTimMFsxHt3AEfHDgZsia3c+rYVx2P5Diw=Robrbe@mail.gmail.com>
	<20101123025548.GA29770@void.printf.net>
	<AANLkTi=aPtSsDk5UYgXz5REw0K7m_xzNDSHgs31Rbcx+@mail.gmail.com>
	<F2601D24-BA24-4E4C-8C2D-C6B5C55416EB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40510 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab0KWEie convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 23:38:34 -0500
Received: by qyk11 with SMTP id 11so1243197qyk.19
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2010 20:38:33 -0800 (PST)
In-Reply-To: <F2601D24-BA24-4E4C-8C2D-C6B5C55416EB@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

On Mon, Nov 22, 2010 at 10:22 PM, Philip Rakity <prakity@marvell.com> w=
rote:
>
> I implemented the first sdhci-pxa.c controller for the pxa168 over a =
year ago. =A0Also fixed issues on Tavor.
>
> This approach is not sufficient to make Aspen nor Tavor work.
>
> There are a number of silicon issues that need to be addressed.
>
>
>
>
> On Nov 22, 2010, at 7:16 PM, zhangfei gao wrote:
>
>> On Mon, Nov 22, 2010 at 9:55 PM, Chris Ball <cjb@laptop.org> wrote:
>>> Hi,
>>>
>>> On Mon, Nov 22, 2010 at 09:46:14PM -0500, Mark F. Brown wrote:
>>>>> =A0config MMC_SDHCI_PXA
>>>>> =A0 =A0 =A0 =A0tristate "Marvell PXA168/PXA910/MMP2 SD Host Contr=
oller support"
>>>>> - =A0 =A0 =A0 depends on ARCH_PXA || ARCH_MMP
>>>>> + =A0 =A0 =A0 depends on (ARCH_PXA || ARCH_MMP) && (MACH_MARVELL_=
JASPER || MACH_FLINT)
>>>>> =A0 =A0 =A0 =A0select MMC_SDHCI
>>>>> =A0 =A0 =A0 =A0select MMC_SDHCI_IO_ACCESSORS
>>>>> =A0 =A0 =A0 =A0help
>>>>> - =A0 =A0 =A0 =A0 This selects the Marvell(R) PXA168/PXA910/MMP2 =
SD Host Controller.
>>>>> - =A0 =A0 =A0 =A0 If you have a PXA168/PXA910/MMP2 platform with =
SD Host Controller
>>>>> + =A0 =A0 =A0 =A0 This selects the Marvell(R) MMP2 SD Host Contro=
ller.
>>>>> + =A0 =A0 =A0 =A0 If you have a MMP2 platform with SD Host Contro=
ller
>>>>> =A0 =A0 =A0 =A0 =A0and a card slot, say Y or M here.
>>>>
>>>> Currently the driver sdhci-pxa only supports the 88AP610 (MMP2)
>>>> platform only. Until the sdhci-pxa code fixed or forked to support
>>>> pxa168 and pxa910 we need to Philip's patch. Any feedback on this
>>>> would be good thanks.
>>>
>> The patch "sdhci-pxa: init_sdh for different platform" already
>> submitted, to be merged.
>> The platfrom specific register accessing are move to arch
>> for mmp2, arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>> for pxa168, another file may be needed
>> arch/arm/mach-mmp/include/mach/pxa168_sdh.h

Zhangfei, I think Philip is correct here. You need to add support for
PXA168 and PXA910 before you declare support for it in the Kconfig.
When the proper accessors and support are added for those platforms
then you can add the Kconfig entries. If MMP2 is currently the only
supported platform, then we should just mention CPU_MMP2.

>>
>>> I don't mind changing the Kconfig text, but tying an SoC-level host
>>> controller to dependencies on specific machines seems pretty wrong.
>>> We should ask Haojian and Eric what they think. =A0I think Philip
>>> suggested using CPU_MMP2 at one point -- how about that?
>>>

Chris I agree CPU_MMP2 is better here.

>>> --
>>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>>> One Laptop Per Child
>>>
>
>
