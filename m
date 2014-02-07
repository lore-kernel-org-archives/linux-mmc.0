From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] Decode EXT_CSD of eMMC 5.0 device
Date: Fri,  7 Feb 2014 14:37:23 -0800
Message-ID: <1391812643-20389-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:37488 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbaBGWhj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Feb 2014 17:37:39 -0500
Received: by mail-qc0-f202.google.com with SMTP id m20so530970qcx.5
        for <linux-mmc@vger.kernel.org>; Fri, 07 Feb 2014 14:37:38 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, oliver@freetz.org
Cc: linux-mmc@vger.kernel.org, grundler@chromium.org, Gwendal Grignou <gwendal@chromium.org>

Display new attributes in Extended CSD register introduced by eMMC 5.0:
'mmc  extcsd read /dev/mmcblk0' returns for eMMC 5.0 device:

=============================================
  Extended CSD rev 1.7 (MMC 5.0)
=============================================

Card Supported Command sets [S_CMD_SET: 0x01]
...
Extended partition attribute support [EXT_SUPPORT: 0x03]
Supported modes [SUPPORTED_MODES: 0x01]
FFU features [FFU_FEATURES: 0x00]
Operation codes timeout [OPERATION_CODE_TIMEOUT: 0x00]
FFU Argument [FFU_ARG: 0x00000000]
Number of FW sectors correctly programmed [NUMBER_OF_FW_SECTORS_CORRECTLY_PROGRAMMED: 0]
Vendor proprietary health report:
[VENDOR_PROPRIETARY_HEALTH_REPORT[301]]: 0x00
...
[VENDOR_PROPRIETARY_HEALTH_REPORT[270]]: 0x00
Device life time estimation type B [DEVICE_LIFE_TIME_EST_TYP_B: 0x01]
 i.e. 0% - 10% device life time used
Device life time estimation type B [DEVICE_LIFE_TIME_EST_TYP_A: 0x01]
 i.e. 0% - 10% device life time used
Pre EOL information [PRE_EOL_INFO: 0x01]
 i.e. Normal
Optimal read size [OPTIMAL_READ_SIZE: 0x00]
Optimal write size [OPTIMAL_WRITE_SIZE: 0x10]
Optimal trim unit size [OPTIMAL_TRIM_UNIT_SIZE: 0x01]
Device version [DEVICE_VERSION: 0x00 - 0x00]
Firmware version:
[FIRMWARE_VERSION[261]]: 0x00
...
[FIRMWARE_VERSION[254]]: 0x05
Power class for 200MHz, DDR at VCC= 3.6V [PWR_CL_DDR_200_360: 0x00]
Generic CMD6 Timer [GENERIC_CMD6_TIME: 0x0a]
Power off notification [POWER_OFF_LONG_TIME: 0x3c]
Cache Size [CACHE_SIZE] is 65536 KiB
...

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>
---
 mmc_cmds.c | 146 ++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 102 insertions(+), 44 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index b8afa74..4b9b12e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -424,12 +424,17 @@ int do_status_get(int nargs, char **argv)
 	return ret;
 }
 
+__u32 get_word_from_ext_csd(__u8 *ext_csd_loc)
+{
+	return (ext_csd_loc[3] << 24) |
+		(ext_csd_loc[2] << 16) |
+		(ext_csd_loc[1] << 8)  |
+		ext_csd_loc[0];
+}
+
 unsigned int get_sector_count(__u8 *ext_csd)
 {
-	return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) |
-	(ext_csd[EXT_CSD_SEC_COUNT_2] << 16) |
-	(ext_csd[EXT_CSD_SEC_COUNT_1] << 8)  |
-	ext_csd[EXT_CSD_SEC_COUNT_0];
+	return get_word_from_ext_csd(&ext_csd[EXT_CSD_SEC_COUNT_0]);
 }
 
 int is_blockaddresed(__u8 *ext_csd)
@@ -701,6 +706,23 @@ int do_read_extcsd(int nargs, char **argv)
 	int fd, ret;
 	char *device;
 	const char *str;
+	const char *ver_str[] = {
+		"4.0",	/* 0 */
+		"4.1",	/* 1 */
+		"4.2",	/* 2 */
+		"4.3",	/* 3 */
+		"Obsolete", /* 4 */
+		"4.41",	/* 5 */
+		"4.5",  /* 6 */
+		"5.0",  /* 7 */
+	};
+	int boot_access;
+	const char* boot_access_str[] = {
+		"No access to boot partition",		/* 0 */
+		"R/W Boot Partition 1",			/* 1 */
+		"R/W Boot Partition 2",			/* 2 */
+		"R/W Replay Protected Memory Block (RPMB)", /* 3 */
+	};
 
 	CHECK(nargs != 2, "Usage: mmc extcsd read </path/to/mmcblkX>\n",
 			  exit(1));
@@ -721,28 +743,12 @@ int do_read_extcsd(int nargs, char **argv)
 
 	ext_csd_rev = ext_csd[192];
 
-	switch (ext_csd_rev) {
-	case 6:
-		str = "4.5";
-		break;
-	case 5:
-		str = "4.41";
-		break;
-	case 3:
-		str = "4.3";
-		break;
-	case 2:
-		str = "4.2";
-		break;
-	case 1:
-		str = "4.1";
-		break;
-	case 0:
-		str = "4.0";
-		break;
-	default:
+	if ((ext_csd_rev < sizeof(ver_str)/sizeof(char*)) &&
+	    (ext_csd_rev != 4))
+		str = ver_str[ext_csd_rev];
+	else
 		goto out_free;
-	}
+
 	printf("=============================================\n");
 	printf("  Extended CSD rev 1.%d (MMC %s)\n", ext_csd_rev, str);
 	printf("=============================================\n\n");
@@ -789,13 +795,77 @@ int do_read_extcsd(int nargs, char **argv)
 			ext_csd[495]);
 		printf("Extended partition attribute support"
 			" [EXT_SUPPORT: 0x%02x]\n", ext_csd[494]);
+	}
+	if (ext_csd_rev >= 7) {
+		int j;
+		int eol_info;
+		char* eol_info_str[] = {
+			"Not Defined",	/* 0 */
+			"Normal",	/* 1 */
+			"Warning",	/* 2 */
+			"Urgent",	/* 3 */
+		};
+
+		printf("Supported modes [SUPPORTED_MODES: 0x%02x]\n",
+			ext_csd[493]);
+		printf("FFU features [FFU_FEATURES: 0x%02x]\n",
+			ext_csd[492]);
+		printf("Operation codes timeout"
+			" [OPERATION_CODE_TIMEOUT: 0x%02x]\n",
+			ext_csd[491]);
+		printf("FFU Argument [FFU_ARG: 0x%08x]\n",
+			get_word_from_ext_csd(&ext_csd[487]));
+		printf("Number of FW sectors correctly programmed"
+			" [NUMBER_OF_FW_SECTORS_CORRECTLY_PROGRAMMED: %d]\n",
+			get_word_from_ext_csd(&ext_csd[302]));
+		printf("Vendor proprietary health report:\n");
+		for (j = 301; j >= 270; j--)
+			printf("[VENDOR_PROPRIETARY_HEALTH_REPORT[%d]]:"
+				" 0x%02x\n", j, ext_csd[j]);
+		for (j = 269; j >= 268; j--) {
+			__u8 life_used=ext_csd[j];
+			printf("Device life time estimation type B"
+				" [DEVICE_LIFE_TIME_EST_TYP_%c: 0x%02x]\n",
+				'B' + (j - 269), life_used);
+			if (life_used >= 0x1 && life_used <= 0xa)
+				printf(" i.e. %d%% - %d%% device life time"
+					" used\n",
+					(life_used - 1) * 10, life_used * 10);
+			else if (life_used == 0xb)
+				printf(" i.e. Exceeded its maximum estimated"
+					" device life time\n");
+		}
+		eol_info = ext_csd[267];
+		printf("Pre EOL information [PRE_EOL_INFO: 0x%02x]\n",
+			eol_info);
+		if (eol_info < sizeof(eol_info_str)/sizeof(char*))
+			printf(" i.e. %s\n", eol_info_str[eol_info]);
+		else
+			printf(" i.e. Reserved\n");
+
+		printf("Optimal read size [OPTIMAL_READ_SIZE: 0x%02x]\n",
+			ext_csd[266]);
+		printf("Optimal write size [OPTIMAL_WRITE_SIZE: 0x%02x]\n",
+			ext_csd[265]);
+		printf("Optimal trim unit size"
+			" [OPTIMAL_TRIM_UNIT_SIZE: 0x%02x]\n", ext_csd[264]);
+		printf("Device version [DEVICE_VERSION: 0x%02x - 0x%02x]\n",
+			ext_csd[263], ext_csd[262]);
+		printf("Firmware version:\n");
+		for (j = 261; j >= 254; j--)
+			printf("[FIRMWARE_VERSION[%d]]:"
+				" 0x%02x\n", j, ext_csd[j]);
+
+		printf("Power class for 200MHz, DDR at VCC= 3.6V"
+			" [PWR_CL_DDR_200_360: 0x%02x]\n", ext_csd[253]);
+	}
+	if (ext_csd_rev >= 6) {
 		printf("Generic CMD6 Timer [GENERIC_CMD6_TIME: 0x%02x]\n",
 			ext_csd[248]);
 		printf("Power off notification [POWER_OFF_LONG_TIME: 0x%02x]\n",
 			ext_csd[247]);
 		printf("Cache Size [CACHE_SIZE] is %d KiB\n",
-			ext_csd[249] << 0 | (ext_csd[250] << 8) |
-			(ext_csd[251] << 16) | (ext_csd[252] << 24));
+			get_word_from_ext_csd(&ext_csd[249]));
 	}
 
 	/* A441: Reserved [501:247]
@@ -945,24 +1015,12 @@ int do_read_extcsd(int nargs, char **argv)
 		printf(" User Area Enabled for boot\n");
 		break;
 	}
-	switch (reg & EXT_CSD_BOOT_CFG_ACC) {
-	case 0x0:
-		printf(" No access to boot partition\n");
-		break;
-	case 0x1:
-		printf(" R/W Boot Partition 1\n");
-		break;
-	case 0x2:
-		printf(" R/W Boot Partition 2\n");
-		break;
-	case 0x3:
-		printf(" R/W Replay Protected Memory Block (RPMB)\n");
-		break;
-	default:
+	boot_access = reg & EXT_CSD_BOOT_CFG_ACC;
+	if (boot_access < sizeof(boot_access_str) / sizeof(char*))
+		printf(" %s\n", boot_access_str[boot_access]);
+	else
 		printf(" Access to General Purpose partition %d\n",
-			(reg & EXT_CSD_BOOT_CFG_ACC) - 3);
-		break;
-	}
+			boot_access - 3);
 
 	printf("Boot config protection [BOOT_CONFIG_PROT: 0x%02x]\n",
 		ext_csd[178]);
-- 
1.9.0.rc1.175.g0b1dcb5

