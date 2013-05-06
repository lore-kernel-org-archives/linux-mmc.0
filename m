From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 14/22] mmc: rtsx_pci_sdmmc: remove unnecessary
 platform_set_drvdata()
Date: Mon, 06 May 2013 15:50:19 +0900
Message-ID: <007901ce4a25$f91ac690$eb5053b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16012 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3EFGuV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:50:21 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD003R96ZKFZP0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:50:19 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Wei WANG' <wei_wang@realsil.com.cn>, 'Roger Tseng' <rogerable@realtek.com>, Jingoo Han <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index ad13f42..82a35b9 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1316,8 +1316,6 @@ static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	mmc_remove_host(mmc);
 	mmc_free_host(mmc);
 
-	platform_set_drvdata(pdev, NULL);
-
 	dev_dbg(&(pdev->dev),
 		": Realtek PCI-E SDMMC controller has been removed\n");
 
-- 
1.7.2.5


