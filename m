From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V2] mmc: eMMC bus width may not work on all platforms
Date: Sun, 22 May 2011 10:30:44 -0700
Message-ID: <15864FE4-25CB-46BC-ACC2-FC24C2E6E241@marvell.com>
References: <2FBABAF6-BFF6-46C9-BE6C-D4CA1EE9BD03@marvell.com>
 <1482D9D127C1754E8684047CF53F7660622B177DBE@pgsmsx505.gar.corp.intel.com>
 <m3fwo7r0nc.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:36156 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752905Ab1EVRa5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 22 May 2011 13:30:57 -0400
In-Reply-To: <m3fwo7r0nc.fsf@pullcord.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Mok, Tze Siong" <tze.siong.mok@intel.com>, Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <mark.brown314@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Note:  I cannot test test for a few days.  Following Chris suggestion posting to list.

version 2
---
return -EINVAL when compare of ext_csd_fails
combine two compare routines into one per suggestion
from Chris.

---
version 1

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
 drivers/mmc/core/mmc.c |  113 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index baab027..6db91d6 100644
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
@@ -372,8 +392,70 @@ static int mmc_read_ext_csd(struct mmc_card *card)
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
 
+static int mmc_compare_ext_csds(struct mmc_card *card, u8 *ext_csd,
+			unsigned bus_width)
+{
+	u8 *bw_ext_csd;
+	int err;
+
+	err = mmc_get_ext_csd(card, &bw_ext_csd);
+	if (err)
+		return err;
+
+	if ((ext_csd == NULL || bw_ext_csd == NULL)) {
+		if (bus_width != MMC_BUS_WIDTH_1)
+			err = -EINVAL;
+		goto out;
+	}
+
+	if (bus_width == MMC_BUS_WIDTH_1)
+		goto out;
+
+	/* only compare read only fields */
+
+	err =	(!(ext_csd[EXT_CSD_PARTITION_SUPPORT] ==
+			bw_ext_csd[EXT_CSD_PARTITION_SUPPORT]) &&
+		(ext_csd[EXT_CSD_ERASED_MEM_CONT] ==
+			bw_ext_csd[EXT_CSD_ERASED_MEM_CONT]) &&
+		(ext_csd[EXT_CSD_REV] ==
+			bw_ext_csd[EXT_CSD_REV]) &&
+		(ext_csd[EXT_CSD_STRUCTURE] ==
+			bw_ext_csd[EXT_CSD_STRUCTURE]) &&
+		(ext_csd[EXT_CSD_CARD_TYPE] ==
+			bw_ext_csd[EXT_CSD_CARD_TYPE]) &&
+		(ext_csd[EXT_CSD_S_A_TIMEOUT] ==
+			bw_ext_csd[EXT_CSD_S_A_TIMEOUT]) &&
+		(ext_csd[EXT_CSD_HC_WP_GRP_SIZE] ==
+			bw_ext_csd[EXT_CSD_HC_WP_GRP_SIZE]) &&
+		(ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] ==
+			bw_ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT]) &&
+		(ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] ==
+			bw_ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE]) &&
+		(ext_csd[EXT_CSD_SEC_TRIM_MULT] ==
+			bw_ext_csd[EXT_CSD_SEC_TRIM_MULT]) &&
+		(ext_csd[EXT_CSD_SEC_ERASE_MULT] ==
+			bw_ext_csd[EXT_CSD_SEC_ERASE_MULT]) &&
+		(ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] ==
+			bw_ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) &&
+		(ext_csd[EXT_CSD_TRIM_MULT] ==
+			bw_ext_csd[EXT_CSD_TRIM_MULT]) &&
+		memcmp(&ext_csd[EXT_CSD_SEC_CNT],
+			&bw_ext_csd[EXT_CSD_SEC_CNT],
+			4) != 0);
+	if (err)
+		err = -EINVAL;
+
+out:
+	mmc_free_ext_csd(bw_ext_csd);
 	return err;
 }

