From: Roman Pen <r.peniaev@gmail.com>
Subject: [PATCH 2/2] mmc-utils: RPMB: add support for 4 rpmb operations
Date: Mon, 21 Jul 2014 21:53:45 +0900
Message-ID: <1405947225-6347-3-git-send-email-r.peniaev@gmail.com>
References: <1405947225-6347-1-git-send-email-r.peniaev@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39309 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbaGUMx6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jul 2014 08:53:58 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so9049387pdb.41
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jul 2014 05:53:58 -0700 (PDT)
In-Reply-To: <1405947225-6347-1-git-send-email-r.peniaev@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Roman Pen <r.peniaev@gmail.com>

mmc rpmb write-key <rpmb device> <key file>
  Program authentication key which is 32 bytes length and stored in the specified file.
  Also you can specify '-' instead of key file path and utility will read the key from stdin.
  BEWARE: key can be programmed only once!
  Example:
   $ echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | mmc rpmb write-key /dev/mmcblk0rpmb -

mmc rpmb read-counter <rpmb device>
  Counter value for the <rpmb device> will be read to stdout.

mmc rpmb read-block <rpmb device> <address> <output file>
  Block of 256 bytes will be read from <rpmb device> to output file or stdout if '-' is specified instead of regular path.

mmc rpmb write-block <rpmb device> <address> <key file> <256 byte data file>
  Block of 256 bytes will be written from data file to <rpmb device>.
  Also you can specify '-' instead of key file path or data file and utility will read the data from stdin.
  Example:
   $ (echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH && awk 'BEGIN {while (c++<256) printf "a"}') | \
     mmc rpmb write-block /dev/mmcblk0rpmb 0x02 - -

Signed-off-by: Roman Pen <r.peniaev@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---
 mmc.c      |  28 +++++
 mmc.h      |   6 +
 mmc_cmds.c | 419 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   4 +
 4 files changed, 457 insertions(+)

diff --git a/mmc.c b/mmc.c
index 926e92f..af2799b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -110,6 +110,34 @@ static struct Command commands[] = {
 		"Send Sanitize command to the <device>.\nThis will delete the unmapped memory region of the device.",
 	  NULL
 	},
+	{ do_rpmb_write_key, -1,
+	  "rpmb write-key", "<rpmb device> <key file>\n"
+		  "Program authentication key which is 32 bytes length and stored in the specified file.\n"
+		  "Also you can specify '-' instead of key file path and utility will read the key from stdin.\n"
+		  "BEWARE: key can be programmed only once!\n"
+		  "Example:\n"
+		  "  $ echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | mmc rpmb write-key /dev/mmcblk0rpmb -",
+	  NULL
+	},
+	{ do_rpmb_read_counter, -1,
+	  "rpmb read-counter", "<rpmb device>\n"
+		  "Counter value for the <rpmb device> will be read to stdout.",
+	  NULL
+	},
+	{ do_rpmb_read_block, -1,
+	  "rpmb read-block", "<rpmb device> <address> <output file>\n"
+		  "Block of 256 bytes will be read from <rpmb device> to output file or stdout if '-' is specified instead of regular path.",
+	  NULL
+	},
+	{ do_rpmb_write_block, -1,
+	  "rpmb write-block", "<rpmb device> <address> <key file> <256 byte data file>\n"
+		  "Block of 256 bytes will be written from data file to <rpmb device>.\n"
+		  "Also you can specify '-' instead of key file path or data file and utility will read the data from stdin.\n"
+		  "Example:\n"
+		  "  $ (echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH && awk 'BEGIN {while (c++<256) printf \"a\"}') | \\\n"
+		  "    mmc rpmb write-block /dev/mmcblk0rpmb 0x02 - -",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 9871d62..5fe5fec 100644
--- a/mmc.h
+++ b/mmc.h
@@ -20,6 +20,10 @@
 
 #define CHECK(expr, msg, err_stmt) { if (expr) { fprintf(stderr, msg); err_stmt; } }
 
+#ifndef offsetof
+#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
+#endif
+
 /* From kernel linux/major.h */
 #define MMC_BLOCK_MAJOR			179
 
@@ -29,6 +33,8 @@
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
 #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
+#define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
+#define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
 
 /*
  * EXT_CSD fields
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b8afa74..258fc37 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -26,9 +26,12 @@
 #include <libgen.h>
 #include <limits.h>
 #include <ctype.h>
+#include <errno.h>
+#include <stdint.h>
 
 #include "mmc.h"
 #include "mmc_cmds.h"
+#include "3rdparty/hmac_sha/hmac_sha2.h"
 
 int read_extcsd(int fd, __u8 *ext_csd)
 {
@@ -1163,3 +1166,419 @@ int do_sanitize(int nargs, char **argv)
 
 }
 
+#define DO_IO(func, fd, buf, nbyte)					\
+	({												\
+		ssize_t ret = 0, r;							\
+		do {										\
+			r = func(fd, buf + ret, nbyte - ret);	\
+			if (r < 0 && errno != EINTR) {			\
+				ret = -1;							\
+				break;								\
+			}										\
+			else if (r > 0)							\
+				ret += r;							\
+		} while (r != 0 && (size_t)ret != nbyte);	\
+													\
+		ret;										\
+	})
+
+enum rpmb_op_type {
+	MMC_RPMB_WRITE_KEY = 0x01,
+	MMC_RPMB_READ_CNT  = 0x02,
+	MMC_RPMB_WRITE     = 0x03,
+	MMC_RPMB_READ      = 0x04,
+
+	/* For internal usage only, do not use it directly */
+	MMC_RPMB_READ_RESP = 0x05
+};
+
+struct rpmb_frame {
+	u_int8_t  stuff[196];
+	u_int8_t  key_mac[32];
+	u_int8_t  data[256];
+	u_int8_t  nonce[16];
+	u_int32_t write_counter;
+	u_int16_t addr;
+	u_int16_t block_count;
+	u_int16_t result;
+	u_int16_t req_resp;
+};
+
+/* Performs RPMB operation.
+ *
+ * @fd: RPMB device on which we should perform ioctl command
+ * @frame_in: input RPMB frame, should be properly inited
+ * @frame_out: output (result) RPMB frame. Caller is responsible for checking
+ *             result and req_resp for output frame.
+ */
+static int do_rpmb_op(int fd,
+					  const struct rpmb_frame *frame_in,
+					  struct rpmb_frame *frame_out)
+{
+	int err;
+	u_int16_t rpmb_type;
+
+	struct mmc_ioc_cmd ioc = {
+		.arg        = 0x0,
+		.blksz      = 512,
+		.blocks     = 1,
+		.write_flag = 1,
+		.opcode     = MMC_WRITE_MULTIPLE_BLOCK,
+		.flags      = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC,
+		.data_ptr   = (uintptr_t)frame_in
+	};
+
+	rpmb_type = be16toh(frame_in->req_resp);
+
+	switch(rpmb_type) {
+	case MMC_RPMB_WRITE:
+	case MMC_RPMB_WRITE_KEY:
+		/* Write request */
+		ioc.write_flag |= (1<<31);
+		err = ioctl(fd, MMC_IOC_CMD, &ioc);
+		if (err < 0) {
+			err = -errno;
+			goto out;
+		}
+
+		/* Result request */
+		memset(frame_out, 0, sizeof(*frame_out));
+		frame_out->req_resp = htobe16(MMC_RPMB_READ_RESP);
+		ioc.write_flag = 1;
+		ioc.data_ptr = (uintptr_t)frame_out;
+		err = ioctl(fd, MMC_IOC_CMD, &ioc);
+		if (err < 0) {
+			err = -errno;
+			goto out;
+		}
+
+		/* Get response */
+		ioc.write_flag = 0;
+		ioc.opcode = MMC_READ_MULTIPLE_BLOCK;
+		err = ioctl(fd, MMC_IOC_CMD, &ioc);
+		if (err < 0) {
+			err = -errno;
+			goto out;
+		}
+
+		break;
+	case MMC_RPMB_READ_CNT:
+	case MMC_RPMB_READ:
+		/* Request */
+		err = ioctl(fd, MMC_IOC_CMD, &ioc);
+		if (err < 0) {
+			err = -errno;
+			goto out;
+		}
+
+		/* Get response */
+		ioc.write_flag = 0;
+		ioc.opcode = MMC_READ_MULTIPLE_BLOCK;
+		ioc.data_ptr = (uintptr_t)frame_out;
+		err = ioctl(fd, MMC_IOC_CMD, &ioc);
+		if (err < 0) {
+			err = -errno;
+			goto out;
+		}
+
+		break;
+	default:
+		err = -EINVAL;
+		goto out;
+	}
+
+out:
+	return err;
+}
+
+int do_rpmb_write_key(int nargs, char **argv)
+{
+	int ret, dev_fd, key_fd;
+	struct rpmb_frame frame_in = {
+		.req_resp = htobe16(MMC_RPMB_WRITE_KEY)
+	}, frame_out;
+
+	CHECK(nargs != 3, "Usage: mmc rpmb write-key </path/to/mmcblkXrpmb> </path/to/key>\n",
+			exit(1));
+
+	dev_fd = open(argv[1], O_RDWR);
+	if (dev_fd < 0) {
+		perror("device open");
+		exit(1);
+	}
+
+	if (0 == strcmp(argv[2], "-"))
+		key_fd = STDIN_FILENO;
+	else {
+		key_fd = open(argv[2], O_RDONLY);
+		if (key_fd < 0) {
+			perror("can't open key file");
+			exit(1);
+		}
+	}
+
+	/* Read the auth key */
+	ret = DO_IO(read, key_fd, frame_in.key_mac, sizeof(frame_in.key_mac));
+	if (ret < 0) {
+		perror("read the key");
+		exit(1);
+	} else if (ret != sizeof(frame_in.key_mac)) {
+		printf("Auth key must be %lu bytes length, but we read only %d, exit\n",
+			   (unsigned long)sizeof(frame_in.key_mac),
+			   ret);
+		exit(1);
+	}
+
+	/* Execute RPMB op */
+	ret = do_rpmb_op(dev_fd, &frame_in, &frame_out);
+	if (ret != 0) {
+		perror("RPMB ioctl failed");
+		exit(1);
+	}
+
+	/* Check RPMB response */
+	if (frame_out.result != 0) {
+		printf("RPMB operation failed, retcode 0x%04x\n",
+			   be16toh(frame_out.result));
+		exit(1);
+	}
+
+	close(dev_fd);
+	if (key_fd != STDIN_FILENO)
+		close(key_fd);
+
+	return ret;
+}
+
+int rpmb_read_counter(int dev_fd, unsigned int *cnt)
+{
+	int ret;
+	struct rpmb_frame frame_in = {
+		.req_resp = htobe16(MMC_RPMB_READ_CNT)
+	}, frame_out;
+
+	/* Execute RPMB op */
+	ret = do_rpmb_op(dev_fd, &frame_in, &frame_out);
+	if (ret != 0) {
+		perror("RPMB ioctl failed");
+		exit(1);
+	}
+
+	/* Check RPMB response */
+	if (frame_out.result != 0)
+		return be16toh(frame_out.result);
+
+	*cnt = be32toh(frame_out.write_counter);
+
+	return 0;
+}
+
+int do_rpmb_read_counter(int nargs, char **argv)
+{
+	int ret, dev_fd;
+	unsigned int cnt;
+
+	CHECK(nargs != 2, "Usage: mmc rpmb read-counter </path/to/mmcblkXrpmb>\n",
+			exit(1));
+
+	dev_fd = open(argv[1], O_RDWR);
+	if (dev_fd < 0) {
+		perror("device open");
+		exit(1);
+	}
+
+	ret = rpmb_read_counter(dev_fd, &cnt);
+
+	/* Check RPMB response */
+	if (ret != 0) {
+		printf("RPMB operation failed, retcode 0x%04x\n", ret);
+		exit(1);
+	}
+
+	close(dev_fd);
+
+	printf("Counter value: 0x%08x\n", cnt);
+
+	return ret;
+}
+
+int do_rpmb_read_block(int nargs, char **argv)
+{
+	int ret, dev_fd, data_fd;
+	uint16_t addr;
+	struct rpmb_frame frame_in = {
+		.req_resp    = htobe16(MMC_RPMB_READ),
+	}, frame_out;
+
+	CHECK(nargs != 4, "Usage: mmc rpmb read-block </path/to/mmcblkXrpmb> <address> </path/to/output_file>\n",
+			exit(1));
+
+	dev_fd = open(argv[1], O_RDWR);
+	if (dev_fd < 0) {
+		perror("device open");
+		exit(1);
+	}
+
+	/* Get block address */
+	errno = 0;
+	addr = strtol(argv[2], NULL, 0);
+	if (errno) {
+		perror("incorrect address");
+		exit(1);
+	}
+	frame_in.addr = htobe16(addr);
+
+	/* Write 256b data */
+	if (0 == strcmp(argv[3], "-"))
+		data_fd = STDOUT_FILENO;
+	else {
+		data_fd = open(argv[3], O_WRONLY | O_CREAT | O_APPEND,
+					   S_IRUSR | S_IWUSR);
+		if (data_fd < 0) {
+			perror("can't open output file");
+			exit(1);
+		}
+	}
+
+	/* Execute RPMB op */
+	ret = do_rpmb_op(dev_fd, &frame_in, &frame_out);
+	if (ret != 0) {
+		perror("RPMB ioctl failed");
+		exit(1);
+	}
+
+	/* Check RPMB response */
+	if (frame_out.result != 0) {
+		printf("RPMB operation failed, retcode 0x%04x\n",
+			   be16toh(frame_out.result));
+		exit(1);
+	}
+
+	/* Write data */
+	ret = DO_IO(write, data_fd, frame_out.data, sizeof(frame_out.data));
+	if (ret < 0) {
+		perror("write the data");
+		exit(1);
+	} else if (ret != sizeof(frame_out.data)) {
+		printf("Data must be %lu bytes length, but we write only %d, exit\n",
+			   (unsigned long)sizeof(frame_out.data),
+			   ret);
+		exit(1);
+	}
+
+	close(dev_fd);
+	if (data_fd != STDOUT_FILENO)
+		close(data_fd);
+
+	return ret;
+}
+
+int do_rpmb_write_block(int nargs, char **argv)
+{
+	int ret, dev_fd, key_fd, data_fd;
+	unsigned char key[32];
+	uint16_t addr;
+	unsigned int cnt;
+	struct rpmb_frame frame_in = {
+		.req_resp    = htobe16(MMC_RPMB_WRITE),
+		.block_count = htobe16(1)
+	}, frame_out;
+
+	CHECK(nargs != 5, "Usage: mmc rpmb write-block </path/to/mmcblkXrpmb> <address> </path/to/key> </path/to/input_file>\n",
+			exit(1));
+
+	dev_fd = open(argv[1], O_RDWR);
+	if (dev_fd < 0) {
+		perror("device open");
+		exit(1);
+	}
+
+	ret = rpmb_read_counter(dev_fd, &cnt);
+	/* Check RPMB response */
+	if (ret != 0) {
+		printf("RPMB read counter operation failed, retcode 0x%04x\n", ret);
+		exit(1);
+	}
+	frame_in.write_counter = htobe32(cnt);
+
+	/* Get block address */
+	errno = 0;
+	addr = strtol(argv[2], NULL, 0);
+	if (errno) {
+		perror("incorrect address");
+		exit(1);
+	}
+	frame_in.addr = htobe16(addr);
+
+	/* Read the auth key */
+	if (0 == strcmp(argv[3], "-"))
+		key_fd = STDIN_FILENO;
+	else {
+		key_fd = open(argv[3], O_RDONLY);
+		if (key_fd < 0) {
+			perror("can't open key file");
+			exit(1);
+		}
+	}
+
+	ret = DO_IO(read, key_fd, key, sizeof(key));
+	if (ret < 0) {
+		perror("read the key");
+		exit(1);
+	} else if (ret != sizeof(key)) {
+		printf("Auth key must be %lu bytes length, but we read only %d, exit\n",
+			   (unsigned long)sizeof(key),
+			   ret);
+		exit(1);
+	}
+
+	/* Read 256b data */
+	if (0 == strcmp(argv[4], "-"))
+		data_fd = STDIN_FILENO;
+	else {
+		data_fd = open(argv[4], O_RDONLY);
+		if (data_fd < 0) {
+			perror("can't open input file");
+			exit(1);
+		}
+	}
+
+	ret = DO_IO(read, data_fd, frame_in.data, sizeof(frame_in.data));
+	if (ret < 0) {
+		perror("read the data");
+		exit(1);
+	} else if (ret != sizeof(frame_in.data)) {
+		printf("Data must be %lu bytes length, but we read only %d, exit\n",
+			   (unsigned long)sizeof(frame_in.data),
+			   ret);
+		exit(1);
+	}
+
+	/* Calculate HMAC SHA256 */
+	hmac_sha256(
+		key, sizeof(key),
+		frame_in.data, sizeof(frame_in) - offsetof(struct rpmb_frame, data),
+		frame_in.key_mac, sizeof(frame_in.key_mac));
+
+	/* Execute RPMB op */
+	ret = do_rpmb_op(dev_fd, &frame_in, &frame_out);
+	if (ret != 0) {
+		perror("RPMB ioctl failed");
+		exit(1);
+	}
+
+	/* Check RPMB response */
+	if (frame_out.result != 0) {
+		printf("RPMB operation failed, retcode 0x%04x\n",
+			   be16toh(frame_out.result));
+		exit(1);
+	}
+
+	close(dev_fd);
+	if (data_fd != STDIN_FILENO)
+		close(data_fd);
+	if (key_fd != STDIN_FILENO)
+		close(key_fd);
+
+	return ret;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index f06cc10..9e625c9 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -28,3 +28,7 @@ int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
 int do_write_reliability_set(int nargs, char **argv);
+int do_rpmb_write_key(int nargs, char **argv);
+int do_rpmb_read_counter(int nargs, char **argv);
+int do_rpmb_read_block(int nargs, char **argv);
+int do_rpmb_write_block(int nargs, char **argv);
-- 
2.0.0

