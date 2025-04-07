Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B860225A40
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014837; cv=none; b=MQ/fnl4rJlF0mAqe8x5x1feXZJzFJ0ghGejoYaiUic3FnlQ97jlyLpr/3d22cUKDxXgvRPCfA86Ph5w1YKCneNL4pxtoTdkB6Ym7zVYtZCNaDpy1L8YvNdwJnpB7sj1++Zb350HoBLNH90FFySpacp8Z9e5+4FR3YEpGz1Xzbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014837; c=relaxed/simple;
	bh=95zApcFzFaRBnwRLdAR5oF/u82+rEBIE9KjTUiDjfu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQhNrRALtMPTn43Z4UW+GJGk0QeiPs44qtZRD+etMWbPpKWMjFVH0o8IQj9yt0aEM+vQ9T44b7jqt+5FQtgg7x5biGIR0Ma/sXbDghtz+0mgJRaLYEWz/x4QyE7kJuWwfOfFiYGEOuSiAIgjHepJ6meXeEBOi9ai7ASgpRjdzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=gV5+ZFpU; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="gV5+ZFpU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014834; x=1775550834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=95zApcFzFaRBnwRLdAR5oF/u82+rEBIE9KjTUiDjfu0=;
  b=gV5+ZFpUJ/fvNwdqhqIjpVjuHTr+pOs/U0QRdSJs1Ax0o5GFVMhP8PmA
   ECtEwvZONp0AJ8uM3QDlyPLsZG3a9/56N7pmH4wDAKLGaLX6HAS4dgB6C
   vdD7fyds2cVraGF/5KlhuUqasgPjtPI1ZSpEGGeZltRTQMRIHHbfZXyFc
   zVDqPM9JyZeUkvwq1LGYydU6R7PmpQtsK+MW7ZCrTXH0R7gdADRF69is7
   +N0yoJiq43X7Eu3uTVnm5J91o4xqvuL+C0PNRjlo/MXvh4c0i24qkppKQ
   rKrDoTjlJSgBTnhIvaXvGYxr/NFyg0ioFhcDGbhYbOerxmXJLBPV8gpyq
   g==;
X-CSE-ConnectionGUID: rZd60U65SP+Leo3Kw4Hsnw==
X-CSE-MsgGUID: NjBB3oZsS4i+B1517nPS6Q==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="72607406"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:33:51 +0800
IronPort-SDR: 67f37fef_rR9bk2k8eMoF60AARgUakkurtHBVeMP6rQ3x1MY8ZbH+Ip6
 2Hensi4HRgeih2VK/xPAZ/7bFIrNx9hEbFrl1aw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:34:08 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:33:50 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 07/10] mmc-utils: Add secure write-protect mode enable/disable
Date: Mon,  7 Apr 2025 11:28:30 +0300
Message-Id: <20250407082833.108616-8-avri.altman@sandisk.com>
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

Allow toggling the SECURE_WP_EN field in the SECURE_WP_MODE_ENABLE part
of Device Configuration area.  Access to the Device Configuration area
is regulated via Authenticated Device Configuration write request.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.c      |  23 ++++++++++++
 mmc_cmds.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   2 ++
 3 files changed, 129 insertions(+)

diff --git a/mmc.c b/mmc.c
index b73dd24..0cffa5b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -197,6 +197,29 @@ static struct Command commands[] = {
 		  "    mmc rpmb write-block /dev/mmcblk0rpmb 0x02 - -",
 	  NULL
 	},
+	{ do_rpmb_sec_wp_enable, 3,
+	  "rpmb secure-wp-mode-on", "<dev> <rpmb device> <key file>\n"
+		  "Enable Secure Write Protection mode.\n"
+		  "The access to the write protection related EXT_CSD and\n"
+		  "CSD fields depends on the value of SECURE_WP_MASK bit in\n"
+		  "SECURE_WP_MODE_CONFIG field\n"
+		  "You can specify '-' instead of key\n"
+		  "Example:\n"
+		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
+		  "    mmc rpmb secure-wp-mode-on /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
+	  NULL
+	},
+	{ do_rpmb_sec_wp_disable, 3,
+	  "rpmb secure-wp-mode-off", "<dev> <rpmb device> <key file>\n"
+		  "Legacy Write Protection mode.\n"
+		  "TMP_WRITE_PROTECT[12] and PERM_WRITE_PROTECT[13] is updated by CMD27.\n"
+		  "USER_WP[171], BOOT_WP[173] and BOOT_WP_STATUS[174] are updated by CMD6\n"
+		  "You can specify '-' instead of key\n"
+		  "Example:\n"
+		  "    echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | \\\n"
+		  "    mmc rpmb secure-wp-mode-off /dev/block/mmcblk0 /dev/mmcblk0rpmb -",
+	  NULL
+	},
 	{ do_cache_en, -1,
 	  "cache enable", "<device>\n"
 		"Enable the eMMC cache feature on <device>.\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 80ac6ab..07bd9ad 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2099,6 +2099,7 @@ enum rpmb_op_type {
 	MMC_RPMB_READ_CNT  = 0x02,
 	MMC_RPMB_WRITE     = 0x03,
 	MMC_RPMB_READ      = 0x04,
+	MMC_RPMB_CONF_WRITE = 0x06,
 
 	/* For internal usage only, do not use it directly */
 	MMC_RPMB_READ_RESP = 0x05
@@ -2210,6 +2211,7 @@ static int do_rpmb_op(int fd, const struct rpmb_frame *frame_in,
 	switch(rpmb_type) {
 	case MMC_RPMB_WRITE:
 	case MMC_RPMB_WRITE_KEY:
+	case MMC_RPMB_CONF_WRITE:
 		if (out_cnt != 1) {
 			err = -EINVAL;
 			goto out;
@@ -2498,6 +2500,108 @@ int do_rpmb_read_block(int nargs, char **argv)
 	return ret;
 }
 
+static bool secure_wp_supported(char *device)
+{
+	__u8 ext_csd[512];
+	int fd;
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		return false;
+	}
+
+	if (read_extcsd(fd, ext_csd)) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		close(fd);
+		return false;
+	}
+
+	close(fd);
+
+	if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
+		fprintf(stderr, "SECURE_WP_SUPPORT option is only available on devices >= MMC 5.0 %s\n", device);
+		return false;
+	}
+
+	return !!(ext_csd[EXT_CSD_SECURE_WP_INFO] & 1);
+}
+
+static int rpmb_auth_write(int nargs, char **argv, uint16_t addr,
+			   uint8_t config_data, char *usage)
+{
+	int ret, dev_fd;
+	unsigned int cnt;
+	struct rpmb_frame frame_in = {
+		.req_resp    = htobe16(MMC_RPMB_CONF_WRITE),
+		.block_count = htobe16(1),
+		.addr	     = htobe16(addr),
+	}, frame_out = {};
+
+	if (nargs != 4) {
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
+	ret = rpmb_read_counter(dev_fd, &cnt);
+	/* Check RPMB response */
+	if (ret != 0) {
+		printf("RPMB read counter operation failed, retcode 0x%04x\n", ret);
+		goto out;
+	}
+	frame_in.write_counter = htobe32(cnt);
+
+	frame_in.data[255] = config_data; /* Byte 28 */
+
+	ret = rpmb_get_key(argv[3], &frame_in, NULL, true);
+	if (ret) {
+		printf("failed to read and apply key %d\n", ret);
+		goto out;
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
+		printf("RPMB operation failed, retcode 0x%04x\n",
+		       be16toh(frame_out.result));
+	}
+
+out:
+	close(dev_fd);
+	return ret;
+}
+
+int do_rpmb_sec_wp_enable(int nargs, char **argv)
+{
+	char *usage = "Usage: mmc rpmb secure-wp-mode-on </path/to/mmcblkx> </path/to/mmcblkXrpmb> </path/to/key>\n";
+
+	return rpmb_auth_write(nargs, argv, 1, 1, usage);
+}
+
+int do_rpmb_sec_wp_disable(int nargs, char **argv)
+{
+	char *usage = "Usage: mmc rpmb secure-wp-mode-off </path/to/mmcblkx> </path/to/mmcblkXrpmb> </path/to/key>\n";
+
+	return rpmb_auth_write(nargs, argv, 1, 0, usage);
+}
+
 int do_rpmb_write_block(int nargs, char **argv)
 {
 	int ret, dev_fd, data_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 407cbe6..873d9b2 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -39,6 +39,8 @@ int do_rpmb_write_key(int nargs, char **argv);
 int do_rpmb_read_counter(int nargs, char **argv);
 int do_rpmb_read_block(int nargs, char **argv);
 int do_rpmb_write_block(int nargs, char **argv);
+int do_rpmb_sec_wp_enable(int nargs, char **argv);
+int do_rpmb_sec_wp_disable(int nargs, char **argv);
 int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
-- 
2.25.1

