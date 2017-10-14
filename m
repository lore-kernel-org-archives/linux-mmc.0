From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 08/11] mmc: mxcmmc: catch all errors when getting regulators
Date: Sat, 14 Oct 2017 21:17:16 +0200
Message-ID: <20171014191719.2129-9-wsa+renesas@sang-engineering.com>
References: <20171014191719.2129-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44323 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbdJNTRl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 14 Oct 2017 15:17:41 -0400
In-Reply-To: <20171014191719.2129-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Bail out everytime when mmc_regulator_get_supply() returns an errno, not
only when probing gets deferred. This is currently a no-op, because this
function only returns -EPROBE_DEFER or 0 right now. But if it will throw
another error somewhen, it will be for a reason. (This still doesn't change
that getting regulators is optional, so 0 can still mean no regulators
found). So, let us a) be future proof and b) have driver code which is
easier to understand.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/mxcmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 328484b96620e8..8bd9f060be2ae0 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1075,7 +1075,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 		dat3_card_detect = true;
 
 	ret = mmc_regulator_get_supply(mmc);
-	if (ret == -EPROBE_DEFER)
+	if (ret)
 		goto out_free;
 
 	if (!mmc->ocr_avail) {
-- 
2.11.0

