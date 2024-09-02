Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7E19C54F
	for <linux-mmc@vger.kernel.org>; Mon,  2 Sep 2024 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280520; cv=none; b=IPCJP8WKc1ZGlK+rAXnvh3yc74QeH8+kd3e4X4egxEfy4Tc78n7D0Hxmq4NJS9xos2h+77PHEw8YN4I3cOEDhPzcSIsQq21cb9KKEfEsgcy6IfkkrZ/J+hDGPDlPLzqLOxjSfOj6c25+935JZczA6FeiuVqTH8dBiSVYpqJPjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280520; c=relaxed/simple;
	bh=PMAU1yy7Xul5XBwcEyyI8//2C07UtHgqHkakRHY2GWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gvWmjrO02Ul7H3ymsJwfmQ+wM2HCiEpPrZH/1QE4RgHWon/374asF7PYUqiAXaidt8+gcsMxCI54t12j9A+Sw0sc8CmdHRhnIOO0l53DqIicK9vlkkmHyoKWxqSrxyYOMTvcFRsVA1RNLlWzfwBnyEEaPOXpXkbZlJ0Kfkh1HEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RpQGveeC; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RpQGveeC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725280515; x=1756816515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PMAU1yy7Xul5XBwcEyyI8//2C07UtHgqHkakRHY2GWA=;
  b=RpQGveeCuTcfSiADFsV3X3M9zwQhOkJOEWMCDjp8MMjfhqY5yuzT1Q1L
   UTO6A/vJu6PuNUeZRpELHGCv6e9E+njMqmKqW3Ejuw4BZbPcnIqRCd/hU
   uqwtxXuAnawcCTy9JYnUIv/LAyy5Eh+FlBATw/9ujNqYTLURf2fzi745S
   LfJGtZyr78AQwg8vilVOmyo3/QUiapeuq3oJiskGBaInQPbw4svLMhQ3H
   TZMaimn+86pnC2zYi1r+amgAJXibUYLmpkFaaayPsy0LMuEQHmgQ72PnY
   vVS4YN8gXHwgnOHdwvB0zQTmcu4k/psze/kZVHiya5J+pSFdYoKePRknx
   w==;
X-CSE-ConnectionGUID: BO+9qvOwSHeq9UGSazEHoA==
X-CSE-MsgGUID: ynetVFZ2Qtahfmm8V19DuQ==
X-IronPort-AV: E=Sophos;i="6.10,195,1719849600"; 
   d="scan'208";a="26724406"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2024 20:35:08 +0800
IronPort-SDR: 66d5a438_GTB1JJVuOmIiAeU6lzbt8VWPYLfneHR4s9lgdO2kqg0fl8j
 41M23nPpHwd3iUmbJYAPoKSffyDg1YXILpWn3OQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 04:40:40 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 05:35:09 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc: core Convert UNSTUFF_BITS macro to inline function
Date: Mon,  2 Sep 2024 15:33:31 +0300
Message-Id: <20240902123331.3566447-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UNSTUFF_BITS macro, which is defined in both drivers/mmc/core/mmc.c
and drivers/mmc/core/sd.c, has been converted to an inline function to
improve readability, maintainability, and type safety.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/mmc.c     | 106 ++++++++++++++------------------
 drivers/mmc/core/mmc_ops.h |  14 +++++
 drivers/mmc/core/sd.c      | 120 ++++++++++++++++---------------------
 3 files changed, 113 insertions(+), 127 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5b2f7c285461..6a23be214543 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -51,20 +51,6 @@ static const unsigned int taac_mant[] = {
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
 
-#define UNSTUFF_BITS(resp,start,size)					\
-	({								\
-		const int __size = size;				\
-		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
-		const int __off = 3 - ((start) / 32);			\
-		const int __shft = (start) & 31;			\
-		u32 __res;						\
-									\
-		__res = resp[__off] >> __shft;				\
-		if (__size + __shft > 32)				\
-			__res |= resp[__off-1] << ((32 - __shft) % 32);	\
-		__res & __mask;						\
-	})
-
 /*
  * Given the decoded CSD structure, decode the raw CID to our CID structure.
  */
@@ -85,36 +71,36 @@ static int mmc_decode_cid(struct mmc_card *card)
 	switch (card->csd.mmca_vsn) {
 	case 0: /* MMC v1.0 - v1.2 */
 	case 1: /* MMC v1.4 */
-		card->cid.manfid	= UNSTUFF_BITS(resp, 104, 24);
-		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
-		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
-		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
-		card->cid.prod_name[3]	= UNSTUFF_BITS(resp, 72, 8);
-		card->cid.prod_name[4]	= UNSTUFF_BITS(resp, 64, 8);
-		card->cid.prod_name[5]	= UNSTUFF_BITS(resp, 56, 8);
-		card->cid.prod_name[6]	= UNSTUFF_BITS(resp, 48, 8);
-		card->cid.hwrev		= UNSTUFF_BITS(resp, 44, 4);
-		card->cid.fwrev		= UNSTUFF_BITS(resp, 40, 4);
-		card->cid.serial	= UNSTUFF_BITS(resp, 16, 24);
-		card->cid.month		= UNSTUFF_BITS(resp, 12, 4);
-		card->cid.year		= UNSTUFF_BITS(resp, 8, 4) + 1997;
+		card->cid.manfid	= unstuff_bits(resp, 104, 24);
+		card->cid.prod_name[0]	= unstuff_bits(resp, 96, 8);
+		card->cid.prod_name[1]	= unstuff_bits(resp, 88, 8);
+		card->cid.prod_name[2]	= unstuff_bits(resp, 80, 8);
+		card->cid.prod_name[3]	= unstuff_bits(resp, 72, 8);
+		card->cid.prod_name[4]	= unstuff_bits(resp, 64, 8);
+		card->cid.prod_name[5]	= unstuff_bits(resp, 56, 8);
+		card->cid.prod_name[6]	= unstuff_bits(resp, 48, 8);
+		card->cid.hwrev		= unstuff_bits(resp, 44, 4);
+		card->cid.fwrev		= unstuff_bits(resp, 40, 4);
+		card->cid.serial	= unstuff_bits(resp, 16, 24);
+		card->cid.month		= unstuff_bits(resp, 12, 4);
+		card->cid.year		= unstuff_bits(resp, 8, 4) + 1997;
 		break;
 
 	case 2: /* MMC v2.0 - v2.2 */
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
-		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
-		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
-		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
-		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
-		card->cid.prod_name[3]	= UNSTUFF_BITS(resp, 72, 8);
-		card->cid.prod_name[4]	= UNSTUFF_BITS(resp, 64, 8);
-		card->cid.prod_name[5]	= UNSTUFF_BITS(resp, 56, 8);
-		card->cid.prv		= UNSTUFF_BITS(resp, 48, 8);
-		card->cid.serial	= UNSTUFF_BITS(resp, 16, 32);
-		card->cid.month		= UNSTUFF_BITS(resp, 12, 4);
-		card->cid.year		= UNSTUFF_BITS(resp, 8, 4) + 1997;
+		card->cid.manfid	= unstuff_bits(resp, 120, 8);
+		card->cid.oemid		= unstuff_bits(resp, 104, 16);
+		card->cid.prod_name[0]	= unstuff_bits(resp, 96, 8);
+		card->cid.prod_name[1]	= unstuff_bits(resp, 88, 8);
+		card->cid.prod_name[2]	= unstuff_bits(resp, 80, 8);
+		card->cid.prod_name[3]	= unstuff_bits(resp, 72, 8);
+		card->cid.prod_name[4]	= unstuff_bits(resp, 64, 8);
+		card->cid.prod_name[5]	= unstuff_bits(resp, 56, 8);
+		card->cid.prv		= unstuff_bits(resp, 48, 8);
+		card->cid.serial	= unstuff_bits(resp, 16, 32);
+		card->cid.month		= unstuff_bits(resp, 12, 4);
+		card->cid.year		= unstuff_bits(resp, 8, 4) + 1997;
 		break;
 
 	default:
@@ -161,43 +147,43 @@ static int mmc_decode_csd(struct mmc_card *card)
 	 * v1.2 has extra information in bits 15, 11 and 10.
 	 * We also support eMMC v4.4 & v4.41.
 	 */
-	csd->structure = UNSTUFF_BITS(resp, 126, 2);
+	csd->structure = unstuff_bits(resp, 126, 2);
 	if (csd->structure == 0) {
 		pr_err("%s: unrecognised CSD structure version %d\n",
 			mmc_hostname(card->host), csd->structure);
 		return -EINVAL;
 	}
 
-	csd->mmca_vsn	 = UNSTUFF_BITS(resp, 122, 4);
-	m = UNSTUFF_BITS(resp, 115, 4);
-	e = UNSTUFF_BITS(resp, 112, 3);
+	csd->mmca_vsn	 = unstuff_bits(resp, 122, 4);
+	m = unstuff_bits(resp, 115, 4);
+	e = unstuff_bits(resp, 112, 3);
 	csd->taac_ns	 = (taac_exp[e] * taac_mant[m] + 9) / 10;
-	csd->taac_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
+	csd->taac_clks	 = unstuff_bits(resp, 104, 8) * 100;
 
-	m = UNSTUFF_BITS(resp, 99, 4);
-	e = UNSTUFF_BITS(resp, 96, 3);
+	m = unstuff_bits(resp, 99, 4);
+	e = unstuff_bits(resp, 96, 3);
 	csd->max_dtr	  = tran_exp[e] * tran_mant[m];
-	csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+	csd->cmdclass	  = unstuff_bits(resp, 84, 12);
 
-	e = UNSTUFF_BITS(resp, 47, 3);
-	m = UNSTUFF_BITS(resp, 62, 12);
+	e = unstuff_bits(resp, 47, 3);
+	m = unstuff_bits(resp, 62, 12);
 	csd->capacity	  = (1 + m) << (e + 2);
 
-	csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);
-	csd->read_partial = UNSTUFF_BITS(resp, 79, 1);
-	csd->write_misalign = UNSTUFF_BITS(resp, 78, 1);
-	csd->read_misalign = UNSTUFF_BITS(resp, 77, 1);
-	csd->dsr_imp = UNSTUFF_BITS(resp, 76, 1);
-	csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
-	csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
-	csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
+	csd->read_blkbits = unstuff_bits(resp, 80, 4);
+	csd->read_partial = unstuff_bits(resp, 79, 1);
+	csd->write_misalign = unstuff_bits(resp, 78, 1);
+	csd->read_misalign = unstuff_bits(resp, 77, 1);
+	csd->dsr_imp = unstuff_bits(resp, 76, 1);
+	csd->r2w_factor = unstuff_bits(resp, 26, 3);
+	csd->write_blkbits = unstuff_bits(resp, 22, 4);
+	csd->write_partial = unstuff_bits(resp, 21, 1);
 
 	if (csd->write_blkbits >= 9) {
-		a = UNSTUFF_BITS(resp, 42, 5);
-		b = UNSTUFF_BITS(resp, 37, 5);
+		a = unstuff_bits(resp, 42, 5);
+		b = unstuff_bits(resp, 37, 5);
 		csd->erase_size = (a + 1) * (b + 1);
 		csd->erase_size <<= csd->write_blkbits - 9;
-		csd->wp_grp_size = UNSTUFF_BITS(resp, 32, 5);
+		csd->wp_grp_size = unstuff_bits(resp, 32, 5);
 	}
 
 	return 0;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 92d4194c7893..06017110e1b0 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -56,5 +56,19 @@ int mmc_cmdq_enable(struct mmc_card *card);
 int mmc_cmdq_disable(struct mmc_card *card);
 int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
 
+static inline u32 unstuff_bits(const u32 *resp, int start, int size)
+{
+	const int __size = size;
+	const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;
+	const int __off = 3 - (start / 32);
+	const int __shft = start & 31;
+	u32 __res = resp[__off] >> __shft;
+
+	if (__size + __shft > 32)
+		__res |= resp[__off - 1] << ((32 - __shft) % 32);
+
+	return __res & __mask;
+}
+
 #endif
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ee37ad14e79e..3272c541516e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -56,20 +56,6 @@ static const unsigned int sd_au_size[] = {
 	SZ_16M / 512,	(SZ_16M + SZ_8M) / 512,	SZ_32M / 512,	SZ_64M / 512,
 };
 
-#define UNSTUFF_BITS(resp,start,size)					\
-	({								\
-		const int __size = size;				\
-		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
-		const int __off = 3 - ((start) / 32);			\
-		const int __shft = (start) & 31;			\
-		u32 __res;						\
-									\
-		__res = resp[__off] >> __shft;				\
-		if (__size + __shft > 32)				\
-			__res |= resp[__off-1] << ((32 - __shft) % 32);	\
-		__res & __mask;						\
-	})
-
 #define SD_POWEROFF_NOTIFY_TIMEOUT_MS 1000
 #define SD_WRITE_EXTR_SINGLE_TIMEOUT_MS 1000
 
@@ -95,18 +81,18 @@ void mmc_decode_cid(struct mmc_card *card)
 	 * SD doesn't currently have a version field so we will
 	 * have to assume we can parse this.
 	 */
-	card->cid.manfid		= UNSTUFF_BITS(resp, 120, 8);
-	card->cid.oemid			= UNSTUFF_BITS(resp, 104, 16);
-	card->cid.prod_name[0]		= UNSTUFF_BITS(resp, 96, 8);
-	card->cid.prod_name[1]		= UNSTUFF_BITS(resp, 88, 8);
-	card->cid.prod_name[2]		= UNSTUFF_BITS(resp, 80, 8);
-	card->cid.prod_name[3]		= UNSTUFF_BITS(resp, 72, 8);
-	card->cid.prod_name[4]		= UNSTUFF_BITS(resp, 64, 8);
-	card->cid.hwrev			= UNSTUFF_BITS(resp, 60, 4);
-	card->cid.fwrev			= UNSTUFF_BITS(resp, 56, 4);
-	card->cid.serial		= UNSTUFF_BITS(resp, 24, 32);
-	card->cid.year			= UNSTUFF_BITS(resp, 12, 8);
-	card->cid.month			= UNSTUFF_BITS(resp, 8, 4);
+	card->cid.manfid		= unstuff_bits(resp, 120, 8);
+	card->cid.oemid			= unstuff_bits(resp, 104, 16);
+	card->cid.prod_name[0]		= unstuff_bits(resp, 96, 8);
+	card->cid.prod_name[1]		= unstuff_bits(resp, 88, 8);
+	card->cid.prod_name[2]		= unstuff_bits(resp, 80, 8);
+	card->cid.prod_name[3]		= unstuff_bits(resp, 72, 8);
+	card->cid.prod_name[4]		= unstuff_bits(resp, 64, 8);
+	card->cid.hwrev			= unstuff_bits(resp, 60, 4);
+	card->cid.fwrev			= unstuff_bits(resp, 56, 4);
+	card->cid.serial		= unstuff_bits(resp, 24, 32);
+	card->cid.year			= unstuff_bits(resp, 12, 8);
+	card->cid.month			= unstuff_bits(resp, 8, 4);
 
 	card->cid.year += 2000; /* SD cards year offset */
 }
@@ -120,41 +106,41 @@ static int mmc_decode_csd(struct mmc_card *card)
 	unsigned int e, m, csd_struct;
 	u32 *resp = card->raw_csd;
 
-	csd_struct = UNSTUFF_BITS(resp, 126, 2);
+	csd_struct = unstuff_bits(resp, 126, 2);
 
 	switch (csd_struct) {
 	case 0:
-		m = UNSTUFF_BITS(resp, 115, 4);
-		e = UNSTUFF_BITS(resp, 112, 3);
+		m = unstuff_bits(resp, 115, 4);
+		e = unstuff_bits(resp, 112, 3);
 		csd->taac_ns	 = (taac_exp[e] * taac_mant[m] + 9) / 10;
-		csd->taac_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
+		csd->taac_clks	 = unstuff_bits(resp, 104, 8) * 100;
 
-		m = UNSTUFF_BITS(resp, 99, 4);
-		e = UNSTUFF_BITS(resp, 96, 3);
+		m = unstuff_bits(resp, 99, 4);
+		e = unstuff_bits(resp, 96, 3);
 		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
-		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+		csd->cmdclass	  = unstuff_bits(resp, 84, 12);
 
-		e = UNSTUFF_BITS(resp, 47, 3);
-		m = UNSTUFF_BITS(resp, 62, 12);
+		e = unstuff_bits(resp, 47, 3);
+		m = unstuff_bits(resp, 62, 12);
 		csd->capacity	  = (1 + m) << (e + 2);
 
-		csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);
-		csd->read_partial = UNSTUFF_BITS(resp, 79, 1);
-		csd->write_misalign = UNSTUFF_BITS(resp, 78, 1);
-		csd->read_misalign = UNSTUFF_BITS(resp, 77, 1);
-		csd->dsr_imp = UNSTUFF_BITS(resp, 76, 1);
-		csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
-		csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
-		csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
+		csd->read_blkbits = unstuff_bits(resp, 80, 4);
+		csd->read_partial = unstuff_bits(resp, 79, 1);
+		csd->write_misalign = unstuff_bits(resp, 78, 1);
+		csd->read_misalign = unstuff_bits(resp, 77, 1);
+		csd->dsr_imp = unstuff_bits(resp, 76, 1);
+		csd->r2w_factor = unstuff_bits(resp, 26, 3);
+		csd->write_blkbits = unstuff_bits(resp, 22, 4);
+		csd->write_partial = unstuff_bits(resp, 21, 1);
 
-		if (UNSTUFF_BITS(resp, 46, 1)) {
+		if (unstuff_bits(resp, 46, 1)) {
 			csd->erase_size = 1;
 		} else if (csd->write_blkbits >= 9) {
-			csd->erase_size = UNSTUFF_BITS(resp, 39, 7) + 1;
+			csd->erase_size = unstuff_bits(resp, 39, 7) + 1;
 			csd->erase_size <<= csd->write_blkbits - 9;
 		}
 
-		if (UNSTUFF_BITS(resp, 13, 1))
+		if (unstuff_bits(resp, 13, 1))
 			mmc_card_set_readonly(card);
 		break;
 	case 1:
@@ -169,17 +155,17 @@ static int mmc_decode_csd(struct mmc_card *card)
 		csd->taac_ns	 = 0; /* Unused */
 		csd->taac_clks	 = 0; /* Unused */
 
-		m = UNSTUFF_BITS(resp, 99, 4);
-		e = UNSTUFF_BITS(resp, 96, 3);
+		m = unstuff_bits(resp, 99, 4);
+		e = unstuff_bits(resp, 96, 3);
 		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
-		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
-		csd->c_size	  = UNSTUFF_BITS(resp, 48, 22);
+		csd->cmdclass	  = unstuff_bits(resp, 84, 12);
+		csd->c_size	  = unstuff_bits(resp, 48, 22);
 
 		/* SDXC cards have a minimum C_SIZE of 0x00FFFF */
 		if (csd->c_size >= 0xFFFF)
 			mmc_card_set_ext_capacity(card);
 
-		m = UNSTUFF_BITS(resp, 48, 22);
+		m = unstuff_bits(resp, 48, 22);
 		csd->capacity     = (1 + m) << 10;
 
 		csd->read_blkbits = 9;
@@ -191,7 +177,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 		csd->write_partial = 0;
 		csd->erase_size = 1;
 
-		if (UNSTUFF_BITS(resp, 13, 1))
+		if (unstuff_bits(resp, 13, 1))
 			mmc_card_set_readonly(card);
 		break;
 	default:
@@ -217,33 +203,33 @@ static int mmc_decode_scr(struct mmc_card *card)
 	resp[3] = card->raw_scr[1];
 	resp[2] = card->raw_scr[0];
 
-	scr_struct = UNSTUFF_BITS(resp, 60, 4);
+	scr_struct = unstuff_bits(resp, 60, 4);
 	if (scr_struct != 0) {
 		pr_err("%s: unrecognised SCR structure version %d\n",
 			mmc_hostname(card->host), scr_struct);
 		return -EINVAL;
 	}
 
-	scr->sda_vsn = UNSTUFF_BITS(resp, 56, 4);
-	scr->bus_widths = UNSTUFF_BITS(resp, 48, 4);
+	scr->sda_vsn = unstuff_bits(resp, 56, 4);
+	scr->bus_widths = unstuff_bits(resp, 48, 4);
 	if (scr->sda_vsn == SCR_SPEC_VER_2)
 		/* Check if Physical Layer Spec v3.0 is supported */
-		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
+		scr->sda_spec3 = unstuff_bits(resp, 47, 1);
 
 	if (scr->sda_spec3) {
-		scr->sda_spec4 = UNSTUFF_BITS(resp, 42, 1);
-		scr->sda_specx = UNSTUFF_BITS(resp, 38, 4);
+		scr->sda_spec4 = unstuff_bits(resp, 42, 1);
+		scr->sda_specx = unstuff_bits(resp, 38, 4);
 	}
 
-	if (UNSTUFF_BITS(resp, 55, 1))
+	if (unstuff_bits(resp, 55, 1))
 		card->erased_byte = 0xFF;
 	else
 		card->erased_byte = 0x0;
 
 	if (scr->sda_spec4)
-		scr->cmds = UNSTUFF_BITS(resp, 32, 4);
+		scr->cmds = unstuff_bits(resp, 32, 4);
 	else if (scr->sda_spec3)
-		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
+		scr->cmds = unstuff_bits(resp, 32, 2);
 
 	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
 	if (!(scr->bus_widths & SD_SCR_BUS_WIDTH_1) ||
@@ -289,17 +275,17 @@ static int mmc_read_ssr(struct mmc_card *card)
 	kfree(raw_ssr);
 
 	/*
-	 * UNSTUFF_BITS only works with four u32s so we have to offset the
+	 * unstuff_bits only works with four u32s so we have to offset the
 	 * bitfield positions accordingly.
 	 */
-	au = UNSTUFF_BITS(card->raw_ssr, 428 - 384, 4);
+	au = unstuff_bits(card->raw_ssr, 428 - 384, 4);
 	if (au) {
 		if (au <= 9 || card->scr.sda_spec3) {
 			card->ssr.au = sd_au_size[au];
-			es = UNSTUFF_BITS(card->raw_ssr, 408 - 384, 16);
-			et = UNSTUFF_BITS(card->raw_ssr, 402 - 384, 6);
+			es = unstuff_bits(card->raw_ssr, 408 - 384, 16);
+			et = unstuff_bits(card->raw_ssr, 402 - 384, 6);
 			if (es && et) {
-				eo = UNSTUFF_BITS(card->raw_ssr, 400 - 384, 2);
+				eo = unstuff_bits(card->raw_ssr, 400 - 384, 2);
 				card->ssr.erase_timeout = (et * 1000) / es;
 				card->ssr.erase_offset = eo * 1000;
 			}
@@ -313,7 +299,7 @@ static int mmc_read_ssr(struct mmc_card *card)
 	 * starting SD5.1 discard is supported if DISCARD_SUPPORT (b313) is set
 	 */
 	resp[3] = card->raw_ssr[6];
-	discard_support = UNSTUFF_BITS(resp, 313 - 288, 1);
+	discard_support = unstuff_bits(resp, 313 - 288, 1);
 	card->erase_arg = (card->scr.sda_specx && discard_support) ?
 			    SD_DISCARD_ARG : SD_ERASE_ARG;
 
-- 
2.25.1

