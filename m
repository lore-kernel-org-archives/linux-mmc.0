From: Ido Yariv <ido@wizery.com>
Subject: [PATCH 2/5] arm: davinci: Allow EVENTQ_0 as a default queue
Date: Fri,  8 Jul 2011 00:33:07 +0300
Message-ID: <1310074390-4277-3-git-send-email-ido@wizery.com>
References: <1310074390-4277-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41458 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab1GGVd1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2011 17:33:27 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so1362105wwe.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2011 14:33:26 -0700 (PDT)
In-Reply-To: <1310074390-4277-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

Davinci platforms may define a default queue for each channel
controller. If one is not defined, the default queue is set to EVENTQ_1.
However, there's no way to distinguish between an unset default queue to
one that is set to EVENTQ_0, as EVENTQ_0 = 0.

In order to keep existing behaviour on platforms which don't specify a
default_queue member, the default_queue member was modified to be a
pointer to enum dma_event_q. A NULL value means that this member was not
specified.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/dm365.c             |    4 +++-
 arch/arm/mach-davinci/dma.c               |    5 +++--
 arch/arm/mach-davinci/include/mach/edma.h |    2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 4604e72..b1cf08e 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -827,6 +827,8 @@ dm365_queue_priority_mapping[][2] = {
 	{-1, -1},
 };
 
+static enum dma_event_q dm365_edma_cc0_default_queue = EVENTQ_3;
+
 static struct edma_soc_info edma_cc0_info = {
 	.n_channel		= 64,
 	.n_region		= 4,
@@ -835,7 +837,7 @@ static struct edma_soc_info edma_cc0_info = {
 	.n_cc			= 1,
 	.queue_tc_mapping	= dm365_queue_tc_mapping,
 	.queue_priority_mapping	= dm365_queue_priority_mapping,
-	.default_queue		= EVENTQ_3,
+	.default_queue_ptr	= &dm365_edma_cc0_default_queue,
 };
 
 static struct edma_soc_info *dm365_edma_info[EDMA_MAX_CC] = {
diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 6b96698..11c71e7 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -1449,8 +1449,9 @@ static int __init edma_probe(struct platform_device *pdev)
 		edma_cc[j]->num_cc = min_t(unsigned, info[j]->n_cc,
 							EDMA_MAX_CC);
 
-		edma_cc[j]->default_queue = info[j]->default_queue;
-		if (!edma_cc[j]->default_queue)
+		if (info[j]->default_queue_ptr)
+			edma_cc[j]->default_queue = *info[j]->default_queue_ptr;
+		else
 			edma_cc[j]->default_queue = EVENTQ_1;
 
 		dev_dbg(&pdev->dev, "DMA REG BASE ADDR=%p\n",
diff --git a/arch/arm/mach-davinci/include/mach/edma.h b/arch/arm/mach-davinci/include/mach/edma.h
index 20c77f2..7f81812 100644
--- a/arch/arm/mach-davinci/include/mach/edma.h
+++ b/arch/arm/mach-davinci/include/mach/edma.h
@@ -250,7 +250,7 @@ struct edma_soc_info {
 	unsigned	n_slot;
 	unsigned	n_tc;
 	unsigned	n_cc;
-	enum dma_event_q	default_queue;
+	enum dma_event_q	*default_queue_ptr;
 
 	/* Resource reservation for other cores */
 	struct edma_rsv_info	*rsv;
-- 
1.7.4.1

