From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc): undefined
 reference to `__aeabi_uldivmod'
Date: Mon, 26 Nov 2012 05:54:33 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C235D56@039-SN1MPN1-003.039d.mgd.msft.net>
References: <50b2a62c.slEE/d1mNq4kUCUf%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.180.186] ([216.32.180.186]:9153 "EHLO
	co1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752134Ab2KZF4D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Nov 2012 00:56:03 -0500
In-Reply-To: <50b2a62c.slEE/d1mNq4kUCUf%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>, Zhang Haijun-B42677 <B42677@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hi, Robot
I don't find the `__aeabi_uldivmod' in branch 'mmc-next' of linux-mmc tree.
Could you point out which file use it?

This patch just use the 'div_u64' to calculate the timeout in order to avoid overflow.

Best Regards
Jerry Huang


> -----Original Message-----
> From: kbuild test robot [mailto:fengguang.wu@intel.com]
> Sent: Monday, November 26, 2012 7:14 AM
> To: Zhang Haijun-B42677
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Chris Ball
> Subject: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc): undefined
> reference to `__aeabi_uldivmod'
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-
> next
> head:   b1dc46e6cd5f314f52a9864cc7ba1b7624b54bd7
> commit: d29254e21ddddee37b3c8525817398d96d6403f3 [45/63] mmc: core: Use
> u64 to calculate the timeout value to avoid overflow
> config: make ARCH=arm omap2plus_defconfig
> 
> All error/warnings:
> 
> drivers/built-in.o: In function `mmc_omap_start_request':
> of_iommu.c:(.text+0x114dbc): undefined reference to `__aeabi_uldivmod'
> 
> ---
> 0-DAY kernel build testing backend         Open Source Technology Center
> Fengguang Wu, Yuanhan Liu                              Intel Corporation


