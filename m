From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v6 13/13] HACK: Hide RPMB partitions
Date: Wed, 18 Mar 2015 10:52:28 +0100
Message-ID: <1426672363-30667-14-git-send-email-tomeu.vizoso@collabora.com>
References: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34972 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933050AbbCRJyD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Mar 2015 05:54:03 -0400
In-Reply-To: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-tegra@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ben Hutchings <ben@decadent.org.uk>, Asaf Vertz <asaf.vertz@tandemg.com>, Lukas Czerner <lczerner@redhat.com>, Joe Perches <joe@perches.com>, Tobias Klauser <tklauser@distanz.ch>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

---
 drivers/mmc/card/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c69afb5..f9d8fc3 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2252,7 +2252,7 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 		return 0;
 
 	for (idx = 0; idx < card->nr_parts; idx++) {
-		if (card->part[idx].size) {
+		if (card->part[idx].size && !(card->part[idx].area_type & MMC_BLK_DATA_AREA_RPMB)) {
 			ret = mmc_blk_alloc_part(card, md,
 				card->part[idx].part_cfg,
 				card->part[idx].size >> 9,
-- 
2.1.0

