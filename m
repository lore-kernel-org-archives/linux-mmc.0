From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 4/6] mmc: mediatek: tune CMD/DATA together
Date: Sat, 13 Oct 2018 15:20:48 +0800
Message-ID: <1539415250-32337-5-git-send-email-chaotian.jing@mediatek.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, jjian.zhou@mediatek.com, wenbin.mei@mediatek.com
List-Id: linux-mmc@vger.kernel.org

for MSDC IP which supports both data tune and async fifo, it can
tune cmd/data together. which can save the time and make the tune
result of CMD more stable as data line are 4bit or 8bit.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index fe80a1d..09d7e44 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1773,12 +1773,98 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	return final_delay == 0xff ? -EIO : 0;
 }
 
+/*
+ * MSDC IP which supports data tune + async fifo can do CMD/DAT tune
+ * together, which can save the tuning time.
+ */
+static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	u32 rise_delay = 0, fall_delay = 0;
+	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
+	u8 final_delay, final_maxlen;
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
+	int i, ret;
+
+	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_INT_DAT_LATCH_CK_SEL,
+		      host->latch_ck);
+
+	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+	sdr_clr_bits(host->base + MSDC_IOCON,
+		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_CMDRDLY, i);
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_DATRRDLY, i);
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (!ret)
+			rise_delay |= (1 << i);
+	}
+	final_rise_delay = get_best_delay(host, rise_delay);
+	/* if rising edge has enough margin, then do not scan falling edge */
+	if (final_rise_delay.maxlen >= 12 ||
+	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
+		goto skip_fall;
+
+	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+	sdr_set_bits(host->base + MSDC_IOCON,
+		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+	for (i = 0; i < PAD_DELAY_MAX; i++) {
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_CMDRDLY, i);
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_DATRRDLY, i);
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (!ret)
+			fall_delay |= (1 << i);
+	}
+	final_fall_delay = get_best_delay(host, fall_delay);
+
+skip_fall:
+	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
+	if (final_maxlen == final_rise_delay.maxlen) {
+		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+		sdr_clr_bits(host->base + MSDC_IOCON,
+			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+			      final_rise_delay.final_phase);
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_DATRRDLY,
+			      final_rise_delay.final_phase);
+		final_delay = final_rise_delay.final_phase;
+	} else {
+		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+		sdr_set_bits(host->base + MSDC_IOCON,
+			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+			      final_fall_delay.final_phase);
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_DATRRDLY,
+			      final_fall_delay.final_phase);
+		final_delay = final_fall_delay.final_phase;
+	}
+
+	dev_dbg(host->dev, "Final pad delay: %x\n", final_delay);
+	return final_delay == 0xff ? -EIO : 0;
+}
+
 static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
+	if (host->dev_comp->data_tune && host->dev_comp->async_fifo) {
+		ret = msdc_tune_together(mmc, opcode);
+		if (host->hs400_mode) {
+			sdr_clr_bits(host->base + MSDC_IOCON,
+				     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+			sdr_set_field(host->base + tune_reg,
+				      MSDC_PAD_TUNE_DATRRDLY, 0);
+		}
+		goto tune_done;
+	}
 	if (host->hs400_mode &&
 	    host->dev_comp->hs400_tune)
 		ret = hs400_tune_response(mmc, opcode);
@@ -1794,6 +1880,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 			dev_err(host->dev, "Tune data fail!\n");
 	}
 
+tune_done:
 	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
 	host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
 	host->saved_tune_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
-- 
1.8.1.1.dirty
