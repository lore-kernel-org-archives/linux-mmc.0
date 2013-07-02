From: Barry Song <Baohua.Song@csr.com>
Subject: [PATCH] sdhci:sirf:drop SDHCI_QUIRK_INVERTED_WRITE_PROTECT as only
 sd0 has inverted_wp
Date: Tue, 2 Jul 2013 10:42:46 +0800
Message-ID: <1372732966-9464-1-git-send-email-Baohua.Song@csr.com>
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
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Bin Shi <Bin.Shi@csr.com>, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-mmc@vger.kernel.org

From: Bin Shi <Bin.Shi@csr.com>

only sd0 has the issue that WP is inverted, so we drop the global set of
SDHCI_QUIRK_INVERTED_WRITE_PROTECT and only enable the "wp-inverted" prop
for sd0 in dts.

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 1 +
 arch/arm/boot/dts/prima2.dtsi | 1 +
 drivers/mmc/host/sdhci-sirf.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 7d1a279..d928b11 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -561,6 +561,7 @@
 					interrupts = <38>;
 					bus-width = <8>;
 					clocks = <&clks 36>;
+					wp-inverted;
 				};
 
 				sd1: sdhci@56100000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 3329719..36cb064 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -557,6 +557,7 @@
 					compatible = "sirf,prima2-sdhc";
 					reg = <0x56000000 0x100000>;
 					interrupts = <38>;
+					wp-inverted;
 				};
 
 				sd1: sdhci@56100000 {
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 62a4a83..38e69f7 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -36,7 +36,6 @@ static struct sdhci_pltfm_data sdhci_sirf_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
-		SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		SDHCI_QUIRK_DELAY_AFTER_POWER,
 };
 
@@ -70,6 +69,7 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 	priv->gpio_cd = gpio_cd;
 
 	sdhci_get_of_property(pdev);
+	mmc_of_parse(host->mmc);
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
