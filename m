From: Ido Yariv <ido@wizery.com>
Subject: [PATCH v2 2/6] arm: davinci: Explicitly set channel controllers' default queues
Date: Sun, 10 Jul 2011 16:14:35 +0300
Message-ID: <1310303679-17936-3-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62339 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1GJNOz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Jul 2011 09:14:55 -0400
Received: by mail-wy0-f174.google.com with SMTP id 8so2098815wyg.19
        for <linux-mmc@vger.kernel.org>; Sun, 10 Jul 2011 06:14:54 -0700 (PDT)
In-Reply-To: <1310303679-17936-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

Davinci platforms may define a default queue for each channel
controller. If one is not defined, the default queue is set to EVENTQ_1.
However, there's no way to distinguish between an unset default queue to
one that is set to EVENTQ_0, as EVENTQ_0 = 0.

Explicitly specify the default queue for all channel controllers on all
Davinci platforms to EVENTQ_1, and don't overwrite it in the EDMA probe
function.

One exception is the DA850 board, for which EVENTQ_1 is not a valid
option for its second channel controller. Use EVENTQ_0 instead for that
channel controller.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/devices-da8xx.c     |    3 +++
 arch/arm/mach-davinci/devices-tnetv107x.c |    1 +
 arch/arm/mach-davinci/dm355.c             |    1 +
 arch/arm/mach-davinci/dm644x.c            |    1 +
 arch/arm/mach-davinci/dm646x.c            |    1 +
 arch/arm/mach-davinci/dma.c               |    2 --
 6 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index fc4e98e..502222a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -133,6 +133,7 @@ static struct edma_soc_info da830_edma_cc0_info = {
 	.n_cc			= 1,
 	.queue_tc_mapping	= da8xx_queue_tc_mapping,
 	.queue_priority_mapping	= da8xx_queue_priority_mapping,
+	.default_queue		= EVENTQ_1,
 };
 
 static struct edma_soc_info *da830_edma_info[EDMA_MAX_CC] = {
@@ -148,6 +149,7 @@ static struct edma_soc_info da850_edma_cc_info[] = {
 		.n_cc			= 1,
 		.queue_tc_mapping	= da8xx_queue_tc_mapping,
 		.queue_priority_mapping	= da8xx_queue_priority_mapping,
+		.default_queue		= EVENTQ_1,
 	},
 	{
 		.n_channel		= 32,
@@ -157,6 +159,7 @@ static struct edma_soc_info da850_edma_cc_info[] = {
 		.n_cc			= 1,
 		.queue_tc_mapping	= da850_queue_tc_mapping,
 		.queue_priority_mapping	= da850_queue_priority_mapping,
+		.default_queue		= EVENTQ_0,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index 6162cae..6298d46 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -80,6 +80,7 @@ static struct edma_soc_info edma_cc0_info = {
 	.n_cc			= 1,
 	.queue_tc_mapping	= edma_tc_mapping,
 	.queue_priority_mapping	= edma_priority_mapping,
+	.default_queue		= EVENTQ_1;
 };
 
 static struct edma_soc_info *tnetv107x_edma_info[EDMA_MAX_CC] = {
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a3a94e9..f1d9c75 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -591,6 +591,7 @@ static struct edma_soc_info edma_cc0_info = {
 	.n_cc			= 1,
 	.queue_tc_mapping	= queue_tc_mapping,
 	.queue_priority_mapping	= queue_priority_mapping,
+	.default_queue		= EVENTQ_1;
 };
 
 static struct edma_soc_info *dm355_edma_info[EDMA_MAX_CC] = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 4c82c27..9971990 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -514,6 +514,7 @@ static struct edma_soc_info edma_cc0_info = {
 	.n_cc			= 1,
 	.queue_tc_mapping	= queue_tc_mapping,
 	.queue_priority_mapping	= queue_priority_mapping,
+	.default_queue		= EVENTQ_1;
 };
 
 static struct edma_soc_info *dm644x_edma_info[EDMA_MAX_CC] = {
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 1e0f809..a40372d 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -551,6 +551,7 @@ static struct edma_soc_info edma_cc0_info = {
 	.n_cc			= 1,
 	.queue_tc_mapping	= dm646x_queue_tc_mapping,
 	.queue_priority_mapping	= dm646x_queue_priority_mapping,
+	.default_queue		= EVENTQ_1;
 };
 
 static struct edma_soc_info *dm646x_edma_info[EDMA_MAX_CC] = {
diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 6b96698..6ba4191 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -1450,8 +1450,6 @@ static int __init edma_probe(struct platform_device *pdev)
 							EDMA_MAX_CC);
 
 		edma_cc[j]->default_queue = info[j]->default_queue;
-		if (!edma_cc[j]->default_queue)
-			edma_cc[j]->default_queue = EVENTQ_1;
 
 		dev_dbg(&pdev->dev, "DMA REG BASE ADDR=%p\n",
 			edmacc_regs_base[j]);
-- 
1.7.4.1

