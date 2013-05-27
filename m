From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2] mmc: sdhci-s3c: fix the wrong register value when,
 clock is disabled
Date: Mon, 27 May 2013 13:10:44 +0900
Message-ID: <51A2DCC4.2020307@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28888 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab3E0EKf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 May 2013 00:10:35 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNF003YGVL66700@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 27 May 2013 13:10:34 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

When use the QUIRK_NONSTANDARD_CLOCK, then never set to 0 at clock control register.
This patch is fixed this problem.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.co
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changelog v2:
- Rebased at the latest mmc tree

 drivers/mmc/host/sdhci-s3c.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 926aaf6..ce71f32 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -297,8 +297,11 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
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
