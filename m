From: Pavel Machek <pavel@ucw.cz>
Subject: msm_sdcc.c: remove references to htc_pwrsink
Date: Thu, 22 Oct 2009 09:19:26 +0200
Message-ID: <20091022071926.GA3244@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38023 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbZJVHT2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2009 03:19:28 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>


htc_pwrsing code never went to mainline, remove references to it.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index dba4600..64d4e48 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -41,7 +41,6 @@
 #include <asm/mach/mmc.h>
 #include <mach/msm_iomap.h>
 #include <mach/dma.h>
-#include <mach/htc_pwrsink.h>
 
 #include "msm_sdcc.h"
 
@@ -775,13 +774,11 @@ msmsdcc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
-		htc_pwrsink_set(PWRSINK_SDCARD, 0);
 		break;
 	case MMC_POWER_UP:
 		pwr |= MCI_PWR_UP;
 		break;
 	case MMC_POWER_ON:
-		htc_pwrsink_set(PWRSINK_SDCARD, 100);
 		pwr |= MCI_PWR_ON;
 		break;
 	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
