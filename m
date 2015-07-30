From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 05/11] mmc: host: omap_hsmmc: set clk rate to the max frequency
Date: Thu, 30 Jul 2015 13:16:28 +0530
Message-ID: <1438242394-25599-6-git-send-email-kishon@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: mugunthanvnm@ti.com, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Set the clock rate of the functional clock to the max frequency
that is passed to the driver either using pdata or dt.

Also remove unnecessary setting of host->fclk to NULL.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e960b5c..0452a8b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2219,7 +2219,12 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
 		ret = PTR_ERR(host->fclk);
-		host->fclk = NULL;
+		goto err1;
+	}
+
+	ret = clk_set_rate(host->fclk, mmc->f_max);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set clock to %d\n", mmc->f_max);
 		goto err1;
 	}
 
-- 
1.7.9.5
