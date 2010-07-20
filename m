From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Subject: [PATCH] tmio_mmc: Make ack_mmc_irqs() write-only
Date: Tue, 20 Jul 2010 16:51:51 +0900
Message-ID: <4C455597.2020200@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.renesas.com ([202.234.163.13]:38899 "EHLO
	mail03.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752194Ab0GTHxs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jul 2010 03:53:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ian@mnementh.co.uk, damm@opensource.se, sameo@linux.intel.com, Paul Mundt <lethal@linux-sh.org>, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

This patch updates ack_mmc_irqs() to acknowledge using write instead
of read-modify-write. Without this fix the old read-modify-write
implementation may acknowledge interrupt sources by mistake. The
driver may if so lock-up waiting forever for an interrupt that will
never come. Observed with the TMIO_STAT_RXRDY bit together with CMD53
on AR6002 and BCM4318 SDIO cards in polled mode.

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



