Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604AC226CFD
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014850; cv=none; b=iAMtMUZmVHf9pdBzMsCVTYBfiUVZVxMBlO5gCJG+fdEDW8n06Ovh+tJ32ZNcRvjTnYVBaZknuX02O0R7SFTwBfTxbKzLvCYJ+jv9VrFKnUQXQwwk9clo+gssAxcWLtpb8A0Pfg+Q3BtXX/8ekjpJr1ZVZ36+V4nO+wJNtMwy9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014850; c=relaxed/simple;
	bh=SkSGNZBN8/s/RsEhKOOX5r3R5uQSocC8lg6KmEVh63M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7Y5ihtMDAWb6cNtOXEtsnms6fiZHW8f83RvYlfbUPV3PrpjLh+HTl8v+JzIhwMTAk1blqPx8PdR7DGF/ZvgK4j9XkIFBwxM4o6tjBAD48n597OjQG0E0aYehdgvtnwDcdYfrqekpvL5yxZuBubZzPdvp7eRnP6ZziBh0vIymjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=XNqfkXX4; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="XNqfkXX4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014848; x=1775550848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SkSGNZBN8/s/RsEhKOOX5r3R5uQSocC8lg6KmEVh63M=;
  b=XNqfkXX4lRha3i83JG0CX6XUhYApBx8lh3lJbmvoN33QyJKsZfxt9P0j
   a8GZIDxuG9QhkMQGfLproM00Qdl1EI6OPC8PVCB56uswxbzqPIcu5KFVD
   Xj7KYCy208h6CKrpr4DtyM5p2vhNCzeVhgu/dlyLY9Ho0bZ6X/1SXcVgl
   w5iDK7V+DAj8Y37mhEy5Fh0HTDYa1oSwg76aMdhzd7JezPc4zuc7DFb30
   9R4yigyfhDvP+NyA1soy1bvDAQV9fxkOMnfRqwtIuR0LdfHnNyTjhCRw1
   xVnPzgTlciR0N73zCqodbhnSN88aDf/SYlqAfekkAYgl3h44pRns8Axls
   w==;
X-CSE-ConnectionGUID: RGgGTPLXRPWPNI6FXqtyMA==
X-CSE-MsgGUID: Tw3w9kgIS66/TZUaHrPY+g==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="72607786"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:34:07 +0800
IronPort-SDR: 67f38000_jWG8blXQCcpiTAjMk9jGhRloDBMJ1qikYZ0jYmX2hstxcBO
 DeFN4gNRya5imZO9fONzqgaTAYN6493MNtjdDOA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:34:25 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:34:06 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 09/10] mmc-utils: Secure Write Protect Mode Read
Date: Mon,  7 Apr 2025 11:28:32 +0300
Message-Id: <20250407082833.108616-10-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407082833.108616-1-avri.altman@sandisk.com>
References: <20250407082833.108616-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avri Altman <avri.altman@wdc.com>

Reads the status of the secure write protect mode.  Specifically, it
returns the values of SECURE_WP_MODE_ENABLE and SECURE_WP_MODE_CONFIG
registers.  Those registers are available via rpmb Authenticated Device
Configuration Read request.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.c      | 11 +++++++
 mmc_cmds.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 3 files changed, 96 insertions(+)

diff --git a/mmc.c b/mmc.c
index 578b00c..36cfe90 100644
--- a/mmc.c
+++ b/mmc.c
@@ -240,6 +240,17 @@ static struct Command commands[] = {
 		  "    mmc rpmb secure-wp-enable /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
 	  NULL
 	},
+	{ do_rpmb_sec_wp_en_read, -2,
+	  "rpmb secure-wp-en-read", "<device> <rpmb device> [key file]\n"
+		  "Reads the status of the SECURE_WP_EN & SECURE_WP_MASK fields.\n"
+		  "You can specify '-' instead of key\n"
+		  "Example:\n"
+		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
+		  "    mmc rpmb secure-wp-en-read /dev/mmcblk0 /dev/mmcblk0rpmb -\n"
+		  "or read without verification\n"
+		  "  $ mmc rpmb secure-wp-en-read /dev/mmcblk0 /dev/mmcblk0rpmb",
+	  NULL
+	},
 	{ do_cache_en, -1,
 	  "cache enable", "<device>\n"
 		"Enable the eMMC cache feature on <device>.\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 2ef4252..d7e4bca 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2100,6 +2100,7 @@ enum rpmb_op_type {
 	MMC_RPMB_WRITE     = 0x03,
 	MMC_RPMB_READ      = 0x04,
 	MMC_RPMB_CONF_WRITE = 0x06,
+	MMC_RPMB_CONF_READ = 0x07,
 
 	/* For internal usage only, do not use it directly */
 	MMC_RPMB_READ_RESP = 0x05
@@ -2237,6 +2238,7 @@ static int do_rpmb_op(int fd, const struct rpmb_frame *frame_in,
 
 		break;
 	case MMC_RPMB_READ_CNT:
+	case MMC_RPMB_CONF_READ:
 		if (out_cnt != 1) {
 			err = -EINVAL;
 			goto out;
@@ -2588,6 +2590,81 @@ out:
 	return ret;
 }
 
+static int rpmb_auth_read(int nargs, char **argv, char *usage)
+{
+	int ret, dev_fd;
+	struct rpmb_frame frame_in = {
+		.req_resp    = htobe16(MMC_RPMB_CONF_READ),
+	}, frame_out = {};
+	unsigned char key[32] = {};
+
+	if (nargs != 3 && nargs != 4) {
+		fprintf(stderr, "%s", usage);
+		return EXIT_FAILURE;
+	}
+
+	if (!secure_wp_supported(argv[1])) {
+		fprintf(stderr, "secure wp not supported %s", argv[1]);
+		return EXIT_FAILURE;
+	}
+
+	dev_fd = open(argv[2], O_RDWR);
+	if (dev_fd < 0) {
+		perror("device open");
+		return EXIT_FAILURE;
+	}
+
+	if (nargs == 4) {
+		ret = rpmb_get_key(argv[3], &frame_in, key, false);
+		if (ret) {
+			printf("failed to read and apply key %d\n", ret);
+			goto out;
+		}
+	}
+
+	/* Execute RPMB op */
+	ret = do_rpmb_op(dev_fd, &frame_in, &frame_out, 1);
+	if (ret != 0) {
+		perror("RPMB ioctl failed");
+		goto out;
+	}
+
+	/* Check RPMB response */
+	if (frame_out.result != 0) {
+		printf("RPMB operation failed, retcode 0x%04x\n", be16toh(frame_out.result));
+		goto out;
+	}
+
+	close(dev_fd);
+
+	/* verify data against key */
+	if (nargs == 4) {
+		unsigned char mac[32] = {};
+		hmac_sha256_ctx ctx;
+
+		hmac_sha256_init(&ctx, key, sizeof(key));
+		hmac_sha256_update(&ctx, frame_out.data,
+				   sizeof(frame_out) - offsetof(struct rpmb_frame, data));
+
+		hmac_sha256_final(&ctx, mac, sizeof(mac));
+
+		/* Compare calculated MAC and MAC from last frame */
+		if (memcmp(mac, frame_out.key_mac, sizeof(mac))) {
+			printf("RPMB MAC mismatch\n");
+			return EXIT_FAILURE;
+		}
+	}
+
+	printf("SECURE_WP_MODE_ENABLE: 0x%02x]\n", frame_out.data[255]);
+	printf("SECURE_WP_MODE_CONFIG: 0x%02x]\n", frame_out.data[254]);
+
+	return 0;
+
+out:
+	close(dev_fd);
+	return ret;
+}
+
 int do_rpmb_sec_wp_enable(int nargs, char **argv)
 {
 	char *usage = "Usage: mmc rpmb secure-wp-mode-on </path/to/mmcblkx> </path/to/mmcblkXrpmb> </path/to/key>\n";
@@ -2616,6 +2693,13 @@ int do_rpmb_sec_wp_mode_clear(int nargs, char **argv)
 	return rpmb_auth_write(nargs, argv, 2, 0, usage);
 }
 
+int do_rpmb_sec_wp_en_read(int nargs, char **argv)
+{
+	char *usage = "Usage: mmc rpmb secure-wp-enable-read <path/to/mmcblk0> </path/to/mmcblkXrpmb> [/path/to/key]\n";
+
+	return rpmb_auth_read(nargs, argv, usage);
+}
+
 int do_rpmb_write_block(int nargs, char **argv)
 {
 	int ret, dev_fd, data_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 61fe337..d83fb57 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -43,6 +43,7 @@ int do_rpmb_sec_wp_enable(int nargs, char **argv);
 int do_rpmb_sec_wp_disable(int nargs, char **argv);
 int do_rpmb_sec_wp_mode_set(int nargs, char **argv);
 int do_rpmb_sec_wp_mode_clear(int nargs, char **argv);
+int do_rpmb_sec_wp_en_read(int nargs, char **argv);
 int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
-- 
2.25.1

