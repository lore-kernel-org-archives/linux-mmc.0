From: <micky_ching@realsil.com.cn>
Subject: [PATCH 12/12] mmc: sdhci: add SD4.0 support
Date: Wed, 29 Apr 2015 09:23:44 +0800
Message-ID: <22de8bf1e23dc747c140d30a1afad2c407af0725.1429845922.git.micky_ching@realsil.com.cn>
References: <cover.1429845922.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1429845922.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

Add support for SD4.0 card.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/host/sdhci.c | 108 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 15bd7c8..6ba8699 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -256,6 +256,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 
 static void sdhci_init(struct sdhci_host *host, int soft)
 {
+	if ((host->flags & SDHCI_HOST_V4_ENABLED) && !soft)
+		sdhci_writew(host, SDHCI_UHSII_HOST_FULL_RESET,
+			SDHCI_UHSII_SOFT_RESET);
 	if (soft)
 		sdhci_do_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
 	else
@@ -270,6 +273,17 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 
+	if (host->flags & SDHCI_HOST_V4_ENABLED) {
+		u32 ier = SDHCI_UHSII_INT_HEADER | SDHCI_UHSII_INT_RES |
+			SDHCI_UHSII_INT_EXPIRED | SDHCI_UHSII_INT_CRC |
+			SDHCI_UHSII_INT_FRAMING | SDHCI_UHSII_INT_TID |
+			SDHCI_UHSII_INT_UNRECOVERABLE | SDHCI_UHSII_INT_EBSY |
+			SDHCI_UHSII_INT_ADMA | SDHCI_UHSII_INT_TIMEOUT;
+
+		sdhci_writel(host, ier, SDHCI_UHSII_INT_ENABLE);
+		sdhci_writel(host, ier, SDHCI_UHSII_SIGNAL_ENABLE);
+	}
+
 	if (soft) {
 		/* force clock reconfiguration */
 		host->clock = 0;
@@ -2733,11 +2747,12 @@ static void sdhci_tuning_timer(unsigned long data)
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
+static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask,
+	u32 uhsii_intmask, u32 *mask)
 {
-	BUG_ON(intmask == 0);
+	BUG_ON(!intmask && !uhsii_intmask);
 
-	if (!host->cmd) {
+	if (!host->cmd && !host->tlp) {
 		pr_err("%s: Got command interrupt 0x%08x even "
 			"though no command operation was in progress.\n",
 			mmc_hostname(host->mmc), (unsigned)intmask);
@@ -2960,6 +2975,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	irqreturn_t result = IRQ_NONE;
 	struct sdhci_host *host = dev_id;
 	u32 intmask, mask, unexpected = 0;
+	u32 uhsii_intmask = 0;
 	int max_loops = 16;
 
 	spin_lock(&host->lock);
@@ -2970,7 +2986,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	}
 
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
-	if (!intmask || intmask == 0xffffffff) {
+
+	if (host->flags & SDHCI_HOST_V4_ENABLED)
+		uhsii_intmask = sdhci_readl(host, SDHCI_UHSII_INT_STATUS);
+
+	if ((!intmask || intmask == 0xffffffff) &&
+			(!uhsii_intmask || uhsii_intmask == 0xffffffff)) {
 		result = IRQ_NONE;
 		goto out;
 	}
@@ -3014,9 +3035,13 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			result = IRQ_WAKE_THREAD;
 		}
 
+		if (uhsii_intmask)
+			sdhci_writel(host, uhsii_intmask,
+				SDHCI_UHSII_INT_STATUS);
+
 		if (intmask & SDHCI_INT_CMD_MASK)
 			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK,
-				      &intmask);
+				uhsii_intmask, &intmask);
 
 		if (intmask & SDHCI_INT_DATA_MASK)
 			sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
@@ -3340,7 +3365,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (host->version & SDHCI_SPEC_VER_MASK)
 				>> SDHCI_SPEC_VER_SHIFT;
-	if (host->version > SDHCI_SPEC_300) {
+	if (host->version > SDHCI_SPEC_400) {
 		pr_err("%s: Unknown controller version (%d). "
 			"You may experience problems.\n", mmc_hostname(mmc),
 			host->version);
@@ -3598,6 +3623,9 @@ int sdhci_add_host(struct sdhci_host *host)
 		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50);
 
+	if (!(caps[1] & SDHCI_CAN_VDD2_180))
+		caps[1] &= ~SDHCI_SUPPORT_UHSII;
+
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
 	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50))
@@ -3628,6 +3656,64 @@ int sdhci_add_host(struct sdhci_host *host)
 		!(host->quirks2 & SDHCI_QUIRK2_BROKEN_DDR50))
 		mmc->caps |= MMC_CAP_UHS_DDR50;
 
+	if (caps[1] & SDHCI_SUPPORT_UHSII) {
+		u32 uhsii_caps;
+		u16 ctrl2;
+
+		/* Set Host Version 4.00 Enable */
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl2 |= SDHCI_CTRL_HOST_V4_ENABLE;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+		host->flags |= SDHCI_HOST_V4_ENABLED;
+
+		host->uhsii_settings_ptr = sdhci_readw(host,
+			SDHCI_UHSII_SETTINGS_PTR);
+		host->uhsii_caps_ptr = sdhci_readw(host,
+			SDHCI_UHSII_HOST_CAPS_PTR);
+
+		uhsii_caps = sdhci_readl(host,
+			host->uhsii_caps_ptr + SDHCI_UHSII_GENERAL_REG);
+
+		host->lane_mode = (uhsii_caps & SDHCI_UHSII_LANES_MASK) >>
+			SDHCI_UHSII_LANES_SHIFT;
+		host->max_gap = (uhsii_caps & SDHCI_UHSII_GAP_MASK) >>
+			SDHCI_UHSII_GAP_SHIFT;
+		host->max_dap = (uhsii_caps & SDHCI_UHSII_DAP_MASK) >>
+			SDHCI_UHSII_DAP_SHIFT;
+		DBG("lane_mode: 0x%x, max_gap: 0x%x, max_dap: 0x%x\n",
+			host->lane_mode, host->max_gap, host->max_dap);
+
+		uhsii_caps = sdhci_readl(host,
+			host->uhsii_caps_ptr + SDHCI_UHSII_PHY_REG);
+
+		host->n_lss_dir = (uhsii_caps & SDHCI_UHSII_LSS_DIR_MASK) >>
+			SDHCI_UHSII_LSS_DIR_SHIFT;
+		host->n_lss_syn = (uhsii_caps & SDHCI_UHSII_LSS_SYN_MASK) >>
+			SDHCI_UHSII_LSS_SYN_SHIFT;
+		host->speed_range = (uhsii_caps & SDHCI_UHSII_RANGE_MASK) >>
+			SDHCI_UHSII_RANGE_SHIFT;
+		DBG("n_lss_dir: 0x%x, n_lss_syn: 0x%x, speed_range: 0x%x\n",
+			host->n_lss_dir, host->n_lss_syn, host->speed_range);
+
+		uhsii_caps = sdhci_readl(host,
+			host->uhsii_caps_ptr + SDHCI_UHSII_LINK_REG_L);
+
+		host->n_fcu = (uhsii_caps & SDHCI_UHSII_N_FCU_MASK) >>
+			SDHCI_UHSII_N_FCU_SHIFT;
+		DBG("n_fcu: 0x%x\n", host->n_fcu);
+
+		uhsii_caps = sdhci_readl(host,
+			host->uhsii_caps_ptr + SDHCI_UHSII_LINK_REG_H);
+
+		host->n_data_gap = uhsii_caps & SDHCI_UHSII_DATA_GAP_MASK;
+		DBG("n_data_gap: 0x%x\n", host->n_data_gap);
+
+		mmc->caps |= MMC_CAP_UHSII;
+
+		if (host->speed_range == SDHCI_UHSII_RANGE_AB)
+			mmc->caps2 |= MMC_CAP2_UHSII_RANGE_AB;
+	}
+
 	/* Does the host need tuning for SDR50? */
 	if (caps[1] & SDHCI_USE_SDR50_TUNING)
 		host->flags |= SDHCI_SDR50_NEEDS_TUNING;
@@ -3644,6 +3730,16 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_DRIVER_TYPE_D)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
 
+	if (host->version == SDHCI_SPEC_400) {
+		mmc->lane_mode = host->lane_mode;
+		mmc->max_gap = host->max_gap;
+		mmc->max_dap = host->max_dap;
+		mmc->n_lss_dir = host->n_lss_dir;
+		mmc->n_lss_syn = host->n_lss_syn;
+		mmc->n_data_gap = host->n_data_gap;
+		mmc->n_fcu = host->n_fcu;
+	}
+
 	/* Initial value for re-tuning timer count */
 	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
 			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
-- 
1.9.1
