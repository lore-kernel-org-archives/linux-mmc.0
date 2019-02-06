From: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 2/3] mmc: core: Indicate SD specs higher than 4.0
Date: Wed,  6 Feb 2019 13:28:06 +0200
Message-ID: <1549452487-17193-3-git-send-email-avri.altman@wdc.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Avi Shchislowski <avi.shchislowski@wdc.com>, Alex Lemberg <alex.lemberg@wdc.com>, linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

SD specs version 4.x and 5.x have a dedicated slices in the SCR register.
Higher versions will rely on a combination of the existing fields.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd.c    | 5 +++++
 include/linux/mmc/card.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index bd48b28..c2db94d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -209,6 +209,11 @@ static int mmc_decode_scr(struct mmc_card *card)
 		/* Check if Physical Layer Spec v3.0 is supported */
 		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
 
+	if (scr->sda_spec3) {
+		scr->sda_spec4 = UNSTUFF_BITS(resp, 42, 1);
+		scr->sda_specx = UNSTUFF_BITS(resp, 38, 4);
+	}
+
 	if (UNSTUFF_BITS(resp, 55, 1))
 		card->erased_byte = 0xFF;
 	else
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8f429b6..d791813f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -133,6 +133,8 @@ struct mmc_ext_csd {
 struct sd_scr {
 	unsigned char		sda_vsn;
 	unsigned char		sda_spec3;
+	unsigned char		sda_spec4;
+	unsigned char		sda_specx;
 	unsigned char		bus_widths;
 #define SD_SCR_BUS_WIDTH_1	(1<<0)
 #define SD_SCR_BUS_WIDTH_4	(1<<2)
-- 
1.9.1
