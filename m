Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FC26980C
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843698; cv=none; b=EdAt/Pe/JzfrOFokXbIgTRPqTodYsNhovQepRZMl/7Se9nZvQ57aAeSScoYzo4mEwCGJmTwSqKJQyWnAYdMmtOb1iv4ITJGBOb7XP2U8tBZcoYP4ECLdWHcLP0B2ec6LCfpbTEsRZkmAQ+RoqYY6NDTkMhKiUk4a0r6RYBjZrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843698; c=relaxed/simple;
	bh=PbUq1leOYvoS+FVeNgtqmjMpstgRFlPz/4TovUSaT2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCDpYea40GKfbzUdFAd/N8FYUzszE+k3dnJIMocNNdnf1ndXpcjg6EKi8DMsYw9y7wAebi7BGAGjFzFdzwGKqIKjzO27u+bQrLjlEpAYQGTFC2TsbGyDICtGzWz7YB+V/KKDd+s1RvrF2d1rxGzVMFgFHRw/jzSkoqHMyxG8dQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=npkqAfdH; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="npkqAfdH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1745843696; x=1777379696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbUq1leOYvoS+FVeNgtqmjMpstgRFlPz/4TovUSaT2k=;
  b=npkqAfdHmMoQd0nH2nUnJiMXE6aOX+YGEHbXOwSdvwHIYdphFiOHfr6k
   MYMWs2BVD80Pk6INCS2WOEqIeCtJ6xsclQnHUJS+XjXuR4m+XS1kOfxSs
   OZoe5lyHX5nTsmKX4pCWicCizDD3OEElZem+q5vsUYkCAOy+0kNqYisJc
   L16/ST6/KZyjyFOus6y4hhOWS8garxpmEGD3QY732JvgftOvP41CpByDZ
   8uFW/PTz/+lF7kT0l9qqRaL7T68u3ga+AVomrI/wgUxdjHisUvbmYigkf
   CYIdKw+6Pqfuqbe99bimAt0f7my9PLmuIPU7IUZK61tlJIiWw3A6k/Moa
   g==;
X-CSE-ConnectionGUID: kTpXLFnxTLitVkooseof/Q==
X-CSE-MsgGUID: I5h+vDXtQU+/fjYnON/msQ==
X-IronPort-AV: E=Sophos;i="6.15,246,1739808000"; 
   d="scan'208";a="76703721"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 20:34:54 +0800
IronPort-SDR: 680f67cd_bJhUe+awRr3SaD9lWnqHmCzPHnmCjZhtSSrtEbA22TMsGaq
 vx/o86TNXu2W7RM82V6iXlS2On5fEvPtmGiyd4w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 04:34:36 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 05:34:53 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 1/4] mmc-utils: Remove unused adv_help member from struct Command
Date: Mon, 28 Apr 2025 15:29:48 +0300
Message-Id: <20250428122951.317055-2-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428122951.317055-1-avri.altman@sandisk.com>
References: <20250428122951.317055-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field was originally introduced in the early days of mmc-utils
(2012) but has never been used in any command. Its presence added
unnecessary complexity to the code.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc.c | 72 +++++++++--------------------------------------------------
 1 file changed, 10 insertions(+), 62 deletions(-)

diff --git a/mmc.c b/mmc.c
index 36cfe90..2b58162 100644
--- a/mmc.c
+++ b/mmc.c
@@ -26,9 +26,6 @@
 
 #include "mmc_cmds.h"
 
-#define BASIC_HELP 0
-#define ADVANCED_HELP 1
-
 typedef int (*CommandFunction)(int argc, char **argv);
 
 struct Command {
@@ -37,10 +34,8 @@ struct Command {
 				   if >= 0, number of arguments,
 				   if < 0, _minimum_ number of arguments */
 	char	*verb;		/* verb */
-	char	*help;		/* help lines; from the 2nd line onward they 
+	char	*help;		/* help lines; from the 2nd line onward they
                                    are automatically indented */
-        char    *adv_help;      /* advanced help message; from the 2nd line 
-                                   onward they are automatically indented */
 
 	/* the following fields are run-time filled by the program */
 	char	**cmds;		/* array of subcommands */
@@ -54,17 +49,14 @@ static struct Command commands[] = {
 	{ do_read_extcsd, -1,
 	  "extcsd read", "<device>\n"
 		"Print extcsd data from <device>.",
-	  NULL
 	},
 	{ do_write_extcsd, 3,
 	  "extcsd write", "<offset> <value> <device>\n"
 		  "Write <value> at offset <offset> to <device>'s extcsd.",
-	  NULL
 	},
 	{ do_writeprotect_boot_get, -1,
 	  "writeprotect boot get", "<device>\n"
 		"Print the boot partitions write protect status for <device>.",
-	  NULL
 	},
 	{ do_writeprotect_boot_set, -1,
 	  "writeprotect boot set",
@@ -80,7 +72,7 @@ static struct Command commands[] = {
 		"  -p  Protect partition permanently instead.\n"
 		"      NOTE! -p is a one-time programmable (unreversible) change.\n"
 #endif /* DANGEROUS_COMMANDS_ENABLED */
-	  , NULL
+	  ,
 	},
 	{ do_writeprotect_user_set, -4,
 	  "writeprotect user set", "<type>" "<start block>" "<blocks>" "<device>\n"
@@ -89,42 +81,34 @@ static struct Command commands[] = {
 #else
 	  "Set the write protect configuration for the specified region\nof the user area for <device>.\n<type> must be \"none|temp|pwron\".\n    \"none\"  - Clear temporary write protection.\n    \"temp\"  - Set temporary write protection.\n    \"pwron\" - Set write protection until the next poweron.\n<start block> specifies the first block of the protected area.\n<blocks> specifies the size of the protected area in blocks.\nNOTE! The area must start and end on Write Protect Group\nboundries, Use the \"writeprotect user get\" command to get the\nWrite Protect Group size.",
 #endif /* DANGEROUS_COMMANDS_ENABLED */
-	  NULL
 	},
 	{ do_writeprotect_user_get, -1,
 	  "writeprotect user get", "<device>\n"
 		"Print the user areas write protect configuration for <device>.",
-	  NULL
 	},
 	{ do_disable_512B_emulation, -1,
 	  "disable 512B emulation", "<device>\n"
 		"Set the eMMC data sector size to 4KB by disabling emulation on\n<device>.",
-	  NULL
 	},
 	{ do_create_gp_partition, -6,
 	  "gp create", "<-y|-n|-c> " "<length KiB> " "<partition> " "<enh_attr> " "<ext_attr> " "<device>\n"
 		"Create general purpose partition for the <device>.\nDry-run only unless -y or -c is passed.\nUse -c if more partitioning settings are still to come.\nNOTE!  This is a one-time programmable (unreversible) change.\nTo set enhanced attribute to general partition being created set\n <enh_attr> to 1 else set it to 0.\nTo set extended attribute to general partition\n set <ext_attr> to 1,2 else set it to 0",
-	  NULL
 	},
 	{ do_enh_area_set, -4,
 	  "enh_area set", "<-y|-n|-c> " "<start KiB> " "<length KiB> " "<device>\n"
 		"Enable the enhanced user area for the <device>.\nDry-run only unless -y or -c is passed.\nUse -c if more partitioning settings are still to come.\nNOTE!  This is a one-time programmable (unreversible) change.",
-	  NULL
 	},
 	{ do_write_reliability_set, -2,
 	  "write_reliability set", "<-y|-n|-c> " "<partition> " "<device>\n"
 		"Enable write reliability per partition for the <device>.\nDry-run only unless -y or -c is passed.\nUse -c if more partitioning settings are still to come.\nNOTE!  This is a one-time programmable (unreversible) change.",
-	  NULL
 	},
 	{ do_status_get, -1,
 	  "status get", "<device>\n"
 	  "Print the response to STATUS_SEND (CMD13).",
-	  NULL
 	},
 	{ do_write_boot_en, -3,
 	  "bootpart enable", "<boot_partition> " "<send_ack> " "<device>\n"
 		"Enable the boot partition for the <device>.\nDisable the boot partition for the <device> if <boot_partition> is set to 0.\nTo receive acknowledgment of boot from the card set <send_ack>\nto 1, else set it to 0.",
-	  NULL
 	},
 	{ do_boot_bus_conditions_set, -4,
 	  "bootbus set", "<boot_mode> " "<reset_boot_bus_conditions> " "<boot_bus_width> " "<device>\n"
@@ -132,7 +116,6 @@ static struct Command commands[] = {
 	  "<boot_mode> must be \"single_backward|single_hs|dual\"\n"
 	  "<reset_boot_bus_conditions> must be \"x1|retain\"\n"
 	  "<boot_bus_width> must be \"x1|x4|x8\"",
-	  NULL
 	},
 	{ do_write_bkops_en, -2,
 	  "bkops_en", "<auto|manual> <device>\n"
@@ -140,22 +123,18 @@ static struct Command commands[] = {
 		"The auto (AUTO_EN) setting is only supported on eMMC 5.0 or newer.\n"
 		"Setting auto won't have any effect if manual is set.\n"
 		"NOTE!  Setting manual (MANUAL_EN) is one-time programmable (unreversible) change.",
-	  NULL
 	},
 	{ do_hwreset_en, -1,
 	  "hwreset enable", "<device>\n"
 		"Permanently enable the eMMC H/W Reset feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
-	  NULL
 	},
 	{ do_hwreset_dis, -1,
 	  "hwreset disable", "<device>\n"
 		"Permanently disable the eMMC H/W Reset feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
-	  NULL
 	},
 	{ do_sanitize, -1,
 	  "sanitize", "<device> [timeout_ms]\n"
 		"Send Sanitize command to the <device>.\nThis will delete the unmapped memory region of the device.",
-	  NULL
 	},
 	{ do_rpmb_write_key, 2,
 	  "rpmb write-key", "<rpmb device> <key file>\n"
@@ -166,12 +145,10 @@ static struct Command commands[] = {
 		  "Example:\n"
 		  "  $ echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
 		  "    mmc rpmb write-key /dev/mmcblk0rpmb -",
-	  NULL
 	},
 	{ do_rpmb_read_counter, 1,
 	  "rpmb read-counter", "<rpmb device>\n"
 		  "Counter value for the <rpmb device> will be read to stdout.",
-	  NULL
 	},
 	{ do_rpmb_read_block, -4,
 	  "rpmb read-block", "<rpmb device> <address> <blocks count> <output file> [key file]\n"
@@ -184,7 +161,6 @@ static struct Command commands[] = {
 		  "    mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 /tmp/block -\n"
 		  "or read two blocks without verification\n"
 		  "  $ mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 /tmp/block",
-	  NULL
 	},
 	{ do_rpmb_write_block, 4,
 	  "rpmb write-block", "<rpmb device> <address> <256 byte data file> <key file>\n"
@@ -195,7 +171,6 @@ static struct Command commands[] = {
 		  "  $ (awk 'BEGIN {while (c++<256) printf \"a\"}' | \\\n"
 		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH) | \\\n"
 		  "    mmc rpmb write-block /dev/mmcblk0rpmb 0x02 - -",
-	  NULL
 	},
 	{ do_rpmb_sec_wp_enable, 3,
 	  "rpmb secure-wp-mode-on", "<dev> <rpmb device> <key file>\n"
@@ -207,7 +182,6 @@ static struct Command commands[] = {
 		  "Example:\n"
 		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
 		  "    mmc rpmb secure-wp-mode-on /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
-	  NULL
 	},
 	{ do_rpmb_sec_wp_disable, 3,
 	  "rpmb secure-wp-mode-off", "<dev> <rpmb device> <key file>\n"
@@ -218,7 +192,6 @@ static struct Command commands[] = {
 		  "Example:\n"
 		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
 		  "    mmc rpmb secure-wp-mode-off /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
-	  NULL
 	},
 	{ do_rpmb_sec_wp_mode_set, 3,
 	  "rpmb secure-wp-disable", "<dev> <rpmb device> <key file>\n"
@@ -228,7 +201,6 @@ static struct Command commands[] = {
 		  "Example:\n"
 		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
 		  "    mmc rpmb secure-wp-disable /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
-	  NULL
 	},
 	{ do_rpmb_sec_wp_mode_clear, 3,
 	  "rpmb secure-wp-enable", "<dev> <rpmb device> <key file>\n"
@@ -238,7 +210,6 @@ static struct Command commands[] = {
 		  "Example:\n"
 		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
 		  "    mmc rpmb secure-wp-enable /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
-	  NULL
 	},
 	{ do_rpmb_sec_wp_en_read, -2,
 	  "rpmb secure-wp-en-read", "<device> <rpmb device> [key file]\n"
@@ -249,64 +220,53 @@ static struct Command commands[] = {
 		  "    mmc rpmb secure-wp-en-read /dev/mmcblk0 /dev/mmcblk0rpmb -\n"
 		  "or read without verification\n"
 		  "  $ mmc rpmb secure-wp-en-read /dev/mmcblk0 /dev/mmcblk0rpmb",
-	  NULL
 	},
 	{ do_cache_en, -1,
 	  "cache enable", "<device>\n"
 		"Enable the eMMC cache feature on <device>.\n"
 		"NOTE! The cache is an optional feature on devices >= eMMC4.5.",
-	  NULL
 	},
 	{ do_cache_dis, -1,
 	  "cache disable", "<device>\n"
 		"Disable the eMMC cache feature on <device>.\n"
 		"NOTE! The cache is an optional feature on devices >= eMMC4.5.",
-	  NULL
 	},
 	{ do_read_csd, -1,
 	  "csd read", "<device path>\n"
 		  "Print CSD data from <device path>.\n"
 		  "The device path should specify the csd file directory.",
-	  NULL
 	},
 	{ do_read_cid, -1,
 	  "cid read", "<device path>\n"
 		  "Print CID data from <device path>.\n"
 		  "The device path should specify the cid file directory.",
-	  NULL
 	},
 	{ do_read_scr, -1,
 	  "scr read", "<device path>\n"
 		  "Print SCR data from <device path>.\n"
 		  "The device path should specify the scr file directory.",
-	  NULL
 	},
 	{ do_ffu, -2,
 	  "ffu", "<image name> <device> [chunk-bytes]\n"
 		"Run Field Firmware Update with <image name> on <device>.\n"
 		"[chunk-bytes] is optional and defaults to its max - 512k. "
 		"should be in decimal bytes and sector aligned.\n",
-	  NULL
 	},
 	{ do_opt_ffu1, -2,
 	 "opt_ffu1", "<image name> <device> [chunk-bytes]\n"
 	 "Optional FFU mode 1, it's the same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.\n",
-	 NULL
 	},
 	{ do_opt_ffu2, -2,
 	 "opt_ffu2", "<image name> <device> [chunk-bytes]\n"
 	 "Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
-	 NULL
 	},
 	{ do_opt_ffu3, -2,
 	"opt_ffu3", "<image name> <device> [chunk-bytes]\n"
 	"Optional FFU mode 3, uses CMD24 Single-block write for downloading, exiting FFU mode after each block written.\n",
-	NULL
 	},
 	{ do_opt_ffu4, -2,
 	 "opt_ffu4", "<image name> <device> [chunk-bytes]\n"
 	 "Optional FFU mode 4, uses CMD24 Single-block write for repeated downloads, remaining in FFU mode until completion.\n",
-	 NULL
 	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
@@ -314,7 +274,6 @@ static struct Command commands[] = {
 		"NOTE!: This will delete all user data in the specified region of the device\n"
 		"<type> must be: legacy | discard | secure-erase | "
 		"secure-trim1 | secure-trim2 | trim \n",
-	NULL
 	},
 	{ do_general_cmd_read, -1,
 	"gen_cmd read", "<device> [arg]\n"
@@ -322,17 +281,14 @@ static struct Command commands[] = {
 		"NOTE!: [arg] is optional and defaults to 0x1. If [arg] is specified, then [arg]\n"
 		"must be a 32-bit hexadecimal number, prefixed with 0x/0X. And bit0 in [arg] must\n"
 		"be 1.",
-	NULL
 	},
 	{ do_softreset, -1,
 	  "softreset", "<device>\n"
 	  "Issues a CMD0 softreset, e.g. for testing if hardware reset for UHS works",
-	  NULL
 	},
 	{ do_preidle, -1,
 	  "preidle", "<device>\n"
 	  "Issues a CMD0 GO_PRE_IDLE",
-	  NULL
 	},
 	{ do_alt_boot_op, -1,
 	  "boot_operation", "<boot_data_file> <device>\n"
@@ -344,7 +300,6 @@ static struct Command commands[] = {
 	  "2. The MMC must currently be running at the bus mode that is configured for the boot operation (HS200 and HS400 not supported at all).\n"
 	  "3. Only up to 512K bytes of boot data will be transferred.\n"
 	  "4. The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.\n",
-	  NULL
 	},
 	{ NULL, 0, NULL, NULL }
 };
@@ -361,24 +316,17 @@ static char *get_prgname(char *programname)
 	return np;
 }
 
-static void print_help(char *programname, struct Command *cmd, int helptype)
+static void print_help(char *programname, struct Command *cmd)
 {
 	char	*pc;
 
 	printf("\t%s %s ", programname, cmd->verb );
 
-	if (helptype == ADVANCED_HELP && cmd->adv_help)
-		for(pc = cmd->adv_help; *pc; pc++){
-			putchar(*pc);
-			if(*pc == '\n')
-				printf("\t\t");
-		}
-	else
-		for(pc = cmd->help; *pc; pc++){
-			putchar(*pc);
-			if(*pc == '\n')
-				printf("\t\t");
-		}
+	for(pc = cmd->help; *pc; pc++){
+		putchar(*pc);
+		if(*pc == '\n')
+			printf("\t\t");
+	}
 
 	putchar('\n');
 }
@@ -389,7 +337,7 @@ static void help(char *np)
 
 	printf("Usage:\n");
 	for( cp = commands; cp->verb; cp++ )
-		print_help(np, cp, BASIC_HELP);
+		print_help(np, cp);
 
 	printf("\n\t%s help|--help|-h\n\t\tShow the help.\n",np);
 	printf("\n\t%s <cmd> --help\n\t\tShow detailed help for a command or subset of commands.\n",np);
@@ -556,7 +504,7 @@ static int parse_args(int argc, char **argv,
 		if(argc>i+1 && !strcmp(argv[i+1],"--help")){
 			if(!helprequested)
 				printf("Usage:\n");
-			print_help(prgname, cp, ADVANCED_HELP);
+			print_help(prgname, cp);
 			helprequested=1;
 			continue;
 		}
-- 
2.25.1

