From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time. Change Kconfig
Date: Mon, 22 Nov 2010 22:16:40 -0500
Message-ID: <AANLkTi=aPtSsDk5UYgXz5REw0K7m_xzNDSHgs31Rbcx+@mail.gmail.com>
References: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com>
	<AANLkTimMFsxHt3AEfHDgZsia3c+rYVx2P5Diw=Robrbe@mail.gmail.com>
	<20101123025548.GA29770@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab0KWDQm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 22:16:42 -0500
Received: by fxm13 with SMTP id 13so3407378fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2010 19:16:41 -0800 (PST)
In-Reply-To: <20101123025548.GA29770@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Mark F. Brown" <mark.brown314@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, markb@marvell.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

On Mon, Nov 22, 2010 at 9:55 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Nov 22, 2010 at 09:46:14PM -0500, Mark F. Brown wrote:
>> > =A0config MMC_SDHCI_PXA
>> > =A0 =A0 =A0 =A0tristate "Marvell PXA168/PXA910/MMP2 SD Host Contro=
ller support"
>> > - =A0 =A0 =A0 depends on ARCH_PXA || ARCH_MMP
>> > + =A0 =A0 =A0 depends on (ARCH_PXA || ARCH_MMP) && (MACH_MARVELL_J=
ASPER || MACH_FLINT)
>> > =A0 =A0 =A0 =A0select MMC_SDHCI
>> > =A0 =A0 =A0 =A0select MMC_SDHCI_IO_ACCESSORS
>> > =A0 =A0 =A0 =A0help
>> > - =A0 =A0 =A0 =A0 This selects the Marvell(R) PXA168/PXA910/MMP2 S=
D Host Controller.
>> > - =A0 =A0 =A0 =A0 If you have a PXA168/PXA910/MMP2 platform with S=
D Host Controller
>> > + =A0 =A0 =A0 =A0 This selects the Marvell(R) MMP2 SD Host Control=
ler.
>> > + =A0 =A0 =A0 =A0 If you have a MMP2 platform with SD Host Control=
ler
>> > =A0 =A0 =A0 =A0 =A0and a card slot, say Y or M here.
>>
>> Currently the driver sdhci-pxa only supports the 88AP610 (MMP2)
>> platform only. Until the sdhci-pxa code fixed or forked to support
>> pxa168 and pxa910 we need to Philip's patch. Any feedback on this
>> would be good thanks.
>
The patch "sdhci-pxa: init_sdh for different platform" already
submitted, to be merged.
The platfrom specific register accessing are move to arch
for mmp2, arch/arm/mach-mmp/include/mach/mmp2_sdh.h
for pxa168, another file may be needed
arch/arm/mach-mmp/include/mach/pxa168_sdh.h

> I don't mind changing the Kconfig text, but tying an SoC-level host
> controller to dependencies on specific machines seems pretty wrong.
> We should ask Haojian and Eric what they think. =A0I think Philip
> suggested using CPU_MMP2 at one point -- how about that?
>
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
