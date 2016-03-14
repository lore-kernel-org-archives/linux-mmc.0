From: David Lechner <david@lechnology.com>
Subject: [PATCH v2 1/5] mmc: davinci: remove matching string
Date: Mon, 14 Mar 2016 17:54:37 -0500
Message-ID: <1457996081-21975-2-git-send-email-david@lechnology.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:59490 "EHLO vern.gendns.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbcCNW41 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Mar 2016 18:56:27 -0400
In-Reply-To: <1457996081-21975-1-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: nsekhar@ti.com
Cc: khilman@kernel.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, David Lechner <david@lechnology.com>

The string "MMCSDCLK" is not actually used for clock lookup, so can be removed.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: none


 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 693144e..a294d261 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1271,7 +1271,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		goto out;
 
 	ret = -ENXIO;
-	host->clk = clk_get(&pdev->dev, "MMCSDCLK");
+	host->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		goto out;
-- 
1.9.1

