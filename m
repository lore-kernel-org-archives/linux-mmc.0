From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 09/11] mmc: omap_hsmmc: catch all errors when getting regulators
Date: Sat,  7 Oct 2017 12:36:56 +0200
Message-ID: <20171007103658.16868-10-wsa+renesas@sang-engineering.com>
References: <20171007103658.16868-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171007103658.16868-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Bail out everytime when mmc_regulator_get_supply() returns an errno, not only
when probing gets deferred. This is currently a no-op, because this function
only returns -EPROBE_DEFER or 0 right now. But if it will throw another error
somewhen, it will be for a reason. (This still doesn't change that getting
regulators is optional, so 0 can still mean no regulators found). So, let us a)
be future proof and b) have driver code which is easier to understand.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f2a1137be8bc4b..071693ebfe1891 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -445,7 +445,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 
 	ret = mmc_regulator_get_supply(mmc);
-	if (ret == -EPROBE_DEFER)
+	if (ret)
 		return ret;
 
 	/* Allow an aux regulator */
-- 
2.11.0
