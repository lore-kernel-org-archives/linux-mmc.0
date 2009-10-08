From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap_hsmmc: Add missing probe handler hook
Date: Thu, 8 Oct 2009 15:54:28 -0700
Message-ID: <20091008225428.GA25892@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Denis Karpov <ext-denis.2.karpov@nokia.com>
List-Id: linux-mmc@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Andrew,

Here's a fix from Roger Quadros that was accidentally not posted
to linux-mmc as pointed out by Felipe Contreras on LKML.

Can you please pick it up?

For reference, this is the issue Uwe Kleine-König mentioned at:
http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00528.html

Felipe Contreras summarized how things broke at:
http://lkml.org/lkml/2009/10/8/334

Regards,

Tony

--5I6of5zJg18YgZEa
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="v2-omap_hsmmc-Add-missing-probe-handler-hook.patch"

Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [v2] omap_hsmmc: Add missing probe handler hook
Date: Fri, 02 Oct 2009 12:22:40 -0000
From: Roger Quadros <ext-roger.quadros@nokia.com>
X-Patchwork-Id: 51344

The missing probe handler hook will never probe the driver. Add it back.
Fixes broken MMC on OMAP.

We use platform_driver_probe() API since omap_hsmmc is not a hot-pluggable
device.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Tested-by: Felipe Contreras <felipe.contreras@gmail.com>
Tested-by: Tony Lindgren <tony@atomide.com>

---
drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4487cc0..0aecaae 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2013,7 +2013,7 @@ static struct platform_driver omap_hsmmc_driver = {
 static int __init omap_hsmmc_init(void)
 {
 	/* Register the MMC driver */
-	return platform_driver_register(&omap_hsmmc_driver);
+	return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_probe);
 }
 
 static void __exit omap_hsmmc_cleanup(void)

--5I6of5zJg18YgZEa--
