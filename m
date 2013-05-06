From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 06/22] mmc: dw_mmc: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 15:16:09 +0900
Message-ID: <005101ce4a21$336eaaf0$9a4c00d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54186 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab3EFGQM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:16:12 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD00CAI5EMVQN0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:16:10 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 41c27b7..37873f1 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -72,7 +72,6 @@ static int dw_mci_pltfm_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	dw_mci_remove(host);
 	return 0;
 }
-- 
1.7.2.5


