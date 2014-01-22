From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/10] mmc: card: Use R1 response for the stop cmd at recovery path
Date: Wed, 22 Jan 2014 16:00:22 +0100
Message-ID: <1390402824-9850-9-git-send-email-ulf.hansson@linaro.org>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:52051 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996AbaAVPAp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 10:00:45 -0500
Received: by mail-we0-f171.google.com with SMTP id w61so406594wes.16
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2014 07:00:42 -0800 (PST)
In-Reply-To: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hosts supporting MMC_CAP_WAIT_WHILE_BUSY shall not be waiting for busy
detection completion in the recovery path, which were the case when
using R1B response.

Start using R1 as response instead to align behavior, no matter if
MMC_CAP_WAIT_WHILE_BUSY is supported or not.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 87cd2b0..74169fa 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -728,7 +728,7 @@ static int send_stop(struct mmc_card *card, u32 *status)
 	int err;
 
 	cmd.opcode = MMC_STOP_TRANSMISSION;
-	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 	err = mmc_wait_for_cmd(card->host, &cmd, 5);
 	if (err == 0)
 		*status = cmd.resp[0];
-- 
1.7.9.5

