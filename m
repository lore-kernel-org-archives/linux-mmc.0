From: Peter Senna Tschudin <peter.senna@gmail.com>
Subject: [PATCH 3/4] drivers/mmc/host/omap_hsmmc.c: fix error return code
Date: Mon, 17 Sep 2012 10:15:27 +0200
Message-ID: <1347869728-2696-3-git-send-email-peter.senna@gmail.com>
References: <1347869728-2696-1-git-send-email-peter.senna@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347869728-2696-1-git-send-email-peter.senna@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: svenkatr@ti.com
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Peter Senna Tschudin <peter.senna@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Peter Senna Tschudin <peter.senna@gmail.com>

Convert a nonnegative error return code to a negative one, as returned
elsewhere in the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e59ac62..c8a2b36 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1893,6 +1893,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 		if (pdata->init(&pdev->dev) != 0) {
 			dev_dbg(mmc_dev(host->mmc),
 				"Unable to configure MMC IRQs\n");
+			ret = -ENXIO;
 			goto err_irq_cd_init;
 		}
 	}
-- 
1.7.11.4
