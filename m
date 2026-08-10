Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8ED3F4854
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376105; cv=none; b=YCoXywNlKU9Z10O+jfnUqGak2xszXs0qRZ75Z12zaDmcJB7bLskVew7XKx06F5zec1uJthbpTCrhPnJVAZVwRktDwfIsWnuYUBQK+OBvaFKm4umUYWm19wxiTwF5gdmTlgwOai5jBoRUE+QXwoD6gNcW0ROe+/4L45KB5dRUaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376105; c=relaxed/simple;
	bh=9bJhAfrtK+sHPFSlq0mcc39XHvzpEMeakDKzzGHvo4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRvyeMwOhkIBwrtS6Xo4jx+Wj60cKyCgf65qn3J5bjsQgaZvOVLnDgTnrTa2EEA1/ok0nfFxgh7sl3teDlKSJlkid+vqGMrjIo17PRyU4XsmJd3TgTa1Kz3oU+UPTrXE9nY7Fc+9bkUDe0+SOuJKkelPUN8WCOYH3ScZ/rsbBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k96dha46; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k96dha46"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15c42a45adso3518466b.0
        for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786376102; x=1786980902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+T22MwXVZJj9hBpf4/s/rxRNKSyma2dim4SOgt58Akk=;
        b=k96dha46931FrBqgSq6lgmxPm+ujg7/VunRKDCarV5mTECgSSNOPRthtTChXztBC+J
         KxHpS3RggxCjSY02cGv3OLdudFL3wfEPe9eQKN5hn6dNXIkun9yzz7P+3z/NqQVw+KYo
         WL5Gc8obCEqOx5pHFM2sLQs6H9AqqZXt8lsTcDyFRxPteis8bIT8GpHhqsGbpWpZoPWo
         WtEiQ2BYV4wR3LJ61QR2WVv15s1XwkhZjDK5f4lxLEBzfvwkJ3exXHqxjuneIKItmcqh
         OEZvr7s/2xB8EEKhac9RcZxDbUykXT3N6dX3kk9LZlAUJzsR2jCGj9kdg20BNisWRN1o
         IbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786376102; x=1786980902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+T22MwXVZJj9hBpf4/s/rxRNKSyma2dim4SOgt58Akk=;
        b=GGrXVNMb071N/q3E/wf4u3yAzR1OmrC9K2lL71P+NVsjLcZjzLrQ824akkB8SGnEKm
         nhG106HSHiqeJxD/m1DBwCSKNEC+etERIVI/nSVwCXkzl3DcYgD/u5hV5HZ62FJEeoY3
         mv2wx+UeA6KiiAzZlyloTk2VqdQjiVv5YWrtshF0io6633GilUx4ES48C2bpEAeyBo26
         ZmczLvzEHbVsRlpPhOV1OST7sFapvaSsZLjcyzX0gNrZT+jHGwMLjOHiKNH3aGVRe2DV
         u8IIXfuhl9sRk6JGNtpxjtAuxe0h/6YiFUzH8/yHxe15g7lj0FCBXgS+GIFmQLNKaj/S
         kFiw==
X-Gm-Message-State: AOJu0YwJltUj559Xth8CJnuqmcxlgkj3VVV+xs1sIdTB9aE0DnvC79Vn
	g/iObwE7W8mgF/HPJx3HlOc+AkwlljRjn34kDxvgCMtHsgulSHJTcW+vaLSpI2oH
X-Gm-Gg: AR+sD133hNhEOpNzhu/s/1zvh9SET4RIVPt/9c9cb6Q44HzPC/XwLErBq2sjGwRouWL
	KjGMcShD88fYjPSF/IGArfVPA8SCvETN25K7Q55tJtmBgxsKZ07EEpUQ7BOLE/6PPX1wPQQ0w2k
	gy//4xYhnd/SQxHS4njQ/GwIHDphIJIzTR1vFjXpsaDHQ5uGL6eEjhAWC8xkfXqF/KFzKYD2pDQ
	+3IaLEbP/iWob+4Zf5HncIqDML97+uA4JBbUdfLCt0FitMY3OLdMxO904uCbv61gHNhUeSkpzyJ
	v4oVdB0s3X4JzpxqAINxNq+Zj/8yJ+bb9D66QHQzGlw07mBlyKeNjRuj+avyiZz7sRJPr+74jfB
	Ljk3gcPJz+kSuv//N9CzLBYVGcXKgKfSGqEIFzw6aBvxmhGy4oyvSpHHTxx71piwGG+Jc2gfjHT
	pqKDmDK9665RVsceVVion99tgnZuuOgp6xZzL7+GyvkS6xtQNjKO+UAX5AS/F16NAXSyzLJGiSc
	vvmFlQXOicX
X-Received: by 2002:a17:907:b04c:20b0:c20:96cd:cd9e with SMTP id a640c23a62f3a-c2096cdd54emr101795566b.15.1786376101777;
        Mon, 10 Aug 2026 08:35:01 -0700 (PDT)
Received: from torstein-laptop.internal ([2a01:799:3a1:9700:9fe:dfd2:946e:90f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2080cc3bdfsm393966466b.48.2026.08.10.08.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:35:01 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>,
	Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v6 3/3] mmc-utils: lsmmc: Add mmc list command
Date: Mon, 10 Aug 2026 17:34:42 +0200
Message-ID: <20260810153442.132286-4-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810153442.132286-1-torsteine+linux@gmail.com>
References: <20260810153442.132286-1-torsteine+linux@gmail.com>
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
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
---
 docs/HOWTO.rst |  12 +++++
 lsmmc.c        | 133 +++++++++++++++++++++++++++++++++++++++++++++++++
 mmc.c          |   6 ++-
 mmc_cmds.h     |   1 +
 4 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 3739a0a..0b486e4 100644
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
index 3139a7d..4167095 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -229,6 +229,38 @@ fallback:
 	return strdup(name);
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
 static char *read_file_at(const char *dir, const char *name)
 {
@@ -2290,6 +2322,107 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 	return ret;
 }
 
+static void print_list_entry(struct config *cfg, const char *devname,
+			     const char *blkdev, char *cid)
+{
+	char *mfr;
+	char devnode[32];
+
+	snprintf(devnode, sizeof(devnode), "/dev/%s", blkdev ? blkdev : "?");
+
+	if (cfg->bus == SD) {
+		struct sd_cid c;
+
+		parse_sd_cid(cid, &c);
+		mfr = get_manufacturer(cfg, c.mid);
+		printf("%-14s %-14s SD   %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		       devname, devnode, mfr ? mfr : "Unlisted", c.pnm,
+		       c.prv_major, c.prv_minor, c.psn, sd_cid_year(&c),
+		       month_name(c.mdt_month));
+	} else {
+		struct mmc_cid c;
+
+		parse_mmc_cid(cid, &c);
+		mfr = get_manufacturer(cfg, c.mid);
+		printf("%-14s %-14s MMC  %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		       devname, devnode, mfr ? mfr : "Unlisted", c.pnm,
+		       c.prv_major, c.prv_minor, c.psn,
+		       mmc_cid_year(&c, cfg->ext_csd_rev),
+		       month_name(c.mdt_month));
+	}
+
+	free(mfr);
+}
+
+int do_list(int nargs, char **argv)
+{
+	const char *bus_path = "/sys/bus/mmc/devices";
+	DIR *d;
+	struct dirent *ent;
+	bool header_printed = false;
+
+	d = opendir(bus_path);
+	if (!d) {
+		fprintf(stderr, "Cannot open %s\n", bus_path);
+		return -1;
+	}
+
+	struct config cfg = {};
+
+	/* Probe ids files so any warning appears before table output */
+	cfg.bus = SD;
+	free(get_manufacturer(&cfg, ~0u));
+	cfg.bus = MMC;
+	free(get_manufacturer(&cfg, ~0u));
+
+	while ((ent = readdir(d)) != NULL) {
+		char devpath[PATH_MAX];
+		char resolved[PATH_MAX];
+		char *type, *cid, *blkdev;
+
+		if (!strchr(ent->d_name, ':'))
+			continue;
+
+		snprintf(devpath, sizeof(devpath), "%s/%s", bus_path, ent->d_name);
+		if (realpath(devpath, resolved) == NULL)
+			continue;
+
+		type = read_file_at(resolved, "type");
+		if (!type)
+			continue;
+
+		if (strcmp(type, "MMC") != 0 && strcmp(type, "SD") != 0) {
+			free(type);
+			continue;
+		}
+
+		cid = read_file_at(resolved, "cid");
+		if (!cid) {
+			free(type);
+			continue;
+		}
+
+		blkdev = find_block_devname(resolved);
+		cfg.bus = strcmp(type, "MMC") ? SD : MMC;
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
index fce7eef..b0f1f9b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -306,6 +306,11 @@ static struct Command commands[] = {
 	  "3. Only up to 512K bytes of boot data will be transferred.\n"
 	  "4. The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.\n",
 	},
+	{ do_list, 0,
+	  "list", "\n"
+		"List all MMC/SD devices with their /dev path and CID info.",
+	  NULL
+	},
 	{ NULL, 0, NULL, NULL }
 };
 
@@ -590,4 +595,3 @@ int main(int ac, char **av )
 
 	exit(func(nargs, args));
 }
-
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 9d5f944..033cc09 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -62,6 +62,7 @@ int do_opt_ffu4(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
+int do_list(int nargs, char **argv);
 int do_erase(int nargs, char **argv);
 int do_general_cmd_read(int nargs, char **argv);
 int do_softreset(int nargs, char **argv);
-- 
2.53.0

