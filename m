From: Ido Yariv <ido@wizery.com>
Subject: [PATCH 3/5] arm: davinci: DA850: Set a default queue for CC1
Date: Fri,  8 Jul 2011 00:33:08 +0300
Message-ID: <1310074390-4277-4-git-send-email-ido@wizery.com>
References: <1310074390-4277-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41458 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab1GGVd3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2011 17:33:29 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so1362105wwe.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2011 14:33:29 -0700 (PDT)
In-Reply-To: <1310074390-4277-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

If a default queue is not set for a channel controller, EVENTQ_1 is
used. The second channel controller has only one event queue, and so,
EVENTQ_1 is an invalid option.

Fix this by explicitly setting the default queue for CC1 to be EVENTQ_0.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index fc4e98e..74114c0 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -139,6 +139,8 @@ static struct edma_soc_info *da830_edma_info[EDMA_MAX_CC] = {
 	&da830_edma_cc0_info,
 };
 
+static enum dma_event_q da850_edma_cc1_default_queue = EVENTQ_0;
+
 static struct edma_soc_info da850_edma_cc_info[] = {
 	{
 		.n_channel		= 32,
@@ -157,6 +159,7 @@ static struct edma_soc_info da850_edma_cc_info[] = {
 		.n_cc			= 1,
 		.queue_tc_mapping	= da850_queue_tc_mapping,
 		.queue_priority_mapping	= da850_queue_priority_mapping,
+		.default_queue_ptr	= &da850_edma_cc1_default_queue,
 	},
 };
 
-- 
1.7.4.1

