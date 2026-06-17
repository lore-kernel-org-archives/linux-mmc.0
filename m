Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38110313267
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717080; cv=none; b=fT3gN7RifIzpLrAdzrhFBWuxhJ5KkO9HF0QQjUL8YZH6I8+yuEhlA/O6nruVTAvZy+C6NgnSQQveBlTHHYXp8VuJhEUsYoFVpuWYH5F2sYGel0RsEHA4gfZEWmkJ6uRiS9rOfS5FnAigMZkFfsQALeC+zyTj8xdXE95mhqgXNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717080; c=relaxed/simple;
	bh=YPq2/XfNV7IcHIWJfktGY/pvhwKvW1Q2WS++AKqTQpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTP/LsFPhAYiiQp1iRO1jg/MPl1bwgzXFJ18sERYzYFb/AtPOIKYJrGmElkOjmEGKGfZhpjkB5++WlFntdvRoqgyKu/r39bHJqgGyomDIAPZI13Y5Bwn6Bmih2v+ifDaupsHtfk/nIR7VyMZLbTMRapvB7Gxfp3n+XWQRhPiOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8EgRTiP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8EgRTiP"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-becfa735b9aso769433666b.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781717078; x=1782321878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTsL37pkbSHwAuivGDj3ECgLPF0KRrUdQTJQgy6Y+Xc=;
        b=T8EgRTiPH32x9kyY0fkJe3dC8YtfmKSsHRviYLAUUZteAKpOVFnXko2+/FvPIv8JWB
         QCxSjjfFm+H9q2D4cv1r9naYU2AQCHZJv3JAnj90vZ9BvKEwg3FIdkP9o+A8Q+x9bC3Q
         4E6ZjthNkoMqtUpLSSjs2YFJdKak/3KNJaXXGOPW5rmvkS1Q9USxLogmetmETvrWykls
         GXaPyucZAOH2XkY8tnNDTWnCpI/cmfFkIXVdwjGclUhBzZppVJ0kUFKa20IVmpdXJM7U
         IxOYKSgtuiWHFNQ2p9GJy/+shZrEJ2B8AOfaLLyZ+Rx8A6k+spDGRAFPmJ4J/pSfWicH
         1tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717078; x=1782321878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTsL37pkbSHwAuivGDj3ECgLPF0KRrUdQTJQgy6Y+Xc=;
        b=qp5l8J2aBFIB0KS3wt+5xZHm9Vo4w+I3ZXXQ43JgcHb7apvitExlXTnDGGAPajbj47
         rcZtwcUSJ7VC3gscoyusfJz2dd3s8nF3h+4kZRrra/BdpjJgt4JL8NYP8QfO5cfCEQ4P
         vfhpLTkDl3RkCZ8bab/RhejYVOVXSY51hs2BwC98OIpiCPY9zrRmmdjRZ/y6yIUqmdd2
         kzPaFSMcY9TOylA4LNrAlRbNL2m2k21uhVZ5x7U1A49ppEEx0cEhpd62xpjsaqHPprxm
         JvxbStkWxc0sMad/OSxDu/VhBcySKIx3voT7rbVX2kgJRMg48NvjyEy2pTFuymmaWrTW
         lhWA==
X-Gm-Message-State: AOJu0YwignkllTaNWIFoFgytZtbXQix0DqkSVWhJhAJGghkY3oXuLEtJ
	hFT2TQsn9G9Oq+smNSLhCX4eKEhYD7EMihTLg1BxRsOP0v+Er48k+luzVQcbKQ==
X-Gm-Gg: Acq92OENcbVxihoFs2t6zgaRDaj3cKeCGCs5e0Gcb960RlbK+6MqL+rnXgcG07BNj9E
	WKBmLsXBcnvaqg9KQdSQbnzaDh4nkg6HDvmzG4F2dUijRXVyrMif6+NtzfyrHK5dZeqO37SD+T2
	q8LeDtSwBD0kLoc1DXFC60c4HNfmznDHafgc9JDxT4P/zQYftpYMI9euV5g9r/Bm5KdTZwZYCTM
	6e9WTbvZVenpjgFQ93M+1wRT2wHw6vFBMidUTCYOnQ4JWpfacbSSXn3kGT7ADGGUL/nn+FXzG6Z
	NM8e74iCJ3yRzxsK5RnlpytCHvwR7Wz++qPAnbueGQ5uE0GsecreOI0jbGdyLDyr6wjIvGEKkXQ
	F5fCzNipxfvpHLw+JmXblM8IfGP1rZJ7kjd5hz5dmE26G6sZPJzzM1qxIe/UEuSwvkpm4eWn6oN
	DCUNhO+QOj0bbMkBk8UjKJIHznk5s=
X-Received: by 2002:a17:907:9348:b0:be2:d66:eb4d with SMTP id a640c23a62f3a-c074eaa733cmr3295866b.44.1781717077410;
        Wed, 17 Jun 2026 10:24:37 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:ec6d:6f56:be28:aea2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c0463a2d1f4sm323873766b.51.2026.06.17.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:24:35 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v3 3/4] mmc-utils: lsmmc: Add mmc list command
Date: Wed, 17 Jun 2026 19:24:10 +0200
Message-ID: <20260617172411.42805-4-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617172411.42805-1-torsteine+linux@gmail.com>
References: <20260617172411.42805-1-torsteine+linux@gmail.com>
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
 docs/HOWTO.rst | 12 ++++++++
 lsmmc.c        | 76 +++++++++++++++++++++++++++++++++++++++++++++++++-
 mmc.c          |  6 +++-
 mmc_cmds.h     |  1 +
 4 files changed, 93 insertions(+), 2 deletions(-)

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
index d42e121..bc43004 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -229,6 +229,39 @@ fallback:
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
+
 /* MMC/SD file parsing functions */
 static char *read_file_at(const char *dir, const char *name)
 {
@@ -2288,6 +2321,37 @@ static const char *month_name(unsigned int month)
 	return months[month];
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
+		       c.prv_major, c.prv_minor, c.psn, 2000 + c.mdt_year,
+		       month_name(c.mdt_month));
+	} else {
+		struct mmc_cid c;
+
+		parse_mmc_cid(cid, &c);
+		mfr = get_manufacturer(cfg, c.mid);
+		printf("%-14s %-14s MMC  %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		       devname, devnode, mfr ? mfr : "Unlisted", c.pnm,
+		       c.prv_major, c.prv_minor, c.psn, 1997 + c.mdt_year,
+		       month_name(c.mdt_month));
+	}
+
+	free(mfr);
+}
+
 int do_list(int nargs, char **argv)
 {
 	const char *bus_path = "/sys/bus/mmc/devices";
@@ -2303,6 +2367,12 @@ int do_list(int nargs, char **argv)
 
 	struct config cfg = {};
 
+	/* Probe ids files so any warning appears before table output */
+	cfg.bus = SD;
+	free(get_manufacturer(&cfg, ~0u));
+	cfg.bus = MMC;
+	free(get_manufacturer(&cfg, ~0u));
+
 	while ((ent = readdir(d)) != NULL) {
 		char devpath[PATH_MAX];
 		char resolved[PATH_MAX];
@@ -2319,6 +2389,11 @@ int do_list(int nargs, char **argv)
 		if (!type)
 			continue;
 
+		if (strcmp(type, "MMC") != 0 && strcmp(type, "SD") != 0) {
+			free(type);
+			continue;
+		}
+
 		cid = read_file_at(resolved, "cid");
 		if (!cid) {
 			free(type);
@@ -2346,7 +2421,6 @@ int do_list(int nargs, char **argv)
 	return 0;
 }
 
-
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

