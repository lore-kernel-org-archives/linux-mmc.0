From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/3] mmc: host: omap_hsmmc: Handle BADA, DEB and CEB interrupts
Date: Tue, 16 Jun 2015 16:07:18 +0530
Message-ID: <1434451039-18195-3-git-send-email-vigneshr@ti.com>
References: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48931 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932353AbbFPKhe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Jun 2015 06:37:34 -0400
In-Reply-To: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>, Vignesh R <vigneshr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Sometimes BADA, DEB or CEB error interrupts occur when sd card is
unplugged during data transfer. These interrupts are currently ignored
by the interrupt handler. But, this results in card not being
recognised on subsequent insertion. This is because mmcqd is waiting
forever for the data transfer(for which error occurred) to complete.
Fix this, by reporting BADA, DEB, CEB errors to mmc-core as -EILSEQ, so
that the core can do appropriate handling.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d0abdffb0d7c..fb4bfefd9250 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1068,7 +1068,8 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 		}
 		if (status & (CTO_EN | DTO_EN))
 			hsmmc_command_incomplete(host, -ETIMEDOUT, end_cmd);
-		else if (status & (CCRC_EN | DCRC_EN))
+		else if (status & (CCRC_EN | DCRC_EN | DEB_EN | CEB_EN |
+				   BADA_EN))
 			hsmmc_command_incomplete(host, -EILSEQ, end_cmd);
 
 		if (status & ACE_EN) {
-- 
2.4.1

