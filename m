From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 03/10 v3] mmc: add two capability flags for CD and WP signal
 polarity
Date: Fri, 25 May 2012 17:15:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251357540.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52728 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab2EYPQC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:16:02 -0400
In-Reply-To: <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

To handle CD and WP SD/MMC slot pins we need generic flags to specify their
polarity.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mmc/host.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 725413d..1b3a917 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -249,6 +249,8 @@ struct mmc_host {
 #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
 #define MMC_CAP2_DETECT_ON_ERR	(1 << 8)	/* On I/O err check card removal */
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
+#define MMC_CAP2_INVERTED_CD	(1 << 10)	/* Card-detect signal active low */
+#define MMC_CAP2_INVERTED_RO	(1 << 11)	/* Write-protect signal active low */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
-- 
1.7.2.5

