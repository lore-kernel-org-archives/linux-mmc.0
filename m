From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 03/11] mmc: dw_mmc: catch all errors when getting regulators
Date: Sat, 14 Oct 2017 21:17:11 +0200
Message-ID: <20171014191719.2129-4-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 45289c5e0295d2..20d66f8189090d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2741,7 +2741,7 @@ static int dw_mci_init_slot(struct dw_mci *host)
 
 	/*if there are external regulators, get them*/
 	ret = mmc_regulator_get_supply(mmc);
-	if (ret == -EPROBE_DEFER)
+	if (ret)
 		goto err_host_allocated;
 
 	if (!mmc->ocr_avail)
-- 
2.11.0
