From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/23] Alternative mmc structure to support pxa168, pxa910, mmp2 family SD
Date: Thu, 6 Jan 2011 20:29:45 +0100
Message-ID: <201101062029.45604.arnd@arndb.de>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com> <AANLkTikmZ=c8LnOwxLqx9w6cXV07eVL7AZ0qQmXKojs9@mail.gmail.com> <7E0D4C72-717F-495B-98FE-35F40C7CDCAE@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59196 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab1AGOJ5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jan 2011 09:09:57 -0500
In-Reply-To: <7E0D4C72-717F-495B-98FE-35F40C7CDCAE@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <markb@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday 31 December 2010, Philip Rakity wrote:
> The patch selects ARCH-MMP (as now) but adds the ability
> to also know which specific SoC was chosen.  (This is sort of done by choosing the development board today).

On a larger scale, we try to go in the opposite direction: make it possible to
have kernels run on as many boards as possible by decreasing the code differences
between SoCs and even SoC families.
 
> > Your patches will make them mess.
> 
> suggest a solution.  
> 
> The current mechanism of having the development board select the CPU does not seem right.
> One can select a development board for MMP2 and PXA168 and yet the arch files to support each CPU
> are different and not compatible.  (for example cache handling).  

The optimal solution would be to make sure that working support for both CPUs can be built into
a single kernel. There is a lot of infrastructure in arch/arm/mm/* that tries to do this, but
I don't know of that actually works for the combination of CPU_MOHAWK and CPU_V6. It does
work for some other combinations of CPU cores though, so it's certainly possible.
For instance, arch/arm/include/asm/cacheflush.h has abstractions to select the cache handling
at boot time.

To go even further, it might make sense to combine the PXA and MMP platforms, since they already
share some code through the plat-pxa directory.

Getting it running for MMP with mohawk and v6 cores could be a significant amount of work if
nobody has tries this in that platform, so for now, I would recommend you just keep ARCH_MMP as
a global option in arch/arm/Kconfig for now and add another 'choice' statement in
arch/arm/mach-mmp/Kconfig to select the CPU core, with the board selection depending on that.

	Arnd

