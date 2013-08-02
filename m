From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 1/4] mmc: sdhci-s3c: fix the wrong register value,
 when clock is disabled
Date: Fri, 02 Aug 2013 23:08:58 +0900
Message-ID: <51FBBD7A.4050501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35720 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab3HBOI7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 10:08:59 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQW00JXDPYX1HO0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Aug 2013 23:08:57 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>

When use the QUIRK_NONSTANDARD_CLOCK, then never set to 0 at clock control register.
This patch is fixed this problem.
([PATCHv2] mmc: sdhci-s3c: fix teh wrong register value, when clock is disabled)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changelog v2:
	- modified the comment

 drivers/mmc/host/sdhci-s3c.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 926aaf6..1572b6a 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -296,9 +296,12 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	unsigned long timeout;
 	u16 clk = 0;
 
-	/* don't bother if the clock is going off */
-	if (clock == 0)
+	/* If the clock is going off, set to 0 at clock control register */
+	if (clock == 0) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+		host->clock = clock;
 		return;
+	}
 
 	sdhci_s3c_set_clock(host, clock);
 
-- 
1.7.9.5
