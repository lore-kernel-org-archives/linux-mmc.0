From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 3/9] mmc: mediatek: make cmd_ints_mask to const
Date: Tue, 20 Oct 2015 17:13:05 +0800
Message-ID: <1445332391-30530-4-git-send-email-chaotian.jing@mediatek.com>
References: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Barry Song <baohua@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Howard Chen <ibanezchen@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Kristina Martsenko <kristina.martsenko@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cog>
List-Id: linux-mmc@vger.kernel.org

cmd_ints_mask and data_ints_mask are constant value,
so make it to const

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b2e89d3..8b3e15d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -353,7 +353,10 @@ static void msdc_reset_hw(struct msdc_host *host)
 static void msdc_cmd_next(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd);
 
-static u32 data_ints_mask = MSDC_INTEN_XFER_COMPL | MSDC_INTEN_DATTMO |
+static const u32 cmd_ints_mask = MSDC_INTEN_CMDRDY | MSDC_INTEN_RSPCRCERR |
+			MSDC_INTEN_CMDTMO | MSDC_INTEN_ACMDRDY |
+			MSDC_INTEN_ACMDCRCERR | MSDC_INTEN_ACMDTMO;
+static const u32 data_ints_mask = MSDC_INTEN_XFER_COMPL | MSDC_INTEN_DATTMO |
 			MSDC_INTEN_DATCRCERR | MSDC_INTEN_DMA_BDCSERR |
 			MSDC_INTEN_DMA_GPDCSERR | MSDC_INTEN_DMA_PROTECT;
 
@@ -725,10 +728,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	if (done)
 		return true;
 
-	sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_CMDRDY |
-			MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
-			MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
-			MSDC_INTEN_ACMDTMO);
+	sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
@@ -818,10 +818,7 @@ static void msdc_start_command(struct msdc_host *host,
 	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
 	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
 
-	sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_CMDRDY |
-			MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
-			MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
-			MSDC_INTEN_ACMDTMO);
+	sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
 	writel(cmd->arg, host->base + SDC_ARG);
 	writel(rawcmd, host->base + SDC_CMD);
 }
-- 
1.8.1.1.dirty
