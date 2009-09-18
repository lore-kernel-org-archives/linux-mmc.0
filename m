From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] sdhci: Increase timeout for internal clock stabilization.
Date: Fri, 18 Sep 2009 18:15:56 -0400
Message-ID: <m3ocp7c31f.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57052 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757334AbZIRWSr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Sep 2009 18:18:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, HaraldWelte@viatech.com, Pierre Ossman <pierre@ossman.eu>, Deepak Saxena <dsaxena@laptop.org>

On an OLPC XO-1.5 development board with Via VX855 chipset, the sdhci
controller can take up to 12ms to stabilize its clock, but the current
timeout at which we give up on the controller is 10ms.

The patch increases the timeout delay rather than using a device-specific
quirk -- since we exit the loop when the clock comes up, increasing the
timeout value will only make us mdelay() longer in the errant case of a
device with a clock that is not stabilizing, which it seems worth waiting
a little longer for in general.

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/mmc/host/sdhci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fc96f8c..00ab7b3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -991,8 +991,8 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 10 ms */
-	timeout = 10;
+	/* Wait max 20 ms */
+	timeout = 20;
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (timeout == 0) {
-- 
1.6.4

-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
