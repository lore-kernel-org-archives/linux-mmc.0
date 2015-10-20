From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 7/9] mmc: mmc: extend the mmc_send_tuning()
Date: Tue, 20 Oct 2015 17:13:09 +0800
Message-ID: <1445332391-30530-8-git-send-email-chaotian.jing@mediatek.com>
References: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Barry Song <baohua@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Howard Chen <ibanezchen@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Kristina Martsenko <kristina.martsenko@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cog>
List-Id: linux-mmc@vger.kernel.org

The mmc_execute_tuning() has already prepared the opcode,
there is no need to prepare it again at mmc_send_tuning(),
and, there is a BUG of mmc_send_tuning() to determine the opcode
by bus width, assume eMMC was running at HS200, 4bit mode,
then the mmc_send_tuning() will overwrite the opcode from CMD21
to CMD19, then got error.

in addition, extend an argument of "cmd_error" to allow getting
if there was cmd error when tune response.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc_ops.c         | 8 ++++----
 drivers/mmc/host/dw_mmc-exynos.c   | 4 ++--
 drivers/mmc/host/dw_mmc.c          | 2 +-
 drivers/mmc/host/dw_mmc.h          | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 +++---
 drivers/mmc/host/sdhci-msm.c       | 2 +-
 drivers/mmc/host/sdhci-sirf.c      | 2 +-
 include/linux/mmc/core.h           | 2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0e9ae1c..4305f75 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -589,7 +589,7 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
-int mmc_send_tuning(struct mmc_host *host)
+int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
 {
 	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
@@ -599,16 +599,13 @@ int mmc_send_tuning(struct mmc_host *host)
 	const u8 *tuning_block_pattern;
 	int size, err = 0;
 	u8 *data_buf;
-	u32 opcode;
 
 	if (ios->bus_width == MMC_BUS_WIDTH_8) {
 		tuning_block_pattern = tuning_blk_pattern_8bit;
 		size = sizeof(tuning_blk_pattern_8bit);
-		opcode = MMC_SEND_TUNING_BLOCK_HS200;
 	} else if (ios->bus_width == MMC_BUS_WIDTH_4) {
 		tuning_block_pattern = tuning_blk_pattern_4bit;
 		size = sizeof(tuning_blk_pattern_4bit);
-		opcode = MMC_SEND_TUNING_BLOCK;
 	} else
 		return -EINVAL;
 
@@ -639,6 +636,9 @@ int mmc_send_tuning(struct mmc_host *host)
 
 	mmc_wait_for_req(host, &mrq);
 
+	if (cmd_error)
+		*cmd_error = cmd.error;
+
 	if (cmd.error) {
 		err = cmd.error;
 		goto out;
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 1e75309..3a7e835 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -446,7 +446,7 @@ out:
 	return loc;
 }
 
-static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
+static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 {
 	struct dw_mci *host = slot->host;
 	struct dw_mci_exynos_priv_data *priv = host->priv;
@@ -461,7 +461,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
 		mci_writel(host, TMOUT, ~0);
 		smpl = dw_mci_exynos_move_next_clksmpl(host);
 
-		if (!mmc_send_tuning(mmc))
+		if (!mmc_send_tuning(mmc, opcode, NULL))
 			candiates |= (1 << smpl);
 
 	} while (start_smpl != smpl);
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fcbf552..be8441d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1427,7 +1427,7 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	int err = -EINVAL;
 
 	if (drv_data && drv_data->execute_tuning)
-		err = drv_data->execute_tuning(slot);
+		err = drv_data->execute_tuning(slot, opcode);
 	return err;
 }
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 8ce4674..394340f 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -281,7 +281,7 @@ struct dw_mci_drv_data {
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
-	int		(*execute_tuning)(struct dw_mci_slot *slot);
+	int		(*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
 	int		(*prepare_hs400_tuning)(struct dw_mci *host,
 						struct mmc_ios *ios);
 	int		(*switch_voltage)(struct mmc_host *mmc,
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 886d230..1f1582f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -759,7 +759,7 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	min = ESDHC_TUNE_CTRL_MIN;
 	while (min < ESDHC_TUNE_CTRL_MAX) {
 		esdhc_prepare_tuning(host, min);
-		if (!mmc_send_tuning(host->mmc))
+		if (!mmc_send_tuning(host->mmc, opcode, NULL))
 			break;
 		min += ESDHC_TUNE_CTRL_STEP;
 	}
@@ -768,7 +768,7 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	max = min + ESDHC_TUNE_CTRL_STEP;
 	while (max < ESDHC_TUNE_CTRL_MAX) {
 		esdhc_prepare_tuning(host, max);
-		if (mmc_send_tuning(host->mmc)) {
+		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
 			max -= ESDHC_TUNE_CTRL_STEP;
 			break;
 		}
@@ -778,7 +778,7 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	/* use average delay to get the best timing */
 	avg = (min + max) / 2;
 	esdhc_prepare_tuning(host, avg);
-	ret = mmc_send_tuning(host->mmc);
+	ret = mmc_send_tuning(host->mmc, opcode, NULL);
 	esdhc_post_tuning(host);
 
 	dev_dbg(mmc_dev(host->mmc), "tunning %s at 0x%x ret %d\n",
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4bcee03..4695bee 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -373,7 +373,7 @@ retry:
 		if (rc)
 			return rc;
 
-		rc = mmc_send_tuning(mmc);
+		rc = mmc_send_tuning(mmc, opcode, NULL);
 		if (!rc) {
 			/* Tuning is successful at this tuning point */
 			tuned_phases[tuned_phase_cnt++] = phase;
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 8842945..d0c7ffe 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -97,7 +97,7 @@ retry:
 			clock_setting | phase,
 			SDHCI_CLK_DELAY_SETTING);
 
-		if (!mmc_send_tuning(mmc)) {
+		if (!mmc_send_tuning(mmc, opcode, NULL)) {
 			/* Tuning is successful at this tuning point */
 			tuned_phase_cnt++;
 			dev_dbg(mmc_dev(mmc), "%s: Found good phase = %d\n",
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 258daf9..43a283a 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -155,7 +155,7 @@ extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
 			bool, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
-extern int mmc_send_tuning(struct mmc_host *host);
+extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 
 #define MMC_ERASE_ARG		0x00000000
-- 
1.8.1.1.dirty
