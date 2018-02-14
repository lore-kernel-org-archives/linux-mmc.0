From: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Subject: [PATCH -next v4] mtd: nand: toshiba: Retrieve ECC requirements from extended ID
Date: Thu, 15 Feb 2018 00:35:06 +0900
Message-ID: <1518622506-16606-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com, marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
List-Id: linux-mmc@vger.kernel.org

This patch enables support to read the ECC strength and size from the
NAND flash using Toshiba Memory SLC NAND extended-ID. This patch is
based on the information of the 6th ID byte of the Toshiba Memory SLC
NAND.

Signed-off-by: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
---
 drivers/mtd/nand/nand_toshiba.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mtd/nand/nand_toshiba.c b/drivers/mtd/nand/nand_toshiba.c
index 57df857..ab43f02 100644
--- a/drivers/mtd/nand/nand_toshiba.c
+++ b/drivers/mtd/nand/nand_toshiba.c
@@ -35,6 +35,32 @@ static void toshiba_nand_decode_id(struct nand_chip *chip)
 	    (chip->id.data[5] & 0x7) == 0x6 /* 24nm */ &&
 	    !(chip->id.data[4] & 0x80) /* !BENAND */)
 		mtd->oobsize = 32 * mtd->writesize >> 9;
+
+	/*
+	 * Extract ECC requirements from 6th id byte.
+	 * For Toshiba SLC, ecc requrements are as follows:
+	 *  - 43nm: 1 bit ECC for each 512Byte is required.
+	 *  - 32nm: 4 bit ECC for each 512Byte is required.
+	 *  - 24nm: 8 bit ECC for each 512Byte is required.
+	 */
+	if (chip->id.len >= 6 && nand_is_slc(chip)) {
+		chip->ecc_step_ds = 512;
+		switch (chip->id.data[5] & 0x7) {
+		case 0x4:
+			chip->ecc_strength_ds = 1;
+			break;
+		case 0x5:
+			chip->ecc_strength_ds = 4;
+			break;
+		case 0x6:
+			chip->ecc_strength_ds = 8;
+			break;
+		default:
+			WARN(1, "Could not get ECC info");
+			chip->ecc_step_ds = 0;
+			break;
+		}
+	}
 }
 
 static int toshiba_nand_init(struct nand_chip *chip)
-- 
2.7.4
