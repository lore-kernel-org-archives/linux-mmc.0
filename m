From: David Lechner <david@lechnology.com>
Subject: [PATCH] mmc: davinci: suppress error message on EPROBE_DEFER
Date: Sun, 21 Jan 2018 14:28:13 -0600
Message-ID: <1516566493-31348-1-git-send-email-david@lechnology.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:37517 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeAUU22 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 21 Jan 2018 15:28:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

This suppresses printing an error message during probe of the TI DaVinci
MMC driver when the error is EPROBE_DEFER.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/mmc/host/davinci_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index c5309cc..8e36317 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1253,8 +1253,9 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 		pdev->id_entry = match->data;
 		ret = mmc_of_parse(mmc);
 		if (ret) {
-			dev_err(&pdev->dev,
-				"could not parse of data: %d\n", ret);
+			if (ret != -EPROBE_DEFER)
+				dev_err(&pdev->dev,
+					"could not parse of data: %d\n", ret);
 			goto parse_fail;
 		}
 	} else {
-- 
2.7.4

