From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: meson-gx-mmc: Fix checking return value of platform_get_irq
Date: Sun,  3 Dec 2017 11:40:07 +0800
Message-ID: <20171203034007.10097-1-axel.lin@ingics.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39918 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdLCDkW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Dec 2017 22:40:22 -0500
Received: by mail-pl0-f65.google.com with SMTP id bi12so8491685plb.6
        for <linux-mmc@vger.kernel.org>; Sat, 02 Dec 2017 19:40:21 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

platform_get_irq() returns negative value on failure.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e0862d3f65b3..11c467b52902 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1208,7 +1208,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
+	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto free_host;
-- 
2.11.0

