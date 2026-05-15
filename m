Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E03E9284
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834136; cv=none; b=P4bqWxD28E9g47p/Vyc9wbhE5Lph1g6xXYuKCfU04TQCT0IfeT0qehOV029E8286goMLYXi95lgcnEvSiF35lKiRBM5NB2hEdVlhOjLAFEEXSBrB5KafJH9rVmCW4WbsVPYDGKVC6vChdpR4h3jCAlT0+kznM5ePJY8J/7PkRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834136; c=relaxed/simple;
	bh=4i7ea7Rzhiboie91DNx8W6OyWSBV4fA7IVk0qjJcUQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQOQnoNeJU7YuV/QPMaJ2gAoPyXPZzOZQbFJSXR+vMy0c5qOlgem6JgxqGE2B4NcrsG/kgYe6q5kf8toxq14rGhaEe+gNcmosOU4mXgy/czjgKj9iGkRsvoB2D6wCu3+AqQ47ghTZPbDjs7k56ZgEnZELtNsAv/WLGnWz2oOGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDzmesrq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDzmesrq"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso285997866b.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834133; x=1779438933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g+8YdEXejlNwuqakmft3/fFMIWlHx3NWwb6PDIs5U4=;
        b=WDzmesrqA7LIPV+3IF+3jCfHNuVc7/j6Oit92cDs1ZEfrM4C8UpzN2m6pmd+j0lC5K
         ezSvJnr8uFtv01SXGgdxQ2EiF2WBIv6ilea7MX4VFbGYm3+nIwhWyewdbXqVpyZmO7fT
         UKYNr7S8vJttP10ZOcQVMD5nmIvMvBjuYwkIapGiw36+HgYT72loBexgjPtoKES/kTOE
         wZgqL9uSkaBf4iP2jgbmURE/adPQZk9ro2Ex4h5LbmiWvGvc2HGpWnxmj1sb2J46x3+J
         rfaGA1tNvou+fZlzzZSA6To9cPSPZ6etntdmYg3F5YSmExuOSeNtPxIZgNxTy73szjsO
         SszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834133; x=1779438933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6g+8YdEXejlNwuqakmft3/fFMIWlHx3NWwb6PDIs5U4=;
        b=sKMHhtDy7vzGq3WUuuZgeXswh7W8ufMuV22OAX2FJtyYBTl71Llzxszyis7cPVnN2g
         CE+Rb+HLHhyL1boH6pTSv93306Vj+unqvQUE+2b1gZAffC0ftE4vgeWGmomm4wBB4SzU
         uorb5IZA6mA4TnjN5l/GMVPHdvhywCKhGGgpfCeQ88h1utrcxc6YHuQu7tWjwCnq4f4v
         CwngkAwTnWbRGTm87RpG+Vpplm+udFsZSU6cXDYEJFxuST/H4quOoP+SXP135kGxVubF
         mM52dEvSzt6dwmi/IUCYr0gBXxlQZrDUfmk4kxxLySSQpAowu7CnGV/Yd1tQvmTgEsi9
         RM6w==
X-Gm-Message-State: AOJu0YyDAPlapJxlEVOfHL3Np2v38kzyAW/bBb0ZcEPGkWjZUeLWfqMd
	6nNLsTQ4DU77qiu0H7ZKrxhzXSnQqCMdjiFU52xpoEIfuhxbvdqDTfK79V8dsvBl
X-Gm-Gg: Acq92OEmYFYjljCDL7tXNNFsZSm2Zbej3AXxHEtrvKJaH52q/9rvGqkyHpDwp/9kp/5
	62NVYe1kCxpgfzuHSZtqU8SujyCUEv4hO8j2C4mNXnu35JLNsNjkBn2YUG+MUsmkqFEy0OsRQ5Y
	JX5HuQv0fhkECmy2uMcwjQgOQUXmGIOiXE1qCJINUcM8u4Ep8vkCSVA4BUMZLqrBEV6EcyKURGP
	E6BeHo2cMkK9TeEzNjB5Q4FyOiaksTdo9orTYki0FsAvMrC+i8Tq+NBcGtsWy2LXjHlGsF23BjY
	gJOlgTxmx0GcYrjP9whg/sWPl1clao3zKV2jmzsV4kTtsmV4EXan3bP9CKICXYrYYMXBgdPTPEW
	pEs7XMLEIuwmiURh3e+5BB3I2nJXKzyDpfU2QqejCTBycCE0xXvUTM2lfa3HjJHlj+v+wWWl4nP
	vsjsiu1LqNu19KZREkrX5kNGu7uc031bk9Nc+v3cr+X1S4+BE=
X-Received: by 2002:a17:907:93d4:b0:bd4:c6be:5f2e with SMTP id a640c23a62f3a-bd51777c81fmr108875766b.3.1778834132446;
        Fri, 15 May 2026 01:35:32 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:a66:143b:cd2f:c4ae])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bd4f4dec7d1sm189493566b.32.2026.05.15.01.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:35:31 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH 3/4] mmc-utils: lsmmc: Add mmc list command
Date: Fri, 15 May 2026 10:34:56 +0200
Message-ID: <20260515083457.3690804-4-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515083457.3690804-1-torsteine+linux@gmail.com>
References: <20260515083457.3690804-1-torsteine+linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
---
 docs/HOWTO.rst |  12 ++++
 lsmmc.c        | 167 +++++++++++++++++++++++++++++++++++++++++++++++++
 mmc.c          |   6 +-
 mmc_cmds.h     |   1 +
 4 files changed, 185 insertions(+), 1 deletion(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 76214a3..167a153 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -90,6 +90,18 @@ Running mmc-utils
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
+            DEVICE          DEV            TYPE  MANUFACTURER         PRODUCT    REV   SERIAL      DATE
+            mmc0:0001       /dev/mmcblk0   MMC   Samsung              MAG4FA     1.0   0x1a2b3c4d  2021-jan
+            mmc1:aaaa       /dev/mmcblk1   SD    SanDisk              SP32G      8.0   0x5e6f7a8b  2020-mar
+
     ``ffu <image name> <device> [chunk-bytes]``
       Default mode.  Run Field Firmware Update with `<image name>` on `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
 
diff --git a/lsmmc.c b/lsmmc.c
index 3149409..4f378fa 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -253,6 +253,38 @@ static char *resolve_dev_path(const char *path)
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
@@ -2203,6 +2235,141 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 	return ret;
 }
 
+static const char *month_name(unsigned int month)
+{
+	static const char *months[] = {
+		"???", "jan", "feb", "mar", "apr", "may", "jun",
+		"jul", "aug", "sep", "oct", "nov", "dec",
+	};
+
+	if (month >= ARRAY_SIZE(months))
+		return "???";
+
+	return months[month];
+}
+
+static void print_list_entry(struct config *cfg, const char *devname,
+			     const char *blkdev, char *cid)
+{
+	const char *mfr;
+	char devnode[32];
+
+	snprintf(devnode, sizeof(devnode), "/dev/%s", blkdev ? blkdev : "?");
+
+	if (cfg->bus == SD) {
+		unsigned int mid, prv_major, prv_minor, psn, mdt_year;
+		unsigned int mdt_month, crc;
+		char oid[3], pnm[6];
+
+		parse_bin(cid, "8u16a40a4u4u32u4r8u4u7u1r",
+			  &mid, &oid[0], &pnm[0], &prv_major, &prv_minor,
+			  &psn, &mdt_year, &mdt_month, &crc);
+		oid[2] = '\0';
+		pnm[5] = '\0';
+
+		mfr = get_manufacturer(cfg, mid);
+		printf("%-14s %-14s SD   %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		       devname, devnode, mfr ? mfr : "Unlisted", pnm,
+		       prv_major, prv_minor, psn, 2000 + mdt_year,
+		       month_name(mdt_month));
+	} else {
+		unsigned int mid, cbx, oid, prv_major, prv_minor, psn;
+		unsigned int mdt_year, mdt_month, crc;
+		char pnm[7];
+
+		parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
+			  &mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor,
+			  &psn, &mdt_year, &mdt_month, &crc);
+		pnm[6] = '\0';
+
+		mfr = get_manufacturer(cfg, mid);
+		printf("%-14s %-14s MMC  %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		       devname, devnode, mfr ? mfr : "Unlisted", pnm,
+		       prv_major, prv_minor, psn, 1997 + mdt_year,
+		       month_name(mdt_month));
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
+			       "DEVICE", "DEV", "TYPE", "MANUFACTURER", "PRODUCT",
+			       "REV", "SERIAL", "DATE");
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
index 077e901..01ad181 100644
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
 
@@ -567,4 +572,3 @@ int main(int ac, char **av )
 
 	exit(func(nargs, args));
 }
-
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

