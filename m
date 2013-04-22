From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: fix the wrong register value when clock is,
 disabled
Date: Mon, 22 Apr 2013 14:02:25 +0900
Message-ID: <5174C461.9010603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48643 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab3DVFCQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Apr 2013 01:02:16 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MLN00JSS4NJR4O0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 22 Apr 2013 14:02:14 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ben Dooks <ben-linux@fluff.org>

When use the QUIRK_NONSTANDARD_CLOCK, then never set to 0 at clock
control register.
This patch is fixed this problem.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 8cd966d..317bde2 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -298,8 +298,11 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk = 0;
 
 	/* don't bother if the clock is going off */
-	if (clock == 0)
+	if (clock == 0) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+		host->clock = clock;
 		return;
+	}
 
 	sdhci_s3c_set_clock(host, clock);
 
-- 
1.7.9.5
