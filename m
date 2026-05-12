Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B3385D62
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605939; cv=none; b=sGGwBICFwc26cDh7RJ+O4w7BsQDomKpcNGjylvkoMNlhF1EyxY1Gjdw3X9KMnq3W+LUBu+zJM4DCvFnciiOyM4VzhjC2HwEsiimESNoSkFBTSR5KCZL34Gb2IXMiiNrH7+wH0lW+G3X+7l0tGXnJdpFenEbZcBYlShj1NPm02RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605939; c=relaxed/simple;
	bh=2Ut2p0i8ihojaZq4IaI3Jgkb0W/DgITtOmzZqSXdR40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jufmfW/TP2XpR0kZ6RVJN4mSdZZso6YGIdRTki0undqpIoqaYtGWwC2JZO1ATRwhVi6nYxBnyfiqE/m6qOxWW1h8V0Lr/yClhjlOMzHVEzFYLMDoIQMpB/SA8zZtoVEIUNFuipFJTcnsDo/cVqavK8h23eyCIEDlAlxikR6LcWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJlZ8f1A; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJlZ8f1A"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67bb5ad91bfso10610944a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605936; x=1779210736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fjq9v8P3pxMzGtVU+6+JzHA5CZ3LyO8chXczgcdMOz8=;
        b=sJlZ8f1AE45IUK8XZD/3WYBpUdDptrtIyJuL4zepwbX6Bdg0PGV1VwVCGAwp2Dw41y
         A/jkx65eezoykCp3DoVbm+kZIujS6kF/jwz/7TUZHNg8/UzfXgtJbV4JAcSIfYWwUdjI
         flRPnlfUBpWrCk2oICwjOjANa3ZDIAqyd1Kjk8JnslWYrpHw5tQ2CyoDKAFprbpfyRB5
         mKGFSvJPpl+j/42WZk4AunRBYMIO75srLjPomYFfNOS7+FsndTzENwKowJWgNyBPLhh9
         PuM1qTWB4kP5TY92A67/OX9o1O+usqnyxstDLOILXCJrOhQTMbOuAgUxyVooMzcqB+5Y
         BPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605936; x=1779210736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjq9v8P3pxMzGtVU+6+JzHA5CZ3LyO8chXczgcdMOz8=;
        b=I+BqCHJHS+1GIHgI4VpC+dqOBnlzWb2nRhDblAIqRVvl2ko0GAs3SeR4BY+0dJt1Lj
         jJFuJmgMkw5JMoV8aLuv9fJAKUte4qUsk+HiKTCu6e67af92OCi2hg3vC/eL7e+Yk/41
         lNVv1SqNp+yffgemi2nfLOpSPCOPZEldBSldlpPrugpRlkiSYJxdDd7wlXrhDQHjjzsI
         1cSJIW3i9CReGhjpzcZSiBmkbx6PbhQF6/ylGRYOtDIM+1IV4vn/aH6rSInDZUT+vdJR
         wOYYG/Ll0EKLUOpjWIgmLrueODpa692mRYKHuk2NyTBaaJM4hZJY+uX7LDf9Ib1eSfAq
         LKDw==
X-Gm-Message-State: AOJu0Yxl7VGqVKvaXdhSUsOdX8dkBCnB+NdVq+MYWkmZ+hzKwF9zybZz
	YoEcHfIVJEGZbPY1alKUWFrYd8jrBpQoBRuq8OXxn6tQVZjaL5OyFGeMkHnUeC683ZY=
X-Gm-Gg: Acq92OGY4LlUeQ+sqRJyyN3L9XTrl1K4KZPeCSIgoGIUTa/5DllpE/xgQ5ekKrZvyhU
	dBxA6cuYVL4M5sBntztrnqAkPUhhnUwtfL6DBa2AehelAPGFKhEM6MkHfz4unKZuIce2j5MKoUx
	kR12Dp1EcrkFpva6WUzxH1LTjdXwOuZ2YfiSwvrCWwGgCXvBdwphlmLKhIacfm9amvE5v5o7Dzl
	h6qGSPxZZnxIZiN+/reoeUG4MSVvRF5YYy/Pma4cBeB1JW2NfQavkYUprQ90aCBZbq+VxTs1W5T
	XCBb2cIhpuVhfXanjBAGt1uxYaPsEpbTU+PK1siShtfMHk+dQB75AFleWLKZLZx2PTS6WeGkbxK
	JLCSs1e3/w+tdsHKmw5fVs/asUD+DgAywpMzsPrxjPf8Xt53lWxzAZR5GS/zqMBrHh4IfsaixYO
	kauT+6ra1LAJ3mcRheMcaOoqCIKxmx2GdmXAJ9uA==
X-Received: by 2002:a17:907:9304:b0:bd3:1a18:cc64 with SMTP id a640c23a62f3a-bd31a1904e2mr169156966b.31.1778605936484;
        Tue, 12 May 2026 10:12:16 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:132c:48b3:4466:1640])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bcaf0660dbbsm699773266b.2.2026.05.12.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:12:15 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein EIde <torsteine+linux@gmail.com>
Subject: [PATCH 1/1] mmc-utils: lsmmc: Add 'mmc list' command
Date: Tue, 12 May 2026 19:12:01 +0200
Message-ID: <20260512171201.36474-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Torstein EIde <torsteine+linux@gmail.com>

Add a 'mmc list' command that scans /sys/bus/mmc/devices/, resolves
each card's sysfs path, and prints a one-line summary per device.

find_block_devname() maps a sysfs device path back to its mmcblkN
name by scanning /sys/class/block/mmcblkN/device symlinks.

print_list_entry() parses the CID register and formats a fixed-width
table row with device name, /dev path, bus type, manufacturer, product,
revision, serial number, and manufacturing date.

The header is printed once before the first result. Devices without a
readable cid file are skipped silently via access() so unrelated sysfs
entries do not produce spurious error messages.
---
 docs/HOWTO.rst |   5 ++
 lsmmc.c        | 162 +++++++++++++++++++++++++++++++++++++++++++++++++
 mmc.c          |   5 ++
 mmc_cmds.h     |   1 +
 4 files changed, 173 insertions(+)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 02edea4..45c440b 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -84,6 +84,11 @@ Running mmc-utils
             sysfs: /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
             SCR Register: 0235800000000000
 
+    ``list``
+        List all MMC/SD devices present on the system. Output is a table with
+        columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC or SD),
+        MANUFACTURER, PRODUCT, REV, SERIAL, and DATE.
+
+        Example::
+
+            $ mmc list
+            DEVICE          DEV            TYPE  MANUFACTURER         PRODUCT     REV    SERIAL      DATE
+            mmc0:0001       /dev/mmcblk0   MMC   Samsung              MAG4FA      1.0    0x1a2b3c4d  2021-jan
+            mmc1:aaaa       /dev/mmcblk1   SD    SanDisk              SP32G       8.0    0x5e6f7a8b  2020-mar
+
     ``ffu <image name> <device> [chunk-bytes]``
       Default mode.  Run Field Firmware Update with `<image name>` on `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
 
diff --git a/lsmmc.c b/lsmmc.c
index e33d636..ec79841 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -252,6 +252,38 @@ static char *resolve_dev_path(const char *path)
 	return resolved;
 }
 
+static char *find_block_devname(const char *sysfs_devpath)
+{
+	DIR *d;
+	struct dirent *ent;
+
+	d = opendir("/sys/class/block");
+	if (!d)
+		return NULL;
+
+	while ((ent = readdir(d)) != NULL) {
+		char linkpath[PATH_MAX];
+		char resolved[PATH_MAX];
+
+		if (strncmp(ent->d_name, "mmcblk", 6) != 0)
+			continue;
+		if (strchr(ent->d_name + 6, 'p'))
+			continue;
+
+		snprintf(linkpath, sizeof(linkpath),
+			 "/sys/class/block/%s/device", ent->d_name);
+		if (realpath(linkpath, resolved) == NULL)
+			continue;
+		if (strcmp(resolved, sysfs_devpath) == 0) {
+			closedir(d);
+			return strdup(ent->d_name);
+		}
+	}
+
+	closedir(d);
+	return NULL;
+}
+
 /* MMC/SD file parsing functions */
 static char *read_file(char *name)
 {
@@ -2197,6 +2229,136 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 	return ret;
 }
 
+static void print_list_entry(struct config *cfg, const char *devname,
+			     const char *blkdev, char *cid)
+{
+	static const char *months[] = {
+		"jan", "feb", "mar", "apr", "may", "jun",
+		"jul", "aug", "sep", "oct", "nov", "dec",
+		"???", "???", "???", "???",
+	};
+	const char *mfr;
+	char devnode[32];
+
+	snprintf(devnode, sizeof(devnode), "/dev/%s", blkdev ? blkdev : "?");
+
+	if (cfg->bus == SD) {
+		unsigned int mid, prv_major, prv_minor, psn, mdt_year, mdt_month, crc;
+		char oid[3], pnm[6];
+
+		parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
+			  &mid, &oid[0], &pnm[0],
+			  &prv_major, &prv_minor, &psn,
+			  &mdt_year, &mdt_month, &crc);
+		oid[2] = '\0';
+		pnm[5] = '\0';
+
+		mfr = get_manufacturer(cfg, mid);
+		printf("%-14s %-14s SD   %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		       devname, devnode,
+		       mfr ? mfr : "Unlisted",
+		       pnm, prv_major, prv_minor,
+		       psn, 2000 + mdt_year, months[mdt_month]);
+	} else {
+		unsigned int mid, cbx, oid, prv_major, prv_minor, psn;
+		unsigned int mdt_year, mdt_month, crc;
+		char pnm[7];
+
+		parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
+			  &mid, &cbx, &oid, &pnm[0],
+			  &prv_major, &prv_minor, &psn,
+			  &mdt_year, &mdt_month, &crc);
+		pnm[6] = '\0';
+
+		mfr = get_manufacturer(cfg, mid);
+		printf("%-14s %-14s MMC  %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		       devname, devnode,
+		       mfr ? mfr : "Unlisted",
+		       pnm, prv_major, prv_minor,
+		       psn, 1997 + mdt_year, months[mdt_month]);
+	}
+}
+
+int do_list(int nargs, char **argv)
+{
+	const char *bus_path = "/sys/bus/mmc/devices";
+	char orig_cwd[PATH_MAX];
+	DIR *d;
+	struct dirent *ent;
+	bool header_printed = false;
+
+	if (!getcwd(orig_cwd, sizeof(orig_cwd))) {
+		fprintf(stderr, "Cannot get current directory.\n");
+		return -1;
+	}
+
+	d = opendir(bus_path);
+	if (!d) {
+		fprintf(stderr, "Cannot open %s\n", bus_path);
+		return -1;
+	}
+
+	while ((ent = readdir(d)) != NULL) {
+		char devpath[PATH_MAX];
+		char resolved[PATH_MAX];
+		char *type, *cid, *blkdev;
+		struct config cfg = {};
+
+		if (!strchr(ent->d_name, ':'))
+			continue;
+
+		snprintf(devpath, sizeof(devpath), "%s/%s", bus_path, ent->d_name);
+		if (realpath(devpath, resolved) == NULL)
+			continue;
+
+		if (chdir(resolved) < 0)
+			continue;
+
+		if (access("cid", R_OK) != 0) {
+			if (chdir(orig_cwd) < 0)
+				break;
+			continue;
+		}
+
+		type = read_file("type");
+		if (!type) {
+			if (chdir(orig_cwd) < 0)
+				break;
+			continue;
+		}
+
+		cid = read_file("cid");
+		if (!cid) {
+			free(type);
+			if (chdir(orig_cwd) < 0)
+				break;
+			continue;
+		}
+
+		blkdev = find_block_devname(resolved);
+		cfg.bus = strcmp(type, "MMC") ? SD : MMC;
+		cfg.ids_dir = orig_cwd;
+
+		if (!header_printed) {
+			printf("%-14s %-14s %-5s%-20s %-10s %-5s %-12s %s\n",
+			       "DEVICE", "DEV", "TYPE", "MANUFACTURER",
+			       "PRODUCT", "REV", "SERIAL", "DATE");
+			header_printed = true;
+		}
+
+		print_list_entry(&cfg, ent->d_name, blkdev, cid);
+
+		free(blkdev);
+		free(cid);
+		free(type);
+		if (chdir(orig_cwd) < 0)
+			break;
+	}
+
+	closedir(d);
+	return 0;
+}
+
 int do_read_csd(int argc, char **argv)
 {
 	return do_read_reg(argc, argv, CSD);
diff --git a/mmc.c b/mmc.c
index 077e901..0953bef 100644
--- a/mmc.c
+++ b/mmc.c
@@ -292,6 +292,11 @@ static struct Command commands[] = {
 	  "4. The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.\n",
 	  NULL
 	},
+	{ do_list, 0,
+	  "list", "\n"
+		"List all MMC/SD devices with their /dev path and CID info.",
+	  NULL
+	},
 	{ NULL, 0, NULL, NULL }
 };
 
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 407cbe6..508776c 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -49,6 +49,7 @@ int do_opt_ffu4(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
+int do_list(int nargs, char **argv);
 int do_erase(int nargs, char **argv);
 int do_general_cmd_read(int nargs, char **argv);
 int do_softreset(int nargs, char **argv);
-- 
2.53.0

