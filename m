From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [mmc:mmc-next 17/28] sdhci-pltfm.c:(.text+0x80): multiple
 definition of `sdhci_runtime_pm_get'
Date: Thu, 8 Nov 2012 20:08:33 +0800
Message-ID: <20121108120833.GA8199@localhost>
References: <509ac6c4.cYfNNpMXVvvrRu6C%fengguang.wu@intel.com>
 <87ip9h6t5y.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34586 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab2KHMIj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Nov 2012 07:08:39 -0500
Content-Disposition: inline
In-Reply-To: <87ip9h6t5y.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org

On Wed, Nov 07, 2012 at 03:43:05PM -0500, Chris Ball wrote:
> Hi,
> 
> On Wed, Nov 07 2012, kbuild test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
> > head:   a6a567a4c25762e36228d2d0c8c1859085132e15
> > commit: 90ba86ed414e8ab4d84fe3342f10948c607efa7a [17/28] mmc:
> > sdhci-s3c: ensure non-transaction of bus before clk_disable
> > config: i386-randconfig-b646 (attached as .config)
> >
> > All error/warnings:
> >
> > drivers/mmc/host/sdhci-pltfm.o: In function `sdhci_runtime_pm_get':
> > sdhci-pltfm.c:(.text+0x80): multiple definition of `sdhci_runtime_pm_get'
> > drivers/mmc/host/sdhci.o:sdhci.c:(.text+0x7550): first defined here
> > drivers/mmc/host/sdhci-pltfm.o: In function `sdhci_runtime_pm_put':
> > sdhci-pltfm.c:(.text+0xa0): multiple definition of `sdhci_runtime_pm_put'
> > drivers/mmc/host/sdhci.o:sdhci.c:(.text+0x7570): first defined here
> 
> Yay for buildbots.  Seungwon, I've dropped this patch from mmc-next now,
> please investigate and fix.
> 
> (Wu, are you sure that this is the correct config?  It's i386 without
> MMC_SDHCI_S3C=y, and MMC_SDHCI_S3C depends on PLAT_SAMSUNG/ARM.)

Sorry I don't understand that. MMC_SDHCI_S3C seems to not matter at all?

Looking at the patch, these inline functions in .h should be prefixed
with "static":

+inline int sdhci_runtime_pm_get(struct sdhci_host *host)
+{
+       return 0;
+}
+inline int sdhci_runtime_pm_put(struct sdhci_host *host)
+{
+       return 0;
+}

Thanks,
Fengguang
