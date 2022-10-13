Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D63BC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 09:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJMJKl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJMJKj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 05:10:39 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D0112EA79
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 02:10:34 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id EE285463230;
        Thu, 13 Oct 2022 11:10:32 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id D49C4460CFF;
        Thu, 13 Oct 2022 11:10:32 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Thu, 13 Oct 2022 11:10:32 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 13 Oct
 2022 11:10:32 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Thu, 13 Oct 2022 11:10:32 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: [PATCHv3 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Topic: [PATCHv3 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Index: Adje41rybrEPkk5sSweJDlsaX00tLg==
Date:   Thu, 13 Oct 2022 09:10:31 +0000
Message-ID: <a64ce8be9687452b8da6c9816ca42b5b@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.66]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27198.006
X-TMASE-Result: 10--2.103000-10.000000
X-TMASE-MatchedRID: u8usGLXufdhINlHl+WuFyiBpp+DpTrQjwfXdYxXtxJnRjBmBWsa9RHiR
        8N4veKk9cvkTkHwK9Y3mn3xyPJAJoh2P280ZiGmR8Jb881FGn9mfmd9HsjZ0U2A+B6CBXAIWBwT
        cDCKI2XKvu8Fz6v3ntfNcxPWaPyYL1LFdtmiebE5tN2GsBybzwrJOtZXi/DJfnhD4vcFcha6N3H
        kV2EiaA1oztYBCKuUcl1rHp0PtyOYJuzWarp7C5bqQyAveNtg6fS0Ip2eEHnycUrtUT/EvSfoLR
        4+zsDTtifGCYEa4FxddoZNyys0iSyETcTmTl2oTcq5BSEEyF1IVQxHy6z/dIg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 2383e46b-1049-40e5-8c7e-8879e41343fd-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Certain commands require a longer switch timeout.
Refactor accordingly to allow e.g. for future sanitize change.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 mmc_cmds.c | 60 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 2957aa9..3337ded 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -76,7 +76,7 @@ int read_extcsd(int fd, __u8 *ext_csd)
 	return ret;
 }
 
-int write_extcsd_value(int fd, __u8 index, __u8 value)
+int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
 {
 	int ret = 0;
 	struct mmc_ioc_cmd idata;
@@ -89,6 +89,8 @@ int write_extcsd_value(int fd, __u8 index, __u8 value)
 			(value << 8) |
 			EXT_CSD_CMD_SET_NORMAL;
 	idata.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	/* Kernel will set cmd_timeout_ms if 0 is set */
+	idata.cmd_timeout_ms = timeout_ms;
 
 	ret = ioctl(fd, MMC_IOC_CMD, &idata);
 	if (ret)
@@ -341,7 +343,7 @@ int do_writeprotect_boot_set(int nargs, char **argv)
 	value |= permanent ? EXT_CSD_BOOT_WP_B_PERM_WP_EN
 			   : EXT_CSD_BOOT_WP_B_PWR_WP_EN;
 
-	ret = write_extcsd_value(fd, EXT_CSD_BOOT_WP, value);
+	ret = write_extcsd_value(fd, EXT_CSD_BOOT_WP, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n",
@@ -508,7 +510,7 @@ int do_writeprotect_user_set(int nargs, char **argv)
 			break;
 		}
 		if (user_wp != ext_csd[EXT_CSD_USER_WP]) {
-			ret = write_extcsd_value(fd, EXT_CSD_USER_WP, user_wp);
+			ret = write_extcsd_value(fd, EXT_CSD_USER_WP, user_wp, 0);
 			if (ret) {
 				fprintf(stderr, "Error setting EXT_CSD\n");
 				exit(1);
@@ -526,7 +528,7 @@ int do_writeprotect_user_set(int nargs, char **argv)
 	}
 	if (wptype != WPTYPE_NONE) {
 		ret = write_extcsd_value(fd, EXT_CSD_USER_WP,
-					ext_csd[EXT_CSD_USER_WP]);
+				ext_csd[EXT_CSD_USER_WP], 0);
 		if (ret) {
 			fprintf(stderr, "Error restoring EXT_CSD\n");
 			exit(1);
@@ -571,7 +573,7 @@ int do_disable_512B_emulation(int nargs, char **argv)
 
 	if (native_sector_size && !data_sector_size &&
 	   (wr_rel_param & EN_REL_WR)) {
-		ret = write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR, 1);
+		ret = write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR, 1, 0);
 
 		if (ret) {
 			fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
@@ -650,7 +652,7 @@ int do_write_boot_en(int nargs, char **argv)
 	else
 		value &= ~EXT_CSD_PART_CONFIG_ACC_ACK;
 
-	ret = write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value);
+	ret = write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n",
@@ -720,7 +722,7 @@ int do_boot_bus_conditions_set(int nargs, char **argv)
 	printf("Changing ext_csd[BOOT_BUS_CONDITIONS] from 0x%02x to 0x%02x\n",
 		ext_csd[EXT_CSD_BOOT_BUS_CONDITIONS], value);
 
-	ret = write_extcsd_value(fd, EXT_CSD_BOOT_BUS_CONDITIONS, value);
+	ret = write_extcsd_value(fd, EXT_CSD_BOOT_BUS_CONDITIONS, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n",
@@ -771,7 +773,7 @@ int do_hwreset(int value, int nargs, char **argv)
 		exit(1);
 	}
 
-	ret = write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value);
+	ret = write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value, 0);
 	if (ret) {
 		fprintf(stderr,
 			"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
@@ -825,9 +827,9 @@ int do_write_bkops_en(int nargs, char **argv)
 			fprintf(stderr, "%s doesn't support AUTO_EN in the BKOPS_EN register\n", device);
 			exit(1);
 		}
-		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_AUTO_ENABLE);
+		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_AUTO_ENABLE, 0);
 	} else if (strcmp(en_type, "manual") == 0) {
-		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_MAN_ENABLE);
+		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_MAN_ENABLE, 0);
 	} else {
 		fprintf(stderr, "%s invalid mode for BKOPS_EN requested: %s. Valid options: auto or manual\n", en_type, device);
 		exit(1);
@@ -1002,7 +1004,7 @@ int set_partitioning_setting_completed(int dry_run, const char * const device,
 	}
 
 	fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
-	ret = write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1);
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x1 to "
 			"EXT_CSD[%d] in %s\n",
@@ -1188,7 +1190,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	gp_size_mult = (length_kib + align/2l) / align;
 
 	/* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
-	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
+	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x1 to EXT_CSD[%d] in %s\n",
 			EXT_CSD_ERASE_GROUP_DEF, device);
@@ -1197,7 +1199,7 @@ int do_create_gp_partition(int nargs, char **argv)
 
 	value = (gp_size_mult >> 16) & 0xff;
 	address = EXT_CSD_GP_SIZE_MULT_1_2 + (partition - 1) * 3;
-	ret = write_extcsd_value(fd, address, value);
+	ret = write_extcsd_value(fd, address, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			value, address, device);
@@ -1205,7 +1207,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	}
 	value = (gp_size_mult >> 8) & 0xff;
 	address = EXT_CSD_GP_SIZE_MULT_1_1 + (partition - 1) * 3;
-	ret = write_extcsd_value(fd, address, value);
+	ret = write_extcsd_value(fd, address, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			value, address, device);
@@ -1213,7 +1215,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	}
 	value = gp_size_mult & 0xff;
 	address = EXT_CSD_GP_SIZE_MULT_1_0 + (partition - 1) * 3;
-	ret = write_extcsd_value(fd, address, value);
+	ret = write_extcsd_value(fd, address, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			value, address, device);
@@ -1226,7 +1228,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	else
 		value &= ~(1 << partition);
 
-	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value);
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write EXT_CSD_ENH_%x to EXT_CSD[%d] in %s\n",
 			partition, EXT_CSD_PARTITIONS_ATTRIBUTE, device);
@@ -1240,7 +1242,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	else
 		value &= (0xF << (4 * ((partition % 2))));
 
-	ret = write_extcsd_value(fd, address, value);
+	ret = write_extcsd_value(fd, address, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%x to EXT_CSD[%d] in %s\n",
 			value, address, device);
@@ -1317,7 +1319,7 @@ int do_enh_area_set(int nargs, char **argv)
 	enh_start_addr *= align;
 
 	/* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
-	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
+	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x1 to "
 			"EXT_CSD[%d] in %s\n",
@@ -1327,7 +1329,7 @@ int do_enh_area_set(int nargs, char **argv)
 
 	/* write to ENH_START_ADDR and ENH_SIZE_MULT and PARTITIONS_ATTRIBUTE's ENH_USR bit */
 	value = (enh_start_addr >> 24) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1335,7 +1337,7 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = (enh_start_addr >> 16) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_2, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_2, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1343,7 +1345,7 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = (enh_start_addr >> 8) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_1, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_1, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1351,7 +1353,7 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = enh_start_addr & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_0, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_0, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1360,7 +1362,7 @@ int do_enh_area_set(int nargs, char **argv)
 	}
 
 	value = (enh_size_mult >> 16) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_2, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_2, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1368,7 +1370,7 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = (enh_size_mult >> 8) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_1, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_1, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1376,7 +1378,7 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = enh_size_mult & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_0, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_0, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1384,7 +1386,7 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] | EXT_CSD_ENH_USR;
-	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value);
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write EXT_CSD_ENH_USR to "
 			"EXT_CSD[%d] in %s\n",
@@ -1455,7 +1457,7 @@ int do_write_reliability_set(int nargs, char **argv)
 	}
 
 	value = ext_csd[EXT_CSD_WR_REL_SET] | (1<<partition);
-	ret = write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value);
+	ret = write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 				value, EXT_CSD_WR_REL_SET, device);
@@ -1998,7 +2000,7 @@ int do_sanitize(int nargs, char **argv)
 		exit(1);
 	}
 
-	ret = write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1);
+	ret = write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1, 0);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			1, EXT_CSD_SANITIZE_START, device);
@@ -2587,7 +2589,7 @@ int do_cache_ctrl(int value, int nargs, char **argv)
 			device);
 		exit(1);
 	}
-	ret = write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value);
+	ret = write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value, 0);
 	if (ret) {
 		fprintf(stderr,
 			"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

