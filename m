From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable
	case
Date: Wed, 15 Sep 2010 21:38:55 +0100
Message-ID: <20100915203855.GA6620@void.printf.net>
References: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org> <7e892c443f11d51a30029ddfeef27af09a9a970d.1283003070.git.matt@console-pimps.org> <4C7F65A1.60105@samsung.com> <20100902091424.GA12456@console-pimps.org> <4C86E672.1030807@samsung.com> <20100915151142.GB21538@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38948 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753682Ab0IOUi7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Sep 2010 16:38:59 -0400
Content-Disposition: inline
In-Reply-To: <20100915151142.GB21538@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>

Hi Matt,

On Wed, Sep 15, 2010 at 04:11:42PM +0100, Matt Fleming wrote:
> Chris, are you OK to pick this up (including Jaehoon's change)? Or
> would you prefer me to resubmit?

Thanks, that's fine, I've applied both patches to mmc-next:

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=c1e1b0d22967e9ddd02c3099e894c888798c56ea
http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=5c0e8a196827961f7256879e5e45d34ad5d61430

I modified the changelog and indentation for this one, resulting in the
patch below; please check it over and let me know if anything's wrong:

From: Jaehoon Chung <jh80.chung@samsung.com>
Date: Wed, 15 Sep 2010 15:30:20 -0400
Subject: [PATCH 2/2] mmc: sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case

When a controller requires SDHCI_QUIRK_BROKEN_CARD_DETECTION, we poll
for card insertion/removal, and that creates interrupts.  There's no
need to be doing this if we have a non-removable card.

This patch requires cards to be removable before we're willing to set
MMC_CAP_NEEDS_POLL.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Matt Fleming <matt@console-pimps.org>
[cjb: modified changelog and code indentation]
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac8b12b..fb6b170 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1846,7 +1846,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
 
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
+	    mmc_card_is_removable(mmc))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	mmc->ocr_avail = 0;
-- 
1.7.2.2

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
