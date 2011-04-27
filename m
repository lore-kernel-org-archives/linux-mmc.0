From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/2] Race fixes in sdhci
Date: Wed, 27 Apr 2011 14:23:30 +0100
Message-ID: <20110427132329.GA21499@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60852 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756311Ab1D0NXW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 09:23:22 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

I've had this pair of patches sitting in my tree for a while now (I
believe they were previously posted) providing stability improvements in
sdhci on my systems.  Having looked through the code I believe but have
not confirmed that the issue is that the timeout is racing with an
actual completion of a pending task - both paths will trigger the
tasklet, and if you trigger a tasklet while it is running this causes it
to be rescheduled.  The result will be that the tasklet gets run a
second time with no work pending for it.

I'm not convinced that these are the best fixes (it feels like we should
instead be closing the races down) but I don't really have time to come
up with something better myself right now so I'm pushing them out as-is
for comment.

Ben Dooks (1):
      MMC: SDHCI: Check mrq->cmd in sdhci_tasklet_finish

Dimitris Papastamos (1):
      MMC: SDHCI: Check mrq != NULL in sdhci_tasklet_finish

 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
