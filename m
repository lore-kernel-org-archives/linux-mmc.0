Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983022FF22
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881097; cv=none; b=P9TffPyLXtOWfOmJDH0S3Slq+LI8Z3nmi81nlkL32vVM+V2Wok0ZwEAEv4P+rT+fugqKDhQM++vsEV+6WaKf6MHz4do2DRNyJxlsG6E2ZlG9BiywUVX7SVGreuJulk7tvdUtgR3JviVOpAw4fk/R52TqJPDGOOvGle6RnjuSjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881097; c=relaxed/simple;
	bh=P51k/8R6ut9WmS13yzdQqbc2gi3MjoTj0RgoCBL3swY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEx4F1z5/A79JDDsc3wdYpmoZoog/jwdGm6ijx+ZcdWMGhru+gk5uJJfdlCAZIwyLpI8FcBzec9kNwpdTS0U+O1DlES3PZ+XcnWQUkKSJVpyG0a66tAsPq6JuJ/ynnrM9pwRrB6t2nau7Dvd2rYCQXIwnNn2vLJV6JkeSHOQRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drJs/R3s; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drJs/R3s"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so581489a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778881094; x=1779485894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSTljqPzlBpmyKDOKiexHLLVgEWWCAKSzjGFIJ3X6PA=;
        b=drJs/R3sjm7Mto2I4oDM16cByhUye3TlH2wRJp0inWHuZ4HczI8MN7sj5HyzthtQs1
         lfoW8eXwm8oy/7JfJ7aLrWA6y3cOkKrl/mf4KhGiEuor2gFHxZq1cR/plTLYo9WCo+JH
         /f3yfYCpx3kN9lgJsLb6Ie8eUfkId1pMUw9OqREcsDRo01UceZ6rxJAwg79kWMtIXObV
         cBp/qx3KZjJS6xERplNpaLRaTyXh/KJwsCw9K8acX/ydQPFGXSarzPa817WCaK0ETmrD
         0OG49L2HF6Au3RMZG08grde8u6IAjiCNB3Qgr7K9uh8oKa655eY6kBWbmg/il0d0D38v
         Uy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778881094; x=1779485894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CSTljqPzlBpmyKDOKiexHLLVgEWWCAKSzjGFIJ3X6PA=;
        b=YDkyxWVW4gxC9xPMWO1gBKUqrPeBkqUU/fI5V4CwfJ/Sej/651MeXdspBmoht7EXIa
         cLAH/LrvBVSLjPaePOeB9aW51k1bIhInaa00vKGw2Krk3HhggSUl3ZU1W+PQCIFjBQcY
         bc4SmpzVeSsSJOm1C4DESTVT4ILo+FrEidBdhKODsgTjBdkin69ZOE0GmRfkAs87ALq3
         f6efzF/lQfUUw7mrLUVpD8hOEvPkvfQ05thUoYF/jloH1mNhY+2/e+g3F93ASyldx/n0
         GAOIhs0+RVtk0ZDi1EIDLyA/oeUMmwZLHNZYEGG7cmvrqwLqbSi3bkzuKbGai198zCIU
         e12Q==
X-Gm-Message-State: AOJu0YzwIyD1vRFVg4jRr13+jRTAwoVvZuEk6Op1GPGZSahYU2mjfEBq
	IJbr0DmnZAVcWz5hyxlJNXSDjgPQqqHO+o+gHv1G5tdn106I2IG+NE7dL+IyZW0q
X-Gm-Gg: Acq92OHfbK1onZDMbIp4k+MFWELSfdRNpx7aWhPY4b2q0q93Ez0OBL4oE/tHfw02vkw
	l+Jc+lNNapl6xhnG0WYp+v6Mff3HNby63ky1Ig9DyEXJvC6spAl3aY3gBnt9kjnIk56c16WCtQm
	R1ourtEscCGGc5CT2XzjxPYVjrW4FhnpRYwBICwEKpfwNbHXW0d0ko/AR6jBtdU0ucXH6XCPKXo
	b5k98Jh9GPs2JQPrJcjRR5LRdDeQGh6vSohIaVrOlyAnbj21ci3HjlBi1wBo1eFY0E+kO/dgU1D
	36rEbq9iWcFEzQuE5BN7Z2A9g9hAa4QZscRShHHxGflmaxGmJxvxNITfVTjbNopIA8sI+P/ZEFF
	TaJUO/HMev5rXgDJ1QXaYntQFmjGFpikx522LAxurn/2/9gZ2ef8Cy73zNMJVXakKyL+BPKO+Rm
	GuFGoqo4Gk2CA1MUzgbtoe/M9mIt+DsPMWmbFcXhYmy9QBmvY=
X-Received: by 2002:a05:6402:504c:b0:678:a507:e837 with SMTP id 4fb4d7f45d1cf-683bc4b0c2emr2288538a12.1.1778881093795;
        Fri, 15 May 2026 14:38:13 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:690:4aa1:581c:2e09])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm2484038a12.11.2026.05.15.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:38:12 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v2 3/5] mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
Date: Fri, 15 May 2026 23:37:45 +0200
Message-ID: <20260515213747.1452692-4-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515213747.1452692-1-torsteine+linux@gmail.com>
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commands like 'cid read' previously required a raw sysfs device path
such as /sys/bus/mmc/devices/mmc0:0001/. Most users know their block
device as /dev/mmcblk0 or /sys/block/mmcblk0.

Add resolve_dev_path() which follows /sys/class/block/<dev>/device via
realpath() to reach the canonical sysfs device directory. Paths that
start with /dev/ or /sys/block/ are resolved automatically in
do_read_reg() before processing, and the resolved sysfs path is printed
so the caller can see which device was matched.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
---
 docs/HOWTO.rst | 59 +++++++++++++++++++++++++++++++++++++++++--------
 lsmmc.c        | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 7a27a50..76214a3 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -35,19 +35,60 @@ Running mmc-utils
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
+        Print CID data from <device path>. The device path may be one of the following:
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
+        Print SCR data from <device path>. The device path may be one of the following:
+          - sysfs device directory  (/sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa)
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
index 1c55b86..58d4609 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -281,6 +281,51 @@ static char *read_file_at(const char *dir, const char *name)
 	return strdup(start);
 }
 
+static char *resolve_dev_path(const char *path)
+{
+	const char *devname = strrchr(path, '/');
+	char basedev[NAME_MAX + 1];
+	char syspath[PATH_MAX];
+	char resolved[PATH_MAX];
+	char *p, *type;
+
+	devname = devname ? devname + 1 : path;
+	if (*devname == '\0')
+		return NULL;
+
+	/* strip partition suffix: mmcblk0p1 -> mmcblk0 */
+	strncpy(basedev, devname, sizeof(basedev) - 1);
+	basedev[sizeof(basedev) - 1] = '\0';
+	p = basedev + strlen(basedev);
+	while (p > basedev && isdigit((unsigned char)p[-1]))
+		p--;
+	if (p > basedev && p[-1] == 'p')
+		p[-1] = '\0';
+
+	if (snprintf(syspath, sizeof(syspath), "/sys/class/block/%s/device",
+		     basedev) >= PATH_MAX)
+		return NULL;
+
+	if (realpath(syspath, resolved) == NULL) {
+		fprintf(stderr, "Cannot resolve '%s': %s\n", path, strerror(errno));
+		return NULL;
+	}
+
+	type = read_file_at(resolved, "type");
+	if (!type) {
+		fprintf(stderr, "'%s' does not appear to be an MMC/SD device\n", path);
+		return NULL;
+	}
+	if (strcmp(type, "MMC") && strcmp(type, "SD")) {
+		fprintf(stderr, "'%s': unknown device type '%s'\n", path, type);
+		free(type);
+		return NULL;
+	}
+	free(type);
+
+	return strdup(resolved);
+}
+
 /* Hexadecimal string parsing functions */
 static char *to_binstr(char *hexstr)
 {
@@ -2162,6 +2207,21 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
 	if (ret)
 		return ret;
 
+	if (cfg.dir &&
+	    (strncmp(cfg.dir, "/dev/", 5) == 0 ||
+	     strncmp(cfg.dir, "/sys/block/", 11) == 0)) {
+		char *sysfs = resolve_dev_path(cfg.dir);
+
+		if (!sysfs) {
+			free(cfg.dir);
+			return -1;
+		}
+
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

