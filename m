From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] mmc: sanitize 'bus width' in debug output
Date: Fri, 29 Jan 2016 09:27:50 +0100
Message-ID: <1454056070-6164-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38582 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973AbcA2I2J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Jan 2016 03:28:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The bus width is sometimes the actual bus width, and sometimes indices
to different arrays encoding the bus width. In my debugging case "2"
could mean 8-bit as well as 4-bit, which was extremly confusing. Let's
use the human-readable actual bus width in all places.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c | 2 +-
 drivers/mmc/core/mmc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f95d41ffc766e5..746de248defced 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1033,7 +1033,7 @@ static inline void mmc_set_ios(struct mmc_host *host)
 		"width %u timing %u\n",
 		 mmc_hostname(host), ios->clock, ios->bus_mode,
 		 ios->power_mode, ios->chip_select, ios->vdd,
-		 ios->bus_width, ios->timing);
+		 1 << ios->bus_width, ios->timing);
 
 	host->ops->set_ios(host, ios);
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 07a135bc893057..4dbe3df8024b2c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -945,7 +945,7 @@ static int mmc_select_bus_width(struct mmc_card *card)
 			break;
 		} else {
 			pr_warn("%s: switch to bus width %d failed\n",
-				mmc_hostname(host), ext_csd_bits[idx]);
+				mmc_hostname(host), 1 << bus_width);
 		}
 	}
 
-- 
2.6.2

