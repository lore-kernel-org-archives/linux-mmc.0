From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdio_cis: fix unknown tuple for CISTPL_SDIO_STD
Date: Wed, 20 Jan 2016 16:17:04 +0800
Message-ID: <1453277824-15719-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:60607 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757921AbcATIVs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2016 03:21:48 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

CISTPL_SDIO_STD(0x91) is a known tuple, but sdio_cis didn't define it,
so we get the warning blow while probing several sdio wifi. Refer to SDIO spec,
it's no need to parse the tuple, so this patch just make it a known one.

[    4.098980] mmc2: queuing unknown CIS tuple 0x91 (3 bytes)
[    4.099033] mmc2: new ultra high speed SDR104 SDIO card at address 0001

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/sdio_cis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index 8e94e55..6f6fc52 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -223,6 +223,7 @@ static const struct cis_tpl cis_tpl_list[] = {
 	{	0x20,	4,	cistpl_manfid		},
 	{	0x21,	2,	/* cistpl_funcid */	},
 	{	0x22,	0,	cistpl_funce		},
+	{	0x91,	2,	/* cistpl_sdio_std */	},
 };
 
 static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
-- 
2.3.7


