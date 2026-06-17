Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871C313267
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717078; cv=none; b=WAUxuRyfPV+7CLKkE+YIqvGrjZxgi+dzwGg8er/BxarDFf/jUr8o4tSyIf0aREKKogLug+Hop1p9zdArxUMETiXyLy7fYRNV36zmMKY8AFqCH2ntBIRGocK1K0wUorJldnkX6i7dwZZldAlQgdbGwcFcxLMUFgTq3R/UCiCO/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717078; c=relaxed/simple;
	bh=2t8BVUQILXQFeTGk0Mnw8aiPpTPs4XbvKIs3yYB5PBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+6Ij0cE5CZoRuOSIAugJ+UGD8HfttUOU9BKlo8mxhU3ZvPJ7cqki1OGhZhwG7AJhIGpFp+iB4L2vbg9NobJIwIuGqAWR9JCJmdrXL/OMgExn7285qObKqPZz+6+W0x97ZvNLIc6Qq0dpL4qOi2XYFSEyyX2BpoSoZVMioDcaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK24645g; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK24645g"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bec423a5265so1109326266b.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781717075; x=1782321875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5eT5hajcYZHzS7XcpUzCmap8IvTdllvy/eQobcS2PQ=;
        b=dK24645geEtTQZpX+5arhZPWp4YlrCoOiXZSTxBqe9eSwZG+G1vo8VK8B1vM4k8629
         7xrcPb4qiXuUyzWPTJL1Va1g+d13DZ+Eu4qJ/QLle1TAj9DlLpwwXU0ZfviQrJMMftBR
         vHDAG8w5NddJ+IWyQg0cvSjjmwauC33USuv+ZXSZg131Kdlzi74uzKkgAxzqI+QWpnEj
         zHp71vU3PaN8y34gRgayfBZhgsMKi4at5drVPnoXrgKzkjY6l5/CeNKTo10yAnRZbqyS
         dqP+xsMHjQRC29zh7KP9+Ixc/70kXYeerqasvH/avAtUAw5tAWLDkB2UzSs3okU4AQc4
         NJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717075; x=1782321875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5eT5hajcYZHzS7XcpUzCmap8IvTdllvy/eQobcS2PQ=;
        b=dztlPT4r2zm3J/qW52+s2LF6Ugd/BoFC9jmB5BxJllGGRQnOC+3afxXJ2CQw2IkjeY
         nnUWCu+wA28DT0mBGbVUEOiiYCtaTSlanGy4aw0xjtnu+5cmyCYEjK9aTqbJMj9h8OMf
         GyLItKxkQc0Reln+7jGJFBpFPZd/Dm7DugRAbYRL8e+sQV/ayKHpaEHyoMmVGVHpj6rR
         esoI6pOSGaZDUgK1lwEQJbFxXRCMaE5aihaZ/V2FrGmlk3IjbiM9Rf1sBU39Ko3YsMy7
         pbx39hcBUxZS+MjIV8TgB+Ak+VyoXr81WPD3KVmXHnucEheqY5p7+AXNx0MF0lDJVF6u
         UycA==
X-Gm-Message-State: AOJu0YzeJHi75YaKfSpr+dvrJmsIan1jnG/cc8wi5iBOYKwMei4iAWnb
	fJKFKNjjaP62hgEhka/iSpSV4qzQd3345FwEJ+a8lbktCRKG+hGe8JJR24IynZZx
X-Gm-Gg: Acq92OFacNV6IAturmXrvoeom1rUAZiU/HMLHXFsTbamk2l0z3Yt0xc8AlmSBHY6FiP
	b16/84SClvTyIq4Y0xGMuK3/1rY3yWrCPJ7S7zuRyWkYbGGVB40dvBkwCdFaPs+LHO5AyP8FAGJ
	rssH/03HWNWY9dPbqPpvcMt4Pd3h7NktuAPwlUaNjgOibsBQ9Aqdxs4CGtyRy0UEx6HQwVNxH5j
	1LCXAtDj1ivsdib6oJq1Hl0keyn59tZECecDwQEy/8YGJF3Mg2HBnhmFiUeoBfrAef5C4Rz84Bw
	5kmDMpYL4OpNdnZKenhtdhlj8u8OnkJ8qu+xSgIszuKujrCuatpVtSAnzhnTOjlrEnXp5Khapf8
	jv48yr8G2W57zhRYefjGyv+jAKWPxwTumvR+eYgdojxBGFwmqUoZjzXhjsEwdkJQ31dXyWGyajj
	/J0mk0P71Sddjnkp7FPaUI5+dyooE=
X-Received: by 2002:a17:907:6090:b0:bed:e2e8:d8c3 with SMTP id a640c23a62f3a-c05a2e40c2dmr337753266b.22.1781717069245;
        Wed, 17 Jun 2026 10:24:29 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:ec6d:6f56:be28:aea2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c0463a2d1f4sm323873766b.51.2026.06.17.10.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:24:28 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>,
	Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v3 2/4] mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
Date: Wed, 17 Jun 2026 19:24:09 +0200
Message-ID: <20260617172411.42805-3-torsteine+linux@gmail.com>
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

Commands like 'cid read' previously required a raw sysfs device path
such as /sys/bus/mmc/devices/mmc0:0001/. Most users know their block
device as /dev/mmcblk0 or /sys/block/mmcblk0.

Add resolve_dev_path() which follows /sys/class/block/<dev>/device via
realpath() to reach the canonical sysfs device directory. Paths that
start with /dev/ or /sys/block/ are resolved automatically in
do_read_reg() before processing, and the resolved sysfs path is printed
so the caller can see which device was matched.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
---
 docs/HOWTO.rst | 59 ++++++++++++++++++++++++++++++++++++++++++--------
 lsmmc.c        | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index d454d8c..3739a0a 100644
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
index afcf446..d42e121 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -285,6 +285,50 @@ static char *read_file_at(const char *dir, const char *name)
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
+	snprintf(basedev, sizeof(basedev), "%s", devname);
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
@@ -2205,6 +2249,21 @@ static int do_read_reg(int argc, char **argv, enum REG_TYPE reg)
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

