From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [mmc:mmc-next 17/28] sdhci-pltfm.c:(.text+0x80): multiple
 definition of `sdhci_runtime_pm_get'
Date: Fri, 09 Nov 2012 19:24:25 +0900
Message-ID: <019401cdbe64$64d26710$2e773530$%jun@samsung.com>
References: <509ac6c4.cYfNNpMXVvvrRu6C%fengguang.wu@intel.com>
 <87ip9h6t5y.fsf@octavius.laptop.org> <20121108120833.GA8199@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:17869 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2KIKY2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Nov 2012 05:24:28 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MD7007MDU8MYI41@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 09 Nov 2012 19:24:26 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MD70012JU8PI530@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 09 Nov 2012 19:24:26 +0900 (KST)
In-reply-to: <20121108120833.GA8199@localhost>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Fengguang Wu' <fengguang.wu@intel.com>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Fengguang Wu <fengguang.wu@intel.com> wrote:
> On Wed, Nov 07, 2012 at 03:43:05PM -0500, Chris Ball wrote:
> > Hi,
> >
> > On Wed, Nov 07 2012, kbuild test robot wrote:
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
> > > head:   a6a567a4c25762e36228d2d0c8c1859085132e15
> > > commit: 90ba86ed414e8ab4d84fe3342f10948c607efa7a [17/28] mmc:
> > > sdhci-s3c: ensure non-transaction of bus before clk_disable
> > > config: i386-randconfig-b646 (attached as .config)
> > >
> > > All error/warnings:
> > >
> > > drivers/mmc/host/sdhci-pltfm.o: In function `sdhci_runtime_pm_get':
> > > sdhci-pltfm.c:(.text+0x80): multiple definition of `sdhci_runtime_pm_get'
> > > drivers/mmc/host/sdhci.o:sdhci.c:(.text+0x7550): first defined here
> > > drivers/mmc/host/sdhci-pltfm.o: In function `sdhci_runtime_pm_put':
> > > sdhci-pltfm.c:(.text+0xa0): multiple definition of `sdhci_runtime_pm_put'
> > > drivers/mmc/host/sdhci.o:sdhci.c:(.text+0x7570): first defined here
> >
> > Yay for buildbots.  Seungwon, I've dropped this patch from mmc-next now,
> > please investigate and fix.
> >
> > (Wu, are you sure that this is the correct config?  It's i386 without
> > MMC_SDHCI_S3C=y, and MMC_SDHCI_S3C depends on PLAT_SAMSUNG/ARM.)
> 
> Sorry I don't understand that. MMC_SDHCI_S3C seems to not matter at all?
> 
> Looking at the patch, these inline functions in .h should be prefixed
> with "static":
> 
> +inline int sdhci_runtime_pm_get(struct sdhci_host *host)
> +{
> +       return 0;
> +}
> +inline int sdhci_runtime_pm_put(struct sdhci_host *host)
> +{
> +       return 0;
> +}
> 
Sorry, I have missed it.
Fengguang, Thank you for detection.
Chris, I'll send a fixed version.

Thanks,
Seungwon Jeon

> Thanks,
> Fengguang
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

