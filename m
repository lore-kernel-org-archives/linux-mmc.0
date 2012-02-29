From: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] mmc: core: remove waiting time when clkgate_delay is set
Date: Wed, 29 Feb 2012 14:52:49 +0900
Message-ID: <1330494769-7558-1-git-send-email-chanho61.park@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33854 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965657Ab2B2FxN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Feb 2012 00:53:13 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0500GHQ4BGIDM0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Feb 2012 14:53:11 +0900 (KST)
Received: from localhost.localdomain ([10.254.103.63])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0M05001OB4CJNQJ0@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Wed, 29 Feb 2012 14:53:10 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Chanho Park <chanho61.park@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Since recent commit("mmc: core: Use delayed work in clock gating
framework":597dd9d79cfbbb1), we always wait "unnecessary" default
clock delay(8 cycles). Actually, we don't need it if clkgate_delay
(unit:ms) is set because we already wait sufficient time to change
the clock due to delayed_workqueue.
This patch removes duplicated waiting time when clkgate_delay is set.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/host.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index c3704e2..d710ce0 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -109,8 +109,11 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 	 */
 	if (!host->clk_requests) {
 		spin_unlock_irqrestore(&host->clk_lock, flags);
-		tick_ns = DIV_ROUND_UP(1000000000, freq);
-		ndelay(host->clk_delay * tick_ns);
+		/* wait only when clk_gate_delay is 0*/
+		if (!host->clkgate_delay) {
+			tick_ns = DIV_ROUND_UP(1000000000, freq);
+			ndelay(host->clk_delay * tick_ns);
+		}
 	} else {
 		/* New users appeared while waiting for this work */
 		spin_unlock_irqrestore(&host->clk_lock, flags);
-- 
1.7.5.4

