From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH mmc-utils 1/6] mmc-utils: drop macro CHECK
Date: Thu, 21 Dec 2017 14:33:11 +0100
Message-ID: <20171221133316.19466-2-u.kleine-koenig@pengutronix.de>
References: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54135 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753074AbdLUNwK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Dec 2017 08:52:10 -0500
In-Reply-To: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de

This macro saves a few lines of code but is harder to read than the
equivalent code spelled out. IMHO the latter is more important, so
expand the macro everywhere and drop it.

While touching this also unbreak the strings used there for better
grepability.
---
 lsmmc.c    |  18 ++++++---
 mmc.h      |   3 --
 mmc_cmds.c | 124 ++++++++++++++++++++++++++++++++++++++++---------------------
 3 files changed, 93 insertions(+), 52 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 71e6a58d26fc..c4faa002e780 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -2348,8 +2348,10 @@ int do_read_csd(int argc, char **argv)
 	struct config config;
 	int ret;
 
-	CHECK(argc != 2 && argc != 3, "Usage: Print CSD data from <device path>.\n",
-	      exit(1));
+	if (argc != 2 && argc != 3) {
+		fprintf(stderr, "Usage: Print CSD data from <device path>.\n");
+		exit(1);
+	}
 
 	ret = lsmmc_main(&config, argc, argv);
 	if (ret)
@@ -2369,8 +2371,10 @@ int do_read_cid(int argc, char **argv)
 	struct config config;
 	int ret;
 
-	CHECK(argc != 2 && argc != 3, "Usage: Print CID data from <device path>.\n",
-	      exit(1));
+	if (argc != 2 && argc != 3) {
+		fprintf(stderr, "Usage: Print CID data from <device path>.\n");
+		exit(1);
+	}
 
 	ret = lsmmc_main(&config, argc, argv);
 	if (ret)
@@ -2390,8 +2394,10 @@ int do_read_scr(int argc, char **argv)
 	struct config config;
 	int ret;
 
-	CHECK(argc != 2 && argc != 3, "Usage: Print SCR data from <device path>.\n",
-	      exit(1));
+	if (argc != 2 && argc != 3) {
+		fprintf(stderr, "Usage: Print SCR data from <device path>.\n");
+		exit(1);
+	}
 
 	ret = lsmmc_main(&config, argc, argv);
 	if (ret)
diff --git a/mmc.h b/mmc.h
index fa49df6f79f8..4beb4fd1a819 100644
--- a/mmc.h
+++ b/mmc.h
@@ -19,9 +19,6 @@
 
 #include <asm-generic/int-ll64.h>
 #include <linux/mmc/ioctl.h>
-#include <stdio.h>
-
-#define CHECK(expr, msg, err_stmt) { if (expr) { fprintf(stderr, msg); err_stmt; } }
 
 #ifndef offsetof
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index d7215bb8921f..f1c70fb5fe55 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -231,9 +231,10 @@ int do_writeprotect_boot_get(int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	CHECK(nargs != 2,
-		"Usage: mmc writeprotect boot get </path/to/mmcblkX>\n",
-		exit(1));
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc writeprotect boot get </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	device = argv[1];
 
@@ -260,9 +261,10 @@ int do_writeprotect_boot_set(int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	CHECK(nargs != 2,
-		"Usage: mmc writeprotect boot set </path/to/mmcblkX>\n",
-		exit(1));
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc writeprotect boot set </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	device = argv[1];
 
@@ -325,9 +327,10 @@ int do_writeprotect_user_get(int nargs, char **argv)
 	__u32 last_prot = -1;
 	int remain;
 
-	CHECK(nargs != 2,
-		"Usage: mmc writeprotect user get </path/to/mmcblkX>\n",
-		exit(1));
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc writeprotect user get </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	device = argv[1];
 
@@ -482,7 +485,11 @@ int do_disable_512B_emulation(int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	CHECK(nargs != 2, "Usage: mmc disable 512B emulation </path/to/mmcblkX>\n", exit(1));
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc disable 512B emulation </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
 	device = argv[1];
 
 	fd = open(device, O_RDWR);
@@ -528,8 +535,10 @@ int do_write_boot_en(int nargs, char **argv)
 	char *device;
 	int boot_area, send_ack;
 
-	CHECK(nargs != 4, "Usage: mmc bootpart enable <partition_number> "
-			  "<send_ack> </path/to/mmcblkX>\n", exit(1));
+	if (nargs != 4) {
+		fprintf(stderr, "Usage: mmc bootpart enable <partition_number> <send_ack> </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	/*
 	 * If <send_ack> is 1, the device will send acknowledgment
@@ -596,9 +605,10 @@ int do_boot_bus_conditions_set(int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	CHECK(nargs != 5, "Usage: mmc: bootbus set <boot_mode> "
-	      "<reset_boot_bus_conditions> <boot_bus_width> <device>\n",
-		exit(1));
+	if (nargs != 5) {
+		fprintf(stderr, "Usage: mmc: bootbus set <boot_mode> <reset_boot_bus_conditions> <boot_bus_width> <device>\n");
+		exit(1);
+	}
 
 	if (strcmp(argv[1], "single_backward") == 0)
 		value |= 0;
@@ -664,8 +674,10 @@ int do_hwreset(int value, int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	CHECK(nargs != 2, "Usage: mmc hwreset enable </path/to/mmcblkX>\n",
-			  exit(1));
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc hwreset enable </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	device = argv[1];
 
@@ -723,8 +735,10 @@ int do_write_bkops_en(int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	CHECK(nargs != 2, "Usage: mmc bkops enable </path/to/mmcblkX>\n",
-			exit(1));
+	if (nargs != 2) {
+	       fprintf(stderr, "Usage: mmc bkops enable </path/to/mmcblkX>\n");
+	       exit(1);
+	}
 
 	device = argv[1];
 
@@ -761,8 +775,10 @@ int do_status_get(int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	CHECK(nargs != 2, "Usage: mmc status get </path/to/mmcblkX>\n",
-		exit(1));
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc status get </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	device = argv[1];
 
@@ -963,8 +979,10 @@ int do_create_gp_partition(int nargs, char **argv)
 	unsigned int length_kib, gp_size_mult;
 	unsigned long align;
 
-	CHECK(nargs != 7, "Usage: mmc gp create <-y|-n|-c> <length KiB> "
-		"<partition> <enh_attr> <ext_attr> </path/to/mmcblkX>\n", exit(1));
+	if (nargs != 7) {
+		fprintf(stderr, "Usage: mmc gp create <-y|-n|-c> <length KiB> <partition> <enh_attr> <ext_attr> </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	if (!strcmp("-y", argv[1])) {
 		dry_run = 0;
@@ -1089,8 +1107,10 @@ int do_enh_area_set(int nargs, char **argv)
 	unsigned int start_kib, length_kib, enh_start_addr, enh_size_mult;
 	unsigned long align;
 
-	CHECK(nargs != 5, "Usage: mmc enh_area set <-y|-n|-c> <start KiB> <length KiB> "
-			  "</path/to/mmcblkX>\n", exit(1));
+	if (nargs != 5) {
+		fprintf(stderr, "Usage: mmc enh_area set <-y|-n|-c> <start KiB> <length KiB> </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	if (!strcmp("-y", argv[1])) {
 		dry_run = 0;
@@ -1234,8 +1254,10 @@ int do_write_reliability_set(int nargs, char **argv)
 	int partition;
 	char *device;
 
-	CHECK(nargs != 4, "Usage: mmc write_reliability set <-y|-n|-c> "
-			"<partition> </path/to/mmcblkX>\n", exit(1));
+	if (nargs != 4) {
+		fprintf(stderr,"Usage: mmc write_reliability set <-y|-n|-c> <partition> </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	if (!strcmp("-y", argv[1])) {
 		dry_run = 0;
@@ -1297,8 +1319,10 @@ int do_read_extcsd(int nargs, char **argv)
 	char *device;
 	const char *str;
 
-	CHECK(nargs != 2, "Usage: mmc extcsd read </path/to/mmcblkX>\n",
-			  exit(1));
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc extcsd read </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	device = argv[1];
 
@@ -1761,8 +1785,10 @@ int do_sanitize(int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	CHECK(nargs != 2, "Usage: mmc sanitize </path/to/mmcblkX>\n",
-			exit(1));
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc sanitize </path/to/mmcblkX>\n");
+		exit(1);
+	}
 
 	device = argv[1];
 
@@ -1933,8 +1959,10 @@ int do_rpmb_write_key(int nargs, char **argv)
 		.req_resp = htobe16(MMC_RPMB_WRITE_KEY)
 	}, frame_out;
 
-	CHECK(nargs != 3, "Usage: mmc rpmb write-key </path/to/mmcblkXrpmb> </path/to/key>\n",
-			exit(1));
+	if (nargs != 3) {
+		fprintf(stderr, "Usage: mmc rpmb write-key </path/to/mmcblkXrpmb> </path/to/key>\n");
+		exit(1);
+	}
 
 	dev_fd = open(argv[1], O_RDWR);
 	if (dev_fd < 0) {
@@ -2013,8 +2041,10 @@ int do_rpmb_read_counter(int nargs, char **argv)
 	int ret, dev_fd;
 	unsigned int cnt;
 
-	CHECK(nargs != 2, "Usage: mmc rpmb read-counter </path/to/mmcblkXrpmb>\n",
-			exit(1));
+	if (nargs != 2) {
+		fprintf(stderr, "Usage: mmc rpmb read-counter </path/to/mmcblkXrpmb>\n");
+		exit(1);
+	}
 
 	dev_fd = open(argv[1], O_RDWR);
 	if (dev_fd < 0) {
@@ -2046,8 +2076,10 @@ int do_rpmb_read_block(int nargs, char **argv)
 		.req_resp    = htobe16(MMC_RPMB_READ),
 	}, *frame_out_p;
 
-	CHECK(nargs != 5 && nargs != 6, "Usage: mmc rpmb read-block </path/to/mmcblkXrpmb> <address> <blocks count> </path/to/output_file> [/path/to/key]\n",
-			exit(1));
+	if (nargs != 5 && nargs != 6) {
+		fprintf(stderr, "Usage: mmc rpmb read-block </path/to/mmcblkXrpmb> <address> <blocks count> </path/to/output_file> [/path/to/key]\n");
+		exit(1);
+	}
 
 	dev_fd = open(argv[1], O_RDWR);
 	if (dev_fd < 0) {
@@ -2195,8 +2227,10 @@ int do_rpmb_write_block(int nargs, char **argv)
 		.block_count = htobe16(1)
 	}, frame_out;
 
-	CHECK(nargs != 5, "Usage: mmc rpmb write-block </path/to/mmcblkXrpmb> <address> </path/to/input_file> </path/to/key>\n",
-			exit(1));
+	if (nargs != 5) {
+		fprintf(stderr, "Usage: mmc rpmb write-block </path/to/mmcblkXrpmb> <address> </path/to/input_file> </path/to/key>\n");
+		exit(1);
+	}
 
 	dev_fd = open(argv[1], O_RDWR);
 	if (dev_fd < 0) {
@@ -2300,8 +2334,10 @@ int do_cache_ctrl(int value, int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	CHECK(nargs != 2, "Usage: mmc cache enable </path/to/mmcblkX>\n",
-			  exit(1));
+	if (nargs != 2) {
+	       fprintf(stderr, "Usage: mmc cache enable </path/to/mmcblkX>\n");
+	       exit(1);
+	}
 
 	device = argv[1];
 
@@ -2373,8 +2409,10 @@ int do_ffu(int nargs, char **argv)
 	char *device;
 	struct mmc_ioc_multi_cmd *multi_cmd;
 
-	CHECK(nargs != 3, "Usage: ffu <image name> </path/to/mmcblkX> \n",
-			exit(1));
+	if (nargs != 3) {
+		fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblkX> \n");
+		exit(1);
+	}
 
 	device = argv[2];
 	dev_fd = open(device, O_RDWR);
-- 
2.15.1

