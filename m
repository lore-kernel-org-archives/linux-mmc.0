From: David Lechner <david@lechnology.com>
Subject: [PATCH v3 2/5] mmc: davinci: remove matching string
Date: Wed, 16 Mar 2016 22:45:32 -0500
Message-ID: <1458186341-6970-3-git-send-email-david@lechnology.com>
References: <1458186341-6970-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458186341-6970-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The string "MMCSDCLK" is not actually used for clock lookup, so can be removed.

Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---

v3 changes: none.

 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index eb3ca9e..498c42d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1241,7 +1241,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		goto out;
 
 	ret = -ENXIO;
-	host->clk = clk_get(&pdev->dev, "MMCSDCLK");
+	host->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		goto out;
-- 
1.9.1
