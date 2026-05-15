Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB131A56C
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834135; cv=none; b=tnu1qieDtQc0UtJYxpFJFdzuFQZHmRCMda7wq1AikRjAGVuJ2anUAyIDCkhRnIzlagusZMbCQvE3JpiRF6xDx0kf7uBFwJQlW3LMjHuxfWuoaRsB3hOdS3dyZTRTe7O6JWIuyNnNMZmv5DFLR/FzFe1/n9/v4tR8V0zU2Ynf2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834135; c=relaxed/simple;
	bh=OAwSy6dJiwW+lrXO1WtrAVzpqZKpvPxZgYNcyIl/928=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4UIIYbZM6DIH2Ix7a7r7l9opC6iog1Q7vcvRJaCj9u6q0i7rdTb9ztzng4vsJMCswfRlzb3IpyKhyxzF7BXKqOcTLDEiXTGEv283VECy8m+et2XvFupMIfSsdYbYeWSppWyhWsF+Pm6XTi7X9M3Me6winOaJU7ECgRKQRbrIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNsmIJGD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNsmIJGD"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso16367033a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834132; x=1779438932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FIOBN70JAHq7mJX0IHUVI7XK9eVgrBwCWRBLMqS+Rs=;
        b=cNsmIJGDtXfBvVdwuxh+g/ty0uj+cBf6NTkeBIc8mTXDlngloSqWbXRVftkC+8RSlk
         HAfw2PxNR1nB5so6y9RWhDX+k6MH3nOwP6jwgxmeXDU8lVhT+O/QTJuq1LS29oXA+7ZK
         nr5jA92qpoefJor47RC7WkibwOmcInL1Sz78mi7SPmkLdMVpRiQOiljhwzVzJlMY+Yix
         tn3npaFLjlqQuJRZrR1X6VP+7xNBWupjUNJGOd0pln/KmzYWMW7yLogkZS8lSD5c6TuB
         KqqflIF7utQfbiFgPdIyNVHWkxHqHy8QnJewsz/hLrU0SMCuvyyOvusoNBxj+1uQjJd3
         uePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834132; x=1779438932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8FIOBN70JAHq7mJX0IHUVI7XK9eVgrBwCWRBLMqS+Rs=;
        b=IEw+xWs9/9ezFPBq/pkm0MRPxN1EMZYM95LMN1oL0P8fLRm4gDF91TmJ2cIdg7wsni
         TGclZEdC87JSnnXPL2DS3KCgVgTakhRq+40AtspLr3v6LQcbYTGDFwf/1pX7P9lw9fK0
         TZNaLBFq+OPeyr66Nf+jiJ8jNWtyYNPhBUJBEGUBZ6YXv4TLz03Ix0SY6sP8BD5iNDG6
         mHFN1FBXQ/+JEvDsckcpwpDQ2FcwySuA1t+F/JUQHIVxl0wGQGpQ6UwnNUGbodJMNwrQ
         wsIwq2xLK6pCHI+7OryLyTXgT5VHYBAensqVKxhJTcG6UmBpTKMbZlIcLnJThf/ggtfM
         T8JA==
X-Gm-Message-State: AOJu0YzuWZgkl0m7wnVAekybG3r6rYN1BDGy+nGuBmOte3OPwusZ2NNN
	9yJWdEJS+YcB2KcfT2PeVKSfdj9taMG2j2ngK8byHQW6hzWBCtmnI+xUSe0lJZlt
X-Gm-Gg: Acq92OG9H6t9Ark4sn5PKf+3gvnJBGmE0OeWT4cJb7qjSRVOZcfgIXmy9hiTS4B1CbG
	Q5EzSN9lyO9gOoEeX6CgKL9b4BSO0FDOGJrhZegQ01OznV931wYsDVyZq+gtO09u0Z3M9p9TEPR
	NtilxKbgcBzBl2xyQl1MjGAqxhH2JjUiK9+mOQY/uhiV8kkFrY4RefH2azuIg9MQOLqIRzzNO1q
	yQHWhDu/KoLO1e2Bmtr5i0/d9qWgxCfTPag3ayr3U3YxwuzPJj69UtF0TXVKHfm7f2Tw4OL/pKh
	oosDctUwo483JA07EET10kvOjmxH0u/Dq4zhwZndf452Xy+K4Mgu0hkjx248CPA/M2pljX2KU50
	wmYbzyEUxfnmvzhQveQ8U1qnpNlmj339iWve78CA+xJWvlECqOFWfob4zKzUm/pejJ7p+Gwz8qs
	+R8opz2Aq+MMBwlQJPxqUXVfA0NmpjChAkKvtz
X-Received: by 2002:a17:907:97ce:b0:bd4:f7f0:bbc7 with SMTP id a640c23a62f3a-bd5178f96admr149563866b.32.1778834131418;
        Fri, 15 May 2026 01:35:31 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:a66:143b:cd2f:c4ae])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bd4f4dec7d1sm189493566b.32.2026.05.15.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:35:29 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH 2/4] mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
Date: Fri, 15 May 2026 10:34:55 +0200
Message-ID: <20260515083457.3690804-3-torsteine+linux@gmail.com>
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
 docs/HOWTO.rst | 59 ++++++++++++++++++++++++++++++++++++++++++--------
 lsmmc.c        | 42 +++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 9 deletions(-)

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
index 113f371..3149409 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -226,6 +226,33 @@ static const char *get_manufacturer(struct config *config, unsigned int manid)
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
+
+	return resolved;
+}
+
 /* MMC/SD file parsing functions */
 static char *read_file(char *name)
 {
@@ -2151,6 +2178,21 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
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

