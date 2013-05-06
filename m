From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 02/22] mmc: atmel-mci: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 15:06:47 +0900
Message-ID: <004d01ce4a1f$e452db40$acf891c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51019 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab3EFGHK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:07:10 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD004YI4Z8HSP0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:06:47 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Ludovic Desroches' <ludovic.desroches@atmel.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/atmel-mci.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e75774f..70fa449 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2476,8 +2476,6 @@ static int __exit atmci_remove(struct platform_device *pdev)
 	struct atmel_mci	*host = platform_get_drvdata(pdev);
 	unsigned int		i;
 
-	platform_set_drvdata(pdev, NULL);
-
 	if (host->buffer)
 		dma_free_coherent(&pdev->dev, host->buf_size,
 		                  host->buffer, host->buf_phys_addr);
-- 
1.7.2.5


