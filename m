From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Subject: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Wed, 07 Jul 2010 10:59:52 +0900
Message-ID: <4C33DF98.10409@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.renesas.com ([202.234.163.13]:39732 "EHLO
	mail05.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751114Ab0GGCAT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2010 22:00:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Magnus Damm <magnus.damm@gmail.com>

This patch clears only necessary bit.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
---
 drivers/mmc/host/tmio_mmc.h |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 64f7d5d..7944604 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -82,10 +82,7 @@

 #define ack_mmc_irqs(host, i) \
 	do { \
-		u32 mask;\
-		mask  = sd_ctrl_read32((host), CTL_STATUS); \
-		mask &= ~((i) & TMIO_MASK_IRQ); \
-		sd_ctrl_write32((host), CTL_STATUS, mask); \
+		sd_ctrl_write32((host), CTL_STATUS, ~(i)); \
 	} while (0)


-- 
1.7.0


