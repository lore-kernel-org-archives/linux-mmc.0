From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 1/3] SDHCI: Remove useless set_clock check
Date: Sat, 12 Jun 2010 14:44:41 +0900
Message-ID: <20100612054441.GA25678@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34414 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0FLFov (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Jun 2010 01:44:51 -0400
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L3V00A88ZYOWD30@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 12 Jun 2010 14:44:48 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3V006UUZYOYQ@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 12 Jun 2010 14:44:48 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

From: Kyungmin Park <kyungmin.park@samsung.com>

When use QUIRK_NONSTANDARD_CLOCK, it check the set_clock function which is not used actually. So delete it.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..4321e0c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1786,7 +1786,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	mmc->ops = &sdhci_ops;
 	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK &&
-			host->ops->set_clock && host->ops->get_min_clock)
+			host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else
 		mmc->f_min = host->max_clk / 256;
-- 
1.5.3.3

