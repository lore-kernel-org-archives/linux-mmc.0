From: Qiang Liu <b32616@freescale.com>
Subject: [PATCH] SD/MMC: fix the issue of SDHC performance regression
Date: Mon, 7 Nov 2011 17:36:29 +0800
Message-ID: <1320658589-13143-1-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:20737
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752339Ab1KGKFp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2011 05:05:45 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, leoli@freescale.com, kumar.gala@freescale.com, Qiang Liu <b32616@freescale.com>

Low performance of SDHC (half of before) due to its frequency was set to 25MHz,
but not 50MHz (involved by commit id 013909c4ffd16ded4895528b856fd8782df04dc6,
add support for query function modes for uhs cards according to Physical Layer
SPEC V3.01).

Set high speed max frequency according to response status of CMD6, but
not for SPEC Version. Response of switch command is first consideration
factor when set SDHC max working frequency. TRAN_SPEED in CSD register
will be seemed as the second factor.

Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/mmc/core/sd.c    |    6 +++---
 include/linux/mmc/card.h |    3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index b33537f..5cdab7c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -306,6 +306,9 @@ static int mmc_read_switch(struct mmc_card *card)
 		goto out;
 	}

+	if (status[13] & SD_MODE_HIGH_SPEED)
+		card->sw_caps.hs_max_dtr = HIGH_SPEED_MAX_DTR;
+
 	if (card->scr.sda_spec3) {
 		card->sw_caps.sd3_bus_mode = status[13];

@@ -348,9 +351,6 @@ static int mmc_read_switch(struct mmc_card *card)
 		}

 		card->sw_caps.sd3_curr_limit = status[7];
-	} else {
-		if (status[13] & 0x02)
-			card->sw_caps.hs_max_dtr = 50000000;
 	}

 out:
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6ad4355..499a268 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -99,6 +99,7 @@ struct sd_ssr {
 struct sd_switch_caps {
 	unsigned int		hs_max_dtr;
 	unsigned int		uhs_max_dtr;
+#define HIGH_SPEED_MAX_DTR	50000000
 #define UHS_SDR104_MAX_DTR	208000000
 #define UHS_SDR50_MAX_DTR	100000000
 #define UHS_DDR50_MAX_DTR	50000000
@@ -106,11 +107,13 @@ struct sd_switch_caps {
 #define UHS_SDR12_MAX_DTR	25000000
 	unsigned int		sd3_bus_mode;
 #define UHS_SDR12_BUS_SPEED	0
+#define HIGH_SPEED_BUS_SPEED	1
 #define UHS_SDR25_BUS_SPEED	1
 #define UHS_SDR50_BUS_SPEED	2
 #define UHS_SDR104_BUS_SPEED	3
 #define UHS_DDR50_BUS_SPEED	4

+#define SD_MODE_HIGH_SPEED	(1 << HIGH_SPEED_BUS_SPEED)
 #define SD_MODE_UHS_SDR12	(1 << UHS_SDR12_BUS_SPEED)
 #define SD_MODE_UHS_SDR25	(1 << UHS_SDR25_BUS_SPEED)
 #define SD_MODE_UHS_SDR50	(1 << UHS_SDR50_BUS_SPEED)
--
1.6.4


