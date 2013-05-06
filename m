From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 19/22] mmc: sdhci-spear: remove unnecessary
 platform_set_drvdata()
Date: Mon, 06 May 2013 15:37:15 +0900
Message-ID: <005e01ce4a24$261f8100$725e8300$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13189 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab3EFGhR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:37:17 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD004K06DXK2M0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:37:16 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Viresh Kumar <viresh.linux@gmail.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/sdhci-spear.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 7ae5b3a..2dba9f8 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -258,7 +258,6 @@ static int sdhci_probe(struct platform_device *pdev)
 	return 0;
 
 set_drvdata:
-	platform_set_drvdata(pdev, NULL);
 	sdhci_remove_host(host, 1);
 free_host:
 	sdhci_free_host(host);
@@ -278,7 +277,6 @@ static int sdhci_remove(struct platform_device *pdev)
 	int dead = 0;
 	u32 scratch;
 
-	platform_set_drvdata(pdev, NULL);
 	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
 	if (scratch == (u32)-1)
 		dead = 1;
-- 
1.7.2.5


