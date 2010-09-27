From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 1/2] mmc: Add helper function to check if a card is
	removable
Date: Mon, 27 Sep 2010 16:01:32 +0100
Message-ID: <20100927150132.GA11578@void.printf.net>
References: <1285576940-27587-1-git-send-email-matt@console-pimps.org> <1285576940-27587-2-git-send-email-matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56315 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234Ab0I0PBh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Sep 2010 11:01:37 -0400
Content-Disposition: inline
In-Reply-To: <1285576940-27587-2-git-send-email-matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>, zhangfei gao <zhangfei.gao@gmail.com>

Hi Matt,

On Mon, Sep 27, 2010 at 09:42:19AM +0100, Matt Fleming wrote:
> There are two checks that need to be made when determining whether a
> card is removable. A host controller may set MMC_CAP_NONREMOVABLE if the
> controller does not support removing cards (e.g. eMMC), in which case
> the card is physically non-removable. Also the 'mmc_assume_removable'
> module parameter can be configured at module load time, in which case
> the card may be logically non-removable.
> 
> A helper function keeps the logic in one place so that code always
> checks both conditions.
> 
> Because this new function is likely to be called from modules we now
> need to export the mmc_assume_removable symbol.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied to mmc-next with Wolfram's ACK and the following style change,
thanks very much.

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 23a4864..2e0fe62 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -272,7 +272,7 @@ extern int mmc_assume_removable;
 
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
-	return (!(host->caps & MMC_CAP_NONREMOVABLE) && mmc_assume_removable);
+	return !(host->caps & MMC_CAP_NONREMOVABLE) && mmc_assume_removable;
 }
 
 #endif
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
