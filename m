From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 1/2] mmc: mediatek: fix controller busy when plug out SD
Date: Thu, 22 Aug 2019 14:47:40 +0800
Message-ID: <20190822064741.11196-2-chaotian.jing@mediatek.com>
References: <20190822064741.11196-1-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822064741.11196-1-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

when plug out SD card, may get data CRC error, the MMC core will issue
CMD13 to get card status, then CMD13 timeout(due to card plug out) will
trigger CMD19 tuning, first CMD19 timeout has not call msdc_reset_hw()
and cause the next CMD19 gets controller busy.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 33f4b6387ef7..5cc422e5db69 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1071,11 +1071,13 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	}
 
 	if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
-		if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
-		    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+		if (events & MSDC_INT_CMDTMO ||
+		    (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
+		     cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200))
 			/*
 			 * should not clear fifo/interrupt as the tune data
-			 * may have alreay come.
+			 * may have alreay come when cmd19/cmd21 gets response
+			 * CRC error.
 			 */
 			msdc_reset_hw(host);
 		if (events & MSDC_INT_RSPCRCERR) {
-- 
2.18.0
