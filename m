From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/7] mac80211: Use debugfs_create_xul() helper
Date: Fri, 25 Oct 2019 11:41:25 +0200
Message-ID: <20191025094130.26033-3-geert+renesas@glider.be>
References: <20191025094130.26033-1-geert+renesas@glider.be>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191025094130.26033-1-geert+renesas@glider.be>
Sender: netdev-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jaehoon Chung <jh80.chung@samsung.com>, "David S . Miller" <davem@davemloft.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

Use the new debugfs_create_xul() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 net/mac80211/debugfs_sta.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index c8ad20c28c438dab..ca34dcdac8c0bd4d 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -928,12 +928,7 @@ STA_OPS(he_capa);
 		sta->debugfs_dir, sta, &sta_ ##name## _ops);
 
 #define DEBUGFS_ADD_COUNTER(name, field)				\
-	if (sizeof(sta->field) == sizeof(u32))				\
-		debugfs_create_u32(#name, 0400, sta->debugfs_dir,	\
-			(u32 *) &sta->field);				\
-	else								\
-		debugfs_create_u64(#name, 0400, sta->debugfs_dir,	\
-			(u64 *) &sta->field);
+	debugfs_create_ulong(#name, 0400, sta->debugfs_dir, &sta->field);
 
 void ieee80211_sta_debugfs_add(struct sta_info *sta)
 {
@@ -978,14 +973,8 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 		DEBUGFS_ADD(airtime);
 
-	if (sizeof(sta->driver_buffered_tids) == sizeof(u32))
-		debugfs_create_x32("driver_buffered_tids", 0400,
-				   sta->debugfs_dir,
-				   (u32 *)&sta->driver_buffered_tids);
-	else
-		debugfs_create_x64("driver_buffered_tids", 0400,
-				   sta->debugfs_dir,
-				   (u64 *)&sta->driver_buffered_tids);
+	debugfs_create_xul("driver_buffered_tids", 0400, sta->debugfs_dir,
+			   &sta->driver_buffered_tids);
 
 	drv_sta_add_debugfs(local, sdata, &sta->sta, sta->debugfs_dir);
 }
-- 
2.17.1
