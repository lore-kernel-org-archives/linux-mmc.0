From: Chris Ball <cjb@laptop.org>
Subject: Re: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc): undefined reference to `__aeabi_uldivmod'
Date: Sun, 25 Nov 2012 18:51:02 -0500
Message-ID: <87sj7x9r89.fsf@octavius.laptop.org>
References: <50b2a62c.slEE/d1mNq4kUCUf%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36286 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696Ab2KYXvJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 18:51:09 -0500
In-Reply-To: <50b2a62c.slEE/d1mNq4kUCUf%fengguang.wu@intel.com> (kbuild test
	robot's message of "Mon, 26 Nov 2012 07:13:48 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

Hi,

On Sun, Nov 25 2012, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
> head:   b1dc46e6cd5f314f52a9864cc7ba1b7624b54bd7
> commit: d29254e21ddddee37b3c8525817398d96d6403f3 [45/63] mmc: core:
> Use u64 to calculate the timeout value to avoid overflow
> config: make ARCH=arm omap2plus_defconfig
>
> All error/warnings:
>
> drivers/built-in.o: In function `mmc_omap_start_request':
> of_iommu.c:(.text+0x114dbc): undefined reference to `__aeabi_uldivmod'

I've removed Haijun's three patches from mmc-next while they're reworked
to fix this.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
