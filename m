Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD845365A1A
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881100; cv=none; b=M06wKkrgWSbdZGOV7uurFUY3Qq4bWyVBdIw+WfrGyhXxSutitwI/3X+eMjKwocqA/rUWI89A+P22yHB89PQwsQGrv2rWVtgPmg/9CssYWMPj/bT0vnh85KYJQDU+mcUSmTFKszug7VQITNVa5MLRm3WBF8IIcB5HcyDH84q+xG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881100; c=relaxed/simple;
	bh=B76t+F3D81BkLhjdYfH7aibLfBpnx8j7HPHG4FNp++w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMxTXB3T/axmLpmasgGkGnFrGzcOFnqpLFQdUbKcJ0xO+/M7vjuiOzuY7ddBBXj+dYz1bO5ottxgvJdo46MAiWwdkxRUYKB9BW9bKVnFSMGLdiJu9mvSP83idhDIehWcuMAaEcML+XYaVuucX3qsQ9Sx+KreBKaaiTf49BT1n6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ00ZVOC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ00ZVOC"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b936331786dso32805266b.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778881097; x=1779485897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMf7U6LHSCh25wK0sQX/0VswvCZbgGZM2rlHMI7onJk=;
        b=UJ00ZVOC6jelX25QOoO62TVSG+t6I3fu6d/A45+UEbxccb+Chy8mz7O/Pony6cw62w
         ip83ZDsIiC7inFYwiotblHV0GPfRYNbwfPjqQm4qfLj5ZBmwOq8H5Ciz0nkuG1fmbmIm
         3hDsvfyA9hHXamGAuLCWxE6eD2OAInukd/1oj/0acVPNZ0n5VzUD27N1J34YnAeQsat7
         r4zkPg0sujdaco8vk+NjdSmJ3knLTGhOfag/1/du6K9KYATqEJof6wpMjd68/dNmfMY1
         SvUbgBoFyvZQoEI+hG/UH85Ys/olh5qObiMFqjQz18smIWZ1ZO3ow/oBtIyWDOeoHcok
         MIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778881097; x=1779485897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pMf7U6LHSCh25wK0sQX/0VswvCZbgGZM2rlHMI7onJk=;
        b=YnID9j4HQs0dbmOAiKz78B4aOJxyKSl47hf7242UrhaC4LJ9P5M2Ah7NUXKMJnEoGx
         46ixgu2dUFXbrBU0UDZXq92BSrW8nKURzJATWt6bRjCxQ2E7Kl4QJZFnHKTJUT6pceHV
         xmPP8VcJrPHSecjVWAXt4kFgvwHQZ45sFJo1n2//F6v3mLjMA+OGLjwZRI+S1XTrXpJJ
         53CufTujoNdnRf6NkLClqjwiXimvMP+3MJbdXFYonJlz02yY6cY8Nq25Psg9mqthKpwy
         6zF6A1QRBQF6h05Z0SOsk7aEQcz4ThyyO5HoRxaLq32SxhqbW/yLDbvjkGGOH1oi2S9w
         mCvw==
X-Gm-Message-State: AOJu0YzdIlhyO2z6wP4Q3MU/QWUMPV4l0H4tKCmaJbeXqis/SoxAVdTc
	QRg8/YjWfNzCtHjcF85gHjOFEqrLxUdx5kgTAtpJtV8L2g6b+N+aU+eU7UsRr8Ko
X-Gm-Gg: Acq92OFeOOaNOqykDB8OorAonPzzLXcQWSI2Bo7oGpUkVwQ4b834hfUlqkji3lUBNMD
	qQLZZSLTgnmqz3bgsWBr0fT98HwlMybaie25BrLxM65jsjRoBlMGGKZ+ij0F+X7vnSFU/dN9Cv4
	L3BhrFPYKVWFYNsY81Y/RX4moVwxsmC5lBsubET1ZqS/sP4yrFrxBIWAnmZJJ9a6LgDt6/EOSAk
	xV63yTRfkaDdor2ttmDr73iBBG760mcejZF5/lQCv+e5PrX7VafTiuxZPItDI/kG65lDO56tCQG
	n3FRvzsBnvBRQu/XoX1CwtOHLXwSDMWgof8NgYaAJfv83diBOOCt+NbS3KpqQ5rGf8OrxbyK9og
	cuC/5YUobCFz6GYBaOzrn+ssufzpJ/DnI83/FD4RMDip2mvaIjlHtIi36F2SbNu9YCGcSTfU2P2
	jzbvEyGLZf/Gn2KtMAKRZgBijSm5ghTRE3ktAx
X-Received: by 2002:a17:907:c248:b0:bcd:bd6:94d with SMTP id a640c23a62f3a-bd5177f054cmr339619166b.20.1778881096777;
        Fri, 15 May 2026 14:38:16 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:690:4aa1:581c:2e09])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm2484038a12.11.2026.05.15.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:38:15 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v2 4/5] mmc-utils: lsmmc: Add mmc list command
Date: Fri, 15 May 2026 23:37:46 +0200
Message-ID: <20260515213747.1452692-5-torsteine+linux@gmail.com>
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
 docs/HOWTO.rst | 12 ++++++++++++
 lsmmc.c        | 34 +++++++++++++++++++++++++++++++++-
 mmc.c          |  6 +++++-
 mmc_cmds.h     |  1 +
 4 files changed, 51 insertions(+), 2 deletions(-)

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
index 58d4609..0458d1b 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -225,6 +225,39 @@ static char *get_manufacturer(struct config *config, unsigned int manid)
 	return NULL;
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
@@ -2335,7 +2368,6 @@ int do_list(int nargs, char **argv)
 	return 0;
 }
 
-
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

