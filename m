From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] Race fixes in sdhci
Date: Wed, 27 Apr 2011 17:44:42 -0400
Message-ID: <m3mxjbl67p.fsf@pullcord.laptop.org>
References: <20110427132329.GA21499@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48765 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759240Ab1D0VlI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2011 17:41:08 -0400
In-Reply-To: <20110427132329.GA21499@opensource.wolfsonmicro.com> (Mark
	Brown's message of "Wed, 27 Apr 2011 14:23:30 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Hi Mark,

On Wed, Apr 27 2011, Mark Brown wrote:
> Ben Dooks (1):
>       MMC: SDHCI: Check mrq->cmd in sdhci_tasklet_finish
>
> Dimitris Papastamos (1):
>       MMC: SDHCI: Check mrq != NULL in sdhci_tasklet_finish

Thanks.  I've merged Ben's patch for .39, and also:

From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: sdhci: Check mrq != NULL in sdhci_tasklet_finish

It seems that under certain circumstances the sdhci_tasklet_finish()
call can be entered with mrq set to NULL, causing the system to crash
with a NULL pointer de-reference.

Seen on S3C6410 system.  Based on a patch by Dimitris Papastamos.

Reported-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: <stable@kernel.org>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e4084a3..f197c67 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1808,6 +1808,13 @@ static void sdhci_tasklet_finish(unsigned long param)
 
 	host = (struct sdhci_host*)param;
 
+        /*
+         * If this tasklet gets rescheduled while running, it will
+         * be run again afterwards but without any active request.
+         */
+	if (!host->mrq)
+		return;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	del_timer(&host->timer);
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
