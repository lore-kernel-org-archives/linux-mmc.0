From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 6/9] mmc: mediatek: add implement of ops->hw_reset()
Date: Tue, 20 Oct 2015 17:13:08 +0800
Message-ID: <1445332391-30530-7-git-send-email-chaotian.jing@mediatek.com>
References: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Minda Chen <Minda.Chen@csr.com>, Dong Aisheng <b29396@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, Weijun Yang <Weijun.Yang@csr.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, Howard Chen <ibanezchen@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ivan.ivanov@linaro.org, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias>
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
