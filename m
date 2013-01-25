From: Balaji T K <balajitk@ti.com>
Subject: [PATCH] mmc: core: expose RPMB partition only for CMD23 capable host
Date: Fri, 25 Jan 2013 17:00:30 +0530
Message-ID: <1359113430-10951-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45346 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872Ab3AYLal (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Jan 2013 06:30:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: loic.pallardy-ext@stericsson.com, peter.ujfalusi@ti.com, Balaji T K <balajitk@ti.com>

SET_BLOCK_COUNT CMD23 is needed for all access to RPMB partition.
If block count is not set by CMD23, all subsequent read/write commands
fail as per eMMC specification. So, If the host does not support CMD23,
do not expose RPMB partition.

Accessing RPMB partition can cause hang / huge delay
for host which do not support CMD23.

Signed-off-by: Balaji T K <balajitk@ti.com>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mmc/core/mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e6e3911..089e8ea 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -496,7 +496,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		 * RPMB regions are defined in multiples of 128K.
 		 */
 		card->ext_csd.raw_rpmb_size_mult = ext_csd[EXT_CSD_RPMB_MULT];
-		if (ext_csd[EXT_CSD_RPMB_MULT]) {
+		if (ext_csd[EXT_CSD_RPMB_MULT] && mmc_host_cmd23(card->host)) {
 			mmc_part_add(card, ext_csd[EXT_CSD_RPMB_MULT] << 17,
 				EXT_CSD_PART_CONFIG_ACC_RPMB,
 				"rpmb", 0, false,
-- 
1.7.5.4

