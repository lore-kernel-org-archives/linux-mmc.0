From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v2] arm, da8xx, mmc: set second MMC controllers default queue
Date: Thu,  8 Dec 2011 07:55:57 +0100
Message-ID: <1323327357-23886-1-git-send-email-hs@denx.de>
References: <1322991210-20486-1-git-send-email-hs@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56604 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab1LHG4K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 01:56:10 -0500
In-Reply-To: <1322991210-20486-1-git-send-email-hs@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, juha.kuikka@gmail.com, linux-mmc@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, Ido Yariv <ido@wizery.com>, Sekhar Nori <nsekhar@ti.com>, Wolfgang Denk <wd@denx.de>, Sergei Shtylyov <sshtylyov@mvista.com>

The MMC driver allocates channels with EVENTQ_DEFAULT, they
get put into EVENTQ_1, which the second EDMA controller does
not have and hence transfers stall. This is fixed
in commit f23fe857bbea393b4b94fe2218c98d934bd3d4cf
"ARM: davinci: Explicitly set channel controllers' default queues"
from Ido Yariv. This patch sets immediately in edma_probe()
the proper default_queue, so this patch does not really fix
something, it is more a cosmetic change.

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: juha.kuikka@gmail.com
Reported-by: juha.kuikka@gmail.com
Acked-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
Cc: linux-mmc@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com
Cc: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
Cc: Ido Yariv <ido@wizery.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>

---
- changes for v2:
  - add comment from Sergei Shtylyov
    add in commit message the commit's summary in parens.
  - add comment from Ido Yariv:
    changed comment and commit message
  - added Acked-by from Rajashekhara, Sudhakar

 arch/arm/mach-davinci/dma.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index da90103..a0cabc7 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -1508,12 +1508,14 @@ static int __init edma_probe(struct platform_device *pdev)
 			goto fail;
 		}
 
-		/* Everything lives on transfer controller 1 until otherwise
-		 * specified. This way, long transfers on the low priority queue
-		 * started by the codec engine will not cause audio defects.
+		/*
+		 * Everything lives on transfer controller 1, except on the
+		 * da850 MMC2 controller, so pass info[j]->default_queue.
+		 * This way, long transfers on the low priority queue started
+		 * by the codec engine will not cause audio defects.
 		 */
 		for (i = 0; i < edma_cc[j]->num_channels; i++)
-			map_dmach_queue(j, i, EVENTQ_1);
+			map_dmach_queue(j, i, info[j]->default_queue);
 
 		queue_tc_mapping = info[j]->queue_tc_mapping;
 		queue_priority_mapping = info[j]->queue_priority_mapping;
-- 
1.7.6.4

