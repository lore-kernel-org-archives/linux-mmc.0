From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 01/14] mmc: mmci: Support MMC_PM_KEEP_POWER
Date: Mon, 5 Dec 2011 18:35:47 +0100
Message-ID: <1323106560-5218-2-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:42328 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932574Ab1LERgR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 12:36:17 -0500
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Add MMC_PM_KEEP_POWER to pm_caps so SDIO clients are able
to use this option to prevent power off in suspend.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 50b5f99..1ac04a2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1240,6 +1240,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		mmc->ocr_avail = plat->ocr_mask;
 	mmc->caps = plat->capabilities;
 
+	/* We support these PM capabilities. */
+	mmc->pm_caps = MMC_PM_KEEP_POWER;
+
 	/*
 	 * We can do SGIO
 	 */
-- 
1.7.5.4

