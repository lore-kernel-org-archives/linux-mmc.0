From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 11/22] mmc: omap: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 15:24:54 +0900
Message-ID: <005601ce4a22$6c740790$455c16b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54289 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab3EFGZ2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:25:28 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD0017M5TGVX40@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:24:55 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Jarkko Lavinen' <jarkko.lavinen@nokia.com>, 'Venkatraman S' <svenkatr@ti.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/omap.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 4254975..4b3e0eb 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1500,8 +1500,6 @@ static int mmc_omap_remove(struct platform_device *pdev)
 	struct mmc_omap_host *host = platform_get_drvdata(pdev);
 	int i;
 
-	platform_set_drvdata(pdev, NULL);
-
 	BUG_ON(host == NULL);
 
 	for (i = 0; i < host->nr_slots; i++)
-- 
1.7.2.5


