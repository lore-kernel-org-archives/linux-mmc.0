From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 08/16] mmc: mmci: Enable module alias autogeneration for AMBA drivers
Date: Wed,  5 Oct 2011 17:04:59 +0100
Message-ID: <1317830707-17517-9-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54987 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934499Ab1JEQFs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 12:05:48 -0400
Received: by wyg34 with SMTP id 34so1862228wyg.19
        for <linux-mmc@vger.kernel.org>; Wed, 05 Oct 2011 09:05:47 -0700 (PDT)
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, =?UTF-8?q?Pawe=C5=82=20Moll?= <Pawel.Moll@arm.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/mmc/host/mmci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b16ea4a..a7d398c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1496,6 +1496,8 @@ static struct amba_id mmci_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, mmci_ids);
+
 static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
-- 
1.7.4.1

