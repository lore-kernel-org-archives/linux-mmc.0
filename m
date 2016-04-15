From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 18/23] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 STD_TUNING
Date: Sat, 16 Apr 2016 01:29:42 +0800
Message-ID: <1460741387-23815-19-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: aisheng.dong@nxp.com, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Enable HW auto retuning when set SDHCI_CTRL_EXEC_TUNING and clear it
when clear SDHCI_CTRL_TUNED_CLK.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 9f9be3f..a582a83 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -44,6 +44,7 @@
 #define  ESDHC_MIX_CTRL_AC23EN		(1 << 7)
 #define  ESDHC_MIX_CTRL_EXE_TUNE	(1 << 22)
 #define  ESDHC_MIX_CTRL_SMPCLK_SEL	(1 << 23)
+#define  ESDHC_MIX_CTRL_AUTO_TUNE_EN	(1 << 24)
 #define  ESDHC_MIX_CTRL_FBCLK_SEL	(1 << 25)
 #define  ESDHC_MIX_CTRL_HS400_EN	(1 << 26)
 /* Bits 3 and 6 are not SDHCI standard definitions */
@@ -484,11 +485,13 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			} else {
 				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
 				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
+				m &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 			}
 
 			if (val & SDHCI_CTRL_EXEC_TUNING) {
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
+				m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 				tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
 				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP_DEFAULT;
 				if (imx_data->boarddata.tuning_start_tap) {
-- 
1.9.1
