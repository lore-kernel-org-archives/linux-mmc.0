From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 2/2] mmc: cavium: Check pointer before de-reference
Date: Thu, 13 Apr 2017 14:10:51 +0200
Message-ID: <20170413121051.10507-3-jglauber@cavium.com>
References: <20170413121051.10507-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413121051.10507-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Add a pointer check to prevent this smatch warning:

drivers/mmc/host/cavium.c:803 cvm_mmc_request()
	error: we previously assumed 'cmd->data' could be null (see line 782)

This is a theoretical fix because MMC_CMD_ADTC seems to imply
that cmd->data is not null. Nevertheless checking cmd->data
before using it improves readability.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index ddf902c..d89c2eb 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -799,7 +799,7 @@ static void cvm_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		  FIELD_PREP(MIO_EMM_CMD_IDX, cmd->opcode) |
 		  FIELD_PREP(MIO_EMM_CMD_ARG, cmd->arg);
 	set_bus_id(&emm_cmd, slot->bus_id);
-	if (mmc_cmd_type(cmd) == MMC_CMD_ADTC)
+	if (cmd->data && mmc_cmd_type(cmd) == MMC_CMD_ADTC)
 		emm_cmd |= FIELD_PREP(MIO_EMM_CMD_OFFSET,
 				64 - ((cmd->data->blocks * cmd->data->blksz) / 8));
 
-- 
2.9.0.rc0.21.g7777322
