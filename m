From: Chris Ball <cjb@laptop.org>
Subject: Re: [mmc:mmc-next 17/28] sdhci-pltfm.c:(.text+0x80): multiple definition of `sdhci_runtime_pm_get'
Date: Wed, 07 Nov 2012 15:43:05 -0500
Message-ID: <87ip9h6t5y.fsf@octavius.laptop.org>
References: <509ac6c4.cYfNNpMXVvvrRu6C%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45455 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727Ab2KGUnM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Nov 2012 15:43:12 -0500
In-Reply-To: <509ac6c4.cYfNNpMXVvvrRu6C%fengguang.wu@intel.com> (kbuild test
	robot's message of "Thu, 08 Nov 2012 04:38:28 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org

Hi,

On Wed, Nov 07 2012, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
> head:   a6a567a4c25762e36228d2d0c8c1859085132e15
> commit: 90ba86ed414e8ab4d84fe3342f10948c607efa7a [17/28] mmc:
> sdhci-s3c: ensure non-transaction of bus before clk_disable
> config: i386-randconfig-b646 (attached as .config)
>
> All error/warnings:
>
> drivers/mmc/host/sdhci-pltfm.o: In function `sdhci_runtime_pm_get':
> sdhci-pltfm.c:(.text+0x80): multiple definition of `sdhci_runtime_pm_get'
> drivers/mmc/host/sdhci.o:sdhci.c:(.text+0x7550): first defined here
> drivers/mmc/host/sdhci-pltfm.o: In function `sdhci_runtime_pm_put':
> sdhci-pltfm.c:(.text+0xa0): multiple definition of `sdhci_runtime_pm_put'
> drivers/mmc/host/sdhci.o:sdhci.c:(.text+0x7570): first defined here

Yay for buildbots.  Seungwon, I've dropped this patch from mmc-next now,
please investigate and fix.

(Wu, are you sure that this is the correct config?  It's i386 without
MMC_SDHCI_S3C=y, and MMC_SDHCI_S3C depends on PLAT_SAMSUNG/ARM.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
