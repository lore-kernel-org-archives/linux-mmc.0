From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH] MMC: fix mmc_pm_notify bus_ops->remove deadlock.
Date: Mon,  4 Apr 2011 09:00:44 -0500
Message-ID: <1301925644-9274-1-git-send-email-andreiw@motorola.com>
References: <alpine.DEB.2.00.1104041407340.2513@localhost6.localdomain6>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:60129 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab1DDNUl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 09:20:41 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p34DIwEv027056
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 09:18:58 -0400 (EDT)
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com [209.85.218.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p34DIwqN027045
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 09:18:58 -0400 (EDT)
Received: by yib12 with SMTP id 12so3189436yib.15
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 06:20:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104041407340.2513@localhost6.localdomain6>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

This resolves the deadlock issue with suspend. There is no
need to claim host before the remove op.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/core/core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 85ef72c..87c4af7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1823,11 +1823,10 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 		if (!host->bus_ops || host->bus_ops->suspend)
 			break;
 
-		mmc_claim_host(host);
-
 		if (host->bus_ops->remove)
 			host->bus_ops->remove(host);
 
+		mmc_claim_host(host);
 		mmc_detach_bus(host);
 		mmc_release_host(host);
 		host->pm_flags = 0;
-- 
1.7.0.4

