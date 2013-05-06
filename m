From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 10/22] mmc: mxs-mmc: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 15:22:51 +0900
Message-ID: <005501ce4a22$2377cb80$6a676280$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53886 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab3EFGWy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:22:54 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD004OZ5Q4HSQ0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:22:53 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Marc Kleine-Budde' <mkl@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/mxs-mmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 4278a17..d38f0da 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -708,8 +708,6 @@ static int mxs_mmc_remove(struct platform_device *pdev)
 
 	mmc_remove_host(mmc);
 
-	platform_set_drvdata(pdev, NULL);
-
 	if (ssp->dmach)
 		dma_release_channel(ssp->dmach);
 
-- 
1.7.2.5


