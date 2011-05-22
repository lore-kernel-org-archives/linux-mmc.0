From: "Mok, Tze Siong" <tze.siong.mok@intel.com>
Subject: RE: [PATCH] mmc: eMMC bus width may not work on all platforms
Date: Sun, 22 May 2011 08:40:42 +0800
Message-ID: <1482D9D127C1754E8684047CF53F7660622B177DBE@pgsmsx505.gar.corp.intel.com>
References: <2FBABAF6-BFF6-46C9-BE6C-D4CA1EE9BD03@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36891 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab1EVAkw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 21 May 2011 20:40:52 -0400
In-Reply-To: <2FBABAF6-BFF6-46C9-BE6C-D4CA1EE9BD03@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <mark.brown314@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Chris,

The following patch https://patchwork.kernel.org/patch/792162/ is tested using Intel EG20T PCH, the Transcend MMC 1bit card can now be detected, read and write to the card successfully. 
Note : Need to add MMC_CAP_BUS_WIDTH_TEST caps into the SD host controller HW platform code in order to work.

Tested-by: tze.siong.mok@intel.com


-----Original Message-----
From: Philip Rakity [mailto:prakity@marvell.com] 
Sent: Wednesday, May 18, 2011 2:41 AM
To: linux-mmc@vger.kernel.org
Cc: Chris Ball; Mok, Tze Siong; Tomoya MORINAGA; Takashi Iwai; Mark Brown
Subject: [PATCH] mmc: eMMC bus width may not work on all platforms

CMD19 -- The offical way to validate bus widths from the
JEDEC spec does not work on all platforms.  Some platforms
that use PCI/PCIe to connect their SD controllers are known
to fail.

If the quirk MMC_BUS_WIDTH_TEST is not defined we try
to figure out the bus width by reading the ext_csd at different
bus widths and compare this against the ext_csd read in 1 bit
mode.  If no ext_csd is available we default to 1 bit operations.

Code has been tested on mmp2 against 8 bit eMMC and Transcend 2GB
card that is known to not work in 4 bit mode.  The physical
pins on the card are not present to support 4 bit operation.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/mmc.c |  135 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 125 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index baab027..42b5045 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -174,14 +174,17 @@ static int mmc_decode_csd(struct mmc_card *card)
 }
 
 /*
- * Read and decode extended CSD.
+ * Read extended CSD.
  */
-static int mmc_read_ext_csd(struct mmc_card *card)
+static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 {
 	int err;
 	u8 *ext_csd;
 
 	BUG_ON(!card);
+	BUG_ON(!new_ext_csd);
+
+	*new_ext_csd = NULL;
 
 	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
 		return 0;
@@ -199,12 +202,15 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 
 	err = mmc_send_ext_csd(card, ext_csd);
 	if (err) {
+		kfree(ext_csd);
+		*new_ext_csd = NULL;
+
 		/* If the host or the card can't do the switch,
 		 * fail more gracefully. */
 		if ((err != -EINVAL)
 		 && (err != -ENOSYS)
 		 && (err != -EFAULT))
-			goto out;
+			return err;
 
 		/*
 		 * High capacity cards should have this "magic" size
@@ -222,9 +228,23 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 				mmc_hostname(card->host));
 			err = 0;
 		}
+	} else
+		*new_ext_csd = ext_csd;
 
-		goto out;
-	}
+	return err;
+}
+
+/*
+ * Decode extended CSD.
+ */
+static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
+{
+	int err = 0;
+
+	BUG_ON(!card);
+
+	if (!ext_csd)
+		return 0;
 
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
 	if (card->csd.structure == 3) {
@@ -372,8 +392,92 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 		card->erased_byte = 0x0;
 
 out:
+	return err;
+}
+
+static inline void mmc_free_ext_csd(u8 *ext_csd)
+{
 	kfree(ext_csd);
+}
+
+static int mmc_cmp_ext_csd(u8 *ext_csd, u8 *bw_ext_csd, unsigned bus_width)
+{
+	if (ext_csd == NULL || bw_ext_csd == NULL)
+		return bus_width != MMC_BUS_WIDTH_1;
+
+	if (bus_width == MMC_BUS_WIDTH_1)
+		return 0;
+
+	/* only compare read only fields */
 
+	if (ext_csd[EXT_CSD_PARTITION_SUPPORT] !=
+		bw_ext_csd[EXT_CSD_PARTITION_SUPPORT])
+			return -1;
+
+	if (ext_csd[EXT_CSD_ERASED_MEM_CONT] !=
+		bw_ext_csd[EXT_CSD_ERASED_MEM_CONT])
+			return -2;
+
+	if (ext_csd[EXT_CSD_REV] !=
+		bw_ext_csd[EXT_CSD_REV])
+			return -3;
+
+	if (ext_csd[EXT_CSD_STRUCTURE] !=
+		bw_ext_csd[EXT_CSD_STRUCTURE])
+			return -4;
+
+	if (ext_csd[EXT_CSD_CARD_TYPE] !=
+		bw_ext_csd[EXT_CSD_CARD_TYPE])
+			return -5;
+
+	if (ext_csd[EXT_CSD_S_A_TIMEOUT] !=
+		bw_ext_csd[EXT_CSD_S_A_TIMEOUT])
+			return -6;
+
+	if (ext_csd[EXT_CSD_HC_WP_GRP_SIZE] !=
+		bw_ext_csd[EXT_CSD_HC_WP_GRP_SIZE])
+			return -7;
+
+	if (ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] !=
+		bw_ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT])
+			return -8;
+
+	if (ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] !=
+		bw_ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE])
+			return -9;
+
+	if (ext_csd[EXT_CSD_SEC_TRIM_MULT] !=
+		bw_ext_csd[EXT_CSD_SEC_TRIM_MULT])
+			return -10;
+
+	if (ext_csd[EXT_CSD_SEC_ERASE_MULT] !=
+		bw_ext_csd[EXT_CSD_SEC_ERASE_MULT])
+			return -11;
+
+	if (ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] !=
+		bw_ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT])
+			return -12;
+
+	if (ext_csd[EXT_CSD_TRIM_MULT] !=
+		bw_ext_csd[EXT_CSD_TRIM_MULT])
+			return -13;
+
+	return memcmp(&ext_csd[EXT_CSD_SEC_CNT],
+			&bw_ext_csd[EXT_CSD_SEC_CNT],
+			4);
+}
+
+static int mmc_compare_ext_csds(struct mmc_card *card, u8 *ext_csd,
+			unsigned bus_width)
+{
+	u8 *bw_ext_csd;
+	int err;
+
+	err = mmc_get_ext_csd(card, &bw_ext_csd);
+	if (!err)
+		err = mmc_cmp_ext_csd(ext_csd, bw_ext_csd, bus_width);
+
+	mmc_free_ext_csd(bw_ext_csd);
 	return err;
 }
 
@@ -438,6 +542,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	u32 cid[4];
 	unsigned int max_dtr;
 	u32 rocr;
+	u8 *ext_csd = NULL;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -536,7 +641,11 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		/*
 		 * Fetch and process extended CSD.
 		 */
-		err = mmc_read_ext_csd(card);
+
+		err = mmc_get_ext_csd(card, &ext_csd);
+		if (err)
+			goto free_card;
+		err = mmc_read_ext_csd(card, ext_csd);
 		if (err)
 			goto free_card;
 
@@ -676,14 +785,18 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 					 0);
 			if (!err) {
 				mmc_set_bus_width(card->host, bus_width);
+
 				/*
 				 * If controller can't handle bus width test,
-				 * use the highest bus width to maintain
-				 * compatibility with previous MMC behavior.
+				 * compare ext_csd previously read in 1 bit mode
+				 * against ext_csd at new bus width
 				 */
 				if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
-					break;
-				err = mmc_bus_test(card, bus_width);
+					err = mmc_compare_ext_csds(card,
+						ext_csd,
+						bus_width);
+				else
+					err = mmc_bus_test(card, bus_width);
 				if (!err)
 					break;
 			}
@@ -730,12 +843,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (!oldcard)
 		host->card = card;
 
+	mmc_free_ext_csd(ext_csd);
 	return 0;
 
 free_card:
 	if (!oldcard)
 		mmc_remove_card(card);
 err:
+	mmc_free_ext_csd(ext_csd);
 
 	return err;
 }
-- 
1.7.0.4


