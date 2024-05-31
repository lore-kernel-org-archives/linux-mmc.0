Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AD61E498
	for <linux-mmc@vger.kernel.org>; Fri, 31 May 2024 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180410; cv=none; b=VujOQBQC3cJqB+bqxXd1qviMKSsaIAOCaMtUBVU8OcIuXSg4DTv6dcXIhymrFH7uTR4zd3Y3zvKm7PaSU5s3pnDpAaHUWUI0HNwPgPyCaQ4hwFbkf1rrxsd3ErLPysBrPU8oPzA9YPdylQhmq776w3i+EevVsxe3XWzhCOeYCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180410; c=relaxed/simple;
	bh=Ua2epOBJdfvMZRj4QucRXwfjwR0i5bSwnn/VWtR25I8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FF4FgCnEWltiHZfEcr45gbUicPvOFF/3wD6e/JiHoyKcws1IT4QP85kFquz7sqcCrTDhTjeBGlv2j8VR1m29IQ3B1LlIfBlz9scI8Bzqak2CD7mtUOZMHVXgNrBAQfuDtggU+Saxn9EJ/k8jcaQ0yQwAiURBV6Q/L+nIkjWDn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from silverhorse.byt.danman.eu (unknown [62.197.239.54])
	by speedy.danman.eu (Postfix) with ESMTPSA id F1861240DA3;
	Fri, 31 May 2024 20:25:21 +0200 (CEST)
From: linux-mmc@danman.eu
To: Avri.Altman@wdc.com,
	linux-mmc@vger.kernel.org
Cc: Daniel Kucera <linux-mmc@danman.eu>
Subject: [PATCH v2] mmc-utils: implemented CMD42 locking/unlocking
Date: Fri, 31 May 2024 20:25:17 +0200
Message-Id: <20240531182517.929498-1-linux-mmc@danman.eu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Kucera <linux-mmc@danman.eu>

Implemented locking/unlocking using CMD42 according to Micron
Technical Note

original link https://media-www.micron.com/-/media/client/global/documents/products/technical-note/sd-cards/tnsd01_enable_sd_lock_unlock_in_linux.pdf?rev=03f03a6bc0f8435fafa93a8fc8e88988
currently available at https://github.com/danielkucera/esp32-sdcard/blob/master/tnsd01_enable_sd_lock_unlock_in_linux.pdf

Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
---
 mmc.c      |  12 ++++
 mmc.h      |  10 +++
 mmc_cmds.c | 189 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   1 +
 4 files changed, 212 insertions(+)

diff --git a/mmc.c b/mmc.c
index bc8f74e..38e3e72 100644
--- a/mmc.c
+++ b/mmc.c
@@ -250,6 +250,18 @@ static struct Command commands[] = {
 		"be 1.",
 	NULL
 	},
+	{ do_lock_unlock, -3,
+	"cmd42", "<parameter> " "<device> " "[password] " "[new_password]\n"
+		"Usage: mmc cmd42 <s|c|l|u|e> <device> [password] [new_password]\n"
+		"<password> can be up to 16 character plaintext or hex string starting with 0x\n"
+		"s\tset password\n"
+		"c\tclear password\n"
+		"l\tlock\n"
+		"sl\tset password and lock\n"
+		"u\tunlock\n"
+		"e\tforce erase\n",
+	NULL
+	},
 	{ do_softreset, -1,
 	  "softreset", "<device>\n"
 	  "Issues a CMD0 softreset, e.g. for testing if hardware reset for UHS works",
diff --git a/mmc.h b/mmc.h
index 6f1bf3e..ddbb06c 100644
--- a/mmc.h
+++ b/mmc.h
@@ -30,6 +30,7 @@
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
 #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
+#define MMC_SET_BLOCKLEN	16  /* ac [31:0] block len R1 */
 #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
 #define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
 #define MMC_WRITE_BLOCK		24	/* adtc [31:0] data addr	R1  */
@@ -46,6 +47,7 @@
 					      [1] Discard Enable
 					      [0] Identify Write Blocks for
 					      Erase (or TRIM Enable)  R1b */
+#define MMC_LOCK_UNLOCK		42  /* adtc R1b */
 #define MMC_GEN_CMD		56   /* adtc  [31:1] stuff bits.
 					      [0]: RD/WR1 R1 */
 
@@ -70,6 +72,14 @@
 #define R1_EXCEPTION_EVENT      (1 << 6)        /* sr, a */
 #define R1_APP_CMD              (1 << 5)        /* sr, c */
 
+#define MMC_CMD42_UNLOCK	0x0 /* UNLOCK */
+#define MMC_CMD42_SET_PWD	0x1 /* SET_PWD */
+#define MMC_CMD42_CLR_PWD	0x2 /* CLR_PWD */
+#define MMC_CMD42_LOCK		0x4 /* LOCK */
+#define MMC_CMD42_ERASE		0x8 /* ERASE */
+#define MAX_PWD_LENGTH		32 /* max PWDS_LEN: old+new */
+#define MMC_BLOCK_SIZE		512 /* data blk size for cmd42 */
+
 /*
  * EXT_CSD fields
  */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 936e0c5..dbbaf8d 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -3245,3 +3245,192 @@ dev_fd_close:
 		exit(1);
 	return 0;
 }
+
+static int hex_to_bytes(char *input, char *output, int len)
+{
+	int ilen = strlen(input);
+
+	if (ilen % 2) {
+		printf("Error: hex string has odd number of characters\n");
+		exit(1);
+	}
+
+	if (ilen / 2 > len) {
+		printf("Error: hex string is too long\n");
+		exit(1);
+	}
+
+	for (int i = 0; i < (ilen / 2); i++) {
+		if (sscanf(input + 2 * i, "%2hhx", &output[i]) != 1) {
+			printf("Error: failed to parse hex string\n");
+			exit(1);
+		}
+	}
+
+	return ilen/2;
+}
+
+static int parse_password(char *pass, char *buf)
+{
+	int pwd_len;
+
+	if (!strncmp("0x", pass, 2)) {
+		pwd_len = hex_to_bytes(pass+2, buf, MAX_PWD_LENGTH);
+	} else {
+		pwd_len = strlen(pass);
+		strncpy(buf, pass, MAX_PWD_LENGTH);
+	}
+
+	if (pwd_len > MAX_PWD_LENGTH) {
+		printf("Password too long.\n");
+		exit(1);
+	}
+
+	return pwd_len;
+}
+
+int do_lock_unlock(int nargs, char **argv)
+{
+	int fd, ret = 0;
+	char *device;
+	__u8 data_block[MMC_BLOCK_SIZE] = {};
+	__u8 data_block_onebyte[1] = {0};
+	int block_size = 0;
+	struct mmc_ioc_multi_cmd *mioc;
+	struct mmc_ioc_cmd *idata;
+	int cmd42_para;
+	char pwd[MAX_PWD_LENGTH*2+1];
+	int pwd_len = 0, new_pwd_len;
+	int min_args, max_args;
+	__u32 r1_response;
+
+	min_args = 4;
+	max_args = 4;
+
+	printf("Function: ");
+	if (!strcmp("s", argv[1])) {
+		cmd42_para = MMC_CMD42_SET_PWD;
+		printf("Set password\n");
+		max_args = 5;
+	} else if (!strcmp("c", argv[1])) {
+		cmd42_para = MMC_CMD42_CLR_PWD;
+		printf("Clear password\n");
+	} else if (!strcmp("l", argv[1])) {
+		cmd42_para = MMC_CMD42_LOCK;
+		printf("Lock the card\n");
+	} else if (!strcmp("sl", argv[1])) {
+		cmd42_para = MMC_CMD42_SET_PWD | MMC_CMD42_LOCK;
+		printf("Set password and lock the card\n");
+		max_args = 5;
+	} else if (!strcmp("u", argv[1])) {
+		cmd42_para = MMC_CMD42_UNLOCK;
+		printf("Unlock the card\n");
+	} else if (!strcmp("e", argv[1])) {
+#ifdef DANGEROUS_COMMANDS_ENABLED
+		cmd42_para = MMC_CMD42_ERASE;
+		printf("Force erase (Warning: all card data will be erased together with PWD!)\n");
+		min_args = 3;
+		max_args = 3;
+#else
+		printf("Erase is disabled unless compiled with DANGEROUS_COMMANDS_ENABLED\n");
+		exit(1);
+#endif
+	} else {
+		printf("Invalid parameter:\n" "s\tset password\n"
+			"c\tclear password\n" "l\tlock\n"
+			"sl\tset password and lock\n" "u\tunlock\n"
+			"e\tforce erase\n");
+		exit(1);
+	}
+
+	if ((nargs < min_args) || (nargs > max_args)) {
+		fprintf(stderr, "Usage: mmc cmd42 <s|c|l|u|e> <device> [password] [new_password]\n");
+		exit(1);
+	}
+
+	if (nargs > 3) {
+		pwd_len = parse_password(argv[3], pwd);
+		printf("Using password '%s', length %d\n", argv[3], pwd_len);
+	}
+
+	if (nargs == 5) {
+		new_pwd_len = parse_password(argv[4], pwd+pwd_len);
+		printf("New password '%s', length %d\n", argv[4], new_pwd_len);
+
+		pwd_len += new_pwd_len;
+	}
+
+	device = argv[2];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	if (cmd42_para == MMC_CMD42_ERASE)
+		block_size = 2;
+	else
+		block_size = MMC_BLOCK_SIZE;
+
+	printf("Set data block length = %d byte(s).\n", block_size);
+
+	mioc = (struct mmc_ioc_multi_cmd *)
+		calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
+			2 * sizeof(struct mmc_ioc_cmd));
+	if (!mioc)
+		return -ENOMEM;
+
+	mioc->num_of_cmds = 2;
+
+	idata = &mioc->cmds[0];
+	set_single_cmd(idata, MMC_SET_BLOCKLEN, 0, 0, block_size);
+
+	if (cmd42_para == MMC_CMD42_ERASE) {
+		data_block_onebyte[0] = cmd42_para;
+	} else {
+		data_block[0] = cmd42_para;
+		data_block[1] = pwd_len;
+		memcpy((char *)(data_block+2), pwd, pwd_len);
+	}
+
+	idata = &mioc->cmds[1];
+
+	idata->write_flag = 1;
+	idata->opcode = MMC_LOCK_UNLOCK;
+	idata->arg = 0;
+	idata->flags = MMC_RSP_R1 | MMC_CMD_AC | MMC_CMD_ADTC;
+	idata->blksz = block_size;
+	idata->blocks = 1;
+
+	if (cmd42_para == MMC_CMD42_ERASE)
+		mmc_ioc_cmd_set_data((*idata), data_block_onebyte);
+	else
+		mmc_ioc_cmd_set_data((*idata), data_block);
+
+	ret = ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
+
+	printf("Multi cmd response: %d\n", ret);
+
+	printf("Set block length response: 0x%08x\n",
+		mioc->cmds[0].response[0]);
+
+	r1_response = mioc->cmds[1].response[0];
+	printf("cmd42 response: 0x%08x\n", r1_response);
+
+	if (r1_response & R1_ERROR) {
+		printf("cmd42 error! Error code: 0x%08x\n",
+			r1_response & R1_ERROR);
+		ret = -1;
+	}
+
+	if (r1_response & R1_LOCK_UNLOCK_FAILED) {
+		printf("Card lock/unlock fail! Error code: 0x%08x\n",
+		r1_response & R1_LOCK_UNLOCK_FAILED);
+		ret = -1;
+	}
+
+	close(fd);
+	return ret;
+}
+
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 5f2bef1..96da608 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -50,3 +50,4 @@ int do_general_cmd_read(int nargs, char **argv);
 int do_softreset(int nargs, char **argv);
 int do_preidle(int nargs, char **argv);
 int do_alt_boot_op(int nargs, char **argv);
+int do_lock_unlock(int nargs, char **argv);
-- 
2.34.1

