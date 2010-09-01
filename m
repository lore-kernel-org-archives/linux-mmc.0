From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 6/9] esdhc-2 mxc: Modify the MSL codes when upstreaming fsl
	esdhc driver
Date: Wed, 1 Sep 2010 17:48:26 +0800
Message-ID: <1283334506-12721-1-git-send-email-r65037@freescale.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Richard Zhu <r65037@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Modify the plat-mxc related MSL codes.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |   31 ++++++++++++++------------
 arch/arm/plat-mxc/include/mach/mmc.h        |    9 +++++++
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 21bfa46..325b78b 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -45,6 +45,9 @@ typedef enum iomux_config {
 				PAD_CTL_PKE | PAD_CTL_HYS)
 #define MX51_GPIO_PAD_CTRL		(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
 				PAD_CTL_SRE_FAST)
+#define MX51_SDHCI_PAD_CTRL 	PAD_CTL_DSE_HIGH | PAD_CTL_PUS_47K_UP | \
+				PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_SRE_FAST | \
+				PAD_CTL_DVS
 
 /*
  * The naming convention for the pad modes is MX51_PAD_<padname>__<padmode>
@@ -294,20 +297,20 @@ typedef enum iomux_config {
 #define MX51_PAD_DISP2_DAT13__DISP2_DAT13       IOMUX_PAD(0x790, 0x388, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP2_DAT14__DISP2_DAT14       IOMUX_PAD(0x794, 0x38C, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP2_DAT15__DISP2_DAT15       IOMUX_PAD(0x798, 0x390, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_CMD__SD1_CMD               IOMUX_PAD(0x79C, 0x394, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_CLK__SD1_CLK               IOMUX_PAD(0x7A0, 0x398, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA0__SD1_DATA0           IOMUX_PAD(0x7A4, 0x39C, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA1__SD1_DATA1           IOMUX_PAD(0x7A8, 0x3A0, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA2__SD1_DATA2           IOMUX_PAD(0x7AC, 0x3A4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA3__SD1_DATA3           IOMUX_PAD(0x7B0, 0x3A8, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_CMD__SD1_CMD	IOMUX_PAD(0x79C, 0x394, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_CLK__SD1_CLK	IOMUX_PAD(0x7A0, 0x398, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL | PAD_CTL_HYS)
+#define MX51_PAD_SD1_DATA0__SD1_DATA0	IOMUX_PAD(0x7A4, 0x39C, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_DATA1__SD1_DATA1	IOMUX_PAD(0x7A8, 0x3A0, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_DATA2__SD1_DATA2	IOMUX_PAD(0x7AC, 0x3A4, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_DATA3__SD1_DATA3	IOMUX_PAD(0x7B0, 0x3A8, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_0__GPIO_1_0		IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, 1, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_CMD__SD2_CMD               IOMUX_PAD(0x7BC, 0x3B4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_CLK__SD2_CLK               IOMUX_PAD(0x7C0, 0x3B8, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA0__SD2_DATA0           IOMUX_PAD(0x7C4, 0x3BC, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA1__SD2_DATA1           IOMUX_PAD(0x7C8, 0x3C0, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA2__SD2_DATA2           IOMUX_PAD(0x7CC, 0x3C4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA3__SD2_DATA3           IOMUX_PAD(0x7D0, 0x3C8, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_1__GPIO_1_1	IOMUX_PAD(0x7B8, 0x3B0, IOMUX_CONFIG_GPIO, 0x0, 0, MX51_GPIO_PAD_CTRL)
+#define MX51_PAD_SD2_CMD__SD2_CMD	IOMUX_PAD(0x7BC, 0x3B4, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_CLK__SD2_CLK	IOMUX_PAD(0x7C0, 0x3B8, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL | PAD_CTL_HYS)
+#define MX51_PAD_SD2_DATA0__SD2_DATA0	IOMUX_PAD(0x7C4, 0x3BC, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA1__SD2_DATA1	IOMUX_PAD(0x7C8, 0x3C0, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA2__SD2_DATA2	IOMUX_PAD(0x7CC, 0x3C4, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA3__SD2_DATA3	IOMUX_PAD(0x7D0, 0x3C8, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__I2C2_SCL		IOMUX_PAD(0x7D4, 0x3CC, (2 | IOMUX_CONFIG_SION), \
 							0x9b8,   3, MX51_I2C_PAD_CTRL)
@@ -316,7 +319,7 @@ typedef enum iomux_config {
 							0x9bc,   3, MX51_I2C_PAD_CTRL)
 #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, IOMUX_CONFIG_GPIO, 0x0, 0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   1, MX51_GPIO_PAD_CTRL)
diff --git a/arch/arm/plat-mxc/include/mach/mmc.h b/arch/arm/plat-mxc/include/mach/mmc.h
index 29115f4..19badbe 100644
--- a/arch/arm/plat-mxc/include/mach/mmc.h
+++ b/arch/arm/plat-mxc/include/mach/mmc.h
@@ -34,6 +34,15 @@ struct imxmmc_platform_data {
 
 	/* enable card detect using DAT3 */
 	int dat3_card_detect;
+
+	/* Bus width capabilities, DDR mode and so on*/
+	unsigned int caps;
+	/* Min clk frequency the eSDHC can be supported */
+	unsigned int min_clk;
+	/* Max clk frequency the eSDHC can be supported */
+	unsigned int max_clk;
+	/* Write protected or not, 1:protected.*/
+	int (*wp_status) (struct device *);
 };
 
 #endif
-- 
1.7.0
