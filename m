Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD288CE7AFC
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjI1SIw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjI1SIv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 14:08:51 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E019F
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695924527; x=1727460527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zs3XBOSyrzyHxYL4YE8uHOGZVC68kXutC3jeqKq/a70=;
  b=UoaQf5aNmcV3z/133632xrMIZaMZ3oKqp2pQBYaumCUKARB+vrkTMB/6
   tQ7lHQHwDs1aL9SZLGTFji1XRJyeMhqG0yOlk6WuQ1uvaVR13qonqDhi3
   Ea6BhAJ9ctpiLDLiHNKER3qHBcODpxF1E6IqbjpwAYEBZZ12Yexri/HPP
   M4cnFAgedb1Hhkhvt9aoosUR4E2VvRVoCoE8Hg7V46ZlYU5fBruexZ6YR
   l+wW6CbEeMDSYnZCjYw+RhKExxlLA/zU2ZYllKsfMPRX1bHGIlKk4ggjt
   Ouu3tpoGzYzfZPbf/JkHY2VOxRpxkwx3z4T3r1C76s/CmkUNxelarcnID
   g==;
X-CSE-ConnectionGUID: siWRNCW2Q1iNbUjmlMY9OA==
X-CSE-MsgGUID: DQiJOzC3QYui2BHdl6PErw==
X-IronPort-AV: E=Sophos;i="6.03,184,1694707200"; 
   d="scan'208";a="249714713"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2023 02:08:47 +0800
IronPort-SDR: hllBIL4mH3o4RoZNU3m9cfW0eXmKX4ACzyikNLpcNLneYium89o+eOkdr3xo166pqooLgzmEJW
 1U8+GQ6O+ac6Okw/FIrDEtIIMDB3Gg85Qnwi6Kc4PtfWC7+ej/BQC2rL8TtlXGI1Ks4Z7xiAis
 A4Qjw6c1EoxEEzbTaQKydV3w2t5JUaWRNphBzqFiWb2Fqkt0td+NUZ628vWMgNGSxlVaOt7pyR
 maR/M2Umnrzar1KnNNMrKgRhrKc0sXfsY6OlDm6YF4+X8a3cCYCV6YGDKXZh/AUmlToD9lHyRU
 5Dk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 10:21:12 -0700
IronPort-SDR: +wxbPxadbSl3Qrsqa5nprecOwQo+daL7qSl7CjoC72jYHAbWm9dV5pdShu5Tpk/ks8GcS27x+f
 Kj69k7gSLgJzwBrKHz9bqtRDbKkk5IixbBTxbvemHiE2v/J4c3rU8/WMxUJhBL8SVz6kG6464K
 tAST/jk2MHRbtL6mJBQwVt8YuQtfQ4s5bwsrm5o1RLwurtfJ5jNnldhKZuGwfHqvRl1JqluI0/
 l9KQGeb5PZY03Rgj8Q96N3FE/k1d+TGMMZ8K3QXxTfSeOei4yWWHMH1psUE2gjsi4DDYVTk4Uc
 PyU=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2023 11:08:46 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 3/4] mmc-utils: lsmmc: Disintegrade print_mmc_csd
Date:   Thu, 28 Sep 2023 21:06:57 +0300
Message-Id: <20230928180658.1795491-4-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928180658.1795491-1-avri.altman@wdc.com>
References: <20230928180658.1795491-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Make it more readable and manageable.  No functional change.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 1322 +++++++++++++++++++++++++++----------------------------
 1 file changed, 653 insertions(+), 669 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index e9b0762..c984d9a 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -1225,502 +1225,677 @@ void print_sd_csd(struct config *config, char *csd)
 	}
 }
 
-void print_mmc_csd(struct config *config, char *csd)
+static void print_mmc_csd_structure(unsigned int csd_structure)
 {
-	unsigned int csd_structure;
-	unsigned int spec_vers;
-	unsigned int taac_timevalue;
-	unsigned int taac_timeunit;
-	unsigned int nsac;
-	unsigned int tran_speed_timevalue;
-	unsigned int tran_speed_transferrateunit;
-	unsigned int ccc;
-	unsigned int read_bl_len;
-	unsigned int read_bl_partial;
-	unsigned int write_blk_misalign;
-	unsigned int read_blk_misalign;
-	unsigned int dsr_imp;
-	unsigned int c_size;
-	unsigned int vdd_r_curr_min;
-	unsigned int vdd_r_curr_max;
-	unsigned int vdd_w_curr_min;
-	unsigned int vdd_w_curr_max;
-	unsigned int c_size_mult;
-	unsigned int erase_grp_size;
-	unsigned int erase_grp_mult;
-	unsigned int wp_grp_size;
-	unsigned int wp_grp_enable;
-	unsigned int default_ecc;
-	unsigned int r2w_factor;
-	unsigned int write_bl_len;
-	unsigned int write_bl_partial;
-	unsigned int content_prot_app;
-	unsigned int file_format_grp;
-	unsigned int copy;
-	unsigned int perm_write_protect;
-	unsigned int tmp_write_protect;
-	unsigned int file_format;
-	unsigned int ecc;
-	unsigned int crc;
-	unsigned int taac;
-	unsigned int tran_speed;
+	printf("\tCSD_STRUCTURE: 0x%01x (", csd_structure);
+	switch (csd_structure) {
+	case 0x0:
+		printf("v1.0)\n");
+		break;
+	case 0x1:
+		printf("v1.1)\n");
+		break;
+	case 0x2:
+		printf("v1.2)\n");
+		break;
+	case 0x3:
+		printf("version in ext_csd)\n");
+		break;
+	}
+}
 
-	parse_bin(csd, "2u4u2r1r4u3u8u1r4u3u12u4u1u1u1u1u2r12u3u3u3u3u3u"
-		  "5u5u5u1u2u3u4u1u4r1u1u1u1u1u2u2u7u1r",
-		  &csd_structure, &spec_vers, &taac_timevalue,
-		  &taac_timeunit, &nsac, &tran_speed_timevalue,
-		  &tran_speed_transferrateunit, &ccc, &read_bl_len,
-		  &read_bl_partial, &write_blk_misalign,
-		  &read_blk_misalign, &dsr_imp, &c_size,
-		  &vdd_r_curr_min, &vdd_r_curr_max,
-		  &vdd_w_curr_min, &vdd_w_curr_max, &c_size_mult,
-		  &erase_grp_size, &erase_grp_mult, &wp_grp_size,
-		  &wp_grp_enable, &default_ecc, &r2w_factor,
-		  &write_bl_len, &write_bl_partial, &content_prot_app,
-		  &file_format_grp, &copy, &perm_write_protect,
-		  &tmp_write_protect, &file_format, &ecc, &crc);
+static void print_mmc_csd_spec_ver(unsigned int spec_vers)
+{
+	printf("\tSPEC_VERS: 0x%01x (", spec_vers);
+	switch (spec_vers) {
+	case 0x0:
+		printf("v1.0-v1.2)\n");
+		break;
+	case 0x1:
+		printf("v1.4)\n");
+		break;
+	case 0x2:
+		printf("v2.0-v2.2)\n");
+		break;
+	case 0x3:
+		printf("v3.1-v3.31)\n");
+		break;
+	case 0x4:
+		printf("v4.0-v4.3)\n");
+		break;
+	default:
+		printf("reserved)\n");
+		break;
+	}
+}
 
-	taac = taac_timevalue << 3 | taac_timeunit;
-	tran_speed = tran_speed_timevalue << 3 | tran_speed_transferrateunit;
+static void
+print_mmc_csd_taac(unsigned int taac_timevalue, unsigned int taac_timeunit)
+{
+	float value;
+	unsigned int taac = taac_timevalue << 3 | taac_timeunit;
 
-	if (config->verbose) {
-		float value;
-		int mult;
-		int blocknr;
-		int block_len;
-		unsigned long long blocks = 0;
-		int block_size = 0;
-		unsigned long long memory_capacity;
+	printf("\tTAAC: 0x%02x (", taac);
+	switch (taac_timevalue) {
+	case 0x0:
+		value = 0.0f;
+		break;
+	case 0x1:
+		value = 1.0f;
+		break;
+	case 0x2:
+		value = 1.2f;
+		break;
+	case 0x3:
+		value = 1.3f;
+		break;
+	case 0x4:
+		value = 1.5f;
+		break;
+	case 0x5:
+		value = 2.0f;
+		break;
+	case 0x6:
+		value = 2.5f;
+		break;
+	case 0x7:
+		value = 3.0f;
+		break;
+	case 0x8:
+		value = 3.5f;
+		break;
+	case 0x9:
+		value = 4.0f;
+		break;
+	case 0xa:
+		value = 4.5f;
+		break;
+	case 0xb:
+		value = 5.0f;
+		break;
+	case 0xc:
+		value = 5.5f;
+		break;
+	case 0xd:
+		value = 6.0f;
+		break;
+	case 0xe:
+		value = 7.0f;
+		break;
+	case 0xf:
+		value = 8.0f;
+		break;
+	default:
+		value = 0.0f;
+		break;
+	}
 
-		printf("======MMC/CSD======\n");
+	switch (taac_timeunit) {
+	case 0x0:
+		printf("%.2fns)\n", value * 1.0f);
+		break;
+	case 0x1:
+		printf("%.2fns)\n", value * 10.0f);
+		break;
+	case 0x2:
+		printf("%.2fns)\n", value * 100.0f);
+		break;
+	case 0x3:
+		printf("%.2fus)\n", value * 1.0f);
+		break;
+	case 0x4:
+		printf("%.2fus)\n", value * 10.0f);
+		break;
+	case 0x5:
+		printf("%.2fus)\n", value * 100.0f);
+		break;
+	case 0x6:
+		printf("%.2fms)\n", value * 1.0f);
+		break;
+	case 0x7:
+		printf("%.2fms)\n", value * 10.0f);
+		break;
+	}
+}
 
-		printf("\tCSD_STRUCTURE: 0x%01x (", csd_structure);
-		switch (csd_structure) {
-		case 0x0:
-			printf("v1.0)\n");
-			break;
-		case 0x1:
-			printf("v1.1)\n");
-			break;
-		case 0x2:
-			printf("v1.2)\n");
-			break;
-		case 0x3:
-			printf("version in ext_csd)\n");
-			break;
-		}
+static void print_mmc_csd_nsac(unsigned int nsac, unsigned int tran_speed_timevalue,
+			       unsigned int tran_speed_transferrateunit)
+{
+	float value;
+	unsigned int tran_speed = tran_speed_timevalue << 3 | tran_speed_transferrateunit;
+
+	printf("\tNSAC: %u clocks\n", nsac);
+	printf("\tTRAN_SPEED: 0x%02x (", tran_speed);
+	switch (tran_speed_timevalue) {
+	case 0x0:
+		value = 0.0f;
+		break;
+	case 0x1:
+		value = 1.0f;
+		break;
+	case 0x2:
+		value = 1.2f;
+		break;
+	case 0x3:
+		value = 1.3f;
+		break;
+	case 0x4:
+		value = 1.5f;
+		break;
+	case 0x5:
+		value = 2.0f;
+		break;
+	case 0x6:
+		value = 2.6f;
+		break;
+	case 0x7:
+		value = 3.0f;
+		break;
+	case 0x8:
+		value = 3.5f;
+		break;
+	case 0x9:
+		value = 4.0f;
+		break;
+	case 0xa:
+		value = 4.5f;
+		break;
+	case 0xb:
+		value = 5.2f;
+		break;
+	case 0xc:
+		value = 5.5f;
+		break;
+	case 0xd:
+		value = 6.0f;
+		break;
+	case 0xe:
+		value = 7.0f;
+		break;
+	case 0xf:
+		value = 8.0f;
+		break;
+	default:
+		value = 0.0f;
+		break;
+	}
 
-		printf("\tSPEC_VERS: 0x%01x (", spec_vers);
-		switch (spec_vers) {
-		case 0x0:
-			printf("v1.0-v1.2)\n");
-			break;
-		case 0x1:
-			printf("v1.4)\n");
-			break;
-		case 0x2:
-			printf("v2.0-v2.2)\n");
-			break;
-		case 0x3:
-			printf("v3.1-v3.31)\n");
-			break;
-		case 0x4:
-			printf("v4.0-v4.3)\n");
-			break;
-		default:
-			printf("reserved)\n");
-			break;
-		}
+	switch (tran_speed_transferrateunit) {
+	case 0x0:
+		printf("%.2fKHz/s)\n", value * 100.0f);
+		break;
+	case 0x1:
+		printf("%.2fMHz/s)\n", value * 1.0f);
+		break;
+	case 0x2:
+		printf("%.2fMHz/s)\n", value * 10.0f);
+		break;
+	case 0x3:
+		printf("%.2fMHz/s)\n", value * 100.0f);
+		break;
+	default:
+		printf("reserved)\n");
+		break;
+	}
+}
 
-		printf("\tTAAC: 0x%02x (", taac);
-		switch (taac_timevalue) {
-		case 0x0:
-			value = 0.0f;
-			break;
-		case 0x1:
-			value = 1.0f;
-			break;
-		case 0x2:
-			value = 1.2f;
-			break;
-		case 0x3:
-			value = 1.3f;
-			break;
-		case 0x4:
-			value = 1.5f;
-			break;
-		case 0x5:
-			value = 2.0f;
-			break;
-		case 0x6:
-			value = 2.5f;
-			break;
-		case 0x7:
-			value = 3.0f;
-			break;
-		case 0x8:
-			value = 3.5f;
-			break;
-		case 0x9:
-			value = 4.0f;
-			break;
-		case 0xa:
-			value = 4.5f;
-			break;
-		case 0xb:
-			value = 5.0f;
-			break;
-		case 0xc:
-			value = 5.5f;
-			break;
-		case 0xd:
-			value = 6.0f;
-			break;
-		case 0xe:
-			value = 7.0f;
-			break;
-		case 0xf:
-			value = 8.0f;
-			break;
-		default:
-			value = 0.0f;
-			break;
-		}
+static void print_mmc_csd_ccc(unsigned int ccc)
+{
+	printf("\tCCC: 0x%03x (class: ", ccc);
+	if (ccc & 0x800)
+		printf("11, ");
+	if (ccc & 0x400)
+		printf("10, ");
+	if (ccc & 0x200)
+		printf("9, ");
+	if (ccc & 0x100)
+		printf("8, ");
+	if (ccc & 0x080)
+		printf("7, ");
+	if (ccc & 0x040)
+		printf("6, ");
+	if (ccc & 0x020)
+		printf("5, ");
+	if (ccc & 0x010)
+		printf("4, ");
+	if (ccc & 0x008)
+		printf("3, ");
+	if (ccc & 0x004)
+		printf("2, ");
+	if (ccc & 0x002)
+		printf("1, ");
+	if (ccc & 0x001)
+		printf("0, ");
+	printf("  )\n");
+}
 
-		switch (taac_timeunit) {
-		case 0x0:
-			printf("%.2fns)\n", value * 1.0f);
-			break;
-		case 0x1:
-			printf("%.2fns)\n", value * 10.0f);
-			break;
-		case 0x2:
-			printf("%.2fns)\n", value * 100.0f);
-			break;
-		case 0x3:
-			printf("%.2fus)\n", value * 1.0f);
-			break;
-		case 0x4:
-			printf("%.2fus)\n", value * 10.0f);
-			break;
-		case 0x5:
-			printf("%.2fus)\n", value * 100.0f);
-			break;
-		case 0x6:
-			printf("%.2fms)\n", value * 1.0f);
-			break;
-		case 0x7:
-			printf("%.2fms)\n", value * 10.0f);
-			break;
-		}
+static void print_mmc_csd_read_bl_len(unsigned int read_bl_len)
+{
+	printf("\tREAD_BL_LEN: 0x%01x (", read_bl_len);
+	switch (read_bl_len) {
+	case 0x0:
+		printf("1 byte)\n");
+		break;
+	case 0x1:
+		printf("2 byte)\n");
+		break;
+	case 0x2:
+		printf("4 byte)\n");
+		break;
+	case 0x3:
+		printf("8 byte)\n");
+		break;
+	case 0x4:
+		printf("16 byte)\n");
+		break;
+	case 0x5:
+		printf("32 byte)\n");
+		break;
+	case 0x6:
+		printf("64 byte)\n");
+		break;
+	case 0x7:
+		printf("128 byte)\n");
+		break;
+	case 0x8:
+		printf("256 byte)\n");
+		break;
+	case 0x9:
+		printf("512 bytes)\n");
+		break;
+	case 0xa:
+		printf("1024 bytes)\n");
+		break;
+	case 0xb:
+		printf("2048 bytes)\n");
+		break;
+	case 0xc:
+		printf("4096 bytes)\n");
+		break;
+	case 0xd:
+		printf("8192 bytes)\n");
+		break;
+	case 0xe:
+		printf("16K bytes)\n");
+		break;
+	default:
+		printf("reserved bytes)\n");
+		break;
+	}
+}
 
-		printf("\tNSAC: %u clocks\n", nsac);
-		printf("\tTRAN_SPEED: 0x%02x (", tran_speed);
-		switch (tran_speed_timevalue) {
-		case 0x0:
-			value = 0.0f;
-			break;
-		case 0x1:
-			value = 1.0f;
-			break;
-		case 0x2:
-			value = 1.2f;
-			break;
-		case 0x3:
-			value = 1.3f;
-			break;
-		case 0x4:
-			value = 1.5f;
-			break;
-		case 0x5:
-			value = 2.0f;
-			break;
-		case 0x6:
-			value = 2.6f;
-			break;
-		case 0x7:
-			value = 3.0f;
-			break;
-		case 0x8:
-			value = 3.5f;
-			break;
-		case 0x9:
-			value = 4.0f;
-			break;
-		case 0xa:
-			value = 4.5f;
-			break;
-		case 0xb:
-			value = 5.2f;
-			break;
-		case 0xc:
-			value = 5.5f;
-			break;
-		case 0xd:
-			value = 6.0f;
-			break;
-		case 0xe:
-			value = 7.0f;
-			break;
-		case 0xf:
-			value = 8.0f;
-			break;
-		default:
-			value = 0.0f;
-			break;
-		}
+static void print_mmc_csd_read_bl_partial(unsigned int read_bl_partial)
+{
+	printf("\tREAD_BL_PARTIAL: 0x%01x (", read_bl_partial);
+	switch (read_bl_partial) {
+	case 0x0:
+		printf("only 512 byte and READ_BL_LEN block size)\n");
+		break;
+	case 0x1:
+		printf("less than READ_BL_LEN block size can be used)\n");
+		break;
+	}
+}
 
-		switch (tran_speed_transferrateunit) {
-		case 0x0:
-			printf("%.2fKHz/s)\n", value * 100.0f);
-			break;
-		case 0x1:
-			printf("%.2fMHz/s)\n", value * 1.0f);
-			break;
-		case 0x2:
-			printf("%.2fMHz/s)\n", value * 10.0f);
-			break;
-		case 0x3:
-			printf("%.2fMHz/s)\n", value * 100.0f);
-			break;
-		default:
-			printf("reserved)\n");
-			break;
-		}
+static void print_mmc_csd_write_blk_misalign(unsigned int write_blk_misalign)
+{
+	printf("\tWRITE_BLK_MISALIGN: 0x%01x (", write_blk_misalign);
+	switch (write_blk_misalign) {
+	case 0x0:
+		printf("writes across block boundaries are invalid)\n");
+		break;
+	case 0x1:
+		printf("writes across block boundaries are allowed)\n");
+		break;
+	}
+}
 
-		printf("\tCCC: 0x%03x (class: ", ccc);
-		if (ccc & 0x800)
-			printf("11, ");
-		if (ccc & 0x400)
-			printf("10, ");
-		if (ccc & 0x200)
-			printf("9, ");
-		if (ccc & 0x100)
-			printf("8, ");
-		if (ccc & 0x080)
-			printf("7, ");
-		if (ccc & 0x040)
-			printf("6, ");
-		if (ccc & 0x020)
-			printf("5, ");
-		if (ccc & 0x010)
-			printf("4, ");
-		if (ccc & 0x008)
-			printf("3, ");
-		if (ccc & 0x004)
-			printf("2, ");
-		if (ccc & 0x002)
-			printf("1, ");
-		if (ccc & 0x001)
-			printf("0, ");
-		printf("  )\n");
+static void print_mmc_csd_read_blk_misalign(unsigned int read_blk_misalign)
+{
+	printf("\tREAD_BLK_MISALIGN: 0x%01x (", read_blk_misalign);
+	switch (read_blk_misalign) {
+	case 0x0:
+		printf("reads across block boundaries are invalid)\n");
+		break;
+	case 0x1:
+		printf("reads across block boundaries are allowed)\n");
+		break;
+	}
+}
 
-		printf("\tREAD_BL_LEN: 0x%01x (", read_bl_len);
-		switch (read_bl_len) {
-		case 0x0:
-			printf("1 byte)\n");
-			break;
-		case 0x1:
-			printf("2 byte)\n");
-			break;
-		case 0x2:
-			printf("4 byte)\n");
-			break;
-		case 0x3:
-			printf("8 byte)\n");
-			break;
-		case 0x4:
-			printf("16 byte)\n");
-			break;
-		case 0x5:
-			printf("32 byte)\n");
-			break;
-		case 0x6:
-			printf("64 byte)\n");
-			break;
-		case 0x7:
-			printf("128 byte)\n");
-			break;
-		case 0x8:
-			printf("256 byte)\n");
-			break;
-		case 0x9:
-			printf("512 bytes)\n");
-			break;
-		case 0xa:
-			printf("1024 bytes)\n");
-			break;
-		case 0xb:
-			printf("2048 bytes)\n");
-			break;
-		case 0xc:
-			printf("4096 bytes)\n");
-			break;
-		case 0xd:
-			printf("8192 bytes)\n");
-			break;
-		case 0xe:
-			printf("16K bytes)\n");
-			break;
-		default:
-			printf("reserved bytes)\n");
-			break;
-		}
+static void print_mmc_csd_dsr_imp(unsigned int dsr_imp)
+{
+	printf("\tDSR_IMP: 0x%01x (", dsr_imp);
+	switch (dsr_imp) {
+	case 0x0:
+		printf("configurable driver stage not available)\n");
+		break;
+	case 0x1:
+		printf("configurable driver state available)\n");
+		break;
+	}
+}
 
-		printf("\tREAD_BL_PARTIAL: 0x%01x (", read_bl_partial);
-		switch (read_bl_partial) {
-		case 0x0:
-			printf("only 512 byte and READ_BL_LEN block size)\n");
-			break;
-		case 0x1:
-			printf("less than READ_BL_LEN block size can be used)\n");
-			break;
-		}
+static void print_mmc_csd_vdd(unsigned int vdd_r_curr_min, unsigned int vdd_r_curr_max,
+			      unsigned int vdd_w_curr_min, unsigned int vdd_w_curr_max)
+{
+	printf("\tVDD_R_CURR_MIN: 0x%01x (", vdd_r_curr_min);
+	switch (vdd_r_curr_min) {
+	case 0x0:
+		printf("0.5mA)\n");
+		break;
+	case 0x1:
+		printf("1mA)\n");
+		break;
+	case 0x2:
+		printf("5mA)\n");
+		break;
+	case 0x3:
+		printf("10mA)\n");
+		break;
+	case 0x4:
+		printf("25mA)\n");
+		break;
+	case 0x5:
+		printf("35mA)\n");
+		break;
+	case 0x6:
+		printf("60mA)\n");
+		break;
+	case 0x7:
+		printf("100mA)\n");
+		break;
+	}
 
-		printf("\tWRITE_BLK_MISALIGN: 0x%01x (", write_blk_misalign);
-		switch (write_blk_misalign) {
-		case 0x0:
-			printf("writes across block boundaries are invalid)\n");
-			break;
-		case 0x1:
-			printf("writes across block boundaries are allowed)\n");
-			break;
-		}
+	printf("\tVDD_R_CURR_MAX: 0x%01x (", vdd_r_curr_max);
+	switch (vdd_r_curr_max) {
+	case 0x0:
+		printf("1mA)\n");
+		break;
+	case 0x1:
+		printf("5mA)\n");
+		break;
+	case 0x2:
+		printf("10mA)\n");
+		break;
+	case 0x3:
+		printf("25mA)\n");
+		break;
+	case 0x4:
+		printf("35mA)\n");
+		break;
+	case 0x5:
+		printf("45mA)\n");
+		break;
+	case 0x6:
+		printf("80mA)\n");
+		break;
+	case 0x7:
+		printf("200mA)\n");
+		break;
+	}
 
-		printf("\tREAD_BLK_MISALIGN: 0x%01x (", read_blk_misalign);
-		switch (read_blk_misalign) {
-		case 0x0:
-			printf("reads across block boundaries are invalid)\n");
-			break;
-		case 0x1:
-			printf("reads across block boundaries are allowed)\n");
-			break;
-		}
+	printf("\tVDD_W_CURR_MIN: 0x%01x (", vdd_w_curr_min);
+	switch (vdd_w_curr_min) {
+	case 0x0:
+		printf("0.5mA)\n");
+		break;
+	case 0x1:
+		printf("1mA)\n");
+		break;
+	case 0x2:
+		printf("5mA)\n");
+		break;
+	case 0x3:
+		printf("10mA)\n");
+		break;
+	case 0x4:
+		printf("25mA)\n");
+		break;
+	case 0x5:
+		printf("35mA)\n");
+		break;
+	case 0x6:
+		printf("60mA)\n");
+		break;
+	case 0x7:
+		printf("100mA)\n");
+		break;
+	}
 
-		printf("\tDSR_IMP: 0x%01x (", dsr_imp);
-		switch (dsr_imp) {
-		case 0x0:
-			printf("configurable driver stage not available)\n");
-			break;
-		case 0x1:
-			printf("configurable driver state available)\n");
-			break;
-		}
+	printf("\tVDD_W_CURR_MAX: 0x%01x (", vdd_w_curr_max);
+	switch (vdd_w_curr_max) {
+	case 0x0:
+		printf("1mA)\n");
+		break;
+	case 0x1:
+		printf("5mA)\n");
+		break;
+	case 0x2:
+		printf("10mA)\n");
+		break;
+	case 0x3:
+		printf("25mA)\n");
+		break;
+	case 0x4:
+		printf("35mA)\n");
+		break;
+	case 0x5:
+		printf("45mA)\n");
+		break;
+	case 0x6:
+		printf("80mA)\n");
+		break;
+	case 0x7:
+		printf("200mA)\n");
+		break;
+	}
+}
+
+static void print_mmc_csd_default_ecc(unsigned int default_ecc)
+{
+	printf("\tDEFAULT_ECC: 0x%01x (", default_ecc);
+	switch (default_ecc) {
+	case 0:
+		printf("none)\n");
+		break;
+	case 1:
+		printf("BCH)\n");
+		break;
+	default:
+		printf("reserved)\n");
+		break;
+	}
+}
+
+static void print_mmc_csd_write_bl_len(unsigned int write_bl_len)
+{
+	printf("\tWRITE_BL_LEN: 0x%01x (", write_bl_len);
+	switch (write_bl_len) {
+	case 0x0:
+		printf("1 byte)\n");
+		break;
+	case 0x1:
+		printf("2 byte)\n");
+		break;
+	case 0x2:
+		printf("4 byte)\n");
+		break;
+	case 0x3:
+		printf("8 byte)\n");
+		break;
+	case 0x4:
+		printf("16 byte)\n");
+		break;
+	case 0x5:
+		printf("32 byte)\n");
+		break;
+	case 0x6:
+		printf("64 byte)\n");
+		break;
+	case 0x7:
+		printf("128 byte)\n");
+		break;
+	case 0x8:
+		printf("256 byte)\n");
+		break;
+	case 0x9:
+		printf("512 bytes)\n");
+		break;
+	case 0xa:
+		printf("1024 bytes)\n");
+		break;
+	case 0xb:
+		printf("2048 bytes)\n");
+		break;
+	case 0xc:
+		printf("4096 bytes)\n");
+		break;
+	case 0xd:
+		printf("8192 bytes)\n");
+		break;
+	case 0xe:
+		printf("16K bytes)\n");
+		break;
+	default:
+		printf("reserved bytes)\n");
+		break;
+	}
+}
+
+static void print_mmc_csd_write_bl_partial(unsigned int write_bl_partial)
+{
+	printf("\tWRITE_BL_PARTIAL: 0x%01x (", write_bl_partial);
+	switch (write_bl_partial) {
+	case 0x0:
+		printf("only 512 byte and WRITE_BL_LEN block size)\n");
+		break;
+	case 0x1:
+		printf("less than WRITE_BL_LEN block size can be used)\n");
+		break;
+	}
+}
 
-		printf("\tC_SIZE: 0x%03x\n", c_size);
-		printf("\tVDD_R_CURR_MIN: 0x%01x (", vdd_r_curr_min);
-		switch (vdd_r_curr_min) {
-		case 0x0:
-			printf("0.5mA)\n");
-			break;
-		case 0x1:
-			printf("1mA)\n");
-			break;
-		case 0x2:
-			printf("5mA)\n");
-			break;
-		case 0x3:
-			printf("10mA)\n");
-			break;
-		case 0x4:
-			printf("25mA)\n");
-			break;
-		case 0x5:
-			printf("35mA)\n");
-			break;
-		case 0x6:
-			printf("60mA)\n");
-			break;
-		case 0x7:
-			printf("100mA)\n");
-			break;
-		}
+static void print_mmc_csd_file_format(unsigned int file_format, unsigned int file_format_grp)
+{
+	printf("\tFILE_FORMAT: 0x%01x (", file_format);
+	if (file_format != 0)
+		printf("Warn: Invalid FILE_FORMAT\n");
 
-		printf("\tVDD_R_CURR_MAX: 0x%01x (", vdd_r_curr_max);
-		switch (vdd_r_curr_max) {
-		case 0x0:
-			printf("1mA)\n");
-			break;
-		case 0x1:
-			printf("5mA)\n");
-			break;
-		case 0x2:
-			printf("10mA)\n");
-			break;
-		case 0x3:
-			printf("25mA)\n");
-			break;
-		case 0x4:
-			printf("35mA)\n");
+	if (file_format_grp == 1) {
+		printf("reserved)\n");
+	} else {
+		switch (file_format) {
+		case 0:
+			printf("partition table)\n");
 			break;
-		case 0x5:
-			printf("45mA)\n");
+		case 1:
+			printf("no partition table)\n");
 			break;
-		case 0x6:
-			printf("80mA)\n");
+		case 2:
+			printf("Universal File Format)\n");
 			break;
-		case 0x7:
-			printf("200mA)\n");
+		case 3:
+			printf("Others/unknown)\n");
 			break;
 		}
+	}
+}
 
-		printf("\tVDD_W_CURR_MIN: 0x%01x (", vdd_w_curr_min);
-		switch (vdd_w_curr_min) {
-		case 0x0:
-			printf("0.5mA)\n");
-			break;
-		case 0x1:
-			printf("1mA)\n");
-			break;
-		case 0x2:
-			printf("5mA)\n");
-			break;
-		case 0x3:
-			printf("10mA)\n");
-			break;
-		case 0x4:
-			printf("25mA)\n");
-			break;
-		case 0x5:
-			printf("35mA)\n");
-			break;
-		case 0x6:
-			printf("60mA)\n");
-			break;
-		case 0x7:
-			printf("100mA)\n");
-			break;
-		}
+static void print_mmc_csd_ecc(unsigned int ecc)
+{
+	printf("\tECC: 0x%01x (", ecc);
+	switch (ecc) {
+	case 0:
+		printf("none)\n");
+		break;
+	case 1:
+		printf("BCH(542,512))\n");
+		break;
+	default:
+		printf("reserved)\n");
+		break;
+	}
+}
 
-		printf("\tVDD_W_CURR_MAX: 0x%01x (", vdd_w_curr_max);
-		switch (vdd_w_curr_max) {
-		case 0x0:
-			printf("1mA)\n");
-			break;
-		case 0x1:
-			printf("5mA)\n");
-			break;
-		case 0x2:
-			printf("10mA)\n");
-			break;
-		case 0x3:
-			printf("25mA)\n");
-			break;
-		case 0x4:
-			printf("35mA)\n");
-			break;
-		case 0x5:
-			printf("45mA)\n");
-			break;
-		case 0x6:
-			printf("80mA)\n");
-			break;
-		case 0x7:
-			printf("200mA)\n");
-			break;
-		}
+static void print_mmc_csd_capacity(unsigned int c_size, unsigned int c_size_mult,
+				   unsigned int read_bl_len)
+{
+	int mult = 1 << (c_size_mult + 2);
+	unsigned long long blocknr = (c_size + 1) * mult;
+	int block_len = 1 << read_bl_len;
+	unsigned long long memory_capacity;
+
+	printf("\tC_SIZE: 0x%03x\n", c_size);
+	printf("\tC_SIZE_MULT: 0x%01x\n", c_size_mult);
+
+	memory_capacity = blocknr * block_len;
+
+	printf("\tCAPACITY: ");
+	if (memory_capacity / (1024ull * 1024ull * 1024ull) > 0)
+		printf("%.2fGbyte", memory_capacity / (1024.0 * 1024.0 * 1024.0));
+	else if (memory_capacity / (1024ull * 1024ull) > 0)
+		printf("%.2fMbyte", memory_capacity / (1024.0 * 1024.0));
+	else if (memory_capacity / (1024ull) > 0)
+		printf("%.2fKbyte", memory_capacity / (1024.0));
+	else
+		printf("%.2fbyte", memory_capacity * 1.0);
+
+	printf(" (%llu bytes, %llu sectors, %d bytes each)\n", memory_capacity, blocknr, block_len);
+}
+
+static void print_mmc_csd(struct config *config, char *csd)
+{
+	unsigned int csd_structure, spec_vers, taac_timevalue, taac_timeunit, nsac;
+	unsigned int tran_speed_timevalue, tran_speed_transferrateunit, ccc, read_bl_len;
+	unsigned int read_bl_partial, write_blk_misalign, read_blk_misalign, dsr_imp;
+	unsigned int c_size, vdd_r_curr_min, vdd_r_curr_max, vdd_w_curr_min, vdd_w_curr_max;
+	unsigned int c_size_mult, erase_grp_size, erase_grp_mult, wp_grp_size, wp_grp_enable;
+	unsigned int default_ecc, r2w_factor, write_bl_len, write_bl_partial, content_prot_app;
+	unsigned int file_format_grp, copy, perm_write_protect, tmp_write_protect, file_format;
+	unsigned int ecc, crc;
+
+	parse_bin(csd, "2u4u2r1r4u3u8u1r4u3u12u4u1u1u1u1u2r12u3u3u3u3u3u"
+		  "5u5u5u1u2u3u4u1u4r1u1u1u1u1u2u2u7u1r",
+		  &csd_structure, &spec_vers, &taac_timevalue,
+		  &taac_timeunit, &nsac, &tran_speed_timevalue,
+		  &tran_speed_transferrateunit, &ccc, &read_bl_len,
+		  &read_bl_partial, &write_blk_misalign,
+		  &read_blk_misalign, &dsr_imp, &c_size,
+		  &vdd_r_curr_min, &vdd_r_curr_max,
+		  &vdd_w_curr_min, &vdd_w_curr_max, &c_size_mult,
+		  &erase_grp_size, &erase_grp_mult, &wp_grp_size,
+		  &wp_grp_enable, &default_ecc, &r2w_factor,
+		  &write_bl_len, &write_bl_partial, &content_prot_app,
+		  &file_format_grp, &copy, &perm_write_protect,
+		  &tmp_write_protect, &file_format, &ecc, &crc);
+
+	if (config->verbose) {
+
+		printf("======MMC/CSD======\n");
+
+		print_mmc_csd_structure(csd_structure);
+
+		print_mmc_csd_spec_ver(spec_vers);
+
+		print_mmc_csd_taac(taac_timevalue, taac_timeunit);
+
+		print_mmc_csd_nsac(nsac, tran_speed_timevalue, tran_speed_transferrateunit);
+
+		print_mmc_csd_ccc(ccc);
+
+		print_mmc_csd_read_bl_len(read_bl_len);
+
+		print_mmc_csd_read_bl_partial(read_bl_partial);
+
+		print_mmc_csd_write_blk_misalign(write_blk_misalign);
+
+		print_mmc_csd_read_blk_misalign(read_blk_misalign);
+
+		print_mmc_csd_dsr_imp(dsr_imp);
+
+		print_mmc_csd_vdd(vdd_r_curr_min, vdd_r_curr_max, vdd_w_curr_min, vdd_w_curr_max);
 
-		printf("\tC_SIZE_MULT: 0x%01x\n", c_size_mult);
 		printf("\tERASE_GRP_SIZE: 0x%02x\n", erase_grp_size);
 		printf("\tERASE_GRP_MULT: 0x%02x (%u write blocks/erase group)\n",
 		       erase_grp_mult, (erase_grp_size + 1) *
@@ -1729,83 +1904,14 @@ void print_mmc_csd(struct config *config, char *csd)
 		       wp_grp_size, wp_grp_size + 1);
 		printf("\tWP_GRP_ENABLE: 0x%01x\n", wp_grp_enable);
 
-		printf("\tDEFAULT_ECC: 0x%01x (", default_ecc);
-		switch (default_ecc) {
-		case 0:
-			printf("none)\n");
-			break;
-		case 1:
-			printf("BCH)\n");
-			break;
-		default:
-			printf("reserved)\n");
-			break;
-		}
+		print_mmc_csd_default_ecc(default_ecc);
 
 		printf("\tR2W_FACTOR: 0x%01x (Write %u times read)\n",
 		       r2w_factor, r2w_factor);
 
-		printf("\tWRITE_BL_LEN: 0x%01x (", write_bl_len);
-		switch (write_bl_len) {
-		case 0x0:
-			printf("1 byte)\n");
-			break;
-		case 0x1:
-			printf("2 byte)\n");
-			break;
-		case 0x2:
-			printf("4 byte)\n");
-			break;
-		case 0x3:
-			printf("8 byte)\n");
-			break;
-		case 0x4:
-			printf("16 byte)\n");
-			break;
-		case 0x5:
-			printf("32 byte)\n");
-			break;
-		case 0x6:
-			printf("64 byte)\n");
-			break;
-		case 0x7:
-			printf("128 byte)\n");
-			break;
-		case 0x8:
-			printf("256 byte)\n");
-			break;
-		case 0x9:
-			printf("512 bytes)\n");
-			break;
-		case 0xa:
-			printf("1024 bytes)\n");
-			break;
-		case 0xb:
-			printf("2048 bytes)\n");
-			break;
-		case 0xc:
-			printf("4096 bytes)\n");
-			break;
-		case 0xd:
-			printf("8192 bytes)\n");
-			break;
-		case 0xe:
-			printf("16K bytes)\n");
-			break;
-		default:
-			printf("reserved bytes)\n");
-			break;
-		}
+		print_mmc_csd_write_bl_len(write_bl_len);
 
-		printf("\tWRITE_BL_PARTIAL: 0x%01x (", write_bl_partial);
-		switch (write_bl_partial) {
-		case 0x0:
-			printf("only 512 byte and WRITE_BL_LEN block size)\n");
-			break;
-		case 0x1:
-			printf("less than WRITE_BL_LEN block size can be used)\n");
-			break;
-		}
+		print_mmc_csd_write_bl_partial(write_bl_partial);
 
 		printf("\tCONTENT_PROT_APP: 0x%01x\n", content_prot_app);
 		printf("\tFILE_FORMAT_GRP: 0x%01x\n", file_format_grp);
@@ -1815,142 +1921,20 @@ void print_mmc_csd(struct config *config, char *csd)
 		printf("\tCOPY: 0x%01x\n", copy);
 		printf("\tPERM_WRITE_PROTECT: 0x%01x\n", perm_write_protect);
 		printf("\tTMP_WRITE_PROTECT: 0x%01x\n", tmp_write_protect);
-		printf("\tFILE_FORMAT: 0x%01x (", file_format);
-		if (file_format != 0)
-			printf("Warn: Invalid FILE_FORMAT\n");
 
-		if (file_format_grp == 1) {
-			printf("reserved)\n");
-		} else {
-			switch (file_format) {
-			case 0:
-				printf("partition table)\n");
-				break;
-			case 1:
-				printf("no partition table)\n");
-				break;
-			case 2:
-				printf("Universal File Format)\n");
-				break;
-			case 3:
-				printf("Others/unknown)\n");
-				break;
-			}
-		}
+		print_mmc_csd_file_format(file_format, file_format_grp);
 
-		printf("\tECC: 0x%01x (", ecc);
-		switch (ecc) {
-		case 0:
-			printf("none)\n");
-			break;
-		case 1:
-			printf("BCH(542,512))\n");
-			break;
-		default:
-			printf("reserved)\n");
-			break;
-		}
+		print_mmc_csd_ecc(ecc);
 
 		printf("\tCRC: 0x%01x\n", crc);
 
-		mult = 1 << (c_size_mult + 2);
-		blocknr = (c_size + 1) * mult;
-		block_len = 1 << read_bl_len;
-		blocks = blocknr;
-		block_size = block_len;
-
-		memory_capacity = blocks * block_size;
-
-		printf("\tCAPACITY: ");
-		if (memory_capacity / (1024ull * 1024ull * 1024ull) > 0)
-			printf("%.2fGbyte",
-			       memory_capacity / (1024.0 * 1024.0 * 1024.0));
-		else if (memory_capacity / (1024ull * 1024ull) > 0)
-			printf("%.2fMbyte", memory_capacity / (1024.0 * 1024.0));
-		else if (memory_capacity / (1024ull) > 0)
-			printf("%.2fKbyte", memory_capacity / (1024.0));
-		else
-			printf("%.2fbyte", memory_capacity * 1.0);
-
-		printf(" (%llu bytes, %llu sectors, %d bytes each)\n",
-		       memory_capacity, blocks, block_size);
+		print_mmc_csd_capacity(c_size, c_size_mult, read_bl_len);
 	} else {
-		int mult;
-		int blocknr;
-		int block_len;
-		unsigned long long blocks = 0;
-		int block_size = 0;
-		unsigned long long memory_capacity;
-
-		printf("version: ");
-		switch (spec_vers) {
-		case 0x0:
-			printf("MMC v1.0-v1.2\n");
-			break;
-		case 0x1:
-			printf("MMC v1.4\n");
-			break;
-		case 0x2:
-			printf("MMC v2.0-v2.2\n");
-			break;
-		case 0x3:
-			printf("MMC v3.1-v3.31\n");
-			break;
-		case 0x4:
-			printf("MMC v4.0-v4.3\n");
-			break;
-		default:
-			printf("reserved\n");
-			break;
-		}
-
-		printf("card classes: ");
-		if (ccc & 0x800)
-			printf("11, ");
-		if (ccc & 0x400)
-			printf("10, ");
-		if (ccc & 0x200)
-			printf("9, ");
-		if (ccc & 0x100)
-			printf("8, ");
-		if (ccc & 0x080)
-			printf("7, ");
-		if (ccc & 0x040)
-			printf("6, ");
-		if (ccc & 0x020)
-			printf("5, ");
-		if (ccc & 0x010)
-			printf("4, ");
-		if (ccc & 0x008)
-			printf("3, ");
-		if (ccc & 0x004)
-			printf("2, ");
-		if (ccc & 0x002)
-			printf("1, ");
-		if (ccc & 0x001)
-			printf("0, ");
-		printf("\b\b\n");
+		print_mmc_csd_spec_ver(spec_vers);
 
-		mult = 1 << (c_size_mult + 2);
-		blocknr = (c_size + 1) * mult;
-		block_len = 1 << read_bl_len;
-		blocks = blocknr;
-		block_size = block_len;
-
-		memory_capacity = blocks * block_size;
+		print_mmc_csd_ccc(ccc);
 
-		printf("capacity: ");
-		if (memory_capacity / (1024ull * 1024ull * 1024ull) > 0)
-			printf("%.2fGbyte",
-			       memory_capacity / (1024.0 * 1024.0 * 1024.0));
-		else if (memory_capacity / (1024ull * 1024ull) > 0)
-			printf("%.2fMbyte", memory_capacity / (1024.0 * 1024.0));
-		else if (memory_capacity / (1024ull) > 0)
-			printf("%.2fKbyte", memory_capacity / (1024.0));
-		else
-			printf("%.2fbyte", memory_capacity * 1.0);
-		printf(" (%llu bytes, %llu sectors, %d bytes each)\n",
-		       memory_capacity, blocks, block_size);
+		print_mmc_csd_capacity(c_size, c_size_mult, read_bl_len);
 	}
 }
 
-- 
2.42.0

