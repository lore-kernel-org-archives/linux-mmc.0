From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 2/4] mmc: mediatek: fix CRC error when calling mmc_select_hs400()
Date: Thu, 30 Jun 2016 10:00:59 +0800
Message-ID: <1467252061-3791-3-git-send-email-chaotian.jing@mediatek.com>
References: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:60317 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752570AbcF3CBY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2016 22:01:24 -0400
In-Reply-To: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Daniel Kurtz <djkurtz@chromium.org>, Wei-Ning Huang <wnhuang@chromium.org>

the tune result of hs200 mode at 200Mhz is not suitable for 50Mhz,
mmc_select_hs400() will set clock frequency to 50Mhz, use defalut
tune setting for 50Mhz to avoid CRC error.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4d7ce65..4b175a6 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -287,6 +287,11 @@ struct msdc_save_para {
 	u32 emmc50_cfg0;
 };
 
+struct msdc_tune_para {
+	u32 iocon;
+	u32 pad_tune;
+};
+
 struct msdc_delay_phase {
 	u8 maxlen;
 	u8 start;
@@ -328,6 +333,8 @@ struct msdc_host {
 	u32 hs400_ds_delay;
 	bool hs400_mode;	/* current eMMC will run at hs400 mode */
 	struct msdc_save_para save_para; /* used when gate HCLK */
+	struct msdc_tune_para def_tune_para; /* default tune setting */
+	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
 };
 
 static void sdr_set_bits(void __iomem *reg, u32 bs)
@@ -583,6 +590,18 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks);
 	sdr_set_bits(host->base + MSDC_INTEN, flags);
 
+	/*
+	 * mmc_select_hs400() will drop to 50Mhz and High speed mode,
+	 * tune result of hs200/200Mhz is not suitable for 50Mhz
+	 */
+	if (host->sclk <= 52000000) {
+		writel(host->def_tune_para.iocon, host->base + MSDC_IOCON);
+		writel(host->def_tune_para.pad_tune, host->base + MSDC_PAD_TUNE);
+	} else {
+		writel(host->saved_tune_para.iocon, host->base + MSDC_IOCON);
+		writel(host->saved_tune_para.pad_tune, host->base + MSDC_PAD_TUNE);
+	}
+
 	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->sclk, timing);
 }
 
@@ -1159,6 +1178,8 @@ static void msdc_init_hw(struct msdc_host *host)
 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
 
+	host->def_tune_para.iocon = readl(host->base + MSDC_IOCON);
+	host->def_tune_para.pad_tune = readl(host->base + MSDC_PAD_TUNE);
 	dev_dbg(host->dev, "init hardware done!");
 }
 
@@ -1409,6 +1430,8 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 			dev_err(host->dev, "Tune data fail!\n");
 	}
 
+	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
+	host->saved_tune_para.pad_tune = readl(host->base + MSDC_PAD_TUNE);
 	return ret;
 }
 
-- 
1.8.1.1.dirty

