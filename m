From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v3 06/10] mmc: mediatek: add implement of ops->hw_reset()
Date: Tue, 27 Oct 2015 14:24:26 +0800
Message-ID: <1445927070-5102-7-git-send-email-chaotian.jing@mediatek.com>
References: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mediatek@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Barry Song <baohua@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Howard Chen <ibanezchen@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Kristina Martsenko <kristina.martsenko@gmail.com>
List-Id: linux-mmc@vger.kernel.org

add implement of ops->hw_reset() for eMMC

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

---
 drivers/mmc/host/mtk-sd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 3858163..5627644 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -64,6 +64,7 @@
 #define SDC_RESP2        0x48
 #define SDC_RESP3        0x4c
 #define SDC_BLK_NUM      0x50
+#define EMMC_IOCON       0x7c
 #define SDC_ACMD_RESP    0x80
 #define MSDC_DMA_SA      0x90
 #define MSDC_DMA_CTRL    0x98
@@ -1209,6 +1210,15 @@ end:
 	pm_runtime_put_autosuspend(host->dev);
 }
 
+static void msdc_hw_reset(struct mmc_host *mmc)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+
+	sdr_set_bits(host->base + EMMC_IOCON, 1);
+	udelay(10); /* 10us is enough */
+	sdr_clr_bits(host->base + EMMC_IOCON, 1);
+}
+
 static struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
@@ -1216,6 +1226,7 @@ static struct mmc_host_ops mt_msdc_ops = {
 	.set_ios = msdc_ops_set_ios,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
 	.card_busy = msdc_card_busy,
+	.hw_reset = msdc_hw_reset,
 };
 
 static int msdc_drv_probe(struct platform_device *pdev)
-- 
1.8.1.1.dirty
