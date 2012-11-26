From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc): undefined
 reference to `__aeabi_uldivmod'
Date: Mon, 26 Nov 2012 04:11:58 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E11756B4@039-SN2MPN1-022.039d.mgd.msft.net>
References: <50b2a62c.slEE/d1mNq4kUCUf%fengguang.wu@intel.com>
 <87sj7x9r89.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:15681
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753206Ab2KZEMF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 23:12:05 -0500
In-Reply-To: <87sj7x9r89.fsf@octavius.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, kbuild test robot <fengguang.wu@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Huang Changming-R66093 <r66093@freescale.com>, Wang Dongsheng-B40534 <B40534@freescale.com>

Hi,Chris

I had update my branch linux-mmc and test, there is no such err.
As u64 need the macro div_u64 in "include/linux/math64.h"

#ifndef div_u64
static inline u64 div_u64(u64 dividend, u32 divisor)
{
        u32 remainder;
        return div_u64_rem(dividend, divisor, &remainder);
}
#endif

As different vendor may redefine div_u64_rem or remove the func div_u64, it's possible.
In driver/mmc/ all func use data->timeout_ns without define div_u64 or not use div_u64 to divide will encounter this err. So I'm not sure which reason bring about this err.

Regards
Haijun.


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Chris Ball
> Sent: Monday, November 26, 2012 7:51 AM
> To: kbuild test robot
> Cc: Zhang Haijun-B42677; linux-mmc@vger.kernel.org; Huang Changming-
> R66093
> Subject: Re: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc): undefined
> reference to `__aeabi_uldivmod'
> 
> Hi,
> 
> On Sun, Nov 25 2012, kbuild test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-
> next
> > head:   b1dc46e6cd5f314f52a9864cc7ba1b7624b54bd7
> > commit: d29254e21ddddee37b3c8525817398d96d6403f3 [45/63] mmc: core:
> > Use u64 to calculate the timeout value to avoid overflow
> > config: make ARCH=arm omap2plus_defconfig
> >
> > All error/warnings:
> >
> > drivers/built-in.o: In function `mmc_omap_start_request':
> > of_iommu.c:(.text+0x114dbc): undefined reference to `__aeabi_uldivmod'
> 
> I've removed Haijun's three patches from mmc-next while they're reworked
> to fix this.  Thanks!
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html


