From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 02/11] mmc: cavium: catch all errors when getting regulators
Date: Sat, 14 Oct 2017 21:17:10 +0200
Message-ID: <20171014191719.2129-3-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/host/cavium.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index fbd29f00fca05e..ed5cefb8376838 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -967,7 +967,7 @@ static int cvm_mmc_of_parse(struct device *dev, struct cvm_mmc_slot *slot)
 	}
 
 	ret = mmc_regulator_get_supply(mmc);
-	if (ret == -EPROBE_DEFER)
+	if (ret)
 		return ret;
 	/*
 	 * Legacy Octeon firmware has no regulator entry, fall-back to
-- 
2.11.0
