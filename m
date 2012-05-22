From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 4/4] mmc: dw_mmc: correct the calculation for CLKDIV
Date: Tue, 22 May 2012 13:01:21 +0900
Message-ID: <006b01cd37cf$8c5d86f0$a51894d0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17483 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2EVEBW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 May 2012 00:01:22 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4E00I07OGXOVF0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:01:21 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4E00AGZOI9ZFO0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:01:21 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

In case of "host->bus_hz < slot->clock", divider value is
miscalculated. And clock divider register value is multiple
of 2. If calculated divider value is odd number, result can
be over-clocking.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b070ee5..8f5768c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -617,14 +617,16 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 	u32 div;
 
 	if (slot->clock != host->current_speed) {
-		if (host->bus_hz % slot->clock)
+		div = host->bus_hz / slot->clock;
+		if (host->bus_hz % slot->clock &&
+			host->bus_hz > slot->clock)
 			/*
 			 * move the + 1 after the divide to prevent
 			 * over-clocking the card.
 			 */
-			div = ((host->bus_hz / slot->clock) >> 1) + 1;
-		else
-			div = (host->bus_hz  / slot->clock) >> 1;
+			div += 1;
+
+		div = (host->bus_hz != slot->clock) ? DIV_ROUND_UP(div, 2) : 0;
 
 		dev_info(&slot->mmc->class_dev,
 			 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ"
-- 
1.7.0.4


