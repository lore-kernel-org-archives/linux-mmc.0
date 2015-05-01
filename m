From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 4/6] mmc: s3cmci: Constify platform_device_id
Date: Sat,  2 May 2015 00:49:20 +0900
Message-ID: <1430495362-31506-4-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34629 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbbEAPv1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2015 11:51:27 -0400
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mmc/host/s3cmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 94cddf381ba3..6291d5042ef2 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1856,7 +1856,7 @@ static int s3cmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id s3cmci_driver_ids[] = {
+static const struct platform_device_id s3cmci_driver_ids[] = {
 	{
 		.name	= "s3c2410-sdi",
 		.driver_data	= 0,
-- 
2.1.4

