Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCD1C69D
	for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2025 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304056; cv=none; b=Z4MYz9qQjHbEKIgzUdffzWkh4Nh9Wu7z/p/PAkZk1Sa0Y8d5hWvzgoTHHuzZW/gMIqk4gv8FBqz+nkWMHElrzXupaRZFIQd0PY9h0Sqs3o6WxwNDwgmDQ0R0sCJzQZJbrPnMx7IqQauDeTjeW7yzOUSWm+M9fRUuD8O6EznUfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304056; c=relaxed/simple;
	bh=xj5VFd/wGT0JNCBUTP0mdIV9ztBJbkLtDXr1qW4MS+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiL5sWsgS+3JCXdN9xEdEC0PV2+bF+jK/UIexSZD4Y3s+PI60qe3a6H6lkLQpZR/hHjTPOnquu59ARLr2Nn2JoWtnTlYSWj0U8jVbyxDT2vYNbDYokSiH5cyDDFylgoEroN/5L/1AVk0+lZTIi7QYXmK/wXyKnLv+9uKeVCFX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVIMHkBz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVIMHkBz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso31412755e9.0
        for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2025 00:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766304053; x=1766908853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEICg7/ZZ+sFIVrpvJHRuWrrOTv4UgF3PCJArP1rKpY=;
        b=dVIMHkBzBfLpjJV7s2a080D4p6sXHoVQ8xGbW0sAmY6yxl+9EMRs8Yft9tjbjUSek7
         4P1b33r85qLnf0RLZD3IrmROISWienpvcXn3pXGxWt4RFfu/fklVLDgdFCbS/Mn8mbst
         npoGaMjy34vio3DULQ3HdIfJlAV8fCAwTJv+HqFLtfZUE4Y1Z8BUhSvcfiN+yEpxkH2J
         4e3lZYwZDabDWrp8Nx2oOUmpmmACGbC+noHM2pf/TgE8B+k2T09UBFv/uaOTcGmR4h9Z
         58lPLirCsD8tniTvkWJKXVloYb9CjvzWtBuCjDyaONrl5J64WAhj3LlUtYdKWH1J4fKX
         6BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766304053; x=1766908853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VEICg7/ZZ+sFIVrpvJHRuWrrOTv4UgF3PCJArP1rKpY=;
        b=pNI6VSy6oLYiaq2HPQd48CznniNQrebDC3eYVHVRAIerhjPsdfkjpfsosrOrql4Xzu
         VgQMPaZKkE8yKKzsX+uAZIMevg7iDXt9Vy64oJFwlFzhHS1BrHT6Kg8mJDS7TMzr/BuY
         sXXBuz4lUTIpUnMt5HOLPBCxg8HFVD9lrFaM+NrsbwQYxfwbZ7hVfZDtJP+yElNpGucX
         QoEvu9N0+ZBmhquOwbPa0IMDb1bLDW6UMWrnfYj18OxUvjrdmZjfQ2J4Tq/Gr9yjghWS
         SH4wW67o1KtON5B/YYg5mJ9ewixy1FmWnH1n0hMSd5HF3MKO8eiyAws1k5yUGQUnYWY4
         lxKA==
X-Forwarded-Encrypted: i=1; AJvYcCWxRHKctZEB+UG7dg6ofRJwlJsyl883x4t0tdNy9ROrotES5kST+3XJSHbu0MKe+QySkNpxvnWNDXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrDoH0/x3AcvPua7n8JkDb26y/y/uyOks3/Qf7zLfVanDzO3o
	9Pf3bdXacsqDR0jCU1uuSeOaEieqhLoDJBVBQHluzlbJPXu8ZpfPcEMEk7PpwQ==
X-Gm-Gg: AY/fxX7VGFcjY+v5d66l2gcHxguotITL0ydRIExQXUXicEXFSfuVXh1aM+YPVfx9TOL
	t+C/Fh9eINFRggzkU+Dkt6OJQ2mR509275/UqNSdoNejrjJpIwOOs/qoYX4pHEGWJP901k/qBB3
	hTzVq2WasOTxDDwLqbJW96BFl3bkUlC1u6dXO9ZBhqOuixywwygz4/WiqwrEAs8T+RzWvXItsJ+
	gzorx7EkYW3LZD34yRz2EUy8DwIZS+NIuFdefkSLsqqlYxVnsCnPx2PmYfckuGoHPMPKTRt6drs
	aPaS1twHqzDKE55ql81KQ1a4yupy0Ql+DHaecieWvp8/nMf0H5tW6hiy6XqvAsenQGj2NwS1Okl
	iVyJSh9KyvN/O+h90C4gIbogzCJqAyMmZ8GQromT6md7tpDgPkmXZm0d8K8osbL2aiQ+23IwxQ9
	NAtyliqENYGKfywE+nEkp4P/Bn3qv4qZQhpTS8RbsOj0fbyOWYCoFXLEJLKytXkJAxhLBWjBrB1
	gJhF83MZyUNc9pe7uoYQ3h7a6aUgQGUqk8=
X-Google-Smtp-Source: AGHT+IHsezzWA6iJUdI5UvYKMe6UT9lcAlVJ52OtK7rtfRWHQ0FR6bocrRH3Lrh6RKPY8nTVSqcTzQ==
X-Received: by 2002:a05:600c:444b:b0:477:557b:691d with SMTP id 5b1f17b1804b1-47d1959fa3emr71070735e9.25.1766304052711;
        Sun, 21 Dec 2025 00:00:52 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com (212-235-122-32.bb.netvision.net.il. [212.235.122.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193621c8sm127174335e9.7.2025.12.21.00.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 00:00:52 -0800 (PST)
From: avri.altman@gmail.com
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 2/2] mmc-utils: lsmmc: cache ext_csd revision for MMC devices
Date: Sun, 21 Dec 2025 10:00:20 +0200
Message-Id: <20251221080020.4532-3-avri.altman@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251221080020.4532-1-avri.altman@gmail.com>
References: <20251221080020.4532-1-avri.altman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avri Altman <avri.altman@sandisk.com>

The Manufacturing Date (MDT) field in the CID register depends on the
Extended CSD Revision (EXT_CSD_REV) to determine the correct base year
(1997, 2013, or 2029).

Currently, lsmmc processes registers in isolation. To enable correct MDT
decoding in the CID print function, we need to read and cache the
EXT_CSD revision when processing MMC devices from sysfs.

This patch adds logic to `process_reg_from_file` to attempt reading the
`ext_csd` binary file and storing the revision byte (index 192) in the
config structure.

Note: Opening the block device node to issue ioctls requires root
privileges (sudo), whereas reading sysfs files might not.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 lsmmc.c    | 36 ++++++++++++++++++++++++++++++++++++
 mmc_cmds.c |  2 +-
 mmc_cmds.h |  3 +++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/lsmmc.c b/lsmmc.c
index b7b9378..e9df5e1 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -45,6 +45,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <fcntl.h>
 
 #include "mmc.h"
 #include "mmc_cmds.h"
@@ -2201,11 +2202,46 @@ err:
 	return ret;
 }
 
+static void read_mmc_extcsd_rev(struct config *config)
+{
+	DIR *dir;
+	struct dirent *dent;
+
+	if (config->bus != MMC)
+		return;
+
+	dir = opendir("block");
+	if (!dir)
+		return;
+
+	while ((dent = readdir(dir)) != NULL) {
+		if (strncmp(dent->d_name, "mmcblk", 6) == 0) {
+			char devpath[512];
+			int fd;
+			__u8 ext_csd[512];
+
+			snprintf(devpath, sizeof(devpath), "/dev/%s", dent->d_name);
+			fd = open(devpath, O_RDONLY);
+			if (fd >= 0) {
+				if (read_extcsd(fd, ext_csd) == 0)
+					config->ext_csd_rev = ext_csd[EXT_CSD_REV];
+				close(fd);
+			}
+
+			break;
+		}
+	}
+
+	closedir(dir);
+}
+
 static int process_reg_from_file(struct config *config, enum REG_TYPE reg)
 {
 	char *reg_content = NULL;
 	int ret = 0;
 
+	read_mmc_extcsd_rev(config);
+
 	switch (reg) {
 	case CID:
 		reg_content = read_file("cid");
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 5990502..4c8c127 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -74,7 +74,7 @@ static inline __u32 per_byte_htole32(__u8 *arr)
 	return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
 }
 
-static int read_extcsd(int fd, __u8 *ext_csd)
+int read_extcsd(int fd, __u8 *ext_csd)
 {
 	int ret = 0;
 	struct mmc_ioc_cmd idata = {};
diff --git a/mmc_cmds.h b/mmc_cmds.h
index f767deb..9d5f944 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -17,12 +17,15 @@
  * those modifications are Copyright (c) 2016 SanDisk Corp.
  */
 
+#include <linux/types.h>
+
 typedef int (*CommandFunction)(int argc, char **argv);
 
 void print_usage(CommandFunction func);
 
 /* mmc_cmds.c */
 int do_read_extcsd(int nargs, char **argv);
+int read_extcsd(int fd, __u8 *ext_csd);
 int do_write_extcsd(int nargs, char **argv);
 int do_writeprotect_boot_get(int nargs, char **argv);
 int do_writeprotect_boot_set(int nargs, char **argv);
-- 
2.34.1

