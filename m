From: Markus Niebel <list-09_linux_arm@tqsc.de>
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: implement DSR support
Date: Wed, 16 Jul 2014 16:19:49 +0200
Message-ID: <1405520389-32649-3-git-send-email-list-09_linux_arm@tqsc.de>
References: <1405520389-32649-1-git-send-email-list-09_linux_arm@tqsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405520389-32649-1-git-send-email-list-09_linux_arm@tqsc.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Markus Niebel <Markus.Niebel@tq-group.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

From: Markus Niebel <Markus.Niebel@tq-group.com>

nor that we have DSR support implement the configuration
side for i.MX SDHCI controller

Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          |   15 +++++++++++++++
 include/linux/platform_data/mmc-esdhc-imx.h |    4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ccec0e3..7db39d8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -942,6 +942,16 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
 
+	if (of_find_property(np, "dsr", NULL)) {
+		u32 tmp;
+
+		of_property_read_u32(np, "dsr", &tmp);
+		boarddata->dsr_req = true;
+		boarddata->dsr = (u16)tmp;
+	} else {
+		boarddata->dsr_req = true;
+	}
+
 	return 0;
 }
 #else
@@ -1119,6 +1129,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
 
+	if (boarddata->dsr_req) {
+		host->mmc->dsr_req = 1;
+		host->mmc->dsr = boarddata->dsr;
+	}
+
 	err = sdhci_add_host(host);
 	if (err)
 		goto disable_clk;
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index 75f70f6..8b88a40 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -35,6 +35,8 @@ enum cd_types {
  * @wp_type:	type of write_protect method (see wp_types enum above)
  * @cd_type:	type of card_detect method (see cd_types enum above)
  * @support_vsel:  indicate it supports 1.8v switching
+ * @dsr_req:	indicate DSR is requested
+ * @dsr:	requested driver stage setting
  */
 
 struct esdhc_platform_data {
@@ -46,5 +48,7 @@ struct esdhc_platform_data {
 	unsigned int f_max;
 	bool support_vsel;
 	unsigned int delay_line;
+	bool dsr_req;
+	u16 dsr;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
1.7.9.5
