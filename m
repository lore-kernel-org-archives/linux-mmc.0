Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD28836
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843720; cv=none; b=E3VIVyX62PilGtu1DAnUa/wivgOn/AbQcgnl1WUcGB93W0oE3E3pHvLth8K6nkjMKtAqzmD41IaTwvjtf7ILvG8auCaG9cqK9J0kG1Y20eKRRdqNhxGz0y+DO576g0c+68zc2hJfPIfDwB6lFP5Pw0FeI+prxMPIZDRCp3YY2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843720; c=relaxed/simple;
	bh=fX7jYAJiDs3sjpg/B05kS4Hml9lwjJhnEZyqN+v7KRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBu0IhY9kWOzs2skBwTjuCEIE65kyzy9XOiSe+Qbk9M1MBXknqfcA7m7NgWRR8IuQGhzGyY1N0XJeXwjf998D2HBPLAVX3GbwLbAmiBMuDh/HyHUi57Lp7z7FlkJ50ZDH7spJmshmM5R2AP+V/LTJ4y6mOonjfgvhzMsLQsZUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=XritAvZh; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="XritAvZh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1745843718; x=1777379718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fX7jYAJiDs3sjpg/B05kS4Hml9lwjJhnEZyqN+v7KRE=;
  b=XritAvZh0l5PqTWxS821n25FzyYGCR3rYYJUXFnA03MyRiFxL66zjQ8b
   lcVmDv9LFtFTfOXsTEZWemh3J6XUMcTNOa+TNHv+IFPOAfOLQtoj1Sbu/
   fm0edl8cWyoAyjLpgdJpHb1JXEcFvo3GpjYP+MxTUia/Gz+s82164Dxtt
   3KQexytNz+oDKNzjrgOGbvPD/pxR1ahe5kAmHApvVZrtoVUgQfihHcsRk
   TVa6F4RTzq39VC7xDNAopadXTFcYswDgY/FiYzElx759mdRaLmOcLjfnc
   CqDZeWRIhePU8f6nfby3FqAvxmozbW2LY/9XCKILJYlnBo1WzZ5fqp6jv
   g==;
X-CSE-ConnectionGUID: jGBEe1pURkuh8pdOc4/S3Q==
X-CSE-MsgGUID: mB9EPaCHQ/Ki51xNqaYK2A==
X-IronPort-AV: E=Sophos;i="6.15,246,1739808000"; 
   d="scan'208";a="79598022"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 20:35:17 +0800
IronPort-SDR: 680f67e4_gFEHlKBSnsMuifqYnULjWoNcckZpXUNay55uLqQNhRj60+z
 LgB37Uw0WLgW6+hhDEQJpxRy7wSaAI10OCNo73w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 04:35:00 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 05:35:16 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 4/4] mmc-utils: Start to use the generic print_usage function
Date: Mon, 28 Apr 2025 15:29:51 +0300
Message-Id: <20250428122951.317055-5-avri.altman@sandisk.com>
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

This patch replaces hardcoded usage messages in multiple functions with
calls to the generic `print_usage` function.

This refactoring simplifies the codebase by consolidating usage message
logic into a single reusable function, ensuring consistency across all
commands.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc_cmds.c | 139 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 59 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index d7e4bca..b2cc3d6 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -265,7 +265,7 @@ int do_writeprotect_boot_get(int nargs, char **argv)
 	char *device;
 
 	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc writeprotect boot get </path/to/mmcblkX>\n");
+		print_usage(do_writeprotect_boot_get);
 		exit(1);
 	}
 
@@ -307,11 +307,7 @@ int do_writeprotect_boot_set(int nargs, char **argv)
 #endif
 
 	if (nargs < 1 + argi ||  nargs > 2 + argi) {
-		fprintf(stderr, "Usage: mmc writeprotect boot set "
-#ifdef DANGEROUS_COMMANDS_ENABLED
-			"[-p] "
-#endif
-			"</path/to/mmcblkX> [0|1]\n");
+		print_usage(do_writeprotect_boot_set);
 		exit(1);
 	}
 
@@ -413,7 +409,7 @@ int do_writeprotect_user_get(int nargs, char **argv)
 	int remain;
 
 	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc writeprotect user get </path/to/mmcblkX>\n");
+		print_usage(do_writeprotect_user_get);
 		exit(1);
 	}
 
@@ -560,8 +556,7 @@ int do_writeprotect_user_set(int nargs, char **argv)
 	return ret;
 
 usage:
-	fprintf(stderr,
-		"Usage: mmc writeprotect user set <type><start block><blocks><device>\n");
+	print_usage(do_writeprotect_user_set);
 	exit(1);
 }
 
@@ -572,7 +567,7 @@ int do_disable_512B_emulation(int nargs, char **argv)
 	char *device;
 
 	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc disable 512B emulation </path/to/mmcblkX>\n");
+		print_usage(do_disable_512B_emulation);
 		exit(1);
 	}
 
@@ -623,7 +618,7 @@ int do_write_boot_en(int nargs, char **argv)
 	int boot_area, send_ack;
 
 	if (nargs != 4) {
-		fprintf(stderr, "Usage: mmc bootpart enable <partition_number> <send_ack> </path/to/mmcblkX>\n");
+		print_usage(do_write_boot_en);
 		exit(1);
 	}
 
@@ -694,7 +689,7 @@ int do_boot_bus_conditions_set(int nargs, char **argv)
 	char *device;
 
 	if (nargs != 5) {
-		fprintf(stderr, "Usage: mmc: bootbus set <boot_mode> <reset_boot_bus_conditions> <boot_bus_width> <device>\n");
+		print_usage(do_boot_bus_conditions_set);
 		exit(1);
 	}
 
@@ -762,11 +757,6 @@ static int do_hwreset(int value, int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc hwreset enable </path/to/mmcblkX>\n");
-		exit(1);
-	}
-
 	device = argv[1];
 
 	fd = open(device, O_RDWR);
@@ -810,11 +800,21 @@ static int do_hwreset(int value, int nargs, char **argv)
 
 int do_hwreset_en(int nargs, char **argv)
 {
+        if (nargs != 2) {
+		print_usage(do_hwreset_en);
+		exit(1);
+	}
+
 	return do_hwreset(EXT_CSD_HW_RESET_EN, nargs, argv);
 }
 
 int do_hwreset_dis(int nargs, char **argv)
 {
+        if (nargs != 2) {
+		print_usage(do_hwreset_dis);
+		exit(1);
+	}
+
 	return do_hwreset(EXT_CSD_HW_RESET_DIS, nargs, argv);
 }
 
@@ -826,7 +826,7 @@ int do_write_bkops_en(int nargs, char **argv)
 	char *en_type;
 
 	if (nargs != 3) {
-		fprintf(stderr, "Usage: mmc bkops_en <auto|manual> </path/to/mmcblkX>\n");
+		print_usage(do_write_bkops_en);
 		exit(1);
 	}
 
@@ -877,7 +877,7 @@ int do_status_get(int nargs, char **argv)
 	__u8 state;
 
 	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc status get </path/to/mmcblkX>\n");
+		print_usage(do_status_get);
 		exit(1);
 	}
 
@@ -1166,7 +1166,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	unsigned long align;
 
 	if (nargs != 7) {
-		fprintf(stderr, "Usage: mmc gp create <-y|-n|-c> <length KiB> <partition> <enh_attr> <ext_attr> </path/to/mmcblkX>\n");
+		print_usage(do_create_gp_partition);
 		exit(1);
 	}
 
@@ -1294,7 +1294,7 @@ int do_enh_area_set(int nargs, char **argv)
 	unsigned long align;
 
 	if (nargs != 5) {
-		fprintf(stderr, "Usage: mmc enh_area set <-y|-n|-c> <start KiB> <length KiB> </path/to/mmcblkX>\n");
+		print_usage(do_enh_area_set);
 		exit(1);
 	}
 
@@ -1441,7 +1441,7 @@ int do_write_reliability_set(int nargs, char **argv)
 	char *device;
 
 	if (nargs != 4) {
-		fprintf(stderr,"Usage: mmc write_reliability set <-y|-n|-c> <partition> </path/to/mmcblkX>\n");
+		print_usage(do_write_reliability_set);
 		exit(1);
 	}
 
@@ -1506,7 +1506,7 @@ int do_read_extcsd(int nargs, char **argv)
 	const char *str;
 
 	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc extcsd read </path/to/mmcblkX>\n");
+		print_usage(do_read_extcsd);
 		exit(1);
 	}
 
@@ -2017,7 +2017,7 @@ int do_write_extcsd(int nargs, char **argv)
 	char *device;
 
 	if (nargs != 4) {
-		fprintf(stderr, "Usage: mmc extcsd write <offset> <value> </path/to/mmcblkX>\n");
+		print_usage(do_write_extcsd);
 		exit(1);
 	}
 
@@ -2049,7 +2049,7 @@ int do_sanitize(int nargs, char **argv)
 	unsigned int timeout = 0;
 
 	if (nargs != 2 && nargs != 3) {
-		fprintf(stderr, "Usage: mmc sanitize </path/to/mmcblkX> [timeout_in_ms]\n");
+		print_usage(do_sanitize);
 		exit(1);
 	}
 
@@ -2279,7 +2279,7 @@ int do_rpmb_write_key(int nargs, char **argv)
 	}, frame_out = {};
 
 	if (nargs != 3) {
-		fprintf(stderr, "Usage: mmc rpmb write-key </path/to/mmcblkXrpmb> </path/to/key>\n");
+		print_usage(do_rpmb_write_key);
 		exit(1);
 	}
 
@@ -2342,7 +2342,7 @@ int do_rpmb_read_counter(int nargs, char **argv)
 	unsigned int cnt;
 
 	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc rpmb read-counter </path/to/mmcblkXrpmb>\n");
+		print_usage(do_rpmb_read_counter);
 		exit(1);
 	}
 
@@ -2382,7 +2382,7 @@ int do_rpmb_read_block(int nargs, char **argv)
 	}, *frame_out_p;
 
 	if (nargs != 5 && nargs != 6) {
-		fprintf(stderr, "Usage: mmc rpmb read-block </path/to/mmcblkXrpmb> <address> <blocks count> </path/to/output_file> [/path/to/key]\n");
+		print_usage(do_rpmb_read_block);
 		exit(1);
 	}
 
@@ -2530,7 +2530,7 @@ static bool secure_wp_supported(char *device)
 }
 
 static int rpmb_auth_write(int nargs, char **argv, uint16_t addr,
-			   uint8_t config_data, char *usage)
+			   uint8_t config_data)
 {
 	int ret, dev_fd;
 	unsigned int cnt;
@@ -2540,10 +2540,8 @@ static int rpmb_auth_write(int nargs, char **argv, uint16_t addr,
 		.addr	     = htobe16(addr),
 	}, frame_out = {};
 
-	if (nargs != 4) {
-		fprintf(stderr, "%s", usage);
-		return EXIT_FAILURE;
-	}
+	if (nargs != 4)
+		return -EINVAL;
 
 	if (!secure_wp_supported(argv[1])) {
 		fprintf(stderr, "secure wp not supported %s", argv[1]);
@@ -2590,7 +2588,7 @@ out:
 	return ret;
 }
 
-static int rpmb_auth_read(int nargs, char **argv, char *usage)
+static int rpmb_auth_read(int nargs, char **argv)
 {
 	int ret, dev_fd;
 	struct rpmb_frame frame_in = {
@@ -2598,10 +2596,8 @@ static int rpmb_auth_read(int nargs, char **argv, char *usage)
 	}, frame_out = {};
 	unsigned char key[32] = {};
 
-	if (nargs != 3 && nargs != 4) {
-		fprintf(stderr, "%s", usage);
-		return EXIT_FAILURE;
-	}
+	if (nargs != 3 && nargs != 4)
+                return -EINVAL;
 
 	if (!secure_wp_supported(argv[1])) {
 		fprintf(stderr, "secure wp not supported %s", argv[1]);
@@ -2667,37 +2663,57 @@ out:
 
 int do_rpmb_sec_wp_enable(int nargs, char **argv)
 {
-	char *usage = "Usage: mmc rpmb secure-wp-mode-on </path/to/mmcblkx> </path/to/mmcblkXrpmb> </path/to/key>\n";
+        int ret;
 
-	return rpmb_auth_write(nargs, argv, 1, 1, usage);
+	ret = rpmb_auth_write(nargs, argv, 1, 1);
+        if (ret == -EINVAL)
+                print_usage(do_rpmb_sec_wp_enable);
+
+        return ret;
 }
 
 int do_rpmb_sec_wp_disable(int nargs, char **argv)
 {
-	char *usage = "Usage: mmc rpmb secure-wp-mode-off </path/to/mmcblkx> </path/to/mmcblkXrpmb> </path/to/key>\n";
+        int ret;
+
+        ret = rpmb_auth_write(nargs, argv, 1, 0);
+        if (ret == -EINVAL)
+                print_usage(do_rpmb_sec_wp_disable);
 
-	return rpmb_auth_write(nargs, argv, 1, 0, usage);
+        return ret;
 }
 
 int do_rpmb_sec_wp_mode_set(int nargs, char **argv)
 {
-	char *usage = "Usage: mmc rpmb secure-wp-disable </path/to/mmcblkx> </path/to/mmcblkXrpmb> </path/to/key>\n";
+        int ret;
 
-	return rpmb_auth_write(nargs, argv, 2, 1, usage);
+        ret = rpmb_auth_write(nargs, argv, 2, 1);
+        if (ret == -EINVAL)
+                print_usage(do_rpmb_sec_wp_mode_set);
+
+        return ret;
 }
 
 int do_rpmb_sec_wp_mode_clear(int nargs, char **argv)
 {
-	char *usage = "Usage: mmc rpmb secure-wp-enable </path/to/mmcblkx> </path/to/mmcblkXrpmb> </path/to/key>\n";
+        int ret;
+
+        ret = rpmb_auth_write(nargs, argv, 2, 0);
+        if (ret == -EINVAL)
+                print_usage(do_rpmb_sec_wp_mode_clear);
 
-	return rpmb_auth_write(nargs, argv, 2, 0, usage);
+        return ret;
 }
 
 int do_rpmb_sec_wp_en_read(int nargs, char **argv)
 {
-	char *usage = "Usage: mmc rpmb secure-wp-enable-read <path/to/mmcblk0> </path/to/mmcblkXrpmb> [/path/to/key]\n";
+        int ret;
 
-	return rpmb_auth_read(nargs, argv, usage);
+        ret = rpmb_auth_read(nargs, argv);
+        if (ret == -EINVAL)
+                print_usage(do_rpmb_sec_wp_en_read);
+
+        return ret;
 }
 
 int do_rpmb_write_block(int nargs, char **argv)
@@ -2711,7 +2727,7 @@ int do_rpmb_write_block(int nargs, char **argv)
 	}, frame_out = {};
 
 	if (nargs != 5) {
-		fprintf(stderr, "Usage: mmc rpmb write-block </path/to/mmcblkXrpmb> <address> </path/to/input_file> </path/to/key>\n");
+		print_usage(do_rpmb_write_block);
 		exit(1);
 	}
 
@@ -2791,11 +2807,6 @@ static int do_cache_ctrl(int value, int nargs, char **argv)
 	int fd, ret;
 	char *device;
 
-	if (nargs != 2) {
-	       fprintf(stderr, "Usage: mmc cache enable </path/to/mmcblkX>\n");
-	       exit(1);
-	}
-
 	device = argv[1];
 
 	fd = open(device, O_RDWR);
@@ -2841,11 +2852,21 @@ static int do_cache_ctrl(int value, int nargs, char **argv)
 
 int do_cache_en(int nargs, char **argv)
 {
+        if (nargs != 2) {
+		print_usage(do_cache_en);
+		exit(1);
+	}
+
 	return do_cache_ctrl(1, nargs, argv);
 }
 
 int do_cache_dis(int nargs, char **argv)
 {
+        if (nargs != 2) {
+		print_usage(do_cache_dis);
+		exit(1);
+	}
+
 	return do_cache_ctrl(0, nargs, argv);
 }
 
@@ -2926,7 +2947,7 @@ int do_erase(int nargs, char **argv)
 	__u32 arg, start, end;
 
 	if (nargs != 5) {
-		fprintf(stderr, "Usage: erase <type> <start addr> <end addr> </path/to/mmcblkX>\n");
+		print_usage(do_erase);
 		exit(1);
 	}
 
@@ -3443,7 +3464,7 @@ int do_general_cmd_read(int nargs, char **argv)
 	struct mmc_ioc_cmd idata;
 
 	if (nargs != 2 && nargs != 3) {
-		fprintf(stderr, "Usage: gen_cmd read </path/to/mmcblkX> [arg]\n");
+		print_usage(do_general_cmd_read);
 		exit(1);
 	}
 
@@ -3515,7 +3536,7 @@ int do_softreset(int nargs, char **argv)
 	char *device;
 
 	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc softreset </path/to/mmcblkX>\n");
+		print_usage(do_softreset);
 		exit(1);
 	}
 
@@ -3530,7 +3551,7 @@ int do_preidle(int nargs, char **argv)
 	char *device;
 
 	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc preidle </path/to/mmcblkX>\n");
+		print_usage(do_preidle);
 		exit(1);
 	}
 
@@ -3550,7 +3571,7 @@ int do_alt_boot_op(int nargs, char **argv)
 	unsigned int boot_blocks, ext_csd_boot_size;
 
 	if (nargs != 3) {
-		fprintf(stderr, "Usage: mmc boot_op <boot_data_file> </path/to/mmcblkX>\n");
+		print_usage(do_alt_boot_op);
 		exit(1);
 	}
 	boot_data_file = argv[1];
-- 
2.25.1

