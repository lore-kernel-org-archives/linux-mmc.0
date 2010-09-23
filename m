From: Philip Rakity <prakity@marvell.com>
Subject: Subject: [PATCH] sdhci: Show SD Command when doing debug printks
Date: Thu, 23 Sep 2010 08:49:01 -0700
Message-ID: <7F73D3B4-C432-4DFB-83F2-56239B902A9C@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
 <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
 <4B9DEAE2.3030707@nokia.com>
 <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com>
 <4BA72971.1070804@nokia.com>
 <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com>
 <4BB052F6.5080808@nokia.com>
 <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com>
 <20100920061459.GA9353@pengutronix.de>
 <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com>
 <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com>
 <55175F2E-72DD-4BB2-8EDD-70D8B553F7B6@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:39675 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab0IWPtE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 11:49:04 -0400
Received: from SC-OWA01.marvell.com (sc-owa01.marvell.com [10.93.76.21]) by dakia3.marvell.com with ESMTP id XNlIIzRvXWIGWREK (version=TLSv1 cipher=RC4-MD5 bits=128 verify=NO) for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 08:49:03 -0700 (PDT)
In-Reply-To: <55175F2E-72DD-4BB2-8EDD-70D8B553F7B6@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


>From 8502f5450c8d97d5a096269c44196684e7e0957d Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Thu, 23 Sep 2010 08:45:38 -0700
Subject: [PATCH] sdhci: Show SD Command when doing debug printks

helps to know if read or write to understand error
Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ba8f9a0..fa57fb1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -80,6 +80,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Max curr: 0x%08x\n",
 		sdhci_readl(host, SDHCI_CAPABILITIES),
 		sdhci_readl(host, SDHCI_MAX_CURRENT));
+	printk(KERN_DEBUG DRIVER_NAME ": Command:  0x%08x\n",
+		sdhci_readw(host, SDHCI_COMMAND));
 
 	if (host->flags & SDHCI_USE_ADMA)
 		printk(KERN_DEBUG DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
-- 
1.6.0.4

