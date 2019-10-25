From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 6/7] mmc: dw_mmc: Fix debugfs on 64-bit platforms
Date: Fri, 25 Oct 2019 11:41:29 +0200
Message-ID: <20191025094130.26033-7-geert+renesas@glider.be>
References: <20191025094130.26033-1-geert+renesas@glider.be>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191025094130.26033-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

"dw_mci.pending_events" and "dw_mci.completed_events" are "unsigned
long", i.e. 32-bit or 64-bit, depending on the platform.  Hence casting
their addresses to "u32 *", and calling debugfs_create_x32() breaks
operation on 64-bit platforms.

Fix this by using the new debugfs_create_xul() helper instead.

Fixes: f95f3850f7a9e1d4 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host driver.")
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
v2:
  - Add Acked-by.
---
 drivers/mmc/host/dw_mmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bf0048ebbda356a7..b4c4a9cd6365f122 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -177,10 +177,10 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 	debugfs_create_file("regs", S_IRUSR, root, host, &dw_mci_regs_fops);
 	debugfs_create_file("req", S_IRUSR, root, slot, &dw_mci_req_fops);
 	debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
-	debugfs_create_x32("pending_events", S_IRUSR, root,
-			   (u32 *)&host->pending_events);
-	debugfs_create_x32("completed_events", S_IRUSR, root,
-			   (u32 *)&host->completed_events);
+	debugfs_create_xul("pending_events", S_IRUSR, root,
+			   &host->pending_events);
+	debugfs_create_xul("completed_events", S_IRUSR, root,
+			   &host->completed_events);
 }
 #endif /* defined(CONFIG_DEBUG_FS) */
 
-- 
2.17.1
