Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62C385D63
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605890; cv=none; b=okarmMAGTt63PmDBSxa8CeZsKlk5i5XOc2ae15SR5X/2KxvqysUC+FfOLCvTPiQu+q8zHR4kLftzpJGDAzHbGThQnGMglMKVWrTZgCD/KIphf4m85ApVPmfxDIbqnxBuJURyeACyvsEdmyjv7HXMcQUXzJ0NZQ3H12ek7+GwluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605890; c=relaxed/simple;
	bh=g2pDuMqAmUe29BV+Egbeo5obc44oBc4xjvbPcqxDATs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBQyAAn/6ARoLL1YuSleuK+mvTtRMKuSsJjfUTXg24ZqaVeF2O1K2ItSCwlb0ofVhG3r451mGebN9vOn01sTp1yTaYnsutSlaDzlZy+CKvrqG36XKt0DCw9BtF21q60IhHLyGCpN+iNlGENzlvQqIG9Xg9wh0NBd5QJO2mPJCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5Lv4Q3Z; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5Lv4Q3Z"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd36614d329so59206266b.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605887; x=1779210687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AuAn6WCqzwgQDMZ00uKAG+YEB+Z8uhC98v8AzYg5BIY=;
        b=c5Lv4Q3ZRz3xs+can0MLM3FVJkOHCZN2o3/n05uBNL9GoBb8Ck34DaAA1WFA1FeI3V
         k3klJ1P/NWXSQWZhdNKABZgf/+gClalB7q5nF8ysO/kmC2UHgOQy6LIuzDa79SxLFZao
         2hx541eNZbFI5XXfTCOP2AlivO69RlHPBpSuRrZ4mJd9EkOxFVjkkwR4K1iu75Vxy0Fs
         rlJN9u71n7gN0AMW1DnwZQ6eT2H0lBZ/Usq6cIfSU2/hN7tl59WHECTirRhgtx7EdZim
         wKAORtsOvhZ8YsD2ElUONwXXzvvSLBDeDo/UXEl8POHWkN46VAxcBzr1jsPSmU5amhS2
         Q3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605887; x=1779210687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuAn6WCqzwgQDMZ00uKAG+YEB+Z8uhC98v8AzYg5BIY=;
        b=X7lb4nkIyLBdgakDAPSKLDlBMT0xNhln02R2L1zCgy+PUwgrdEp1LiEQYayo3qiXj3
         xj/4lLyDLq1ZIP1cBoesyo4y4b7bKMVpLiADbapaulydIqnDcLIHTLkH6qkc1BviGOf0
         ZFrGNv6Lvnewv8Qmeat8KCt7idTK0zskZG28w+rZ9nqjU7Qpj4efezZj7iIxfJOLxGtv
         CERpZH2ep0xFaUwbWHNNGu+8gsqhXiMJJiTwpsRwcJPWR7uTeOKivT3m2Y3Qx/JddVkC
         SPgrihCullZBq1MFetH0uXfWVOm8ACKvii04ZIV/wKoHwfAYYEHUm4QQFl+5hnkncgOB
         PgxQ==
X-Gm-Message-State: AOJu0YzYC9Cnz2m7jxVBZIYf5HsVtxwzGToVakvLsoxTuSzH09Be/2xa
	uzpH8I4CdgdNebNHoQSxjD1imoRNaYO3s71WDX5VY7BfoQ0dwNi3pox/1kw1LqSshsY=
X-Gm-Gg: Acq92OG4GYbmuudB26U78P54kfWQqcNm+D7U1OMhfQsRbvh5TeWLJvkaoRAKc9zG0/6
	k+hhw6hMAScFwbI1Iip6tCqvDrwsaMZ8b1N9uS82CYxPs9dKS5sxqzzi7gt+3oBxEos6dSoBfTH
	n1IKCFM3jdkR/tFBfRjq07+X6cHpV0fcKPUmext2q0hcot0IStF7lZeS6vYibkGX16g5WDDRNAv
	Oy/B9vkNuD6l0Uh36NC5S/rVzH6KJuK9v9fjnJx3Y4HE8m7E3MkYXrBIE5oRrBGDDMvBGPLozHh
	IG1+VlM1QA5UdjbHX4+0yctLF61Caex2eh4fY05Vx9BSjwb0giOX6HAQBSqlasmgd8D9+ul48uB
	UjM7p19KkrX66f+N8ckbsbM9aGYwMjQi+RvWIN9gZEw3J/kVFgUG6lAOZNzWTsmsO/6dQCW163w
	BPiSJv2tlnyFiEhBJM/u+aWZrfI0ndiZQoIBQB0g==
X-Received: by 2002:a17:907:3e85:b0:bd1:c82b:8bae with SMTP id a640c23a62f3a-bd28fda8024mr258242766b.45.1778605886920;
        Tue, 12 May 2026 10:11:26 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:132c:48b3:4466:1640])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bd3351ad00dsm60069566b.19.2026.05.12.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:11:26 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein EIde <torsteine+linux@gmail.com>
Subject: [PATCH 1/1] mmc-utils: lsmmc: Accept /dev/ and /sys/block/ paths for cid/csd/scr read
Date: Tue, 12 May 2026 19:10:59 +0200
Message-ID: <20260512171059.36352-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Torstein EIde <torsteine+linux@gmail.com>

Commands like 'cid read' previously required a raw sysfs device path
such as /sys/bus/mmc/devices/mmc0:0001/. Most users know their block
device as /dev/mmcblk0 or /sys/block/mmcblk0.

Add resolve_dev_path() which follows /sys/class/block/<dev>/device via
realpath() to reach the canonical sysfs device directory. Paths that
start with /dev/ or /sys/block/ are resolved automatically in
do_read_reg() before processing, and the resolved sysfs path is printed
so the caller can see which device was matched.
---
 docs/HOWTO.rst | 53 +++++++++++++++++++++++++++++++++++++++++---------
 lsmmc.c        | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 7a27a50..02edea4 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -35,19 +35,54 @@ Running mmc-utils
         Set user area write protection.
 
     ``csd read  [-h] [-v] [-b bus_type] [-r register]  <device path>``
-        Print CSD data from <device path>. The device path should specify the csd sysfs file directory.
-        if [bus_type] is passed (mmc or sd) the [register] content must be passed as well, and no need for device path.
-        it is useful for cases we are getting the register value without having the actual platform.
+        Print CSD data from <device path>. The device path may be one of the following:
+          - sysfs device directory  (/sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001)
+          - device node (/dev/mmcblkN)
+          - sysfs block device entry (/sys/block/mmcblkN) 
+        /dev/ and /sys/block/ paths are resolved to the sysfs device
+        directory automatically and the resolved path is printed.
+        If [-b bus_type] is passed (mmc or sd) the [-r register] content must
+        be passed as well, and no device path is required. Useful when the
+        register value is known without access to the actual hardware.
+
+        Example::
+
+            $ mmc csd read /dev/mmcblk0
+            sysfs: /sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001
+            CSD Register: 00000000...
 
     ``cid read <device path>``
-        Print CID data from <device path>. The device path should specify the cid sysfs file directory.
-        if [bus_type] is passed (mmc or sd) the [register] content must be passed as well, and no need for device path.
-        it is useful for cases we are getting the register value without having the actual platform.
+        Print CID data from <device path>. The device path may be a one of the following:
+          - sysfs device directory  (/sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001)
+          - device node (/dev/mmcblkN)
+          - sysfs block device entry (/sys/block/mmcblkN) 
+        /dev/ and /sys/block/ paths are resolved to the sysfs device
+        directory automatically and the resolved path is printed.
+        If [-b bus_type] is passed (mmc or sd) the [-r register] content must
+        be passed as well, and no device path is required. Useful when the
+        register value is known without access to the actual hardware.
+
+        Example::
+
+            $ mmc cid read /dev/mmcblk0
+            sysfs: /sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001
+            Manufacturer ID: 0x15
+            OEM ID: 0x0100
+            Product name: MAG4FA
+            Product revision: 1.0
+            Serial number: 0x1a2b3c4d
+            Manufacturing date: 01/2021
 
     ``scr read <device path>``
-        Print SCR data from <device path>. The device path should specify the scr sysfs file directory.
-        if [bus_type] is passed (mmc or sd) the [register] content must be passed as well, and no need for device path.
-        it is useful for cases we are getting the register value without having the actual platform.
+        Print SCR data from <device path>. The device path may be a one of the following:
+          - sysfs device directory  (/sys/devices/platform/fe310000.mmc/mmc_host/mmc0/mmc0:0001)
+          - device node (/dev/mmcblkN)
+          - sysfs block device entry (/sys/block/mmcblkN) 
+        /dev/ and /sys/block/ paths are resolved to the sysfs device
+        directory automatically and the resolved path is printed.
+        If [-b bus_type] is passed (mmc or sd) the [-r register] content must
+        be passed as well, and no device path is required. Useful when the
+        register value is known without access to the actual hardware.
+
+        Example::
+
+            $ mmc scr read /dev/mmcblk1
+            sysfs: /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
+            SCR Register: 0235800000000000
 
     ``ffu <image name> <device> [chunk-bytes]``
       Default mode.  Run Field Firmware Update with `<image name>` on `<device>`. `[chunk-bytes]` is optional and defaults to its max - 512k. Should be in decimal bytes and sector aligned.
diff --git a/lsmmc.c b/lsmmc.c
index 225c753..e33d636 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -226,6 +226,32 @@ static const char *get_manufacturer(struct config *config, unsigned int manid)
 	return NULL;
 }
 
+static char *resolve_dev_path(const char *path)
+{
+	const char *devname = strrchr(path, '/');
+	char syspath[PATH_MAX];
+	char *resolved;
+
+	devname = devname ? devname + 1 : path;
+	if (*devname == '\0')
+		return NULL;
+
+	if (snprintf(syspath, sizeof(syspath), "/sys/class/block/%s/device",
+		     devname) >= PATH_MAX)
+		return NULL;
+
+	resolved = malloc(PATH_MAX);
+	if (!resolved)
+		return NULL;
+
+	if (realpath(syspath, resolved) == NULL) {
+		fprintf(stderr, "Cannot resolve '%s': %s\n", path, strerror(errno));
+		free(resolved);
+		return NULL;
+	}
+	return resolved;
+}
+
 /* MMC/SD file parsing functions */
 static char *read_file(char *name)
 {
@@ -2149,6 +2175,18 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 	if (ret)
 		return ret;
 
+	if (cfg.dir &&
+	    (strncmp(cfg.dir, "/dev/", 5) == 0 ||
+	     strncmp(cfg.dir, "/sys/block/", 11) == 0)) {
+		char *sysfs = resolve_dev_path(cfg.dir);
+
+		if (!sysfs)
+			return -1;
+		free(cfg.dir);
+		cfg.dir = sysfs;
+		printf("sysfs: %s\n", cfg.dir);
+	}
+
 	if (cfg.dir) {
 		ret = process_dir(&cfg, reg);
 		free(cfg.dir);
-- 
2.53.0

