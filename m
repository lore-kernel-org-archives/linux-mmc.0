From: Heiko Schocher <hs@denx.de>
Subject: [PATCH] arm, da8xx, mmc: set second MMC controllers default queue
Date: Sun,  4 Dec 2011 10:33:30 +0100
Message-ID: <1322991210-20486-1-git-send-email-hs@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58264 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab1LDJdi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2011 04:33:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Heiko Schocher <hs@denx.de>, juha.kuikka@gmail.com, linux-mmc@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, Ido Yariv <ido@wizery.com>, Sekhar Nori <nsekhar@ti.com>, Wolfgang Denk <wd@denx.de>

The MMC driver allocates channels with EVENTQ_DEFAULT they
get put into EVENTQ_1 which the second EDMA controller does
not have and hence transfers stall. This is tried to fix
in commit f23fe857bbea393b4b94fe2218c98d934bd3d4cf
from Ido Yariv, but missed a fix for the second MMC
controller on da850.

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: juha.kuikka@gmail.com
Reported-by: juha.kuikka@gmail.com
Cc: linux-mmc@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com
Cc: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
Cc: Ido Yariv <ido@wizery.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/mach-davinci/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index da90103..e10a251 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -1513,7 +1513,7 @@ static int __init edma_probe(struct platform_device *pdev)
 		 * started by the codec engine will not cause audio defects.
 		 */
 		for (i = 0; i < edma_cc[j]->num_channels; i++)
-			map_dmach_queue(j, i, EVENTQ_1);
+			map_dmach_queue(j, i, info[j]->default_queue);
 
 		queue_tc_mapping = info[j]->queue_tc_mapping;
 		queue_priority_mapping = info[j]->queue_priority_mapping;
-- 
1.7.6.4

