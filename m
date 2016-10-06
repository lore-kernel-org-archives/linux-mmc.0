From: Aaron Brice <aaron.brice@datasoft.com>
Subject: [PATCH] sdhci-esdhc-imx: Correct two register accesses
Date: Thu,  6 Oct 2016 15:54:17 -0700
Message-ID: <1475794457-17993-1-git-send-email-aaron.brice@datasoft.com>
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
To: david.russell@datasoft.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

 - The DMA error interrupt bit is in a different position as
   compared to the sdhci standard.  This is accounted for in
   many cases, but not handled in the case of clearing the
   INT_STATUS register by writing a 1 to that location.
 - The HOST_CONTROL register is very different as compared to
   the sdhci standard.  This is accounted for in the write
   case, but not when read back out (which it is in the sdhci
   code).

Signed-off-by: Dave Russell <david.russell@datasoft.com>
Signed-off-by: Aaron Brice <aaron.brice@datasoft.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1f54fd8..d61ef16 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -346,7 +346,8 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 data;
 
-	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
+	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE ||
+			reg == SDHCI_INT_STATUS)) {
 		if ((val & SDHCI_INT_CARD_INT) && !esdhc_is_usdhc(imx_data)) {
 			/*
 			 * Clear and then set D3CD bit to avoid missing the
@@ -555,6 +556,25 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 	esdhc_clrset_le(host, 0xffff, val, reg);
 }
 
+static u8 esdhc_readb_le(struct sdhci_host *host, int reg)
+{
+	u8 ret;
+	u32 long_val;
+
+	switch (reg) {
+	case SDHCI_HOST_CONTROL:
+		long_val = readl(host->ioaddr + reg);
+
+		ret = long_val & SDHCI_CTRL_LED;
+		ret |= (long_val >> 5) & SDHCI_CTRL_DMA_MASK;
+		ret |= (long_val & ESDHC_CTRL_4BITBUS);
+		ret |= (long_val & ESDHC_CTRL_8BITBUS) << 3;
+		return ret;
+	}
+
+	return readb(host->ioaddr + reg);
+}
+
 static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -947,6 +967,7 @@ static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
+	.read_b = esdhc_readb_le,
 	.write_l = esdhc_writel_le,
 	.write_w = esdhc_writew_le,
 	.write_b = esdhc_writeb_le,
-- 
2.7.4
