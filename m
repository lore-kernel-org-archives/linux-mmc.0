From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 22/22] mmc: wmt-sdmmc: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 15:40:28 +0900
Message-ID: <006101ce4a24$98be27c0$ca3a7740$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58935 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab3EFGk3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:40:29 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD0009U6HQVCH0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:40:28 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Tony Prisk <linux@prisktech.co.nz>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/wmt-sdmmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 442f576..34231d5 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -927,8 +927,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 
 	mmc_free_host(mmc);
 
-	platform_set_drvdata(pdev, NULL);
-
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
 
 	return 0;
-- 
1.7.2.5


