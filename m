From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 06/11] mmc: mmci: catch all errors when getting regulators
Date: Sat,  7 Oct 2017 12:36:53 +0200
Message-ID: <20171007103658.16868-7-wsa+renesas@sang-engineering.com>
References: <20171007103658.16868-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46649 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752845AbdJGKhK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 7 Oct 2017 06:37:10 -0400
In-Reply-To: <20171007103658.16868-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Bail out everytime when mmc_regulator_get_supply() returns an errno, not only
when probing gets deferred. This is currently a no-op, because this function
only returns -EPROBE_DEFER or 0 right now. But if it will throw another error
somewhen, it will be for a reason. (This still doesn't change that getting
regulators is optional, so 0 can still mean no regulators found). So, let us a)
be future proof and b) have driver code which is easier to understand.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f1f54a81848951..e8a1bb1ae69423 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1658,7 +1658,7 @@ static int mmci_probe(struct amba_device *dev,
 
 	/* Get regulators and the supported OCR mask */
 	ret = mmc_regulator_get_supply(mmc);
-	if (ret == -EPROBE_DEFER)
+	if (ret)
 		goto clk_disable;
 
 	if (!mmc->ocr_avail)
-- 
2.11.0

