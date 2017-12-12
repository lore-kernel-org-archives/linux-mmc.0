From: Flavio Ceolin <flavio.ceolin@intel.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Disable clk_xin clock in the remove
Date: Tue, 12 Dec 2017 00:19:55 -0800
Message-ID: <20171212081955.2309-1-flavio.ceolin@intel.com>
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
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "open list:SECURE DIGITAL HOST CONTROLLER INTERFACE SDHCI..." <linux-mmc@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, Adrian Hunter <adrian.hunter@intel.com>, Flavio Ceolin <flavio.ceolin@intel.com>, "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

clk_xin is properly prepared/enabled on sdhci_arasan_probe(), and
unprepared/disabled in the error path, but it is not being
unprepared/disabled on sdhci_arasan_remove().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Flavio Ceolin <flavio.ceolin@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 0720ea7..69bd260 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -692,6 +692,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	struct clk *clk_ahb = sdhci_arasan->clk_ahb;
+	struct clk *clk_xin = devm_clk_get(&pdev->dev, "clk_xin");
 
 	if (!IS_ERR(sdhci_arasan->phy)) {
 		if (sdhci_arasan->is_phy_on)
@@ -705,6 +706,9 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(clk_ahb);
 
+	if (!IS_ERR(clk_xin))
+		clk_disable_unprepare(clk_xin);
+
 	return ret;
 }
 
-- 
2.9.5
