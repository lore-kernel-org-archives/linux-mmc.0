From: Ben Nizette <bn@niasdigital.com>
Subject: [PATCH v2] mmc: lower init clock frequency to 300kHz
Date: Sat, 2 Jan 2010 10:11:10 +1100
Message-ID: <2A48D9AC-90D7-405F-A64C-0703F5FEC175@niasdigital.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from outbound.icp-qv1-irony-out6.iinet.net.au ([203.59.1.109]:35158
	"EHLO outbound.icp-qv1-irony-out6.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992Ab0AAXLR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Jan 2010 18:11:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, Hein_Tibosch <hein_tibosch@yahoo.es>, Sascha Hauer <s.hauer@pengutronix.de>


A good few months ago, commit

commit 8dfd0374be84793360db7fff2e635d2cd3bbcb21
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Thu Apr 9 08:32:02 2009 +0200

    MMC core: limit minimum initialization frequency to 400kHz

broke a few setups with cards which don't quite adhere to the MMC spec - 400kHz is just too fast for them.  In my testing, all of the cards which fail at 400kHz are OK by about 350Khz but this patch drops the floor to 300 to be on the safe side.

Dropping the floor also means that the warning will trigger on some valid setups, albeit ones which won't run particularly crappy cards.  This patch then slightly softens the language of said warning to make it clear it isn't always a problem.

V1 of this patch dropped the floor all the way to 50kHz on the basis that it was only for a few 100 bytes so that very low speed shouldn't matter.  After some discussion [1] the consensus was that 50 was too slow after all so this patch is a bit more sensible.

Signed-off-by: Ben Nizette <bn@niasdigital.com>

[1] http://lkml.org/lkml/2009/7/1/529

---
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7dab2e5..49f0eae 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -891,12 +891,12 @@ static void mmc_power_up(struct mmc_host *host)
 	 */
 	mmc_delay(10);
 
-	if (host->f_min > 400000) {
-		pr_warning("%s: Minimum clock frequency too high for "
+	if (host->f_min > 300000) {
+		pr_warning("%s: Minimum clock frequency may be too high for "
 				"identification mode\n", mmc_hostname(host));
 		host->ios.clock = host->f_min;
 	} else
-		host->ios.clock = 400000;
+		host->ios.clock = 300000;
 
 	host->ios.power_mode = MMC_POWER_ON;
 	mmc_set_ios(host);

