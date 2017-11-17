From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/6] mmc: s3cmci: Fix platform_get_irq's error checking
Date: Sat, 18 Nov 2017 01:58:18 +0530
Message-ID: <1510950502-22565-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33674 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761003AbdKQU2l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Nov 2017 15:28:41 -0500
In-Reply-To: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, carlo@caione.org, khilman@baylibre.com, ben-linux@fluff.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/s3cmci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f7f157a..cc801bc 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1658,9 +1658,9 @@ static int s3cmci_probe(struct platform_device *pdev)
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq == 0) {
+	if (host->irq < 0) {
 		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
-		ret = -EINVAL;
+		ret = host->irq;
 		goto probe_iounmap;
 	}
 
-- 
2.7.4

