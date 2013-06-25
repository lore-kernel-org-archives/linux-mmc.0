From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/4] mmc: sdhci-s3c: fix the wrong register value,
 when clock is disabled
Date: Tue, 25 Jun 2013 10:20:57 +0900
Message-ID: <51C8F079.8090009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12306 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab3FYBUy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jun 2013 21:20:54 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOX00KHID295570@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 25 Jun 2013 10:20:53 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Kyungmin Park <kyungmin.park@samsung.com>

When use the QUIRK_NONSTANDARD_CLOCK, then never set to 0 at clock control register.
This patch is fixed this problem.
([PATCHv2] mmc: sdhci-s3c: fix teh wrong register value, when clock is disabled)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
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
