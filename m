From: Helmut Grohne <h.grohne@intenta.de>
Subject: [PATCH v3 2/2] mmc: sdhci-of-arasan: Add quirk for unstable clocks
Date: Wed, 20 Jun 2018 13:33:00 +0200
Message-ID: <6a5d5fcb0495e7d9e789af9c4b192739fe31f24a.1529493667.git.h.grohne@intenta.de>
References: <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
 <cover.1529493667.git.h.grohne@intenta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1529493667.git.h.grohne@intenta.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: Atul Garg <agarg@arasan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Some controllers immediately report SDHCI_CLOCK_INT_STABLE after
enabling the clock even when the clock is not stable. When used in
conjunction with older/slower cards, this can result in:

    mmc0: error -84 whilst initialising SD card

When the stable reporting is known to be broken, we simply wait for the
maximum stabilization period.

Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index e3332a522a5d..a40bcc27f187 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -102,6 +102,9 @@ struct sdhci_arasan_data {
 
 /* Controller does not have CD wired and will not function normally without */
 #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST	BIT(0)
+/* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
+ * internal clock even when the clock isn't stable */
+#define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
 };
 
 static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
@@ -207,6 +210,16 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_set_clock(host, clock);
 
+	if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE)
+		/*
+		 * Some controllers immediately report SDHCI_CLOCK_INT_STABLE
+		 * after enabling the clock even though the clock is not
+		 * stable. Trying to use a clock without waiting here results
+		 * in EILSEQ while detecting some older/slower cards. The
+		 * chosen delay is the maximum delay from sdhci_set_clock.
+		 */
+		msleep(20);
+
 	if (ctrl_phy) {
 		phy_power_on(sdhci_arasan->phy);
 		sdhci_arasan->is_phy_on = true;
@@ -758,6 +771,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
 		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
 
+	if (of_property_read_bool(np, "xlnx,int-clock-stable-broken"))
+		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE;
+
 	pltfm_host->clk = clk_xin;
 
 	if (of_device_is_compatible(pdev->dev.of_node,
-- 
2.11.0
