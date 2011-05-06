From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 10/16] OMAP: board-rm680: set MMC nomux flag
Date: Fri,  6 May 2011 12:14:09 +0300
Message-ID: <1304673255-31634-11-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

Let the bootloader do all the pad configuration.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rm680.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 42d10b1..c4e821f 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -116,6 +116,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.nomux		= true,
 	},
 	{ /* Terminator */ }
 };
-- 
1.7.0.4

