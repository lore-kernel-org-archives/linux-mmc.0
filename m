From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 16/22] OMAP: board-rm680: set MMC nomux flag
Date: Thu,  5 May 2011 14:51:16 +0300
Message-ID: <1304596282-4095-17-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:62715 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168Ab1EELwT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:52:19 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>

Let the bootloader do all the pad configuration.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rm680.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 2af8b05..2dba9d0 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -125,6 +125,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.nomux		= true,
 	},
 	{ /* Terminator */ }
 };
-- 
1.7.0.4

