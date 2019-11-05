From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 3/3] mmc: core: Add 'fixed-emmc-driver-type-hs{200,400}'
Date: Tue, 5 Nov 2019 06:50:15 +0100
Message-ID: <20191105055015.23656-3-erosca@de.adit-jv.com>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105055015.23656-1-erosca@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Mathieu Malaterre <malat@debian.org>, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Add support for two more DT bindings, which stem from the need to
implement below real-life requirement shared by eMMC vendor:

 ---snip---
 Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
 ---snip---

Inspire from [Y] and [Z] during implementation and testing (H3ULCB-KF).
Below decision matrix is intended as function of user's input:

      [0]        [2]        [4]
[0]  hs200:[0]  hs200:[2]  hs200:[0]
     hs400:[0]  hs400:[0]  hs400:[4]
[2]  hs200:[2]  hs200:[2]  hs200:[2]
     hs400:[0]  hs400:[R]  hs400:[4]
[4]  hs200:[0]  hs200:[2]  hs200:[R]
     hs400:[4]  hs400:[4]  hs400:[4]

[0] "fixed-emmc-driver-type"
[2] "fixed-emmc-driver-type-hs200"
[4] "fixed-emmc-driver-type-hs400"
[R] RAW/ECSD drive strength as implemented in
    commit cc4f414c885cd0 ("mmc: mmc: Add driver strength selection")
[Y] commit 6186d06c519e21 ("mmc: parse new binding for eMMC fixed driver type")
[Z] https://www.elinux.org/Tests:eMMC-fixed-drive-strength

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 drivers/mmc/core/host.c  |  4 ++++
 drivers/mmc/core/mmc.c   | 19 ++++++++++++++++---
 include/linux/mmc/host.h |  2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 54abfdfc69ba..2a3d3b542e0d 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -336,6 +336,8 @@ int mmc_of_parse(struct mmc_host *host)
 
 	/* Must be after "non-removable" check */
 	mmc_of_read_drv_type(host, "fixed-emmc-driver-type", &host->fixed_drv_type);
+	mmc_of_read_drv_type(host, "fixed-emmc-driver-type-hs200", &host->fixed_drv_type_hs200);
+	mmc_of_read_drv_type(host, "fixed-emmc-driver-type-hs400", &host->fixed_drv_type_hs400);
 
 	host->dsr_req = !device_property_read_u32(dev, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
@@ -455,6 +457,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->max_blk_count = PAGE_SIZE / 512;
 
 	host->fixed_drv_type = -EINVAL;
+	host->fixed_drv_type_hs200 = -EINVAL;
+	host->fixed_drv_type_hs400 = -EINVAL;
 	host->ios.power_delay_ms = 10;
 
 	return host;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c8804895595f..89e6fb9aedeb 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -62,6 +62,8 @@ static const unsigned int taac_mant[] = {
 		__res & __mask;						\
 	})
 
+static void mmc_select_driver_type(struct mmc_card *card, int timing);
+
 /*
  * Given the decoded CSD structure, decode the raw CID to our CID structure.
  */
@@ -1192,6 +1194,8 @@ static int mmc_select_hs400(struct mmc_card *card)
 		return err;
 	}
 
+	mmc_select_driver_type(card, EXT_CSD_TIMING_HS400);
+
 	/* Switch card to HS400 */
 	val = EXT_CSD_TIMING_HS400 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
@@ -1270,6 +1274,8 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	if (err)
 		goto out_err;
 
+	mmc_select_driver_type(card, EXT_CSD_TIMING_HS200);
+
 	/* Switch HS to HS200 */
 	val = EXT_CSD_TIMING_HS200 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
@@ -1304,10 +1310,17 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	return err;
 }
 
-static void mmc_select_driver_type(struct mmc_card *card)
+static void mmc_select_driver_type(struct mmc_card *card, int timing)
 {
 	int card_drv_type, drive_strength, drv_type = 0;
 	int fixed_drv_type = card->host->fixed_drv_type;
+	int fixed_drv_type_hs200 = card->host->fixed_drv_type_hs200;
+	int fixed_drv_type_hs400 = card->host->fixed_drv_type_hs400;
+
+	if (fixed_drv_type_hs200 >= 0 && timing == EXT_CSD_TIMING_HS200)
+		fixed_drv_type = fixed_drv_type_hs200;
+	else if (fixed_drv_type_hs400 >= 0 && timing == EXT_CSD_TIMING_HS400)
+		fixed_drv_type = fixed_drv_type_hs400;
 
 	card_drv_type = card->ext_csd.raw_driver_strength |
 			mmc_driver_type_mask(0);
@@ -1385,7 +1398,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 	}
 
-	mmc_select_driver_type(card);
+	mmc_select_driver_type(card, EXT_CSD_TIMING_HS400);
 
 	/* Switch card to HS400 */
 	val = EXT_CSD_TIMING_HS400 |
@@ -1445,7 +1458,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 	if (err)
 		return err;
 
-	mmc_select_driver_type(card);
+	mmc_select_driver_type(card, EXT_CSD_TIMING_HS200);
 
 	/*
 	 * Set the bus width(4 or 8) with host's support and
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0..6960ba98810a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -371,6 +371,8 @@ struct mmc_host {
 #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
+	int			fixed_drv_type_hs200;	/* HS200-specific fixed_drv_type */
+	int			fixed_drv_type_hs400;	/* HS400-specific fixed_drv_type */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
2.23.0
