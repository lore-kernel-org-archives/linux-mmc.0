From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 03/11] mmc: sdhci-of-arasan: Replace deprecated clk API
 calls
Date: Mon,  1 Jul 2019 10:59:43 +0530
Message-ID: <1561958991-21935-4-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com, christoph.muellner@theobroma-systems.com, philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org, scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk, tony.xie@rock-chips.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com, olof@lixom.net
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The clk framework APIs devm_clk_register and of_clk_add_provider, which
are used here, are deprecated. Replace the calls with the new API calls.
Also add an API call devm_clk_get() to get the clock from DT.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b12abf9..d60a2e8 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -641,14 +641,25 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 	sdcardclk_init.ops = &arasan_sdcardclk_ops;
 
 	sdhci_arasan->sdcardclk_hw.init = &sdcardclk_init;
-	sdhci_arasan->sdcardclk =
-		devm_clk_register(dev, &sdhci_arasan->sdcardclk_hw);
+	ret = devm_clk_hw_register(dev, &sdhci_arasan->sdcardclk_hw);
+	if (ret) {
+		dev_err(dev, "Failed to register SD clk_hw\n");
+		return ret;
+	}
 	sdhci_arasan->sdcardclk_hw.init = NULL;
 
-	ret = of_clk_add_provider(np, of_clk_src_simple_get,
-				  sdhci_arasan->sdcardclk);
-	if (ret)
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get,
+				     &sdhci_arasan->sdcardclk_hw);
+	if (ret) {
 		dev_err(dev, "Failed to add clock provider\n");
+		return ret;
+	}
+
+	sdhci_arasan->sdcardclk = devm_clk_get(dev, "clk_sdcard");
+	if (IS_ERR(sdhci_arasan->sdcardclk)) {
+		dev_err(dev, "sdcardclk clock not found.\n");
+		ret = PTR_ERR(sdhci_arasan->sdcardclk);
+	}
 
 	return ret;
 }
-- 
2.1.1
