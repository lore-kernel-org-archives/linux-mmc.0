From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH] MMC: SDHCI Auto-CMD23 fixes.
Date: Wed, 25 May 2011 02:13:43 -0500
Message-ID: <1306307623-8610-1-git-send-email-andreiw@motorola.com>
References: <m3aaeby3xr.fsf@pullcord.laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:40015 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab1EYGke (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 02:40:34 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4P6c9ma012488
	for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 02:38:09 -0400 (EDT)
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com [74.125.83.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4P6XH8d010576
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 02:38:09 -0400 (EDT)
Received: by mail-pv0-f170.google.com with SMTP id 21so632589pvh.15
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2011 23:40:33 -0700 (PDT)
In-Reply-To: <m3aaeby3xr.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

Fixes bugs in Auto-CMD23 feature enable decision. Auto-CMD23
shoud be enabled if host is >= v3, and SDMA is not in use.

USE_ADMA | USE_SDMA | Auto-CMD23
---------+----------+-----------
    0    |    0     |     1
---------+----------+-----------
    0    |    1     |     0
---------+----------+-----------
    1    |    0     |     1
---------+----------+-----------
    1    |    1     |     1

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/host/sdhci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fbb1842..a4e64b0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2498,9 +2498,9 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->flags |= SDHCI_AUTO_CMD12;
 
 	/* Auto-CMD23 stuff only works in ADMA or PIO. */
-	if ((host->version == SDHCI_SPEC_300) &&
+	if ((host->version >= SDHCI_SPEC_300) &&
 	    ((host->flags & SDHCI_USE_ADMA) ||
-	     !(host->flags & SDHCI_REQ_USE_DMA))) {
+	     !(host->flags & SDHCI_USE_SDMA))) {
 		host->flags |= SDHCI_AUTO_CMD23;
 		printk(KERN_INFO "%s: Auto-CMD23 available\n", mmc_hostname(mmc));
 	} else
-- 
1.7.0.4

