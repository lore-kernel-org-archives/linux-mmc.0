From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH] mmc: sunxi: drop superfluous error message
Date: Sun,  8 Oct 2017 16:50:08 +0200
Message-ID: <20171008145009.17550-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

This error message can go because a) currently nothing else than
EPROBE_DEFER is returned and b) if this is going to change a much more
detailed error message should come from mmc_regulator_get_supply()
anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

While I think this patch is correct as is (because of this discussion [1]), I
still wonder about the intention of the now removed message. Because a not
supplied vmmc is not determined by the return value of *_get_supply(), but by a
check if mmc->supply.vmmc is populated afterwards. So, if this was the original
intention such a check would need to be implemented on top of this patch.

[1] https://patchwork.kernel.org/patch/9965823/

 drivers/mmc/host/sunxi-mmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 53c970fe087397..cc98355dbdb9cc 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1175,11 +1175,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return -EINVAL;
 
 	ret = mmc_regulator_get_supply(host->mmc);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get vmmc supply\n");
+	if (ret)
 		return ret;
-	}
 
 	host->reg_base = devm_ioremap_resource(&pdev->dev,
 			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
-- 
2.11.0
