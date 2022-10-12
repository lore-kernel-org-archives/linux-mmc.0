Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874B0C43217
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Oct 2022 19:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJLTDu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJLTDt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2022 15:03:49 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA7D2CC97
        for <linux-mmc@vger.kernel.org>; Wed, 12 Oct 2022 12:03:47 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id E0A2F3A18E6;
        Wed, 12 Oct 2022 21:03:45 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C3DB13A18E1;
        Wed, 12 Oct 2022 21:03:45 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Wed, 12 Oct 2022 21:03:45 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 12 Oct
 2022 21:03:45 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Wed, 12 Oct 2022 21:03:42 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: [PATCHv2 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Topic: [PATCHv2 1/2] mmc-utils: Refactor switch to allow custom timeout
Thread-Index: AdjebSjVc+AEAThvQj+uqrbmgvcwAQ==
Date:   Wed, 12 Oct 2022 19:03:42 +0000
Message-ID: <4152c899b638429fb5ec1fb93009b42b@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.2]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27198.002
X-TMASE-Result: 10-0.385000-10.000000
X-TMASE-MatchedRID: F7tLedRt7idINlHl+WuFyiBpp+DpTrQjwfXdYxXtxJnRjBmBWsa9RHiR
        8N4veKk9cvkTkHwK9Y3mn3xyPJAJoh2P280ZiGmR8Jb881FGn9mfmd9HsjZ0U0oLeBActQNS6BS
        soHGi6wUBux928zFU7VRZoV6ATwmSm3tkJNb9bT8EOhHzDsL05kxUJyPnqTyGvn+2qfQyWg0tNr
        NpwDfjtU+9l9kcZ4Fy+Y/kAF2RJJBOMyMXfHp86Z4CIKY/Hg3AhGBk0/7pshLEQdG7H66TyH4gK
        q42LRYkOU+KLyVa0hZkp5UQOcN2bNtukgIENmzZQZUhqp7TvBl+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: a983541e-2021-433a-bfe6-cd8bd4e556ca-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Certain commands require a longer switch timeout.
Refactor accordingly to allow e.g. for future sanitize change.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 mmc_cmds.c | 83 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 2957aa9..8bc7a56 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -54,6 +54,8 @@
 #define WPTYPE_PWRON 2
 #define WPTYPE_PERM 3
 
+#define SWITCH_TIMEOUT_MS (10 * 1000)
+
 
 int read_extcsd(int fd, __u8 *ext_csd)
 {
@@ -76,7 +78,7 @@ int read_extcsd(int fd, __u8 *ext_csd)
 	return ret;
 }
 
-int write_extcsd_value(int fd, __u8 index, __u8 value)
+int write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
 {
 	int ret = 0;
 	struct mmc_ioc_cmd idata;
@@ -89,6 +91,7 @@ int write_extcsd_value(int fd, __u8 index, __u8 value)
 			(value << 8) |
 			EXT_CSD_CMD_SET_NORMAL;
 	idata.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	idata.cmd_timeout_ms = timeout_ms;
 
 	ret = ioctl(fd, MMC_IOC_CMD, &idata);
 	if (ret)
@@ -341,7 +344,8 @@ int do_writeprotect_boot_set(int nargs, char **argv)
 	value |= permanent ? EXT_CSD_BOOT_WP_B_PERM_WP_EN
 			   : EXT_CSD_BOOT_WP_B_PWR_WP_EN;
 
-	ret = write_extcsd_value(fd, EXT_CSD_BOOT_WP, value);
+	ret = write_extcsd_value(fd, EXT_CSD_BOOT_WP, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n",
@@ -508,7 +512,8 @@ int do_writeprotect_user_set(int nargs, char **argv)
 			break;
 		}
 		if (user_wp != ext_csd[EXT_CSD_USER_WP]) {
-			ret = write_extcsd_value(fd, EXT_CSD_USER_WP, user_wp);
+			ret = write_extcsd_value(fd, EXT_CSD_USER_WP, user_wp,
+					SWITCH_TIMEOUT_MS);
 			if (ret) {
 				fprintf(stderr, "Error setting EXT_CSD\n");
 				exit(1);
@@ -526,7 +531,7 @@ int do_writeprotect_user_set(int nargs, char **argv)
 	}
 	if (wptype != WPTYPE_NONE) {
 		ret = write_extcsd_value(fd, EXT_CSD_USER_WP,
-					ext_csd[EXT_CSD_USER_WP]);
+				ext_csd[EXT_CSD_USER_WP], SWITCH_TIMEOUT_MS);
 		if (ret) {
 			fprintf(stderr, "Error restoring EXT_CSD\n");
 			exit(1);
@@ -571,7 +576,8 @@ int do_disable_512B_emulation(int nargs, char **argv)
 
 	if (native_sector_size && !data_sector_size &&
 	   (wr_rel_param & EN_REL_WR)) {
-		ret = write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR, 1);
+		ret = write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR, 1,
+				SWITCH_TIMEOUT_MS);
 
 		if (ret) {
 			fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
@@ -650,7 +656,8 @@ int do_write_boot_en(int nargs, char **argv)
 	else
 		value &= ~EXT_CSD_PART_CONFIG_ACC_ACK;
 
-	ret = write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value);
+	ret = write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n",
@@ -720,7 +727,8 @@ int do_boot_bus_conditions_set(int nargs, char **argv)
 	printf("Changing ext_csd[BOOT_BUS_CONDITIONS] from 0x%02x to 0x%02x\n",
 		ext_csd[EXT_CSD_BOOT_BUS_CONDITIONS], value);
 
-	ret = write_extcsd_value(fd, EXT_CSD_BOOT_BUS_CONDITIONS, value);
+	ret = write_extcsd_value(fd, EXT_CSD_BOOT_BUS_CONDITIONS, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n",
@@ -771,7 +779,8 @@ int do_hwreset(int value, int nargs, char **argv)
 		exit(1);
 	}
 
-	ret = write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value);
+	ret = write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr,
 			"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
@@ -825,9 +834,11 @@ int do_write_bkops_en(int nargs, char **argv)
 			fprintf(stderr, "%s doesn't support AUTO_EN in the BKOPS_EN register\n", device);
 			exit(1);
 		}
-		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_AUTO_ENABLE);
+		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_AUTO_ENABLE,
+				SWITCH_TIMEOUT_MS);
 	} else if (strcmp(en_type, "manual") == 0) {
-		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_MAN_ENABLE);
+		ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_MAN_ENABLE,
+				SWITCH_TIMEOUT_MS);
 	} else {
 		fprintf(stderr, "%s invalid mode for BKOPS_EN requested: %s. Valid options: auto or manual\n", en_type, device);
 		exit(1);
@@ -1002,7 +1013,8 @@ int set_partitioning_setting_completed(int dry_run, const char * const device,
 	}
 
 	fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
-	ret = write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1);
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x1 to "
 			"EXT_CSD[%d] in %s\n",
@@ -1188,7 +1200,8 @@ int do_create_gp_partition(int nargs, char **argv)
 	gp_size_mult = (length_kib + align/2l) / align;
 
 	/* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
-	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
+	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x1 to EXT_CSD[%d] in %s\n",
 			EXT_CSD_ERASE_GROUP_DEF, device);
@@ -1197,7 +1210,7 @@ int do_create_gp_partition(int nargs, char **argv)
 
 	value = (gp_size_mult >> 16) & 0xff;
 	address = EXT_CSD_GP_SIZE_MULT_1_2 + (partition - 1) * 3;
-	ret = write_extcsd_value(fd, address, value);
+	ret = write_extcsd_value(fd, address, value, SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			value, address, device);
@@ -1205,7 +1218,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	}
 	value = (gp_size_mult >> 8) & 0xff;
 	address = EXT_CSD_GP_SIZE_MULT_1_1 + (partition - 1) * 3;
-	ret = write_extcsd_value(fd, address, value);
+	ret = write_extcsd_value(fd, address, value, SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			value, address, device);
@@ -1213,7 +1226,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	}
 	value = gp_size_mult & 0xff;
 	address = EXT_CSD_GP_SIZE_MULT_1_0 + (partition - 1) * 3;
-	ret = write_extcsd_value(fd, address, value);
+	ret = write_extcsd_value(fd, address, value, SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			value, address, device);
@@ -1226,7 +1239,8 @@ int do_create_gp_partition(int nargs, char **argv)
 	else
 		value &= ~(1 << partition);
 
-	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value);
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write EXT_CSD_ENH_%x to EXT_CSD[%d] in %s\n",
 			partition, EXT_CSD_PARTITIONS_ATTRIBUTE, device);
@@ -1240,7 +1254,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	else
 		value &= (0xF << (4 * ((partition % 2))));
 
-	ret = write_extcsd_value(fd, address, value);
+	ret = write_extcsd_value(fd, address, value, SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%x to EXT_CSD[%d] in %s\n",
 			value, address, device);
@@ -1317,7 +1331,8 @@ int do_enh_area_set(int nargs, char **argv)
 	enh_start_addr *= align;
 
 	/* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
-	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
+	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x1 to "
 			"EXT_CSD[%d] in %s\n",
@@ -1327,7 +1342,8 @@ int do_enh_area_set(int nargs, char **argv)
 
 	/* write to ENH_START_ADDR and ENH_SIZE_MULT and PARTITIONS_ATTRIBUTE's ENH_USR bit */
 	value = (enh_start_addr >> 24) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1335,7 +1351,8 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = (enh_start_addr >> 16) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_2, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_2, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1343,7 +1360,8 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = (enh_start_addr >> 8) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_1, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_1, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1351,7 +1369,8 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = enh_start_addr & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_0, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_0, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1360,7 +1379,8 @@ int do_enh_area_set(int nargs, char **argv)
 	}
 
 	value = (enh_size_mult >> 16) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_2, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_2, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1368,7 +1388,7 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = (enh_size_mult >> 8) & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_1, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_1, value, SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1376,7 +1396,8 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = enh_size_mult & 0xff;
-	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_0, value);
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_0, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
 			"EXT_CSD[%d] in %s\n", value,
@@ -1384,7 +1405,8 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 	value = ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] | EXT_CSD_ENH_USR;
-	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value);
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write EXT_CSD_ENH_USR to "
 			"EXT_CSD[%d] in %s\n",
@@ -1455,7 +1477,8 @@ int do_write_reliability_set(int nargs, char **argv)
 	}
 
 	value = ext_csd[EXT_CSD_WR_REL_SET] | (1<<partition);
-	ret = write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value);
+	ret = write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 				value, EXT_CSD_WR_REL_SET, device);
@@ -1998,7 +2021,8 @@ int do_sanitize(int nargs, char **argv)
 		exit(1);
 	}
 
-	ret = write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1);
+	ret = write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
 			1, EXT_CSD_SANITIZE_START, device);
@@ -2587,7 +2611,8 @@ int do_cache_ctrl(int value, int nargs, char **argv)
 			device);
 		exit(1);
 	}
-	ret = write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value);
+	ret = write_extcsd_value(fd, EXT_CSD_CACHE_CTRL, value,
+			SWITCH_TIMEOUT_MS);
 	if (ret) {
 		fprintf(stderr,
 			"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

