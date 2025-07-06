Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BB1EB195
	for <linux-mmc@vger.kernel.org>; Sun,  6 Jul 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751803621; cv=none; b=qObIMddF2oQN9upP+oYAbvHQRynXxnMIBFVvv1BloRaV3nyYVMU2dLotoABEC0PuapQY9JZhY/qpQwQN2tUErXO8wFt5NfbiZMKfX4Kvz+Tp+vlwT6BLMT3QEXj/s+qYvfVIF9td31sNlQwm+AWLZxdvinGjNKY9uc7c0dlgMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751803621; c=relaxed/simple;
	bh=3OCoDoiwL2oafY3OhIw+K7jX+I9Q4OC5UvDld5EcFX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDBwy8qdDbBYXWFSJQACdzdpVo2qDudfSUfrUb94I4kbi9vwPafAm0fZuUMwWQ7uBEGYkGYxZqDLvcQopU7w5DWu32J5/aYZeoBs5fx1+JSWPemRZu7H5SDtQJlazTPqC6su63bpVprvfi8RUxb5z7B9SHf4bFy7ayODyDp7N44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=jL14QZ47; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="jL14QZ47"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1751803619; x=1783339619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3OCoDoiwL2oafY3OhIw+K7jX+I9Q4OC5UvDld5EcFX8=;
  b=jL14QZ47R3QVlBwt8Ul2j/lTuSN/R3LCid72E1wDQmkgkXZ6mdP5snVQ
   LRrAJtBbfOFJN4unS+iLM04up3szlZpGPJyeDUJ9EKIQ9kxefpw1+UjIb
   QTIBAcl17raB1OSiv6HVKUZPjtEfNnD6pNDW9J8V2u7dRZ4LYvaoq8FIK
   GX16ZGf2x/ol81Mcq3gaBlGCf+KidlxEpuNE0gnyrG1BEOTheH2PqkE2D
   O7Ipit+LdxYw/vEnIm640h6S9qH5hW3CEN+trxAhRuVfuKlct4r6gf/2y
   VK6gzfvTUqg68qe7HhIJfOMHIXmwtVfKqczBxKeKPjWEC5hRnu0MnshcK
   w==;
X-CSE-ConnectionGUID: RKVOANtyTu2fGdSR/QTJ4w==
X-CSE-MsgGUID: i68gk0W2TnyFflnF276RYQ==
X-IronPort-AV: E=Sophos;i="6.16,291,1744041600"; 
   d="scan'208";a="90783634"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2025 20:06:53 +0800
IronPort-SDR: 686a584b_40Md4A03morKnrbGHLKWOZSs+C8t/VZNPGxbEl0+XTc+fKe
 reiATvhRQeAL9BFtdqse5L0MTEoEQsBaEYqe+zg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2025 04:04:44 -0700
WDCIronportException: Internal
Received: from unknown (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.49])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2025 05:06:52 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH] mmc-utils: Use designated initializers for struct zeroing
Date: Sun,  6 Jul 2025 15:06:37 +0300
Message-Id: <20250706120637.59267-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace memset-based struct zero-initialization with C99 designated
initializers for improved clarity and safety.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc_cmds.c | 50 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 7994223..c781aba 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -77,8 +77,8 @@ static inline __u32 per_byte_htole32(__u8 *arr)
 static int read_extcsd(int fd, __u8 *ext_csd)
 {
 	int ret = 0;
-	struct mmc_ioc_cmd idata;
-	memset(&idata, 0, sizeof(idata));
+	struct mmc_ioc_cmd idata = {};
+
 	memset(ext_csd, 0, sizeof(__u8) * 512);
 	idata.write_flag = 0;
 	idata.opcode = MMC_SEND_EXT_CSD;
@@ -125,9 +125,8 @@ write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_ms)
 static int send_status(int fd, __u32 *response)
 {
 	int ret = 0;
-	struct mmc_ioc_cmd idata;
+	struct mmc_ioc_cmd idata = {};
 
-	memset(&idata, 0, sizeof(idata));
 	idata.opcode = MMC_SEND_STATUS;
 	idata.arg = (1 << 16);
 	idata.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -159,9 +158,8 @@ static __u32 get_size_in_blks(int fd)
 static int set_write_protect(int fd, __u32 blk_addr, int on_off)
 {
 	int ret = 0;
-	struct mmc_ioc_cmd idata;
+	struct mmc_ioc_cmd idata = {};
 
-	memset(&idata, 0, sizeof(idata));
 	idata.write_flag = 1;
 	if (on_off)
 		idata.opcode = MMC_SET_WRITE_PROT;
@@ -180,12 +178,11 @@ static int set_write_protect(int fd, __u32 blk_addr, int on_off)
 static int send_write_protect_type(int fd, __u32 blk_addr, __u64 *group_bits)
 {
 	int ret = 0;
-	struct mmc_ioc_cmd idata;
+	struct mmc_ioc_cmd idata = {};
 	__u8 buf[8];
 	__u64 bits = 0;
 	int x;
 
-	memset(&idata, 0, sizeof(idata));
 	idata.write_flag = 0;
 	idata.opcode = MMC_SEND_WRITE_PROT_TYPE;
 	idata.blksz      = 8,
@@ -2192,9 +2189,7 @@ static int do_rpmb_op(int fd, const struct rpmb_frame *frame_in,
 	u_int16_t rpmb_type;
 	struct mmc_ioc_multi_cmd *mioc;
 	struct mmc_ioc_cmd *ioc;
-	struct rpmb_frame frame_status;
-
-	memset(&frame_status, 0, sizeof(frame_status));
+	struct rpmb_frame frame_status = {};
 
 	if (!frame_in || !frame_out || !out_cnt)
 		return -EINVAL;
@@ -3121,9 +3116,7 @@ static bool ffu_is_supported(__u8 *ext_csd, char *device)
 static int enter_ffu_mode(int dev_fd)
 {
 	int ret;
-	struct mmc_ioc_cmd cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
+	struct mmc_ioc_cmd cmd = {};
 
 	fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
 	ret = ioctl(dev_fd, MMC_IOC_CMD, &cmd);
@@ -3136,9 +3129,7 @@ static int enter_ffu_mode(int dev_fd)
 static int exit_ffu_mode(int dev_fd)
 {
 	int ret;
-	struct mmc_ioc_cmd cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
+	struct mmc_ioc_cmd cmd = {};
 
 	fill_switch_cmd(&cmd, EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
 	ret = ioctl(dev_fd, MMC_IOC_CMD, &cmd);
@@ -3461,7 +3452,13 @@ int do_general_cmd_read(int nargs, char **argv)
 	__u8 buf[512];
 	__u32 arg = 0x01;
 	int ret = -EINVAL, i;
-	struct mmc_ioc_cmd idata;
+	struct mmc_ioc_cmd idata = {
+		.write_flag = 0,
+		.opcode = MMC_GEN_CMD,
+		.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC,
+		.blksz = 512,
+		.blocks = 1
+	};
 
 	if (nargs != 2 && nargs != 3) {
 		print_usage(do_general_cmd_read);
@@ -3484,13 +3481,7 @@ int do_general_cmd_read(int nargs, char **argv)
 		}
 	}
 
-	memset(&idata, 0, sizeof(idata));
-	idata.write_flag = 0;
-	idata.opcode = MMC_GEN_CMD;
 	idata.arg = arg;
-	idata.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
-	idata.blksz = 512;
-	idata.blocks = 1;
 	mmc_ioc_cmd_set_data(idata, buf);
 
 	ret = ioctl(dev_fd, MMC_IOC_CMD, &idata);
@@ -3512,7 +3503,11 @@ out:
 
 static void issue_cmd0(char *device, __u32 arg)
 {
-	struct mmc_ioc_cmd idata;
+	struct mmc_ioc_cmd idata = {
+		.opcode = MMC_GO_IDLE_STATE,
+		.flags = MMC_RSP_NONE | MMC_CMD_BC,
+		.arg = arg,
+	};
 	int fd;
 
 	fd = open(device, O_RDWR);
@@ -3521,11 +3516,6 @@ static void issue_cmd0(char *device, __u32 arg)
 		exit(1);
 	}
 
-	memset(&idata, 0, sizeof(idata));
-	idata.opcode = MMC_GO_IDLE_STATE;
-	idata.arg = arg;
-	idata.flags = MMC_RSP_NONE | MMC_CMD_BC;
-
 	/* No need to check for error, it is expected */
 	ioctl(fd, MMC_IOC_CMD, &idata);
 	close(fd);
-- 
2.34.1

