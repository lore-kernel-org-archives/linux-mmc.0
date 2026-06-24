Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A671AAE17
	for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326923; cv=none; b=oxlkJl3iSJ2JsNH98S6tTfcypNNHi6qqs9xU7mVUvNC5SyzwJFoljBh5Swum2oqGyTmOffZjOhXqS1H/9zemNVHOUeaHYX4XPF+IC1cn6WDSmuBYG11XgIL3JUGdoSaDfKTamdDUKcvwPB1qgl8V+Z3/Ya6cY6KRhkYOdHXEXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326923; c=relaxed/simple;
	bh=MIYpGPKJcDpPkcFRjF1uxTTAy2svBqNhs3+4s17PNyI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuN5WbUODHwQmaXNsq2BscY4HG6rvoIIG0KFitPiVpN1dDDD8ogMOhQdhZn+Z4WftwwQe8xItEusbnv146BDqf0QwU/p+FD+pC/C04D/ddjj/kbt1nzq4H74Dv2YTCFkX67lAZ+NKuu3kQt94+1pyAz1hNFgK25UUc5dygdz/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oao88cgK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oao88cgK"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-697f6c67028so362338a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jun 2026 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782326920; x=1782931720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIYqjjCd4qikDXRfx9NSFfEbd2TwU34k7XjjnsknrQ8=;
        b=oao88cgKS6ivZl5jRQGqT1J49vwF+6LO/noaGvJr1qOyKx9PgutYaDp9MFtiLQMQlT
         TkiZ30g4gvZwm+LIBGHpvqxChDWq79b3YXziiiPgmEuaEPWIL2ED/FH1KDih9OzxWEDO
         V3zecdYbXGTyxtAihmb9uGpGPRLiuevsuLMZse+I/kGia+2pcAWYyWYkQBJ+LyR2wCs+
         QbbxqiuITfser3xMAru25z138WZnP9TCd3ULbkbMurD+tt0FdkxIjHPyh9U1zA04c4ZR
         1PIGVKvk5p2yjvw0ESKzCQj6+Vh1wjHsGdzBQMEkxiZcYwjwsOQFsEjWaQfJyVEmbN8a
         8tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326920; x=1782931720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIYqjjCd4qikDXRfx9NSFfEbd2TwU34k7XjjnsknrQ8=;
        b=neszjkSALxr2mrAHBRSD4bUGd87MbS8IHhQgzi0MYLTd43GDzBirAy07qnbidXZR0O
         1L9bgyZnVlt+AClO/o6DR8Pq4wOGHzq2D1Hpf59Nwrp2MJo6MIqZ4N8US5IWponSVee9
         tmfVgCwI9fqKEKRXfHtT2f51x8f8v4msl3oQK88bmjV31z+7ABuyu3NizeGLju/1+Dna
         PPFJABnz3q/hAsdLAZ6NOMmNLUdFxy8voWt4hZocb3R2fcRGtFMlNIvR5RziLwCqk7FO
         +kT92guC5AgGoty1w0GCNIb/ZObYfrdd+fwufhbH/OSDYtRbOA9IwEHM4Sxkr2Uwy0zv
         Za5g==
X-Gm-Message-State: AOJu0Yza8S0neTK0HaGkXdNgJ2ov6n4+HBhyX9Kql4cYRoYUEnITYIut
	UpI40HB+y2xSqhV4beMj1veuiktNJVGy8sB7hGZT4R0YZmK2R4pdAcwlY45Vhg==
X-Gm-Gg: AfdE7ck3PID4Fcq69bjqqZBvHmSaqdEtxH9LqcfhLJGprOKjh/jhV33emWhsTGiQsUV
	sYKBGThh+vCv+CFll/LnVAzzI+yVjDDFQ1LxulkMRM95GbzC0QJIAbQC3w2OQYoBpgYkVqLZONU
	oTE85ToH8fgppcNS3fZ+bVwwlozEON33qXUsAdN1nxNQT4UkeSm0WQ5DGNQ1/t5LDdK8bOMLAas
	R9XARTAAJuU93bjrLwty0+KAD/kvSY3Fub19BFH9kcMGxmF9qPZpBRjf2ujzsQZiQkoJ2ZdPd6n
	eiv3ypMmhVGAdGNuyHkJQNqpBsGzFRbnJcIWtKNJ9MhHDWIwEE4eSQ+0TS2MLdDSTKEBZY1fyLM
	H5QooRHB2K/3VjmpIGhgjGNj79SWClPH6AqcdG34S9w3Z1Za9TVv6uLDX4h30e2lH2F+V56wRwC
	xA37sO6GiabJDajd8C/07X+P6fE+oMU5RweI1O9A==
X-Received: by 2002:a05:6402:4403:b0:695:2f69:d371 with SMTP id 4fb4d7f45d1cf-69808482676mr1073321a12.9.1782326920018;
        Wed, 24 Jun 2026 11:48:40 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:91be:16ef:9f06:8b10])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac4774sm1659189a12.3.2026.06.24.11.48.38
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:48:39 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Subject: [PATCH v4 2/3] mmc-utils: lsmmc: Add mmc list command
Date: Wed, 24 Jun 2026 20:48:23 +0200
Message-ID: <20260624184824.2215718-3-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624184824.2215718-1-torsteine+linux@gmail.com>
References: <20260624184824.2215718-1-torsteine+linux@gmail.com>
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
 lsmmc.c        | 147 +++++++++++++++++++++++++++++++++++++++++++++++++
 mmc.c          |   6 +-
 mmc_cmds.h     |   1 +
 4 files changed, 165 insertions(+), 1 deletion(-)

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
index d5a26b6..bc43004 100644
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
@@ -2274,6 +2307,120 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 	return ret;
 }
 
+static const char *month_name(unsigned int month)
+{
+	static const char *months[] = {
+		"jan", "feb", "mar", "apr", "may", "jun",
+		"jul", "aug", "sep", "oct", "nov", "dec",
+		"invalid0", "invalid1", "invalid2", "invalid3",
+	};
+
+	if (month >= ARRAY_SIZE(months))
+		return "invalid";
+
+	return months[month];
+}
+
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

