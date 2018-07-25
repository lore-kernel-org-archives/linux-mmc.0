From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: tmio: remove unneeded variable in tmio_mmc_start_command()
Date: Wed, 25 Jul 2018 17:46:14 +0900
Message-ID: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Pass TMIO_MASK_CMD to tmio_mmc_enable_mmc_irqs() directly,
and remove the variable, irq_mask.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 3080299..3cb554c 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -309,7 +309,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
 {
 	struct mmc_data *data = host->data;
 	int c = cmd->opcode;
-	u32 irq_mask = TMIO_MASK_CMD;
 
 	switch (mmc_resp_type(cmd)) {
 	case MMC_RSP_NONE: c |= RESP_NONE; break;
@@ -349,7 +348,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
 			c |= TRANSFER_READ;
 	}
 
-	tmio_mmc_enable_mmc_irqs(host, irq_mask);
+	tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_CMD);
 
 	/* Fire off the command */
 	sd_ctrl_write32_as_16_and_16(host, CTL_ARG_REG, cmd->arg);
-- 
2.7.4
