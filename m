Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE03A5449
	for <linux-mmc@vger.kernel.org>; Sun,  9 Aug 2026 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786263733; cv=none; b=ooiKk59vZ8wUDu7H4RWH3lr8PbRoR4OAGTZhuxP/DbjTuJuyBNDc7ipzdgDqAENfW6msuj6VYRlUZIxCAC6oYpymtS7ONNEfVASQ/7Pkf6vggFg4QxHMemrA6cEdSkAdCoj0B1Cs65IBhn1NsaCNNyHwBdGbAXtE/A2wGdZE88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786263733; c=relaxed/simple;
	bh=xVmxegc19Q7wISwVJg6iGWZLBsNNIumIjTFcUH9zhms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eg2VMDIlsjywkwzWqq8Vzci65vZNsx3D88Y0kYEEvnBO7zumxShxSm0Z2FtqLiEiDrDklG8Ppm6QTFvPRd3GCF5oPHiPfojJIYA1wqFV5dFgd9aJh0bhcfTBC39fvBkjyk72Td/GWFPdMPY8IOG08bXykoZG6CuZq/4H3mO6XYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/PkDQqS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/PkDQqS"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso5152520a12.0
        for <linux-mmc@vger.kernel.org>; Sun, 09 Aug 2026 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786263730; x=1786868530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcQdpyc3MAFTbiE9wJi3m4YyI9ejFUcgU+1L6iCeMx4=;
        b=Q/PkDQqS/qhKCmmMoeIztXBTQOyIMDR5LA7LoE1wzjLtouhQjistgFrSWBjpLTjWEs
         a27kRlNo55affg5/7BT4Nra/ju8ulzpqNHj4Pru/bK3VrcCNKM0xshxPurFpcVh8cYTW
         1Km7nqDj2qkgtnm9xtuAGSi9EEyfX3pIutiR/b7CNCg/R4akDuhRDyBEDt52zMv5vNUQ
         wzzNDTb3YjVPx6qfuP6vtvFe/XPqCj3Sx6fZArN3YMtwFc1zZjZjR3iIK+QLR8sI0eAf
         wjGw9XsrGP4EB3VmaK9D3l6raP45EFDuODzU6f5K+DGGV13P3EIiJwtUJ/oJn7E70Ofn
         I/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786263730; x=1786868530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcQdpyc3MAFTbiE9wJi3m4YyI9ejFUcgU+1L6iCeMx4=;
        b=AxSpeFYMq15OO7jdOtER59VU0GAI48RwBwzq3saDBbJhAhpcCKibHs5Smm9UygHiAl
         Nr5fLOaCH/EqtwLKcsMamJ0jl7B9t9chhGbWB93C0QLwqWow1yP3BAGpybP9h8H5ZpeP
         SCWJg3WLO+UAqh7wT4hc6IsCSb8UNqs2WY3OHflga9U22OzrML1nSaaRs8lVzR8JgXzA
         Ei6WTlI2k//LHLkqZt/JT2zBvctoz6sgsI8VwrwZxmZfkEs2AeYAnLHnEGSMcL+iw47b
         VnKiN64sovTfA2xGQPgiEGKQEKe+Q6b9+vRwzeSL13NLINXyU9m3/q1Ch4ee4zAJQlrQ
         97uA==
X-Gm-Message-State: AOJu0Yx+eTz7fIl2LoTlA4pSIgeKUu+5V0lWs/o9WyDdSgPx/RbilY6C
	cFB0jwHWOKgDxImmOramr71Q7bGugufi6kVLUPiMnvOH5BY/n2CdwIR+WKmPcg==
X-Gm-Gg: AR+sD13Lb7xq4lSty8TP0/tEc0uHH5IQumggHNvZTgaBoassQJGWJmxig2yqNMBhks5
	JAUKsEkk/ebCDk1dnt+5zVHp/W+sNUhEZlz4TPKvMlsZ0X9EXJMAMIwS9+QjorLm3VxNU2UAKff
	TleKspRP3mEQEU6Ja3StzEV2yInObJT+XN4JMGtBFycepVCwUR9wx4KoXYLRALno4t3cUmgx1Dj
	GsSXboabF3jIHvnTXVfmL3oSVzvrgQ07tsg74kkxUatM7foqNxzpFn1wXCXWaW0YEqzhJIUCyWY
	QPsUJcpnz7goRBU7CO6pKUUWJWdEd4RFcmmoI857VlzqRtaCjvHJsRml3PsZMF50bKCnlw4NJ4q
	jDqG4qsqs7Zl5rDeCmuCWeliLucJ477YGrKqqgVON/i60TXNhQsP5RBjmTL9GMzQk+RuTSLn30g
	HppFNh/T8cF5tD/B02iS+jzSker33L84gbiQkTwffp10/vLym03v1ZVbZmosb07EpMP+ncqor+f
	FVPC9rWXHFmFQ==
X-Received: by 2002:a17:907:3f07:b0:c1c:4c72:e6df with SMTP id a640c23a62f3a-c208c6574d0mr495763266b.0.1786263729381;
        Sun, 09 Aug 2026 01:22:09 -0700 (PDT)
Received: from torstein-laptop.internal ([2a01:799:3a1:9700:1e75:8b0f:2e1:e0bd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2080cc3b88sm226094066b.51.2026.08.09.01.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 01:22:08 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v5 3/3] mmc-utils: lsmmc: Add mmc list command
Date: Sun,  9 Aug 2026 10:21:53 +0200
Message-ID: <20260809082153.104311-4-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809082153.104311-1-torsteine+linux@gmail.com>
References: <20260809082153.104311-1-torsteine+linux@gmail.com>
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

