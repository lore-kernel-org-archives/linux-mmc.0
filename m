From: Dmitry Rozhkov <dmitry.rozhkov@jollamobile.com>
Subject: [PATCH] mmc: Adjust timings for power ramping up
Date: Mon, 13 Aug 2012 19:19:21 +0300
Message-ID: <20120813161921.GA5022@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp154.iad.emailsrvr.com ([207.97.245.154]:45237 "EHLO
	smtp154.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab2HMQ0i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Aug 2012 12:26:38 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

According to p6.4.1.1 of the Physical Layer Simplified Specification
Ver3.01 the "host needs to keep power line level less than 0.5V and
more than 1ms before power ramp up". This patch adds an explicit delay
of 10ms just before power rump up.

Without this patch some microSD cards (e.g. Kingston 8G Class 10) can't be
used as bootable media on some TI OMAP chips at least.
See https://bugs.nemomobile.org/show_bug.cgi?id=92 for details.

Signed-off-by: Dmitry Rozhkov <dmitry.rozhkov@jollamobile.com>
---
 drivers/mmc/core/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0b6141d..22b0eb2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1163,6 +1163,13 @@ static void mmc_power_up(struct mmc_host *host)
 
 	mmc_host_clk_hold(host);
 
+	/*
+	 * According to p6.4.1.1 of the Physical Layer Simplified Specification
+	 * Ver3.01 the "host needs to keep power line level less than 0.5V and
+	 * more than 1ms before power ramp up".
+	 */
+	mmc_delay(10);
+
 	/* If ocr is set, we use it */
 	if (host->ocr)
 		bit = ffs(host->ocr) - 1;
-- 
1.7.9.5

