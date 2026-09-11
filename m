Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com [45.254.49.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCDC43304D
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109488; cv=none; b=FZpT8RdfbjzyJ0JgqqRF8Sy0VwfbOzH2/RLlfhJpidvPhgmubzCSNb3x1pU96iw8W8ZH/ekTePBPwm7+IfcYufFHzQodrvFO9V8DYolPhNWmiPvJxnJUD8egN2eA6YXrLzIlR3xL2Pcsr2VToMEqULJrI3rytVeuGU7GULoQM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109488; c=relaxed/simple;
	bh=LB/ErzN93M9kUje1WfiwRrOOdfFZsfZirjLbqS6/syY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rrHE4kQKsgZtk/bEqojxJf8KHRFsejwcQPyg42kJOnvlf+oDFGO+P22VeqaSFhJFS6xtJgNYVC8aJgEWH/mN8V6WTeypKQDUu7XSjfRRXodM90XWHZBWc3vFY2D3s1FZNu3/CBxP2A4QGNaDSQL2UL4qPs6UBSgMpJPgyrhW6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dotfQiqA; arc=none smtp.client-ip=45.254.49.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dotfQiqA"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d64b96b0;
	Fri, 11 Sep 2026 14:45:56 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [RFC PATCH 2/4] mmc-utils: lsmmc: Add SDIO device support to the list command
Date: Fri, 11 Sep 2026 14:44:54 +0800
Message-Id: <1789109096-196082-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa08f373b9c03a4kunma7c49b4e5df282
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGhhMVh0ZT0NPS0xISUlKGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dotfQiqACOUVJ5VPTYxRFrKoeWuvPYIOqi6AR+p37uB9EHYTa8MZDqJ8xoaXcUsfGry/SFfBKVd4PrFEG4ZWetAYQ9Wxpwh22RclRm1UVpfTWj/kkSQWxFGOGiexeJ61yvDrYtetCEU9ljEvTcuFpjHUHuAYnFtR6XYstTK2fN0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=MJt0uUAmDzgknP2UyLoANI3vrwrX1YqwWJ2WAXyONK8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Teach the list command about SDIO cards: devices whose sysfs type is
"SDIO" are enumerated one row per function, reading the function
vendor/device/class/revision ids from the card's sysfs directory and
decoding vendor, device and interface class names from a new sdio.ids
database (the SDIO counterpart of pci.ids, installed alongside the
existing multimediacard.ids/sdcard.ids files).

Standalone SDIO enumeration tooling already exists: the lssdio script
of the sdioutils project, announced on linux-mmc at
https://lore.kernel.org/linux-mmc/20230214195702.ungo5roxliq7pjas@pali/
and also the origin of the sdio.ids database imported here. However,
lssdio is a standalone perl script, and SDIO devices are massively
deployed in lightweight IoT embedded systems where a perl runtime
costs 10-20MB of storage - a non-starter there.

Moreover, the userspace tooling of a subsystem is usually unified:
lsusb for USB, lspci for PCI. Devices based on the mmc subsystem
already have their MMC and SD cards supported by mmc-utils, so
continuing to support SDIO enumeration in the existing list command
is the natural home for it.

The table gains a CLASS column: for SDIO functions it shows the
interface class declared in the function's CIS, decoded through the
sdio.ids database (e.g. "WLAN"); the non-standard class 0x00 is shown
as-is, and MMC/SD cards do not have an interface class and show "-".
Pure SDIO cards do not have a block device, so the DEV column shows
"-" for them. Functions whose ids are missing from the sdio.ids
database are reported as Unlisted(0x<device id>), so unknown devices
are still identifiable and can be submitted to the sdioids database.

sdio.ids is imported from the sdioids repository
(https://github.com/sdioutils/sdioids), version 2026.08.10.

Example output on a board with a Realtek RTL8723BS wireless module
(and a second, yet unlisted function):

  # mmc list
  DEVICE         DEV                 TYPE  MANUFACTURER                PRODUCT                                  REV   CLASS  SERIAL  DATE
  mmc0:0001:1    /dev/mmc0:0001:1    SDIO  Realtek Semiconductor Corp. RTL8723BS [Rockchip] (WiFi 802.11b/g/n)  FF    WLAN   -       -
  mmc0:0001:2    /dev/mmc0:0001:2    SDIO  Realtek Semiconductor Corp. Unlisted(0xc822)                         FF    00     -       -

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---
 Makefile       |   4 +-
 docs/HOWTO.rst |   9 +-
 lsmmc.c        | 273 ++++++++++++++++++++++++++++++++++++++++++++++---
 sdio.ids       | 206 +++++++++++++++++++++++++++++++++++++
 4 files changed, 475 insertions(+), 17 deletions(-)
 create mode 100644 sdio.ids

diff --git a/Makefile b/Makefile
index 6eb584b..1cc24b7 100644
--- a/Makefile
+++ b/Makefile
@@ -5,7 +5,8 @@ GIT_VERSION := "$(shell git describe --abbrev=0 --tags)-$$(git rev-list --count
 AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 \
 	    -DVERSION=\"$(GIT_VERSION)\" \
 	    -DSD_IDS_PATH=\"$(idsdir)/sdcard.ids\" \
-	    -DMMC_IDS_PATH=\"$(idsdir)/multimediacard.ids\"
+	    -DMMC_IDS_PATH=\"$(idsdir)/multimediacard.ids\" \
+	    -DSDIO_IDS_PATH=\"$(idsdir)/sdio.ids\"
 CFLAGS ?= -g -O2
 bashcompletiondir ?= /usr/share/bash-completion/completions
 objects = \
@@ -64,6 +65,7 @@ install: $(progs)
 	$(INSTALL) -m755 -d $(DESTDIR)$(idsdir)
 	$(INSTALL) -m 644 sdcard.ids $(DESTDIR)$(idsdir)
 	$(INSTALL) -m 644 multimediacard.ids $(DESTDIR)$(idsdir)
+	$(INSTALL) -m 644 sdio.ids $(DESTDIR)$(idsdir)
 	$(INSTALL) -m755 -d $(DESTDIR)$(bashcompletiondir)
 	$(INSTALL) -m 644 completion/mmc $(DESTDIR)$(bashcompletiondir)/mmc
 
diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 3518b0f..c4709d7 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -115,9 +115,12 @@ Running mmc-utils
             Life time type B: 0x01 [0%-10% of device life time used]
 
     ``list``
-        List all MMC/SD devices present on the system. Output is a table with
-        columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC or SD),
-        MANUFACTURER, PRODUCT, REV, SERIAL, and DATE.
+        List all MMC/SD/SDIO devices present on the system. Output is a table with
+        columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC, SD or SDIO),
+        MANUFACTURER, PRODUCT, REV, CLASS (SDIO interface class, decoded from the
+        sdio.ids database), SERIAL, and DATE. SDIO cards are listed
+        one row per function, with names decoded from the sdio.ids database,
+        and do not have a DEV path unless the card also provides memory.
 
         Example::
 
diff --git a/lsmmc.c b/lsmmc.c
index 4167095..6ea43d3 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -63,10 +63,14 @@
 #ifndef MMC_IDS_PATH
 #define MMC_IDS_PATH "/usr/share/misc/multimediacard.ids"
 #endif
+#ifndef SDIO_IDS_PATH
+#define SDIO_IDS_PATH "/usr/share/misc/sdio.ids"
+#endif
 
 enum bus_type {
 	MMC = 1,
 	SD,
+	SDIO,
 };
 
 struct config {
@@ -229,6 +233,230 @@ fallback:
 	return strdup(name);
 }
 
+/*
+ * Look up a name in an sdio.ids style database:
+ *
+ *   <vid4hex><2sp><vendor name>
+ *   \t<did4hex><2sp><device name>   (scoped to the vendor line above)
+ *   C <cls2hex><2sp><class name>
+ *
+ * @vid/@did/@cls are lowercase hex strings without the 0x prefix. For a
+ * device lookup both @vid and @did are used; for a class lookup only
+ * @cls. Returns a strdup'ed name or NULL if not found.
+ */
+static char *sdio_ids_lookup(const char *path, const char *vid,
+			     const char *did, const char *cls)
+{
+	char line[256], cur_vid[5] = "";
+	bool vendor_found = false;
+	char *name = NULL;
+	FILE *f;
+
+	if (!vid && !cls)
+		return NULL;
+
+	f = fopen(path, "r");
+	if (!f)
+		return NULL;
+
+	while (!name && fgets(line, sizeof(line), f)) {
+		char *p = line;
+
+		line[strcspn(line, "\r\n")] = '\0';
+
+		if (*p == '#' || !*p)
+			continue;
+
+		/* class line: "C <cls2hex>  <name>" */
+		if (cls && p[0] == 'C' && isspace((unsigned char)p[1])) {
+			p++;
+			while (isspace((unsigned char)*p))
+				p++;
+
+			if (isxdigit((unsigned char)p[0]) &&
+			    isxdigit((unsigned char)p[1]) &&
+			    !strncasecmp(p, cls, 2)) {
+				p += 2;
+				while (isspace((unsigned char)*p))
+					p++;
+				if (*p)
+					name = strdup(p);
+			}
+			continue;
+		}
+
+		/* vendor line: "<vid4hex>  <name>" */
+		if (vid && isxdigit((unsigned char)p[0]) &&
+		    isxdigit((unsigned char)p[1]) &&
+		    isxdigit((unsigned char)p[2]) &&
+		    isxdigit((unsigned char)p[3]) &&
+		    p[4] == ' ' && p[5] == ' ') {
+			memcpy(cur_vid, p, 4);
+			cur_vid[4] = '\0';
+			vendor_found = !strcasecmp(cur_vid, vid);
+			if (vendor_found && !did) {
+				p += 6;
+				while (*p == ' ')
+					p++;
+				if (*p)
+					name = strdup(p);
+			}
+			continue;
+		}
+
+		/* device line: "\t<did4hex>  <name>", scoped to the vendor above */
+		if (vid && did && vendor_found && p[0] == '\t' &&
+		    isxdigit((unsigned char)p[1]) &&
+		    isxdigit((unsigned char)p[2]) &&
+		    isxdigit((unsigned char)p[3]) &&
+		    isxdigit((unsigned char)p[4]) && p[5] == ' ' &&
+		    p[6] == ' ') {
+			char id[5];
+
+			memcpy(id, p + 1, 4);
+			id[4] = '\0';
+			if (!strcasecmp(id, did)) {
+				p += 7;
+				while (*p == ' ')
+					p++;
+				if (*p)
+					name = strdup(p);
+			}
+		}
+	}
+
+	fclose(f);
+	return name;
+}
+
+static char *get_sdio_ids_name(const char *vid, const char *did,
+			       const char *cls)
+{
+	static bool warned;
+	FILE *f;
+
+	f = fopen("sdio.ids", "r");
+	if (f) {
+		fclose(f);
+		return sdio_ids_lookup("sdio.ids", vid, did, cls);
+	}
+
+	f = fopen(SDIO_IDS_PATH, "r");
+	if (f) {
+		fclose(f);
+		return sdio_ids_lookup(SDIO_IDS_PATH, vid, did, cls);
+	}
+
+	if (!warned) {
+		fprintf(stderr, "Warning: sdio.ids not found (./sdio.ids or %s)\n",
+			SDIO_IDS_PATH);
+		warned = true;
+	}
+
+	return NULL;
+}
+
+/* Copy a sysfs hex id (e.g. "0x0092") into a lowercase hex string. */
+static void sdio_hex_id(const char *val, char *out, size_t outsz)
+{
+	const char *p = val;
+	size_t i;
+
+	if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X'))
+		p += 2;
+
+	for (i = 0; p[i] && i + 1 < outsz; i++)
+		out[i] = tolower((unsigned char)p[i]);
+	out[i] = '\0';
+}
+
+static char *read_file_at(const char *dir, const char *name);
+
+static void print_sdio_functions(const char *devname,
+				 const char *blkdev, const char *cardpath)
+{
+	char devnode[32];
+	DIR *d;
+	struct dirent *ent;
+
+	snprintf(devnode, sizeof(devnode), "/dev/%s", blkdev ? blkdev : "-");
+
+	d = opendir(cardpath);
+	if (!d)
+		return;
+
+	while ((ent = readdir(d)) != NULL) {
+		char funcdir[PATH_MAX + 256];
+		char vid[8], did[8], cls[8], clsbuf[24];
+		char *vendor, *device, *class, *revision;
+		char *vname, *dname, *cname, *product = NULL;
+		size_t len = strlen(devname);
+
+		if (strncmp(ent->d_name, devname, len) ||
+		    ent->d_name[len] != ':' ||
+		    !isdigit((unsigned char)ent->d_name[len + 1]))
+			continue;
+
+		snprintf(funcdir, sizeof(funcdir), "%s/%s",
+			 cardpath, ent->d_name);
+
+		vendor = read_file_at(funcdir, "vendor");
+		device = read_file_at(funcdir, "device");
+		class = read_file_at(funcdir, "class");
+		revision = read_file_at(funcdir, "revision");
+
+		if (!vendor || !device) {
+			free(vendor);
+			free(device);
+			free(class);
+			free(revision);
+			continue;
+		}
+
+		sdio_hex_id(vendor, vid, sizeof(vid));
+		sdio_hex_id(device, did, sizeof(did));
+		sdio_hex_id(class ? class : "0x00", cls, sizeof(cls));
+
+		vname = get_sdio_ids_name(vid, NULL, NULL);
+		dname = get_sdio_ids_name(vid, did, NULL);
+		cname = get_sdio_ids_name(NULL, NULL, cls);
+
+		/*
+		 * Product name: the device name from the sdio.ids
+		 * database, or the raw device id when it is not listed.
+		 */
+		if (dname) {
+			product = dname;
+			dname = NULL;
+		} else {
+			product = malloc(strlen(did) + 16);
+			if (product)
+				snprintf(product, strlen(did) + 16,
+					 "Unlisted(0x%s)", did);
+		}
+
+		/* Class name from the database, or the raw class id */
+		snprintf(clsbuf, sizeof(clsbuf), "%s",
+			 cname ? cname : cls);
+
+		printf("%-14s %-14s %-5s %-20s %-32s %-5s %-20s %-12s %s\n",
+		       ent->d_name, devnode, "SDIO", vname ? vname : "Unlisted",
+		       product ? product : "Unlisted",
+		       revision ? revision : "-", clsbuf, "-", "-");
+
+		free(product);
+		free(cname);
+		free(dname);
+		free(vname);
+		free(revision);
+		free(class);
+		free(device);
+		free(vendor);
+	}
+
+	closedir(d);
+}
+
 static char *find_block_devname(const char *sysfs_devpath)
 {
 	DIR *d;
@@ -2335,18 +2563,18 @@ static void print_list_entry(struct config *cfg, const char *devname,
 
 		parse_sd_cid(cid, &c);
 		mfr = get_manufacturer(cfg, c.mid);
-		printf("%-14s %-14s SD   %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		printf("%-14s %-14s SD   %-20s %-32s %u.%u %-20s 0x%08x %u-%s\n",
 		       devname, devnode, mfr ? mfr : "Unlisted", c.pnm,
-		       c.prv_major, c.prv_minor, c.psn, sd_cid_year(&c),
+		       c.prv_major, c.prv_minor, "-", c.psn, sd_cid_year(&c),
 		       month_name(c.mdt_month));
 	} else {
 		struct mmc_cid c;
 
 		parse_mmc_cid(cid, &c);
 		mfr = get_manufacturer(cfg, c.mid);
-		printf("%-14s %-14s MMC  %-20s %-10s %u.%u  0x%08x  %u-%s\n",
+		printf("%-14s %-14s MMC  %-20s %-32s %u.%u %-20s 0x%08x %u-%s\n",
 		       devname, devnode, mfr ? mfr : "Unlisted", c.pnm,
-		       c.prv_major, c.prv_minor, c.psn,
+		       c.prv_major, c.prv_minor, "-", c.psn,
 		       mmc_cid_year(&c, cfg->ext_csd_rev),
 		       month_name(c.mdt_month));
 	}
@@ -2374,6 +2602,7 @@ int do_list(int nargs, char **argv)
 	free(get_manufacturer(&cfg, ~0u));
 	cfg.bus = MMC;
 	free(get_manufacturer(&cfg, ~0u));
+	free(get_sdio_ids_name("ffff", NULL, NULL));
 
 	while ((ent = readdir(d)) != NULL) {
 		char devpath[PATH_MAX];
@@ -2391,27 +2620,45 @@ int do_list(int nargs, char **argv)
 		if (!type)
 			continue;
 
-		if (strcmp(type, "MMC") != 0 && strcmp(type, "SD") != 0) {
+		if (strcmp(type, "MMC") != 0 && strcmp(type, "SD") != 0 &&
+		    strcmp(type, "SDIO") != 0) {
+			free(type);
+			continue;
+		}
+
+		blkdev = find_block_devname(resolved);
+
+		if (!header_printed) {
+			printf("%-14s %-14s %-5s %-20s %-32s %-5s %-20s %-12s %s\n",
+			       "DEVICE", "DEV", "TYPE", "MANUFACTURER", "PRODUCT",
+			       "REV", "CLASS", "SERIAL", "DATE");
+			header_printed = true;
+		}
+
+		if (!strcmp(type, "SDIO")) {
+			/*
+			 * SDIO cards carry no CID; their functions are
+			 * enumerated from the card's sysfs directory and
+			 * printed one row per function. Pure SDIO cards
+			 * do not have a block device either.
+			 */
+			print_sdio_functions(ent->d_name, blkdev,
+					     resolved);
+
+			free(blkdev);
 			free(type);
 			continue;
 		}
 
 		cid = read_file_at(resolved, "cid");
 		if (!cid) {
+			free(blkdev);
 			free(type);
 			continue;
 		}
 
-		blkdev = find_block_devname(resolved);
 		cfg.bus = strcmp(type, "MMC") ? SD : MMC;
 
-		if (!header_printed) {
-			printf("%-14s %-14s %-5s%-20s %-10s %-5s %-12s %s\n",
-			       "DEVICE", "DEV", "TYPE", "MANUFACTURER", "PRODUCT",
-			       "REV", "SERIAL", "DATE");
-			header_printed = true;
-		}
-
 		print_list_entry(&cfg, ent->d_name, blkdev, cid);
 
 		free(blkdev);
diff --git a/sdio.ids b/sdio.ids
new file mode 100644
index 0000000..671c3d6
--- /dev/null
+++ b/sdio.ids
@@ -0,0 +1,206 @@
+#
+#	List of SDIO ID's
+#
+#	Version: 2026.08.10
+#	Date:    2026-08-10 01:54:06
+#
+#	Maintained by volunteers of the SDIO ID Project at
+#	https://sdioutils.github.io/sdioids/.
+#
+#	New data are always welcome, especially if they are accurate. If you
+#	have anything to contribute, please submit it through the web site
+#	above, which turns your submission into a pull request.
+#
+#	This file can be distributed under either the GNU General Public License
+#	(version 2 or higher) or the 3-clause BSD License.
+#
+#	The database is a compilation of factual data, and as such the copyright
+#	only covers the aggregation and formatting. The copyright is held by
+#	its contributors.
+#
+
+# Vendors and devices. Please keep sorted.
+
+# Syntax:
+# vendor  vendor_name
+# 	device  chip_vendor_name chip_name [marketing_name] (type)	<- single tab
+
+# SDIO vendor IDs 0000-00ff match one-byte JEDEC IDs assigned by JEDEC publication 106
+
+0020  STMicroelectronics
+	2280  CW1200 (WiFi 802.11a/b/g/n)
+0023  Wafer Scale Integration, Inc.
+	7910  KeyStream KS7010 (WiFi 802.11b/g)
+005b  Kawasaki Steel Corp.
+	7910  KeyStream KS7010 (WiFi 802.11b/g)
+0089  Intel Corp.
+	1402  IWMC3200 [Multicomm 3200 Evans Peak] (WiMAX)
+	1403  IWMC3200 [Multicomm 3200 Evans Peak] (WiFi 802.11a/b/g/n)
+	1404  IWMC3200 [Multicomm 3200 Evans Peak]
+	1405  IWMC3200 [Multicomm 3200 Evans Peak] (GPS)
+	1406  IWMC3200 [Multicomm 3200 Evans Peak] (Bluetooth 2.1)
+	1407  IWMC3200 [Multicomm 3200 Evans Peak] (WiMAX 2.5GHz)
+0092  C-guys, Inc.
+	0001  Texas Instruments, Inc. ACX100 [SD-Link11b] (WiFi 802.11b)
+	0004  Broadcom Corp. BCM4318 [EW-CG1102GC] (WiFi 802.11a/b/g)
+	0005  [SD-Radio2] (FM Radio)
+	5544  [SD-Radio] (FM Radio)
+0097  Texas Instruments, Inc.
+	4076  WL1271 [WiLink 6.0] (WiFi 802.11b/g/n)
+0098  Toshiba Corp.
+	0001  SD-BT00 (Bluetooth 1.0b)
+	0002  PA3271U [SD Card2] (Bluetooth 1.1)
+	0003  PA3370U [SD Card3] (Bluetooth 1.2)
+
+# SDIO vendor IDs 0100-ffff match PCMCIA vendor IDs managed and assigned by USB-IF
+
+0104  Socket Communications, Inc.
+	005e  IS5300/8510-00209 [SDIO In-Hand Scan Card] (Barcode Scanner)
+	00c5  Toshiba Corp. BL4800 [Bluetooth SDIO Connection Kit] (Bluetooth 1.1)
+024c  Realtek Semiconductor Corp.
+	0240  RTL8723BS [Bestbuy] (WiFi 802.11b/g/n)
+	0241  RTL8723BS [Bestbuy] (WiFi 802.11b/g/n)
+	0523  RTL8723BS [HP] (WiFi 802.11b/g/n)
+	0524  RTL8723BS [ECS] (WiFi 802.11b/g/n)
+	0525  RTL8723BS [TCL] (WiFi 802.11b/g/n)
+	0623  RTL8723BS [Acer] (WiFi 802.11b/g/n)
+	0624  RTL8723BS [Reserved] (WiFi 802.11b/g/n)
+	0625  RTL8723BS [Rockchip] (WiFi 802.11b/g/n)
+	0626  RTL8723BS [Braswell] (WiFi 802.11b/g/n)
+	0627  RTL8723BS [Acer] (WiFi 802.11b/g/n)
+	8753  RTL8723BS [Common] (WiFi 802.11b/g/n)
+	b723  RTL8723BS [Common] (WiFi 802.11b/g/n)
+	b821  RTL8821BS (WiFi 802.11a/b/g/n/ac)
+	b822  RTL8822BS (WiFi 802.11a/b/g/n/ac)
+	c821  RTL8821CS (WiFi 802.11a/b/g/n/ac)
+	c822  RTL8822CS (WiFi 802.11a/b/g/n/ac)
+	d723  RTL8723DS (WiFi 802.11b/g/n)
+	d724  RTL8723DS (WiFi 802.11b/g/n)
+	d821  RTL8821DS (WiFi 802.11a/b/g/n/ac)
+0271  Atheros Communications, Inc.
+	0108  AR6001 (WiFi 802.11a/b/g)
+	0109  AR6001 (WiFi 802.11a/b/g)
+	010a  AR6001 (WiFi 802.11a/b/g)
+	010b  AR6001 (WiFi 802.11a/b/g)
+	0200  AR6002 (WiFi 802.11a/b/g)
+	0201  AR6002 (WiFi 802.11a/b/g)
+	0300  AR6003 (WiFi 802.11a/b/g/n)
+	0301  AR6003 (WiFi 802.11a/b/g/n)
+	0400  AR6004 (WiFi 802.11a/b/g/n)
+	0401  AR6004 (WiFi 802.11a/b/g/n)
+	0402  AR6004 (WiFi 802.11a/b/g/n)
+	0403  AR6004 (WiFi 802.11a/b/g/n)
+	0411  AR6004 (WiFi 802.11a/b/g/n)
+	0418  AR6004 (WiFi 802.11a/b/g/n)
+	0419  AR6004 (WiFi 802.11a/b/g/n)
+	050a  AR6005 (WiFi 802.11b/g/n)
+	0701  QCA9377 [Tufello] (WiFi 802.11a/b/g/n/ac)
+0296  Palm, Inc.
+	5347  Arasan AC21C00/AC2200/AC2600 [SDIO-UART bridge] (UART)
+02d0  Broadcom Corp.
+	044b  BCM4318 (WiFi 802.11a/b/g)
+	4324  BCM43241 (WiFi 802.11a/b/g/n)
+	4329  BCM4329 (WiFi 802.11a/b/g/n)
+	4330  BCM4330 (WiFi 802.11a/b/g/n)
+	4334  BCM4334 (WiFi 802.11a/b/g/n)
+	4335  BCM4335/BCM4339 (WiFi 802.11a/b/g/n/ac)
+	4339  BCM4339 (WiFi 802.11a/b/g/n/ac)
+	4345  BCM4345 (WiFi 802.11a/b/g/n/ac)
+	4354  BCM4354 (WiFi 802.11a/b/g/n/ac)
+	4355  Cypress CYW89359 (WiFi 802.11a/b/g/n/ac)
+	4356  BCM4356 (WiFi 802.11a/b/g/n/ac)
+	4359  BCM4359 (WiFi 802.11a/b/g/n/ac)
+	4373  Cypress CYW4373 (WiFi 802.11a/b/g/n/ac)
+	a804  Cypress CYW43012 (WiFi 802.11a/b/g/n)
+	a887  BCM43143 (WiFi 802.11b/g/n)
+	a94c  BCM43340 (WiFi 802.11a/b/g/n)
+	a94d  BCM43341 (WiFi 802.11a/b/g/n)
+	a962  BCM43362 (WiFi 802.11b/g/n)
+	a9a4  BCM43364 (WiFi 802.11b/g/n)
+	a9a6  BCM43438 (WiFi 802.11b/g/n)
+	a9bf  BCM43455 (WiFi 802.11a/b/g/n/ac)
+02db  SyChip Inc.
+	0002  WLAN6060SD [Pegasus] (WiFi 802.11b)
+02df  Marvell Semiconductor Inc.
+	9103  88W8385/88W8686 [Libertas] (WiFi 802.11b/g)
+	9104  88W8688 [Libertas] (WiFi 802.11a/b/g)
+	9105  88W8688 [Libertas] (Bluetooth 3.0)
+	9116  88W8786 [Avastar 8700] (WiFi 802.11a/b/g/n)
+	9119  88W8787 [Avastar 8700] (WiFi 802.11a/b/g/n)
+	911a  88W8787 [Avastar 8700] (Bluetooth 4.0)
+	911b  88W8787 [Avastar 8700] (Bluetooth AMP)
+	9128  88W8797 [Avastar 8700]
+	9129  88W8797 [Avastar 8700] (WiFi 802.11a/b/g/n)
+	912a  88W8797 [Avastar 8700] (Bluetooth 4.0)
+	912c  88W8897 [Avastar 8800]
+	912d  88W8897 [Avastar 8800] (WiFi 802.11a/b/g/n/ac)
+	912e  88W8897 [Avastar 8800] (Bluetooth 4.1)
+	9134  88W8887 [Avastar 8800]
+	9135  88W8887 [Avastar 8800] (WiFi 802.11a/b/g/n/ac)
+	9136  88W8887 [Avastar 8800] (Bluetooth 4.1)
+	9139  88W8801 [Avastar 8800] (WiFi 802.11b/g/n)
+	9140  88W8997 [Avastar 8900]
+	9141  88W8997 [Avastar 8900] (WiFi 802.11a/b/g/n/ac)
+	9142  88W8997 [Avastar 8900] (Bluetooth 4.2)
+	9144  88W8977 [Avastar 8900]
+	9145  88W8977 [Avastar 8900] (WiFi 802.11a/b/g/n)
+	9146  88W8977 [Avastar 8900] (Bluetooth 4.2)
+	9148  88W8987 [Avastar 8900]
+	9149  88W8987 [Avastar 8900] (WiFi 802.11a/b/g/n/ac)
+	914a  88W8987 [Avastar 8900] (Bluetooth 4.2)
+02fe  Inprocomm, Inc.
+	2128  IPN2128 (WiFi 802.11b)
+032a  Cambridge Silicon Radio Ltd.
+	0001  UF1050 [UniFi-1] (WiFi 802.11b/g)
+	0002  UF2000 [UniFi-2] (WiFi 802.11b/g)
+	0007  UF6026/UF6027/UF6028 [UniFi-3] (WiFi 802.11b/g/n)
+	0008  CSR6030 [UniFi-4] (WiFi 802.11b/g/n)
+037a  MediaTek Inc.
+	5911  MT5911N (WiFi 802.11b/g)
+	6602  MT6632 (WiFi 802.11a/b/g/n/ac)
+	6632  MT6632 (Bluetooth 4.1)
+	7603  MT7663 (WiFi 802.11a/b/g/n/ac)
+	7608  MT7668 (WiFi 802.11a/b/g/n/ac)
+	7663  MT7663 (Bluetooth 5.0)
+	7668  MT7668 (Bluetooth 5.0)
+	7901  MT7921 (WiFi 802.11a/b/g/n/ac/ax)
+	7961  MT7921 (Bluetooth 5.0)
+039a  Siano Mobile Silicon
+	0201  SMS1140 [Nova B] (Digital TV Receiver)
+	0202  SMS1140 [Nice] (Digital TV Receiver)
+	0300  SMS1xxx [Vega] (Digital TV Receiver)
+	0301  SMS1xxx [Venice] (Digital TV Receiver)
+	0302  SMS1xxx [Ming] (Digital TV Receiver)
+	0500  SMS1xxx [Pele] (Digital TV Receiver)
+	0600  SMS2270 [Rio] (Digital TV Receiver)
+	0700  SMS2160 [Denver T-DMB] (Digital TV Receiver)
+	0800  SMS1530 [Denver ATSC-M/H] (Digital TV Receiver)
+	1100  SMS1xxx [Nova A] (Digital TV Receiver)
+	5347  SMS1xxx [Stellar] (Digital TV Receiver)
+041b  Redpine Signals, Inc.
+	9113  RS9113 (WiFi 802.11a/b/g/n)
+	9116  RS9116 (WiFi 802.11a/b/g/n)
+0501  Globalsat Technology Co.
+	f501  [SD-501] (GPS)
+104c  Texas Instruments, Inc.
+	9066  WL1251 [WiLink 4.0] (WiFi 802.11b/g)
+13d1  AboCom Systems, Inc.
+	ac02  MediaTek Inc. MT5911N [SDW11G] (WiFi 802.11b/g)
+
+# List of known interface classes
+#
+# Syntax:
+# C class  class_name
+
+# The SDIO Standard Function code defined by SDIO specification, section 6.10 Function Basic Registers and addendums
+
+# C 00  None
+C 01  UART
+C 02  Bluetooth Type-A
+C 03  Bluetooth Type-B
+C 04  GPS
+C 05  Camera
+C 06  PHS
+C 07  WLAN
+C 08  ATA
+C 09  Bluetooth Type-A AMP
-- 
2.25.1

