From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT] mmc: core: use usleep_range rather than HZ magic in mmc_delay()
Date: Tue, 14 Nov 2017 23:55:20 +0100
Message-ID: <20171114225520.6793-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33100 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756626AbdKNWz0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Nov 2017 17:55:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Documentation/timers/timers-howto.txt recommends to use usleep_range for
delays 1-20ms. Let's adhere to it. No need for messing with HZ and still
do busy looping these days.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Here is a more detailed test page for this describing my tests:

https://elinux.org/Tests:mmc-delay-refactor

I did mainly test the insert/eject cycle because powering up the cards
seemed to trigger most delays. Transferring data did not cause any calls
to mmc_delay() for me. Please let me know if someone knows a test pattern
which should be included before applying this change.

Works fine for me on Lager (R-Car H2) and Salvator-X (R-Car M3-W). Testing on
other platforms very welcome. This should be independent of the IP core.

 drivers/mmc/core/core.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 71e6c6d7ceb70d..b2877e2d740fa5 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -62,12 +62,10 @@ void mmc_set_initial_state(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
-	if (ms < 1000 / HZ) {
-		cond_resched();
-		mdelay(ms);
-	} else {
+	if (ms <= 20)
+		usleep_range(ms * 1000, ms * 1250);
+	else
 		msleep(ms);
-	}
 }
 
 void mmc_rescan(struct work_struct *work);
-- 
2.11.0

