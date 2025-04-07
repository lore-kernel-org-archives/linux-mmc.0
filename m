Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5161448D5
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014834; cv=none; b=O7nNbzbjSaeOItcp3vM+vk/cOZuHSjbL/wmpiiOlF+MY0twrzReigkzm2M2lfoCkqw+IbCm0AHPlrpXX7N0AEbn1msrbFMNBkcY3KVbhFs89m40r5dp4JtV5BS7PAlzexjWTAq2xX8ISrYTnevUwutkV9DAC9wdyIFpRaG5S+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014834; c=relaxed/simple;
	bh=WsQfU94sdRkJSoCKmdOTQra69uQgF3XATvf/bYmWmwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dsKeAWhNx1lFw+8x9qE8kc5LP7ohcUavT3q3h18e+oHAzZc9YSpCaf0slBL0/DIjXsLrSvdkd42e+SJBHGSqHJD4n/4sCCosj1GBiXuLYp0EtEMo5fQ8FZ59IVCf/7ncwELBA2t/9xXr/dhvgCUgKbh1jJ9UD729hrar5f87mN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=DZLcdUNz; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="DZLcdUNz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014832; x=1775550832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WsQfU94sdRkJSoCKmdOTQra69uQgF3XATvf/bYmWmwo=;
  b=DZLcdUNzSx1m1OlqPRV7pOiwtbchIcTvONO6AWtBHGpunPWrYGbqfP9f
   Qeqjm8zO327guR9LVeB+0huq56eDBHeQlLgPzzvCDeGrrti61YeggmtSR
   bXnUfPajDwRI9GLWJeG94NUstKI6XzcQgS0OGDrR1zD638vvKwsSEAR78
   uM7Ep6UaxKT7v+6XHWuB1XSsuf77dU+vZ553qebkrqJcc4DnRwoNFYgtr
   N2bs4XEdJ7xFhSOelrVDqQ1DJDl35neexQ1YK9BgOom0wInhOE9hVR+ps
   zggZa6emLToTMZxLI9gW04A6MYRqiv1uYicix1Nl35mz+zwHPG4U7odPN
   A==;
X-CSE-ConnectionGUID: 70pe0/CDRSeb/5K6Xz4w4A==
X-CSE-MsgGUID: xAxDaBHrSa+Mn9QWT8QYYQ==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="72607260"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:33:44 +0800
IronPort-SDR: 67f37fe9_XeZnYbTRvqSf9GAXC5WtDum7PNQqU7K006oQMA4z71gc5gU
 RlOdHqqyR+htUwP41zDS5azcJci1Jk3YoxgZLHA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:34:02 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:33:43 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 06/10] mmc-utils: Refactor RPMB key handling into a separate function
Date: Mon,  7 Apr 2025 11:28:29 +0300
Message-Id: <20250407082833.108616-7-avri.altman@sandisk.com>
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

This patch refactors the key handling logic into a new function
`rpmb_get_key`. The new function centralizes the logic for reading the
key from a file or standard input, and optionally performing HMAC SHA256
encryption.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 147 ++++++++++++++++++++++-------------------------------
 1 file changed, 62 insertions(+), 85 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index d019dc8..80ac6ab 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2128,6 +2128,52 @@ static inline void set_single_cmd(struct mmc_ioc_cmd *ioc, __u32 opcode,
 	ioc->flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 }
 
+static int rpmb_get_key(const char key_file_name[], struct rpmb_frame *frame_in,
+			unsigned char key_out[32], bool encrypt)
+{
+	int ret, key_fd;
+	unsigned char key[32] = {};
+
+	if (strcmp(key_file_name, "-") == 0) {
+		key_fd = STDIN_FILENO;
+	} else {
+		key_fd = open(key_file_name, O_RDONLY);
+		if (key_fd < 0) {
+			perror("can't open key file");
+			return EXIT_FAILURE;
+		}
+	}
+
+	ret = DO_IO(read, key_fd, key, sizeof(key));
+	if (ret < 0) {
+		perror("read the key");
+		goto out;
+	} else if (ret != sizeof(key)) {
+		printf("Auth key must be %lu bytes length, but we read only %d, exit\n",
+		       (unsigned long)sizeof(key), ret);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (key_out)
+		memcpy(key_out, key, 32);
+
+	if (encrypt) {
+		/* Calculate HMAC SHA256 */
+		hmac_sha256(key, sizeof(key), frame_in->data,
+			    sizeof(struct rpmb_frame) - offsetof(struct rpmb_frame, data),
+			    frame_in->key_mac, sizeof(frame_in->key_mac));
+	}
+
+	ret = 0;
+
+out:
+	if (key_fd != STDIN_FILENO)
+		close(key_fd);
+
+	return ret;
+}
+
 /* Performs RPMB operation.
  *
  * @fd: RPMB device on which we should perform ioctl command
@@ -2137,10 +2183,8 @@ static inline void set_single_cmd(struct mmc_ioc_cmd *ioc, __u32 opcode,
  * @out_cnt: count of outer frames. Used only for multiple blocks reading,
  *           in the other cases -EINVAL will be returned.
  */
-static int do_rpmb_op(int fd,
-					  const struct rpmb_frame *frame_in,
-					  struct rpmb_frame *frame_out,
-					  unsigned int out_cnt)
+static int do_rpmb_op(int fd, const struct rpmb_frame *frame_in,
+		      struct rpmb_frame *frame_out, unsigned int out_cnt)
 {
 	int err;
 	u_int16_t rpmb_type;
@@ -2225,7 +2269,7 @@ out:
 
 int do_rpmb_write_key(int nargs, char **argv)
 {
-	int ret, dev_fd, key_fd;
+	int ret, dev_fd;
 	struct rpmb_frame frame_in = {
 		.req_resp = htobe16(MMC_RPMB_WRITE_KEY)
 	}, frame_out = {};
@@ -2241,28 +2285,9 @@ int do_rpmb_write_key(int nargs, char **argv)
 		exit(1);
 	}
 
-	if (0 == strcmp(argv[2], "-"))
-		key_fd = STDIN_FILENO;
-	else {
-		key_fd = open(argv[2], O_RDONLY);
-		if (key_fd < 0) {
-			perror("can't open key file");
-			exit(1);
-		}
-	}
-
-	/* Read the auth key */
-	ret = DO_IO(read, key_fd, frame_in.key_mac, sizeof(frame_in.key_mac));
-	if (ret < 0) {
-		perror("read the key");
-		exit(1);
-	} else if (ret != sizeof(frame_in.key_mac)) {
-		printf("Auth key must be %lu bytes length, but we read only %d, exit\n",
-			   (unsigned long)sizeof(frame_in.key_mac),
-			   ret);
-		exit(1);
-	}
-
+	ret = rpmb_get_key(argv[2], &frame_in, NULL, false);
+	if (ret)
+		return ret;
 	/* Execute RPMB op */
 	ret = do_rpmb_op(dev_fd, &frame_in, &frame_out, 1);
 	if (ret != 0) {
@@ -2278,8 +2303,6 @@ int do_rpmb_write_key(int nargs, char **argv)
 	}
 
 	close(dev_fd);
-	if (key_fd != STDIN_FILENO)
-		close(key_fd);
 
 	return ret;
 }
@@ -2342,7 +2365,7 @@ int do_rpmb_read_counter(int nargs, char **argv)
 
 int do_rpmb_read_block(int nargs, char **argv)
 {
-	int i, ret, dev_fd, data_fd, key_fd = -1;
+	int i, ret, dev_fd, data_fd;
 	uint16_t addr;
 	/*
 	 * for reading RPMB, number of blocks is set by CMD23 only, the packet
@@ -2407,26 +2430,9 @@ int do_rpmb_read_block(int nargs, char **argv)
 
 	/* Key is specified */
 	if (nargs == 6) {
-		if (0 == strcmp(argv[5], "-"))
-			key_fd = STDIN_FILENO;
-		else {
-			key_fd = open(argv[5], O_RDONLY);
-			if (key_fd < 0) {
-				perror("can't open input key file");
-				exit(1);
-			}
-		}
-
-		ret = DO_IO(read, key_fd, key, sizeof(key));
-		if (ret < 0) {
-			perror("read the key data");
-			exit(1);
-		} else if (ret != sizeof(key)) {
-			printf("Data must be %lu bytes length, but we read only %d, exit\n",
-				   (unsigned long)sizeof(key),
-				   ret);
-			exit(1);
-		}
+		ret = rpmb_get_key(argv[5], &frame_in, key, false);
+		if (ret)
+			return ret;
 	}
 
 	/* Execute RPMB op */
@@ -2488,16 +2494,13 @@ int do_rpmb_read_block(int nargs, char **argv)
 	close(dev_fd);
 	if (data_fd != STDOUT_FILENO)
 		close(data_fd);
-	if (key_fd != -1 && key_fd != STDIN_FILENO)
-		close(key_fd);
 
 	return ret;
 }
 
 int do_rpmb_write_block(int nargs, char **argv)
 {
-	int ret, dev_fd, key_fd, data_fd;
-	unsigned char key[32];
+	int ret, dev_fd, data_fd;
 	uint16_t addr;
 	unsigned int cnt;
 	struct rpmb_frame frame_in = {
@@ -2555,33 +2558,9 @@ int do_rpmb_write_block(int nargs, char **argv)
 		exit(1);
 	}
 
-	/* Read the auth key */
-	if (0 == strcmp(argv[4], "-"))
-		key_fd = STDIN_FILENO;
-	else {
-		key_fd = open(argv[4], O_RDONLY);
-		if (key_fd < 0) {
-			perror("can't open key file");
-			exit(1);
-		}
-	}
-
-	ret = DO_IO(read, key_fd, key, sizeof(key));
-	if (ret < 0) {
-		perror("read the key");
-		exit(1);
-	} else if (ret != sizeof(key)) {
-		printf("Auth key must be %lu bytes length, but we read only %d, exit\n",
-			   (unsigned long)sizeof(key),
-			   ret);
-		exit(1);
-	}
-
-	/* Calculate HMAC SHA256 */
-	hmac_sha256(
-		key, sizeof(key),
-		frame_in.data, sizeof(frame_in) - offsetof(struct rpmb_frame, data),
-		frame_in.key_mac, sizeof(frame_in.key_mac));
+	ret = rpmb_get_key(argv[4], &frame_in, NULL, true);
+	if (ret)
+		return ret;
 
 	/* Execute RPMB op */
 	ret = do_rpmb_op(dev_fd, &frame_in, &frame_out, 1);
@@ -2600,8 +2579,6 @@ int do_rpmb_write_block(int nargs, char **argv)
 	close(dev_fd);
 	if (data_fd != STDIN_FILENO)
 		close(data_fd);
-	if (key_fd != STDIN_FILENO)
-		close(key_fd);
 
 	return ret;
 }
@@ -2686,8 +2663,8 @@ static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
 	  fprintf(stderr, "High Capacity Erase Unit Size=%d bytes\n" \
                           "High Capacity Erase Timeout=%d ms\n" \
                           "High Capacity Write Protect Group Size=%d bytes\n",
-		           ext_csd[224]*0x80000,
-		           ext_csd[223]*300,
+			   ext_csd[224]*0x80000,
+			   ext_csd[223]*300,
                            ext_csd[221]*ext_csd[224]*0x80000);
 	}
 
-- 
2.25.1

