From: Chris Ball <cjb@laptop.org>
Subject: Re: 2.36.1 sdhci R5C822 regression
Date: Fri, 17 Dec 2010 15:30:24 +0000
Message-ID: <20101217153024.GA26910@void.printf.net>
References: <4D0B380C.4000407@tls-tautenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43120 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606Ab0LQPa0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Dec 2010 10:30:26 -0500
Content-Disposition: inline
In-Reply-To: <4D0B380C.4000407@tls-tautenburg.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bringfried Stecklum <stecklum@tls-tautenburg.de>
Cc: linux-mmc@vger.kernel.org

Hi Bringfried,

On Fri, Dec 17, 2010 at 11:14:36AM +0100, Bringfried Stecklum wrote:
> On resume from hibernation (suspend is fine) a kernel trace happens along with
> the well-know "IRQ nobody cared" statement (see below). The interrupt gets
> disabled, and since mmc0 is compiled into the kernel, I cannot do anything about
> it (I tried CONFIG_MMC_RICOH_MMC=m but this will be overriden during the build).

Please try the patch below, and let us know if it cures the problem for
you.  Thanks!  (This patch is already scheduled for inclusion in 2.6.37.)

- Chris.

From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 10 Dec 2010 08:40:31 +0100
Subject: mmc: Fix re-probing with PM_POST_RESTORE notification

In the error-path where PM notifies PM_POST_RESTORE, the rescan-blockage
should be cleared as well.  Otherwise it'll be never re-probed.

Also, as a bonus, this fixes a bug in S4 with user-mode suspend in the
current code, as it sends PM_POST_RESTORE instead of
PM_POST_HIBERNATION wrongly.

Cc: <stable@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6286898..e7c0c78 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1833,6 +1833,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 
 	case PM_POST_SUSPEND:
 	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
 
 		spin_lock_irqsave(&host->lock, flags);
 		host->rescan_disable = 0;
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
