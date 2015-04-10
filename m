From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 3/9] mmc: sdhci-st: Add delay management functions for top
 registers (eMMC).
Date: Fri, 10 Apr 2015 09:58:25 +0100
Message-ID: <1428656311-2605-4-git-send-email-peter.griffin@linaro.org>
References: <1428656311-2605-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1428656311-2605-1-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: peter.griffin@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, lee.jones@linaro.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org

Due to the tight timing constraints in some UHS modes, it is required to have
some delay management in the design. Two types of delay management are supported
in the HW: -

1) Static delay management
2) Dynamic delay management

NB: The delay management is only there when eMMC interface is selected.

1: Static delay management: is used to provide PVT dependent static delay on the
clock/data lines to manage setup/hold requirements of the interface. The maximum
delay possible is 3.25ns. These delays are PVT dependent, and thus delay values
applied are not accurate and vary across provcess voltage and temperature range.
Due to this these delays must not be used on the very time critical paths.

2. Dynamic delay locked loop (DLL): is used to provide dynamic delay management.
The advantage of DLL is that it provides accurate & PVT indepedent delay.

The DLL is used to provide delay on the loopback clock on "Read Path" to capture
read data reliably. On TX path the clock on which output data is transmitted is
delayed, resulting in delay of TX data.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci-st.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index f6f2a48..b5e4df8 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -122,6 +122,65 @@ struct st_mmc_platform_data {
 		 ST_TOP_MMC_DLY_CTRL_ATUNE_NOT_CFG_DLY | \
 		 ST_TOP_MMC_START_DLL_LOCK)
 
+/*
+ * For clock speeds greater than 90MHz, we need to check that the
+ * DLL procedure has finished before switching to ultra-speed modes.
+ */
+#define	CLK_TO_CHECK_DLL_LOCK	90000000
+
+static inline void st_mmcss_set_static_delay(void __iomem *ioaddr)
+{
+	if (!ioaddr)
+		return;
+
+	writel_relaxed(0x0, ioaddr + ST_TOP_MMC_DLY_CTRL);
+	writel_relaxed(ST_TOP_MMC_DLY_MAX,
+			ioaddr + ST_TOP_MMC_TX_CLK_DLY);
+}
+
+static inline void st_mmcss_set_dll(void __iomem *ioaddr)
+{
+	if (!ioaddr)
+		return;
+
+	writel_relaxed(ST_TOP_MMC_DYN_DLY_CONF,	ioaddr + ST_TOP_MMC_DLY_CTRL);
+	writel_relaxed(ST_TOP_MMC_TX_DLL_STEP_DLY_VALID,
+			ioaddr + ST_TOP_MMC_TX_DLL_STEP_DLY);
+}
+
+static int st_mmcss_lock_dll(void __iomem *ioaddr)
+{
+	unsigned long curr, value;
+	unsigned long finish = jiffies + HZ;
+
+	/* Checks if the DLL procedure is finished */
+	do {
+		curr = jiffies;
+		value = readl(ioaddr + ST_MMC_STATUS_R);
+		if (value & 0x1)
+			return 0;
+
+		cpu_relax();
+	} while (!time_after_eq(curr, finish));
+
+	return -EBUSY;
+}
+
+static int sdhci_st_set_dll_for_clock(struct sdhci_host *host)
+{
+	int ret = 0;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+
+	if (host->clock > CLK_TO_CHECK_DLL_LOCK) {
+		st_mmcss_set_dll(pdata->top_ioaddr);
+		ret = st_mmcss_lock_dll(host->ioaddr);
+	}
+
+	return ret;
+}
+
+
 static u32 sdhci_st_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
-- 
1.9.1
