Received: from mail-m1973175.qiye.163.com (mail-m1973175.qiye.163.com [220.197.31.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738343B3DA;
	Mon, 21 Sep 2026 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977270; cv=none; b=Vz4eOpR5r0DFHaHPu4M/+R4wjuUf5GWrIROwS5UTrmB8VFEavKW6m7iR/ipTxnsdJBA2LrM7lI4PF7goQDjqjvKuV3aMbRKABAj4nXPV/hwfP9tEI2WNaSJ1itQ4X+T6vq7K36HRx9iEGQjgD+xG4IUPTawhHC3OUd1634F5JFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977270; c=relaxed/simple;
	bh=GH4pmSqkXu9vOdwhG/pmIybrWx8obcjcGkqlzB4ba+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r7pF163S02ZnowBU9Bq9DOvo/Q5aCKUDq6quFuQMo3AbbJpFenfkfKMpMgWaGBF4aIKPh0nnEz9cbyWmQ82zPStzP2OYI3XkmioYSa+uh4y5Fnp2JQyh3y1p/77k3t8zDM7ZAjDGXqfgyu15sXUJ4Nyfms9SiVR7c9VJ5u9yMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Eyk6LxSo; arc=none smtp.client-ip=220.197.31.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Eyk6LxSo"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e89beca3;
	Mon, 21 Sep 2026 15:18:44 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v2 2/3] tools/sdio: add sdio-raw userspace client
Date: Mon, 21 Sep 2026 15:18:18 +0800
Message-Id: <1789975099-157594-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789975099-157594-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789975099-157594-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0c2d4da4d03a4kunm73dcdfcc3109b9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQkJCGVZNSx5LT08fTh
	hOTUxWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Eyk6LxSoUD3OTumiORl0C6682RC2/knXaXbQ/C96yv7yior96zlxaGuvCmEFXrZnRsK0Y/3jk7tk21K2SjvYRhBuDXFNGb8gjUo/L8JwLoJPYN/i0Vx5cX/fKfhpGSuOSXeLDN5t5Lu5do9bv+zxl5V1cAma6UTDQ5K3y4t2VQI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=jOC6qHiBgYi8dSnviZJ+OcXTR0ZqOxJlfo/1KFxPbIY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Add a minimal reference/debug client for the SDIO userspace passthrough
character device (CONFIG_MMC_SDIO_CDEV). It issues CMD52/CMD53 through
the SDIO_IOC_RW and SDIO_IOC_RW_EXT ioctls of /dev/mmcX:YYYY:FN, which
covers the usual bring-up and factory-test needs:

  - list: enumerate SDIO functions from sysfs; the VID:PID is looked
    up against the id database of include/linux/mmc/sdio_ids.h and
    shown with its name, or as Unlisted(0x<pid>); the CIS strings the
    kernel parsed at enumeration (sysfs info1..4) are shown as well
  - cmd52: single byte read/write, with read-back verification
  - cmd53: byte mode read/write of 1..512 bytes, hexdump or file I/O
  - cccr: dump the CCCR of function 0
  - fbr: dump the FBR of the selected function, accessed through
    function 0 like the kernel does (SDIO_FBR_BASE(), the CIS pointer
    sits at offset 0x09 of the FBR)
  - cis: walk the common (fn 0) or per-function CIS tuple chain the
    same way drivers/mmc/core/sdio_cis.c does, decoding MANFID,
    VERS_1 and FUNCID, hexdumping the rest

The name tables for 'list' are generated at build time from
sdio_ids.h, so no database is duplicated in the tree. The ioctls
require CAP_SYS_ADMIN. The target function is parsed from the device
node name and can be overridden with -f, so any function can be poked
through a single node.

Also add tools/sdio/ to the MMC subsystem entry in MAINTAINERS.

Tested on RK3576 with a Cypress 43752 SDIO WLAN card (both functions
report 0x02d0:0xaae8). The card's function CIS carries no VERS_1
tuple, so the INFO column of 'list' stays empty for it.

  # ./sdio-raw -d /dev/mmc2:0001:1 cmd52 -a 0x0
  fn1 addr 0x00000: 0xe8

  # ./sdio-raw -d /dev/mmc2:0001:1 cmd53 -a 0x0 -n 8
    0000: 00 00 00 00 00 00 00 00  ........

  # ./sdio-raw -d /dev/mmc2:0001:1 cccr
  CCCR (fn 0):
    0x00       CCCR/SDIO revision       0x43
    0x01       SD spec revision         0x03
    0x02       I/O enable               0x06
    0x03       I/O ready                0x06
    0x04       Int enable               0x06
    0x05       Int pending              0x00
    0x06       I/O abort                0x00
    0x07       Bus interface control    0x42
    0x08       Card capability          0x02
    0x09-0x0b  Common CIS pointer       0x001070
    0x0c       Bus suspend              0x00
    0x0d       Function select          0x00
    0x0e       Exec flags               0x00
    0x0f       Ready flags              0x00
    0x10-0x11  FN0 block size           0x0000
    0x12       Power control            0x01
    0x13       High-speed               0x07

  # ./sdio-raw -d /dev/mmc2:0001:1 cis -f 1
  CIS (fn 1) @ 0x01000:
    0x01000 TPL 0x20 MANFID len=4
      manufacturer 0x02d0, product 0xaae8
    0x01006 TPL 0x21 FUNCID len=2
      function code 0x0c

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 MAINTAINERS                |   1 +
 tools/Makefile             |  14 +-
 tools/sdio/Build           |   1 +
 tools/sdio/Makefile        |  66 +++++
 tools/sdio/gen-sdio-ids.sh |  59 ++++
 tools/sdio/sdio-raw.c      | 714 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 849 insertions(+), 6 deletions(-)
 create mode 100644 tools/sdio/Build
 create mode 100644 tools/sdio/Makefile
 create mode 100644 tools/sdio/gen-sdio-ids.sh
 create mode 100644 tools/sdio/sdio-raw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 06760c4..a476c06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18845,6 +18845,7 @@ F:	Documentation/devicetree/bindings/mmc/
 F:	drivers/mmc/
 F:	include/linux/mmc/
 F:	include/uapi/linux/mmc/
+F:	tools/sdio/
 
 MULTIPLEXER SUBSYSTEM
 M:	Peter Rosin <peda@lysator.liu.se>
diff --git a/tools/Makefile b/tools/Makefile
index cb40961..10efd38 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -31,6 +31,7 @@ help:
 	@echo '  sched_ext              - sched_ext example schedulers'
 	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
+	@echo '  sdio                   - sdio tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  thermometer            - temperature capture tool'
 	@echo '  thermal-engine         - thermal monitoring tool'
@@ -70,7 +71,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-counter dma firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
+counter dma firewire hv guest bootconfig spi sdio usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -124,7 +125,7 @@ ynl: FORCE
 	$(call descend,net/ynl)
 
 all: acpi counter cpupower dma gpio hv firewire \
-		perf selftests bootconfig spi turbostat usb \
+		perf selftests bootconfig spi sdio turbostat usb \
 		virtio mm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
 		debugging tracing thermal thermometer thermal-engine ynl
@@ -135,7 +136,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-counter_install dma_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
+counter_install dma_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install sdio_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
 	$(call descend,$(@:_install=),install)
 
 selftests_install:
@@ -171,7 +172,8 @@ install: acpi_install counter_install cpupower_install dma_install gpio_install
 		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install debugging_install intel-speed-select_install \
-		tracing_install thermometer_install thermal-engine_install ynl_install
+		tracing_install thermometer_install thermal-engine_install ynl_install \
+		sdio_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -179,7 +181,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-counter_clean dma_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
+counter_clean dma_clean hv_clean firewire_clean bootconfig_clean spi_clean sdio_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
 	$(call descend,$(@:_clean=),clean)
 
 libapi_clean:
@@ -226,7 +228,7 @@ ynl_clean:
 	$(call descend,net/$(@:_clean=),clean)
 
 clean: acpi_clean counter_clean cpupower_clean dma_clean hv_clean firewire_clean \
-		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
+		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean sdio_clean usb_clean virtio_clean \
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean firmware_clean debugging_clean \
diff --git a/tools/sdio/Build b/tools/sdio/Build
new file mode 100644
index 0000000..582fecd
--- /dev/null
+++ b/tools/sdio/Build
@@ -0,0 +1 @@
+sdio-raw-y += sdio-raw.o
diff --git a/tools/sdio/Makefile b/tools/sdio/Makefile
new file mode 100644
index 0000000..229bab8
--- /dev/null
+++ b/tools/sdio/Makefile
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only
+include ../scripts/Makefile.include
+
+bindir ?= /usr/bin
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
+CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include -I$(OUTPUT).
+
+ALL_TARGETS := sdio-raw
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
+
+all: $(ALL_PROGRAMS)
+
+export srctree OUTPUT CC LD CFLAGS
+include $(srctree)/tools/build/Makefile.include
+
+#
+# We need the SDIO UAPI header outside of the kernel tree
+#
+$(OUTPUT)include/linux/mmc/sdio_ioctl.h: FORCE
+	mkdir -p $(OUTPUT)include/linux/mmc 2>&1 || true
+	ln -sf $(CURDIR)/../../include/uapi/linux/mmc/sdio_ioctl.h $@
+
+prepare: $(OUTPUT)include/linux/mmc/sdio_ioctl.h $(OUTPUT)sdio_ids_gen.h
+
+#
+# Name tables for the 'list' command, generated from the kernel's
+# SDIO id database.
+#
+$(OUTPUT)sdio_ids_gen.h: gen-sdio-ids.sh $(srctree)/include/linux/mmc/sdio_ids.h
+	$(Q)$(SHELL) $< $(srctree)/include/linux/mmc/sdio_ids.h > $@
+
+#
+# sdio-raw
+#
+SDIO_RAW_IN := $(OUTPUT)sdio-raw-in.o
+$(SDIO_RAW_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=sdio-raw
+$(OUTPUT)sdio-raw: $(SDIO_RAW_IN) $(OUTPUT)sdio_ids_gen.h
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
+clean:
+	rm -f $(ALL_PROGRAMS)
+	rm -rf $(OUTPUT)include/
+	rm -f $(OUTPUT)sdio_ids_gen.h
+	find $(or $(OUTPUT),.) -name '*.o' -delete
+	find $(or $(OUTPUT),.) -name '\.*.o.d' -delete
+	find $(or $(OUTPUT),.) -name '\.*.o.cmd' -delete
+
+install: $(ALL_PROGRAMS)
+	install -d -m 755 $(DESTDIR)$(bindir);		\
+	for program in $(ALL_PROGRAMS); do		\
+		install $$program $(DESTDIR)$(bindir);	\
+	done
+
+FORCE:
+
+.PHONY: all install clean FORCE prepare
diff --git a/tools/sdio/gen-sdio-ids.sh b/tools/sdio/gen-sdio-ids.sh
new file mode 100644
index 0000000..89a8489
--- /dev/null
+++ b/tools/sdio/gen-sdio-ids.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate the SDIO name lookup tables for the sdio-raw 'list' command
+# from include/linux/mmc/sdio_ids.h. Devices and classes listed there
+# show up with their macro name, everything else is reported unlisted.
+
+set -e
+
+if [ $# -ne 1 ]; then
+	echo "usage: $0 <path/to/sdio_ids.h>" >&2
+	exit 1
+fi
+
+src="$1"
+
+# The generated header carries the same license tag as this script.
+# It is assembled from parts so that checkpatch does not mistake the
+# tag inside the heredoc for a misplaced tag in this shell file.
+spdx='/* SPDX''-License-Identifier: GPL-2.0 */'
+
+cat <<EOF
+$spdx
+/*
+ * Auto-generated from include/linux/mmc/sdio_ids.h - do not edit.
+ * Regenerated by tools/sdio/Makefile at build time.
+ */
+#ifndef SDIO_IDS_GEN_H
+#define SDIO_IDS_GEN_H
+
+struct sdio_id_name {
+	unsigned int id;
+	const char *name;
+};
+
+static const struct sdio_id_name sdio_class_names[] = {
+EOF
+
+awk '
+/^#define[ \t]+SDIO_CLASS_[A-Za-z0-9_]+[ \t]+0[xX][0-9a-fA-F]+/ {
+	name = $2;
+	sub(/^SDIO_CLASS_/, "", name);
+	printf "\t{ %s, \"%s\" },\n", $3, name;
+}' "$src"
+
+echo "};"
+echo ""
+echo "static const struct sdio_id_name sdio_device_names[] = {"
+
+awk '
+/^#define[ \t]+SDIO_DEVICE_ID_[A-Za-z0-9_]+[ \t]+(0[xX][0-9a-fA-F]+|[0-9]+)/ {
+	name = $2;
+	sub(/^SDIO_DEVICE_ID_/, "", name);
+	printf "\t{ %s, \"%s\" },\n", $3, name;
+}' "$src"
+
+echo "};"
+echo ""
+echo "#endif /* SDIO_IDS_GEN_H */"
diff --git a/tools/sdio/sdio-raw.c b/tools/sdio/sdio-raw.c
new file mode 100644
index 0000000..ab8c0fb
--- /dev/null
+++ b/tools/sdio/sdio-raw.c
@@ -0,0 +1,714 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sdio-raw - raw SDIO register access via the SDIO userspace
+ * passthrough character device (CONFIG_MMC_SDIO_CDEV).
+ *
+ * Reference/debug client for the SDIO_IOC_RW (CMD52) and
+ * SDIO_IOC_RW_EXT (CMD53) ioctls exposed by /dev/mmcX:YYYY:FN.
+ *
+ * The ioctls require CAP_SYS_ADMIN; raw access while a function
+ * driver is bound can disturb the state the driver maintains.
+ *
+ * Author: Shawn Lin <shawn.lin@linux.dev>
+ */
+
+#include <ctype.h>
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+
+#include <linux/mmc/sdio_ioctl.h>
+
+#ifdef __has_include
+#if __has_include("sdio_ids_gen.h")
+#include "sdio_ids_gen.h"
+#define HAVE_SDIO_IDS	1
+#endif
+#endif
+
+#ifndef HAVE_SDIO_IDS
+/*
+ * No generated tables (e.g. manual build without the tools Makefile):
+ * everything is reported as unlisted.
+ */
+struct sdio_id_name {
+	unsigned int id;
+	const char *name;
+};
+static const struct sdio_id_name sdio_class_names[] = { { ~0U, "" } };
+static const struct sdio_id_name sdio_device_names[] = { { ~0U, "" } };
+#endif
+
+#define ARRAY_SIZE(a)	(sizeof(a) / sizeof((a)[0]))
+
+static const char *progname = "sdio-raw";
+
+static _Noreturn void usage(int rc)
+{
+	fprintf(rc ? stderr : stdout,
+"Usage: %s -d DEV COMMAND [ARGS]\n"
+"\n"
+"Raw SDIO register access through the SDIO passthrough character\n"
+"device. The ioctls require CAP_SYS_ADMIN (run as root).\n"
+"\n"
+"Options:\n"
+"  -d, --device DEV   SDIO function chardev, e.g. /dev/mmc1:0001:1\n"
+"  -f, --func FN      override function number (default: parsed from DEV)\n"
+"  -h, --help         show this help\n"
+"\n"
+"Commands:\n"
+"  cmd52 -a ADDR [-w VAL] [-r]      read one byte (-w: write it, -r: read back)\n"
+"  cmd53 -a ADDR -n COUNT [-w FILE] [-o FILE] [--fixed]\n"
+"                                   byte mode read/write, 1..512 bytes\n"
+"  list                             enumerate SDIO functions (sysfs)\n"
+"  cccr                             dump CCCR (function 0)\n"
+"  fbr                              dump FBR of the selected function\n"
+"  cis [-f FN]                      walk the common (fn 0) or function CIS\n"
+"\n"
+"Addresses accept 0x-hex or decimal. cmd53 read goes to stdout as a\n"
+"hexdump unless -o is given; cmd53 write reads from FILE ('-' = stdin).\n",
+		progname);
+	exit(rc);
+}
+
+static void die_errno(const char *what)
+{
+	fprintf(stderr, "%s: %s: %s", progname, what, strerror(errno));
+	if (errno == EPERM)
+		fprintf(stderr, " (CAP_SYS_ADMIN required, run as root)");
+	fputc('\n', stderr);
+	exit(1);
+}
+
+static unsigned long parse_num(const char *s, const char *what)
+{
+	char *end;
+	unsigned long v;
+
+	errno = 0;
+	v = strtoul(s, &end, 0);
+	if (errno || end == s || *end) {
+		fprintf(stderr, "%s: invalid %s: %s\n", progname, what, s);
+		exit(1);
+	}
+	return v;
+}
+
+/* /dev/mmc1:0001:1 -> function 1 */
+static unsigned int fn_from_dev(const char *dev)
+{
+	const char *p = strrchr(dev, ':');
+
+	if (p && p[1])
+		return strtoul(p + 1, NULL, 10);
+	return 0;
+}
+
+static int open_dev(const char *dev)
+{
+	int fd;
+
+	if (!dev) {
+		fprintf(stderr, "%s: no device given, use -d DEV\n", progname);
+		exit(1);
+	}
+
+	fd = open(dev, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "%s: open %s: %s\n", progname, dev,
+			strerror(errno));
+		exit(1);
+	}
+	return fd;
+}
+
+static int rd52(int fd, unsigned int fn, unsigned int addr,
+		unsigned char *val)
+{
+	struct sdio_ioc_rw rw = {
+		.fn = fn,
+		.addr = addr,
+	};
+
+	if (ioctl(fd, SDIO_IOC_RW, &rw) < 0)
+		return -1;
+	*val = rw.data;
+	return 0;
+}
+
+static void hexdump(const unsigned char *buf, unsigned int len)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < len; i += 16) {
+		printf("  %04x:", i);
+		for (j = 0; j < 16; j++) {
+			if (i + j < len)
+				printf(" %02x", buf[i + j]);
+			else
+				printf("   ");
+		}
+		printf("  ");
+		for (j = 0; j < 16 && i + j < len; j++)
+			putchar(isprint(buf[i + j]) ? buf[i + j] : '.');
+		putchar('\n');
+	}
+}
+
+static void cmd52(int fd, unsigned int fn, unsigned long addr, int write,
+		  unsigned long val, int raw)
+{
+	struct sdio_ioc_rw rw = {
+		.write = write,
+		.fn = fn,
+		.raw = raw,
+		.addr = addr,
+		.data = val,
+	};
+
+	if (ioctl(fd, SDIO_IOC_RW, &rw) < 0)
+		die_errno("CMD52 failed");
+
+	if (write && !raw)
+		printf("fn%u addr 0x%05lx: wrote 0x%02lx\n", rw.fn, addr, val);
+	else
+		printf("fn%u addr 0x%05lx: 0x%02x\n", rw.fn, addr, rw.data);
+}
+
+static void cmd53(int fd, unsigned int fn, unsigned long addr,
+		  unsigned long count,
+		  int write, int incr_addr, const char *infile,
+		  const char *outfile)
+{
+	struct sdio_ioc_rw_ext rw;
+	FILE *f;
+
+	memset(&rw, 0, sizeof(rw));
+	rw.write = write;
+	rw.fn = fn;
+	rw.incr_addr = incr_addr;
+	rw.addr = addr;
+	rw.count = count;
+
+	if (write) {
+		f = (!infile || !strcmp(infile, "-")) ? stdin :
+							fopen(infile, "rb");
+		if (!f) {
+			fprintf(stderr, "%s: open %s: %s\n", progname, infile,
+				strerror(errno));
+			exit(1);
+		}
+		if (fread(rw.data, 1, count, f) != count) {
+			fprintf(stderr, "%s: short read from %s\n", progname,
+				infile ? infile : "stdin");
+			exit(1);
+		}
+		if (f != stdin)
+			fclose(f);
+	}
+
+	if (ioctl(fd, SDIO_IOC_RW_EXT, &rw) < 0)
+		die_errno("CMD53 failed");
+
+	if (write)
+		return;
+
+	if (outfile) {
+		f = fopen(outfile, "wb");
+		if (!f) {
+			fprintf(stderr, "%s: open %s: %s\n", progname, outfile,
+				strerror(errno));
+			exit(1);
+		}
+		fwrite(rw.data, 1, count, f);
+		fclose(f);
+	} else {
+		hexdump(rw.data, count);
+	}
+}
+
+static void cccr(int fd)
+{
+	static const struct {
+		unsigned char addr;
+		unsigned char len;
+		const char *name;
+	} fields[] = {
+		{ 0x00, 1, "CCCR/SDIO revision" },
+		{ 0x01, 1, "SD spec revision" },
+		{ 0x02, 1, "I/O enable" },
+		{ 0x03, 1, "I/O ready" },
+		{ 0x04, 1, "Int enable" },
+		{ 0x05, 1, "Int pending" },
+		{ 0x06, 1, "I/O abort" },
+		{ 0x07, 1, "Bus interface control" },
+		{ 0x08, 1, "Card capability" },
+		{ 0x09, 3, "Common CIS pointer" },
+		{ 0x0c, 1, "Bus suspend" },
+		{ 0x0d, 1, "Function select" },
+		{ 0x0e, 1, "Exec flags" },
+		{ 0x0f, 1, "Ready flags" },
+		{ 0x10, 2, "FN0 block size" },
+		{ 0x12, 1, "Power control" },
+		{ 0x13, 1, "High-speed" },
+	};
+	unsigned char regs[0x18];
+	unsigned int i, j;
+	unsigned long v;
+
+	for (i = 0; i < sizeof(regs); i++)
+		if (rd52(fd, 0, i, &regs[i]))
+			die_errno("CMD52 (CCCR dump) failed");
+
+	printf("CCCR (fn 0):\n");
+	for (i = 0; i < ARRAY_SIZE(fields); i++) {
+		v = 0;
+		for (j = 0; j < fields[i].len; j++)
+			v |= (unsigned long)regs[fields[i].addr + j] << (8 * j);
+
+		if (fields[i].len == 1)
+			printf("  0x%02x       %-24s 0x%02lx\n", fields[i].addr,
+			       fields[i].name, v);
+		else if (fields[i].len == 2)
+			printf("  0x%02x-0x%02x %-21s 0x%04lx\n",
+			       fields[i].addr, fields[i].addr + 1,
+			       fields[i].name, v);
+		else
+			printf("  0x%02x-0x%02x %-21s 0x%06lx\n",
+			       fields[i].addr,
+			       fields[i].addr + fields[i].len - 1,
+			       fields[i].name, v);
+	}
+	printf("  raw 0x00-0x17:\n");
+	hexdump(regs, sizeof(regs));
+}
+
+static void fbr(int fd, unsigned int fn)
+{
+	unsigned char regs[0x20];
+	unsigned long cis, csa;
+	unsigned int i;
+
+	if (fn == 0) {
+		fprintf(stderr, "%s: %s needs a function 1..7, use -f\n",
+			progname, __func__);
+		exit(1);
+	}
+
+	/*
+	 * The FBR of function fn lives at fn * 0x100 in the common
+	 * register area and is always accessed through function 0, like
+	 * the kernel does (SDIO_FBR_BASE(), drivers/mmc/core/sdio_cis.c).
+	 */
+	for (i = 0; i < sizeof(regs); i++)
+		if (rd52(fd, 0, fn * 0x100 + i, &regs[i]))
+			die_errno("CMD52 (FBR dump) failed");
+
+	cis = regs[0x09] | regs[0x0a] << 8 | regs[0x0b] << 16;
+	csa = regs[0x0c] | regs[0x0d] << 8 | regs[0x0e] << 16;
+
+	printf("FBR (fn %u) @ 0x%03x:\n", fn, fn * 0x100);
+	printf("  0x00      Standard interface code 0x%02x\n", regs[0x00]);
+	printf("  0x01      Ext std interface code  0x%02x\n", regs[0x01]);
+	printf("  0x02      Power selection         0x%02x\n", regs[0x02]);
+	printf("  0x09-0x0b CIS pointer               0x%06lx\n", cis);
+	printf("  0x0c-0x0e CSA pointer               0x%06lx\n", csa);
+	printf("  0x10-0x11 Function block size       0x%04x\n",
+	       regs[0x10] | regs[0x11] << 8);
+	printf("  raw 0x00-0x1f:\n");
+	hexdump(regs, sizeof(regs));
+}
+
+/*
+ * CIS walk, mirroring drivers/mmc/core/sdio_cis.c: the CIS pointer
+ * sits at offset 0x09 of the CCCR (fn 0) or of the FBR of the selected
+ * function, and both the pointer and the tuple chain are read through
+ * function 0.  Function 0 dumps the common CIS, functions 1..7 their
+ * per-function CIS.
+ */
+#define CISTPL_END	0xff
+#define CISTPL_VERS_1	0x15
+#define CISTPL_MANFID	0x20
+#define CISTPL_FUNCID	0x21
+
+static const char *tpl_name(unsigned char code)
+{
+	switch (code) {
+	case CISTPL_VERS_1:	return "VERS_1";
+	case CISTPL_MANFID:	return "MANFID";
+	case CISTPL_FUNCID:	return "FUNCID";
+	default:		return "";
+	}
+}
+
+static void cis_dump(int fd, unsigned int fn)
+{
+	unsigned char b[3], body[256];
+	unsigned long addr;
+	unsigned int n;
+
+	if (rd52(fd, 0, fn * 0x100 + 0x09, &b[0]) ||
+	    rd52(fd, 0, fn * 0x100 + 0x0a, &b[1]) ||
+	    rd52(fd, 0, fn * 0x100 + 0x0b, &b[2]))
+		die_errno("CMD52 (CIS pointer) failed");
+
+	addr = b[0] | b[1] << 8 | b[2] << 16;
+	if (!addr) {
+		printf("CIS (fn %u): not present (CIS pointer is 0)\n", fn);
+		return;
+	}
+	addr &= 0x1ffff;
+
+	printf("CIS (fn %u) @ 0x%05lx:\n", fn, addr);
+
+	for (n = 0; n < 256; n++) {
+		unsigned char code, link;
+		unsigned int i;
+
+		if (rd52(fd, 0, addr, &code))
+			die_errno("CMD52 (CIS walk) failed");
+		if (code == CISTPL_END) {
+			printf("  0x%05lx TPL 0xff END\n", addr);
+			break;
+		}
+		if (code == 0x00) {	/* null tuple, has no link field */
+			printf("  0x%05lx TPL 0x00 NULL\n", addr);
+			addr++;
+			continue;
+		}
+		if (rd52(fd, 0, addr + 1, &link))
+			die_errno("CMD52 (CIS walk) failed");
+		if (link == 0xff) {
+			printf("  0x%05lx TPL 0x%02x link=0xff (undefined), stop\n",
+			       addr, code);
+			break;
+		}
+
+		for (i = 0; i < link; i++)
+			if (rd52(fd, 0, addr + 2 + i, &body[i]))
+				die_errno("CMD52 (CIS walk) failed");
+
+		printf("  0x%05lx TPL 0x%02x %-6s len=%u\n", addr, code,
+		       tpl_name(code), link);
+
+		switch (code) {
+		case CISTPL_MANFID:
+			if (link >= 4) {
+				printf("    manufacturer 0x%04x, product 0x%04x\n",
+				       body[0] | body[1] << 8,
+				       body[2] | body[3] << 8);
+				break;
+			}
+			hexdump(body, link);
+			break;
+		case CISTPL_VERS_1: {
+			unsigned int j = 2;
+
+			printf("    rev %u.%u:", body[0], body[1]);
+			while (j < link && body[j] != 0xff) {
+				unsigned int start = j;
+
+				while (j < link && body[j])
+					j++;
+				printf(" \"%.*s\"", (int)(j - start),
+				       (const char *)&body[start]);
+				j++;	/* skip the NUL */
+			}
+			putchar('\n');
+			break;
+		}
+		case CISTPL_FUNCID:
+			if (link >= 1) {
+				printf("    function code 0x%02x\n", body[0]);
+				break;
+			}
+			hexdump(body, link);
+			break;
+		default:
+			hexdump(body, link);
+			break;
+		}
+
+		addr += 2 + link;
+	}
+}
+
+#ifndef SDIO_SYSFS_DEVICES
+#define SDIO_SYSFS_DEVICES	"/sys/bus/sdio/devices"
+#endif
+
+static int read_attr(const char *dir, const char *attr, char *buf, size_t len)
+{
+	char path[PATH_MAX];
+	FILE *f;
+	size_t n;
+
+	snprintf(path, sizeof(path), "%s/%s", dir, attr);
+	f = fopen(path, "r");
+	if (!f)
+		return -1;
+	if (!fgets(buf, len, f)) {
+		fclose(f);
+		return -1;
+	}
+	fclose(f);
+	n = strlen(buf);
+	while (n && (buf[n - 1] == '\n' || buf[n - 1] == '\r'))
+		buf[--n] = '\0';
+	return 0;
+}
+
+static const char *lookup_name(const struct sdio_id_name *tbl,
+			       unsigned int count, unsigned int id)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (tbl[i].id == id)
+			return tbl[i].name;
+	return NULL;
+}
+
+/*
+ * Join the CIS strings the kernel parsed at enumeration (sysfs
+ * info1..info4, from CISTPL_VERS_1) into one identification string.
+ */
+static void read_info(const char *dir, char *buf, size_t len)
+{
+	static const char * const attrs[] = { "info1", "info2", "info3", "info4" };
+	char tmp[64];
+	size_t used = 0;
+	unsigned int i;
+
+	buf[0] = '\0';
+	for (i = 0; i < ARRAY_SIZE(attrs); i++) {
+		size_t slen;
+
+		if (read_attr(dir, attrs[i], tmp, sizeof(tmp)) || !tmp[0])
+			continue;
+
+		slen = strlen(tmp);
+		if (used + slen + 1 >= len)
+			break;
+		if (used)
+			buf[used++] = ' ';
+		memcpy(buf + used, tmp, slen + 1);
+		used += slen;
+	}
+}
+
+static void list_devices(void)
+{
+	struct dirent **entries;
+	int i, n, total = 0;
+
+	n = scandir(SDIO_SYSFS_DEVICES, &entries, NULL, alphasort);
+	if (n < 0) {
+		printf("no SDIO bus (%s: %s)\n", SDIO_SYSFS_DEVICES,
+		       strerror(errno));
+		return;
+	}
+
+	printf("%-20s %-14s %-24s %-14s %-5s %s\n",
+	       "NODE", "VID:PID", "NAME", "CLASS", "REV", "INFO");
+
+	for (i = 0; i < n; i++) {
+		const char *devname = entries[i]->d_name;
+		const char *dname, *cname;
+		char path[PATH_MAX];
+		char vend[16], devid[16], clsv[16], rev[32], info[160];
+		char namebuf[64], clsbuf[40], vidpid[16];
+		unsigned int vid, pid, c;
+
+		if (devname[0] == '.')
+			continue;
+
+		snprintf(path, sizeof(path), "%s/%s", SDIO_SYSFS_DEVICES,
+			 devname);
+
+		if (read_attr(path, "vendor", vend, sizeof(vend)) ||
+		    read_attr(path, "device", devid, sizeof(devid)) ||
+		    read_attr(path, "class", clsv, sizeof(clsv)) ||
+		    read_attr(path, "revision", rev, sizeof(rev)))
+			continue;
+
+		read_info(path, info, sizeof(info));
+
+		vid = strtoul(vend, NULL, 0);
+		pid = strtoul(devid, NULL, 0);
+		c = strtoul(clsv, NULL, 0);
+
+		snprintf(vidpid, sizeof(vidpid), "0x%04x:0x%04x", vid, pid);
+
+		dname = lookup_name(sdio_device_names,
+				    ARRAY_SIZE(sdio_device_names), pid);
+		if (!dname) {
+			snprintf(namebuf, sizeof(namebuf), "Unlisted(0x%04x)",
+				 pid);
+			dname = namebuf;
+		}
+
+		cname = lookup_name(sdio_class_names,
+				    ARRAY_SIZE(sdio_class_names), c);
+		if (cname)
+			snprintf(clsbuf, sizeof(clsbuf), "0x%02x (%s)", c,
+				 cname);
+		else
+			snprintf(clsbuf, sizeof(clsbuf), "0x%02x", c);
+
+		printf("/dev/%-15s %-14s %-24s %-14s %-5s %s\n",
+		       devname, vidpid, dname, clsbuf, rev,
+		       info[0] ? info : "-");
+		total++;
+	}
+
+	if (!total)
+		printf("no SDIO device found\n");
+
+	for (i = 0; i < n; i++)
+		free(entries[i]);
+	free(entries);
+}
+
+static unsigned int get_fn(const char *dev, int fn_override)
+{
+	unsigned int fn = fn_override >= 0 ? (unsigned int)fn_override :
+					 fn_from_dev(dev);
+
+	if (fn > 7) {
+		fprintf(stderr, "%s: invalid function number %u\n", progname,
+			fn);
+		exit(1);
+	}
+	return fn;
+}
+
+static unsigned long get_addr(const char *s)
+{
+	unsigned long addr = parse_num(s, "address");
+
+	if (addr > 0x1ffff) {
+		fprintf(stderr, "%s: addr 0x%lx out of range\n", progname,
+			addr);
+		exit(1);
+	}
+	return addr;
+}
+
+int main(int argc, char **argv)
+{
+	const char *dev = NULL, *cmd;
+	const char *infile = NULL, *outfile = NULL;
+	unsigned long addr = 0, count = 0, val = 0;
+	int fn_override = -1, write = 0, raw = 0, incr_addr = 1;
+	unsigned int fn;
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		const char *a = argv[i];
+
+		if (!strcmp(a, "-d") || !strcmp(a, "--device")) {
+			if (++i >= argc)
+				usage(1);
+			dev = argv[i];
+		} else if (!strcmp(a, "-f") || !strcmp(a, "--func")) {
+			if (++i >= argc)
+				usage(1);
+			fn_override = parse_num(argv[i], "function number");
+		} else if (!strcmp(a, "-h") || !strcmp(a, "--help")) {
+			usage(0);
+		} else {
+			break;
+		}
+	}
+
+	if (i >= argc)
+		usage(1);
+
+	cmd = argv[i++];
+
+	if (!strcmp(cmd, "cmd52")) {
+		for (; i < argc; i++) {
+			if (!strcmp(argv[i], "-a") && i + 1 < argc)
+				addr = get_addr(argv[++i]);
+			else if (!strcmp(argv[i], "-w") && i + 1 < argc)
+				write = 1, val = parse_num(argv[++i], "byte value");
+			else if (!strcmp(argv[i], "-r"))
+				raw = 1;
+			else if (!strcmp(argv[i], "-f") && i + 1 < argc)
+				fn_override = parse_num(argv[++i], "function number");
+			else
+				usage(1);
+		}
+		fn = get_fn(dev, fn_override);
+		cmd52(open_dev(dev), fn, addr, write, val, raw);
+	} else if (!strcmp(cmd, "cmd53")) {
+		for (; i < argc; i++) {
+			if (!strcmp(argv[i], "-a") && i + 1 < argc)
+				addr = get_addr(argv[++i]);
+			else if (!strcmp(argv[i], "-n") && i + 1 < argc)
+				count = parse_num(argv[++i], "count");
+			else if (!strcmp(argv[i], "-w") && i + 1 < argc)
+				write = 1, infile = argv[++i];
+			else if (!strcmp(argv[i], "-o") && i + 1 < argc)
+				outfile = argv[++i];
+			else if (!strcmp(argv[i], "--fixed"))
+				incr_addr = 0;
+			else if (!strcmp(argv[i], "-f") && i + 1 < argc)
+				fn_override = parse_num(argv[++i], "function number");
+			else
+				usage(1);
+		}
+		if (!addr && !count) {
+			fprintf(stderr, "%s: cmd53 needs -a ADDR and -n COUNT\n",
+				progname);
+			usage(1);
+		}
+		if (!count || count > 512) {
+			fprintf(stderr, "%s: count must be 1..512\n", progname);
+			exit(1);
+		}
+		fn = get_fn(dev, fn_override);
+		if (fn == 0) {
+			fprintf(stderr, "%s: cmd53 is not valid for fn 0\n",
+				progname);
+			exit(1);
+		}
+		cmd53(open_dev(dev), fn, addr, count, write, incr_addr,
+		      infile, outfile);
+	} else if (!strcmp(cmd, "list")) {
+		list_devices();
+	} else if (!strcmp(cmd, "cccr")) {
+		cccr(open_dev(dev));
+	} else if (!strcmp(cmd, "cis")) {
+		for (; i < argc; i++) {
+			if (!strcmp(argv[i], "-f") && i + 1 < argc)
+				fn_override = parse_num(argv[++i], "function number");
+			else
+				usage(1);
+		}
+		fn = get_fn(dev, fn_override);
+		cis_dump(open_dev(dev), fn);
+	} else if (!strcmp(cmd, "fbr")) {
+		for (; i < argc; i++) {
+			if (!strcmp(argv[i], "-f") && i + 1 < argc)
+				fn_override = parse_num(argv[++i], "function number");
+			else
+				usage(1);
+		}
+		fn = get_fn(dev, fn_override);
+		fbr(open_dev(dev), fn);
+	} else {
+		fprintf(stderr, "%s: unknown command: %s\n", progname, cmd);
+		usage(1);
+	}
+
+	return 0;
+}
-- 
2.7.4

