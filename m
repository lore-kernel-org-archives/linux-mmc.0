From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] mmc: aspeed: Fix return value check in
 aspeed_sdc_probe()
Date: Mon, 26 Aug 2019 12:00:13 +0000
Message-ID: <20190826120013.183435-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc: linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

In case of error, the function of_platform_device_create() returns
NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 8bb095ca2fa9..d5acb5afc50f 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -261,9 +261,9 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 		struct platform_device *cpdev;
 
 		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
-		if (IS_ERR(cpdev)) {
+		if (!cpdev) {
 			of_node_put(child);
-			ret = PTR_ERR(cpdev);
+			ret = -ENODEV;
 			goto err_clk;
 		}
 	}
