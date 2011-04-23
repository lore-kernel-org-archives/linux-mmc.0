From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH 3/6] sdhci: Always pass clock request value zero to set_clock host op
Date: Fri, 22 Apr 2011 18:01:39 -0700
Message-ID: <1303520502-32171-4-git-send-email-john.stultz@linaro.org>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:49426 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118Ab1DWBB7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2011 21:01:59 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3MHGDDa026487
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 11:16:13 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id p3N11ssD125682
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 19:01:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3N11QwQ030956
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 19:01:27 -0600
In-Reply-To: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Todd Poynor <toddpoynor@google.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Dima Zavin <dima@android.com>, John Stultz <john.stultz@linaro.org>

From: Todd Poynor <toddpoynor@google.com>

To allow the set_clock host op to disable the SDCLK source when not
needed, always call the host op when the requested clock speed is
zero.  Do this even if host->clock already equals zero, because
the SDHCI driver may set that value (without calling the host op)
to force an update at the next (non-zero-speed) call.

CC: Chris Ball <cjb@laptop.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Dima Zavin <dima@android.com>
Change-Id: If99230d76138679b5767f77cb925f15408ae518e
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..3820adf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -992,7 +992,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk;
 	unsigned long timeout;
 
-	if (clock == host->clock)
+	if (clock && clock == host->clock)
 		return;
 
 	if (host->ops->set_clock) {
-- 
1.7.3.2.146.gca209

