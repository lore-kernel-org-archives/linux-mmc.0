From: =?UTF-8?B?R3LDqWdvcnkgU291dGFkw6k=?= <gsoutade@neotion.com>
Subject: [PATCH v5 0001/0003] mmc: Move code that manages user area and gp
 partitions into functions
Date: Fri, 12 Sep 2014 16:31:17 +0200
Message-ID: <541303B5.6080100@neotion.com>
References: <53C7E45E.2060102@neotion.com>	<CAPDyKFoRpQBHGGCMPvEKdeVGjTO-rnyYVostLZGCV3dudD1rmA@mail.gmail.com>	<53EB2DC3.2080002@neotion.com>	<CAPDyKFpjYqVUZ8GHB76gD8pOx_eMg9ecvbWrMEfbhEd5ffk7mw@mail.gmail.com>	<53ECB95F.2030207@neotion.com> <CAPDyKFp2ekmucHVzMWxeKfyTmuFKTXAYwUEpL5QxvEh8AjFopg@mail.gmail.com> <53F1FBA3.6060108@neotion.com> <5411435C.3080905@neotion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.neotion.com ([5.39.84.84]:48768 "EHLO mail.neotion.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbaILOeW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Sep 2014 10:34:22 -0400
In-Reply-To: <5411435C.3080905@neotion.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Move code that manages user area and general purpose
 partitions into functions.

Signed-off-by: Gr=C3=A9gory Soutad=C3=A9 <gsoutade@neotion.com>
---
 drivers/mmc/core/mmc.c |  162 ++++++++++++++++++++++++++--------------=
--------
 1 file changed, 89 insertions(+), 73 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1eda8dd..77b4cf3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -298,6 +298,93 @@ static void mmc_select_card_type(struct mmc_card *=
card)
 	card->mmc_avail_type =3D avail_type;
 }

+static void mmc_manage_enhanced_area(struct mmc_card *card, u8 *ext_cs=
d)
+{
+	u8 hc_erase_grp_sz =3D 0, hc_wp_grp_sz =3D 0;
+
+	/*
+	 * Enhanced area feature support -- check whether the eMMC
+	 * card has the Enhanced area enabled.  If so, export enhanced
+	 * area offset and size to user by adding sysfs interface.
+	 */
+	if ((ext_csd[EXT_CSD_PARTITION_SUPPORT] & 0x2) &&
+	    (ext_csd[EXT_CSD_PARTITION_ATTRIBUTE] & 0x1)) {
+		hc_erase_grp_sz =3D
+			ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
+		hc_wp_grp_sz =3D
+			ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
+
+		card->ext_csd.enhanced_area_en =3D 1;
+		/*
+		 * calculate the enhanced data area offset, in bytes
+		 */
+		card->ext_csd.enhanced_area_offset =3D
+			(ext_csd[139] << 24) + (ext_csd[138] << 16) +
+			(ext_csd[137] << 8) + ext_csd[136];
+		if (mmc_card_blockaddr(card))
+			card->ext_csd.enhanced_area_offset <<=3D 9;
+		/*
+		 * calculate the enhanced data area size, in kilobytes
+		 */
+		card->ext_csd.enhanced_area_size =3D
+			(ext_csd[142] << 16) + (ext_csd[141] << 8) +
+			ext_csd[140];
+		card->ext_csd.enhanced_area_size *=3D
+			(size_t)(hc_erase_grp_sz * hc_wp_grp_sz);
+		card->ext_csd.enhanced_area_size <<=3D 9;
+	} else {
+		/*
+		 * If the enhanced area is not enabled, disable these
+		 * device attributes.
+		 */
+		card->ext_csd.enhanced_area_offset =3D -EINVAL;
+		card->ext_csd.enhanced_area_size =3D -EINVAL;
+	}
+}
+
+static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_cs=
d)
+{
+	unsigned int part_size;
+	u8 hc_erase_grp_sz =3D 0, hc_wp_grp_sz =3D 0;
+	int idx;
+
+	/*
+	 * General purpose partition feature support --
+	 * If ext_csd has the size of general purpose partitions,
+	 * set size, part_cfg, partition name in mmc_part.
+	 */
+	if (ext_csd[EXT_CSD_PARTITION_SUPPORT] &
+	    EXT_CSD_PART_SUPPORT_PART_EN) {
+		if (card->ext_csd.enhanced_area_en !=3D 1) {
+			hc_erase_grp_sz =3D
+				ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
+			hc_wp_grp_sz =3D
+				ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
+
+			card->ext_csd.enhanced_area_en =3D 1;
+		}
+
+		for (idx =3D 0; idx < MMC_NUM_GP_PARTITION; idx++) {
+			if (!ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3] &&
+			    !ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1] &&
+			    !ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 2])
+				continue;
+			part_size =3D
+				(ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 2]
+				<< 16) +
+				(ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1]
+				<< 8) +
+				ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
+			part_size *=3D (size_t)(hc_erase_grp_sz *
+				hc_wp_grp_sz);
+			mmc_part_add(card, part_size << 19,
+				EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
+				"gp%d", idx, false,
+				MMC_BLK_DATA_AREA_GP);
+		}
+	}
+}
+
 /*
  * Decode extended CSD.
  */
@@ -305,7 +392,6 @@ static int mmc_read_ext_csd(struct mmc_card *card, =
u8 *ext_csd)
 {
 	int err =3D 0, idx;
 	unsigned int part_size;
-	u8 hc_erase_grp_sz =3D 0, hc_wp_grp_sz =3D 0;

 	BUG_ON(!card);

@@ -402,80 +488,10 @@ static int mmc_read_ext_csd(struct mmc_card *card=
, u8 *ext_csd)
 		ext_csd[EXT_CSD_TRIM_MULT];
 	card->ext_csd.raw_partition_support =3D ext_csd[EXT_CSD_PARTITION_SUP=
PORT];
 	if (card->ext_csd.rev >=3D 4) {
-		/*
-		 * Enhanced area feature support -- check whether the eMMC
-		 * card has the Enhanced area enabled.  If so, export enhanced
-		 * area offset and size to user by adding sysfs interface.
-		 */
-		if ((ext_csd[EXT_CSD_PARTITION_SUPPORT] & 0x2) &&
-		    (ext_csd[EXT_CSD_PARTITION_ATTRIBUTE] & 0x1)) {
-			hc_erase_grp_sz =3D
-				ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
-			hc_wp_grp_sz =3D
-				ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
+		mmc_manage_enhanced_area(card, ext_csd);

-			card->ext_csd.enhanced_area_en =3D 1;
-			/*
-			 * calculate the enhanced data area offset, in bytes
-			 */
-			card->ext_csd.enhanced_area_offset =3D
-				(ext_csd[139] << 24) + (ext_csd[138] << 16) +
-				(ext_csd[137] << 8) + ext_csd[136];
-			if (mmc_card_blockaddr(card))
-				card->ext_csd.enhanced_area_offset <<=3D 9;
-			/*
-			 * calculate the enhanced data area size, in kilobytes
-			 */
-			card->ext_csd.enhanced_area_size =3D
-				(ext_csd[142] << 16) + (ext_csd[141] << 8) +
-				ext_csd[140];
-			card->ext_csd.enhanced_area_size *=3D
-				(size_t)(hc_erase_grp_sz * hc_wp_grp_sz);
-			card->ext_csd.enhanced_area_size <<=3D 9;
-		} else {
-			/*
-			 * If the enhanced area is not enabled, disable these
-			 * device attributes.
-			 */
-			card->ext_csd.enhanced_area_offset =3D -EINVAL;
-			card->ext_csd.enhanced_area_size =3D -EINVAL;
-		}
+		mmc_manage_gp_partitions(card, ext_csd);

-		/*
-		 * General purpose partition feature support --
-		 * If ext_csd has the size of general purpose partitions,
-		 * set size, part_cfg, partition name in mmc_part.
-		 */
-		if (ext_csd[EXT_CSD_PARTITION_SUPPORT] &
-			EXT_CSD_PART_SUPPORT_PART_EN) {
-			if (card->ext_csd.enhanced_area_en !=3D 1) {
-				hc_erase_grp_sz =3D
-					ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
-				hc_wp_grp_sz =3D
-					ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
-
-				card->ext_csd.enhanced_area_en =3D 1;
-			}
-
-			for (idx =3D 0; idx < MMC_NUM_GP_PARTITION; idx++) {
-				if (!ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3] &&
-				!ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1] &&
-				!ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 2])
-					continue;
-				part_size =3D
-				(ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 2]
-					<< 16) +
-				(ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1]
-					<< 8) +
-				ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
-				part_size *=3D (size_t)(hc_erase_grp_sz *
-					hc_wp_grp_sz);
-				mmc_part_add(card, part_size << 19,
-					EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
-					"gp%d", idx, false,
-					MMC_BLK_DATA_AREA_GP);
-			}
-		}
 		card->ext_csd.sec_trim_mult =3D
 			ext_csd[EXT_CSD_SEC_TRIM_MULT];
 		card->ext_csd.sec_erase_mult =3D
--=20
1.7.9.5
