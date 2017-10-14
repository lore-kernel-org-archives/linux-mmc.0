From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 06/11] mmc: mmci: catch all errors when getting regulators
Date: Sat, 14 Oct 2017 21:17:14 +0200
Message-ID: <20171014191719.2129-7-wsa+renesas@sang-engineering.com>
References: <20171014191719.2129-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171014191719.2129-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Bail out everytime when mmc_regulator_get_supply() returns an errno, not
only when probing gets deferred. This is currently a no-op, because this
function only returns -EPROBE_DEFER or 0 right now. But if it will throw
another error somewhen, it will be for a reason. (This still doesn't change
that getting regulators is optional, so 0 can still mean no regulators
found). So, let us a) be future proof and b) have driver code which is
easier to understand.

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
