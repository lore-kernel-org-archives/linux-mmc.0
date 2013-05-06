From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 21/22] mmc: tmio_mmc: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 15:39:27 +0900
Message-ID: <006001ce4a24$74cbe280$5e63a780$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13622 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab3EFGj3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:39:29 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD009TI6HLZAI0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:39:28 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, 'Ian Molton' <ian@mnementh.co.uk>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/tmio_mmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 139212e..8860d4d 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -112,8 +112,6 @@ static int tmio_mmc_remove(struct platform_device *pdev)
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	if (mmc) {
 		struct tmio_mmc_host *host = mmc_priv(mmc);
 		free_irq(platform_get_irq(pdev, 0), host);
-- 
1.7.2.5


