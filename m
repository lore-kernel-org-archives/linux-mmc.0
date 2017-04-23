From: Jiajie Hao <jiajie.hao@mediatek.com>
Subject: [PATCH v2] mmc: sdio: Fix sdio wait busy implement limitation
Date: Sun, 23 Apr 2017 17:38:27 +0800
Message-ID: <1492940307-20785-1-git-send-email-jiajie.hao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:64479 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1044336AbdDWJii (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Apr 2017 05:38:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linus.walleij@linaro.org, chaotian.jing@mediatek.com, yong.mao@mediatek.com, eddie.huang@mediatek.com, srv_heupstream@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Jiajie Hao <jiajie.hao@mediatek.com>

The host may issue an I/O abort by writing to the CCCR at any time
during I/O read operation via CMD52. And host may need suspend
transcation during write busy stage in SDIO suspend/resume scenario.
>From other side, a card may accept CMD52 during data transfer phase.

Previous implement would block issuing above command in busy stage.
It cause function driver can't implement as proper way and has no
opportunity to do some coverage in error case via I/O abort etc.

We need bypass some necessary operation during busy check stage.

Signed-off-by: Jiajie Hao <jiajie.hao@mediatek.com>
---
Changes since v1:(https://lkml.org/lkml/2017/4/17/69)
    * extend orignal interface to cover necessary cases.
    * rename mmc_is_io_op() to sdio_is_op_busy() for matching it's meaning.

---
 drivers/mmc/core/core.c     |    4 +++-
 drivers/mmc/core/sdio_ops.h |   10 ++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 926e0fd..2ae83a7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -234,8 +234,10 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	/*
 	 * For sdio rw commands we must wait for card busy otherwise some
 	 * sdio devices won't work properly.
+	 * And bypass I/O abort, reset and bus suspend operations.
 	 */
-	if (mmc_is_io_op(mrq->cmd->opcode) && host->ops->card_busy) {
+	if (sdio_is_io_busy(mrq->cmd->opcode, mrq->cmd->arg) &&
+	    host->ops->card_busy) {
 		int tries = 500; /* Wait aprox 500ms at maximum */
 
 		while (host->ops->card_busy(host) && --tries)
diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index bed8a83..ee35cb4 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -26,9 +26,15 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 int sdio_reset(struct mmc_host *host);
 unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz);
 
-static inline bool mmc_is_io_op(u32 opcode)
+static inline bool sdio_is_io_busy(u32 opcode, u32 arg)
 {
-	return opcode == SD_IO_RW_DIRECT || opcode == SD_IO_RW_EXTENDED;
+	u32 addr;
+
+	addr = (arg >> 9) & 0x1FFFF;
+
+	return (opcode == SD_IO_RW_EXTENDED ||
+		(opcode == SD_IO_RW_DIRECT &&
+		!(addr == SDIO_CCCR_ABORT || addr == SDIO_CCCR_SUSPEND)));
 }
 
 #endif
-- 
1.7.9.5

