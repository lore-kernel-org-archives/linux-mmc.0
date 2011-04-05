From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 2/2] mmc: sdhci: add regulator disable/put when control error
Date: Tue, 05 Apr 2011 17:02:20 +0900
Message-ID: <4D9ACC8C.2000202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:17453 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab1DEIDw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 04:03:52 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJ6004NT6ECVED0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Apr 2011 17:03:48 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJ6007N76ECWM@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Apr 2011 17:03:48 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Kyungmin Park <kyungmin.park@samsung.com>

Missing regulator disable/put. Fixed them.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1768ffb..35edcc1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2048,6 +2048,10 @@ reset:
 	sdhci_reset(host, SDHCI_RESET_ALL);
 	free_irq(host->irq, host);
 	del_timer_sync(&host->timer);
+	if (host->vmmc) {
+		regulator_disable(host->vmmc);
+		regulator_put(host->vmmc);
+	}
 
 untasklet:
 	tasklet_kill(&host->card_tasklet);
