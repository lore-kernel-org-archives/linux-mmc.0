From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v3] ARM: davinci: map default_queue to edma channels
Date: Thu, 19 Jan 2012 08:05:21 +0100
Message-ID: <1326956721-25158-1-git-send-email-hs@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54264 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab2ASHFb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2012 02:05:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Heiko Schocher <hs@denx.de>, juha.kuikka@gmail.com, linux-mmc@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, Ido Yariv <ido@wizery.com>, Sekhar Nori <nsekhar@ti.com>, Wolfgang Denk <wd@denx.de>, Sergei Shtylyov <sshtylyov@mvista.com>

Default queue is expected to be a low-priority queue.
This way, long transfers on the default queue started
by the codec engine will not cause audio defects.

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: juha.kuikka@gmail.com
Reported-by: juha.kuikka@gmail.com
Acked-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
Cc: linux-mmc@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com
Cc: linux-arm-kernel@lists.infradead.org
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
- changes for v3:
  - add comments from Sekhar Nori <nsekhar@ti.com>:
    - add linux-arm-kernel@lists.infradead.org to Cc
    - simplify and move comment to
      arch/arm/mach-davinci/include/mach/edma.h
    - rework commit message
    - as the subject changed v2 can be found for example here:
      http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-December/023606.html
    - checkpatch shows:
total: 0 errors, 0 warnings, 24 lines checked

temp/0001-ARM-davinci-map-default_queue-to-edma-channels.patch has no obvious style problems and is ready for submission.

 arch/arm/mach-davinci/dma.c               |    6 +-----
 arch/arm/mach-davinci/include/mach/edma.h |    5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index da90103..fd33919 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -1508,12 +1508,8 @@ static int __init edma_probe(struct platform_device *pdev)
 			goto fail;
 		}
 
-		/* Everything lives on transfer controller 1 until otherwise
-		 * specified. This way, long transfers on the low priority queue
-		 * started by the codec engine will not cause audio defects.
-		 */
 		for (i = 0; i < edma_cc[j]->num_channels; i++)
-			map_dmach_queue(j, i, EVENTQ_1);
+			map_dmach_queue(j, i, info[j]->default_queue);
 
 		queue_tc_mapping = info[j]->queue_tc_mapping;
 		queue_priority_mapping = info[j]->queue_priority_mapping;
diff --git a/arch/arm/mach-davinci/include/mach/edma.h b/arch/arm/mach-davinci/include/mach/edma.h
index 20c77f2..7e84c90 100644
--- a/arch/arm/mach-davinci/include/mach/edma.h
+++ b/arch/arm/mach-davinci/include/mach/edma.h
@@ -250,6 +250,11 @@ struct edma_soc_info {
 	unsigned	n_slot;
 	unsigned	n_tc;
 	unsigned	n_cc;
+	/*
+	 * Default queue is expected to be a low-priority queue.
+	 * This way, long transfers on the default queue started
+	 * by the codec engine will not cause audio defects.
+	 */
 	enum dma_event_q	default_queue;
 
 	/* Resource reservation for other cores */
-- 
1.7.7.5

