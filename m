From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time.
 Change Kconfig
Date: Mon, 22 Nov 2010 19:22:57 -0800
Message-ID: <F2601D24-BA24-4E4C-8C2D-C6B5C55416EB@marvell.com>
References: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com>
 <AANLkTimMFsxHt3AEfHDgZsia3c+rYVx2P5Diw=Robrbe@mail.gmail.com>
 <20101123025548.GA29770@void.printf.net>
 <AANLkTi=aPtSsDk5UYgXz5REw0K7m_xzNDSHgs31Rbcx+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54111 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750790Ab0KWDXB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Nov 2010 22:23:01 -0500
In-Reply-To: <AANLkTi=aPtSsDk5UYgXz5REw0K7m_xzNDSHgs31Rbcx+@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "Mark F. Brown" <mark.brown314@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>


I implemented the first sdhci-pxa.c controller for the pxa168 over a year ago.  Also fixed issues on Tavor.

This approach is not sufficient to make Aspen nor Tavor work.  

There are a number of silicon issues that need to be addressed.  




On Nov 22, 2010, at 7:16 PM, zhangfei gao wrote:

> On Mon, Nov 22, 2010 at 9:55 PM, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>> 
>> On Mon, Nov 22, 2010 at 09:46:14PM -0500, Mark F. Brown wrote:
>>>>  config MMC_SDHCI_PXA
>>>>        tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
>>>> -       depends on ARCH_PXA || ARCH_MMP
>>>> +       depends on (ARCH_PXA || ARCH_MMP) && (MACH_MARVELL_JASPER || MACH_FLINT)
>>>>        select MMC_SDHCI
>>>>        select MMC_SDHCI_IO_ACCESSORS
>>>>        help
>>>> -         This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
>>>> -         If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
>>>> +         This selects the Marvell(R) MMP2 SD Host Controller.
>>>> +         If you have a MMP2 platform with SD Host Controller
>>>>          and a card slot, say Y or M here.
>>> 
>>> Currently the driver sdhci-pxa only supports the 88AP610 (MMP2)
>>> platform only. Until the sdhci-pxa code fixed or forked to support
>>> pxa168 and pxa910 we need to Philip's patch. Any feedback on this
>>> would be good thanks.
>> 
> The patch "sdhci-pxa: init_sdh for different platform" already
> submitted, to be merged.
> The platfrom specific register accessing are move to arch
> for mmp2, arch/arm/mach-mmp/include/mach/mmp2_sdh.h
> for pxa168, another file may be needed
> arch/arm/mach-mmp/include/mach/pxa168_sdh.h
> 
>> I don't mind changing the Kconfig text, but tying an SoC-level host
>> controller to dependencies on specific machines seems pretty wrong.
>> We should ask Haojian and Eric what they think.  I think Philip
>> suggested using CPU_MMP2 at one point -- how about that?
>> 
>> --
>> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>> One Laptop Per Child
>> 

