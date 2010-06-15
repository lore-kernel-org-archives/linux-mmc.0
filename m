From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: [PATCH v5] OMAP: Fix for bus width which improves SD card's
	peformance.
Date: Tue, 15 Jun 2010 13:37:49 +0530
Message-ID: <AANLkTil7PEqhzAcxkErry4ucc1bg07cr7Sj-OpJsGB4e@mail.gmail.com>
References: <003b01cad0f0$6ea78040$544ff780@am.dhcp.ti.com>
	<20100406163211.GA29117@nokia.com>
	<4BBB6767.7010202@ti.com>
	<20100406165720.GA17916@nokia.com>
	<00b401cad5e0$1d1868d0$544ff780@am.dhcp.ti.com>
	<4BBBC628.9030207@ti.com>
	<00c901cad5e7$9de54350$544ff780@am.dhcp.ti.com>
	<4BBBD87C.1040307@ti.com>
	<003601cad73c$98c3aa50$544ff780@am.dhcp.ti.com>
	<s2l7f9d1ffb1004190836l9ba703c5lab13638d968a5c55@mail.gmail.com>
	<h2h7f9d1ffb1004190851gf08897awf198d3c8e5f9dbce@mail.gmail.com>
	<008f01cae1b2$6262c970$544ff780@am.dhcp.ti.com>
	<AANLkTikNlJLiJeXwbBuS_KGPN6soAlKLQH1EUeJCKYi2@mail.gmail.com>
	<AANLkTiks-UvRtQiZtpp-zwlGhMcGNoPZdHKC29lrlFYr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49011 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0FOIHv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jun 2010 04:07:51 -0400
In-Reply-To: <AANLkTiks-UvRtQiZtpp-zwlGhMcGNoPZdHKC29lrlFYr@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Madhusudhan <madhu.cr@ti.com>, akpm@linux-foundation.org, tony@atomide.com, Nishanth Menon <nm@ti.com>, felipe.balbi@nokia.com, Vimal Singh <vimal.newwork@gmail.com>, "S, Venkatraman" <svenkatr@ti.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>

From: Kishore Kadiyala <kishore.kadiyala@ti.com>

This patch improves low speeds for SD cards.
OMAP-MMC controller's can support maximum bus width of '8'.
when bus width is mentioned as "8" in controller data,the SD
stack will check whether bus width is "4" and if not it will
set bus width to "1" and there by degrading performance.
This patch fixes the issue and improves the performance of
SD cards.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Tested-by: Jarkko Nikula <jhnikula@gmail.com>
---
In V5 : Rebasing on 2.6.35-rc3
In V4 : Updated with Nishanth's comments and appened his Signed-off
	http://marc.info/?t=127169149300006&r=1&w=2
In V3 : Updated  with Madhu's comments  and appended Tested by Nikula
In V2 : Appended Signed-off by Venkat and Ack by Madhu

Here are my experiment numbers, on a Class 6 SDHC card:
Read peformance is increased by 220%
Write Performance is increased by 52%

 drivers/mmc/host/omap_hsmmc.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b032828..a0c8515 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2096,10 +2096,23 @@ static int __init omap_hsmmc_probe(struct
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY;

-	if (mmc_slot(host).wires >= 8)
+	switch (mmc_slot(host).wires) {
+	case 8:
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
-	else if (mmc_slot(host).wires >= 4)
+		/* Fall through */
+	case 4:
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
+		break;
+	case 1:
+		/* Nothing to crib here */
+	case 0:
+		/* Assuming nothing was given by board, Core use's 1-Bit */
+		break;
+	default:
+		/* Completely unexpected.. Core goes with 1-Bit Width */
+		dev_crit(mmc_dev(host->mmc), "Invalid width %d\n used!"
+			"using 1 instead\n", mmc_slot(host).wires);
+	}

 	if (mmc_slot(host).nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
-- 
1.6.3.3
