From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 07/12] mmc: core: Remove unused struct _mmc_csd from public mmc.h header
Date: Wed, 11 Jan 2017 12:51:13 +0100
Message-ID: <1484135478-2077-8-git-send-email-ulf.hansson@linaro.org>
References: <1484135478-2077-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35943 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964914AbdAKLvx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2017 06:51:53 -0500
Received: by mail-lf0-f49.google.com with SMTP id o140so80122043lff.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2017 03:51:52 -0800 (PST)
In-Reply-To: <1484135478-2077-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/mmc/mmc.h | 44 --------------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 8f78543..7406d9b 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -184,50 +184,6 @@ static inline bool mmc_op_multi(u32 opcode)
 #define R2_SPI_OUT_OF_RANGE	(1 << 15)	/* or CSD overwrite */
 #define R2_SPI_CSD_OVERWRITE	R2_SPI_OUT_OF_RANGE
 
-/* These are unpacked versions of the actual responses */
-
-struct _mmc_csd {
-	u8  csd_structure;
-	u8  spec_vers;
-	u8  taac;
-	u8  nsac;
-	u8  tran_speed;
-	u16 ccc;
-	u8  read_bl_len;
-	u8  read_bl_partial;
-	u8  write_blk_misalign;
-	u8  read_blk_misalign;
-	u8  dsr_imp;
-	u16 c_size;
-	u8  vdd_r_curr_min;
-	u8  vdd_r_curr_max;
-	u8  vdd_w_curr_min;
-	u8  vdd_w_curr_max;
-	u8  c_size_mult;
-	union {
-		struct { /* MMC system specification version 3.1 */
-			u8  erase_grp_size;
-			u8  erase_grp_mult;
-		} v31;
-		struct { /* MMC system specification version 2.2 */
-			u8  sector_size;
-			u8  erase_grp_size;
-		} v22;
-	} erase;
-	u8  wp_grp_size;
-	u8  wp_grp_enable;
-	u8  default_ecc;
-	u8  r2w_factor;
-	u8  write_bl_len;
-	u8  write_bl_partial;
-	u8  file_format_grp;
-	u8  copy;
-	u8  perm_write_protect;
-	u8  tmp_write_protect;
-	u8  file_format;
-	u8  ecc;
-};
-
 /*
  * OCR bits are mostly in host.h
  */
-- 
1.9.1

