From: akpm@linux-foundation.org
Subject: [patch 095/232] sdhci: increase timeout for internal clock stabilization.
Date: Tue, 22 Sep 2009 16:45:31 -0700
Message-ID: <200909222345.n8MNjWmY014579@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45247 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752969AbZIVXqF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 19:46:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, cjb@laptop.org, HaraldWelte@viatech.com, linux-mmc@vger.kernel.org, pierre@ossman.eu

From: Chris Ball <cjb@laptop.org>

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
Acked-by: Pierre Ossman <pierre@ossman.eu>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/sdhci.c~sdhci-increase-timeout-for-internal-clock-stabilization drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~sdhci-increase-timeout-for-internal-clock-stabilization
+++ a/drivers/mmc/host/sdhci.c
@@ -994,8 +994,8 @@ static void sdhci_set_clock(struct sdhci
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 10 ms */
-	timeout = 10;
+	/* Wait max 20 ms */
+	timeout = 20;
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (timeout == 0) {
_
