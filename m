Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DC12E1ED
	for <linux-mmc@vger.kernel.org>; Wed, 27 Mar 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565147; cv=none; b=l/b71REFUphNJqXibDKtvp1sooKmTOG4wwK3bZLeqgtDkXDi1IH+1af9HTlccRUs4N3puyXAWYjbmejuzaphFHCNX5+Tw02YL0oqcSc818hZcGl0mVkcyNFWv//mXhHJ0STuYWw3Lc982eQg7/lMs94IlmLGTuyPovL8lAi2seY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565147; c=relaxed/simple;
	bh=CqMpuRyC2PKiBERysfvO1nXJjTw9rNj1ogwemNixDog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWm9hXXEr9tXDsZHUA6A9dHl1nhhZ6h84RyBZSU5ddGPjGGm+p/waj/aU0Ya9FelfHfks3HCzVXfTsT1O/FzMhhNKINwL+upZJmmhvVl4omAF93MJld882sL3AlnSbhE8RdYtk63ksnf4wQevKuQPRzi+evJalZ23/Ohbm/rg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rcaem3DB; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rcaem3DB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711565145; x=1743101145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CqMpuRyC2PKiBERysfvO1nXJjTw9rNj1ogwemNixDog=;
  b=rcaem3DBxCu3Oyz4X9g/J2ndA0xEAXx9r6UXRhuLsXi1u9Y8QWldzVPa
   xocfFw0x6Wz+IiQ8PigkYVcANLDK8eONBj1+WefYpSMfbGdrAr9wwCdX9
   Eq+ORwYu4VxjOPRo10V+F9uIMX+H0NsGMv2y0N1ollfJtKRUYwU17Y2ft
   Nm5U7bIYPi8b4sxQ0AdkEHxHeOoZaJM6IMlSpqhexw3a89q0IwM8WIwc+
   UfknkWw7WOyq8h5ZR8V1fAKlWBZYetK8njqqEPT/vFs98Ah0OZaaHS/po
   ZxGZuGABo1iyAS76EsjGfH3jX6FBr/7tDJ5jq8OEOrFvzQ9e1KqKh3v06
   Q==;
X-CSE-ConnectionGUID: aBJUmy0SSCKGkzuGZfa4DQ==
X-CSE-MsgGUID: na4a2I4ESXCjiEQUSkV33A==
X-IronPort-AV: E=Sophos;i="6.07,159,1708358400"; 
   d="scan'208";a="12628594"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2024 02:45:38 +0800
IronPort-SDR: jVOKsYalBO/POOqLY8h1X5n4wdk4J8n79oA1lo0+JQqF2RTN4QREKjYyHprg7dDBiAFE4JYORE
 q8wQIXEly32g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2024 10:48:41 -0700
IronPort-SDR: u1zyBXV+wUb9hMvZYZSEoa5M32TSwnyZXZt5fy4E12gYrA4m1aHG2R1FZmNqXQfvks4jmfivlu
 EGy8exJ1E2vw==
WDCIronportException: Internal
Received: from 5cg1443s5d.ad.shared (HELO BXYGM33.ad.shared) ([10.225.32.191])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Mar 2024 11:45:37 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2] mmc-utils: man 1 mmc-utils
Date: Wed, 27 Mar 2024 20:45:28 +0200
Message-ID: <20240327184528.788-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have put together a draft man page for mmc-utils.  The contents are
from mmc-utils help documents and edited for brevity.  The point is not
to replace the existing docmentation, but to serve as a quick reference.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---

Changelog:
v1->v2: Fix some spelling mistakes
---
 Makefile |   9 +-
 mmc.1    | 308 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 312 insertions(+), 5 deletions(-)
 create mode 100644 mmc.1

diff --git a/Makefile b/Makefile
index 10b78ab..a890833 100644
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,7 @@ prefix ?= /usr/local
 bindir = $(prefix)/bin
 LIBS=
 RESTORE_LIBS=
+mandir = /usr/share/man
 
 progs = mmc
 
@@ -29,7 +30,7 @@ ifdef C
 	check = sparse $(CHECKFLAGS)
 endif
 
-all: $(progs) manpages
+all: $(progs)
 
 .c.o:
 ifdef C
@@ -43,16 +44,14 @@ mmc: $(objects)
 manpages:
 	$(MAKE) -C man
 
-install-man:
-	$(MAKE) -C man install
-
 clean:
 	rm -f $(progs) $(objects)
 	$(MAKE) -C man clean
 
-install: $(progs) install-man
+install: $(progs)
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(progs) $(DESTDIR)$(bindir)
+	$(INSTALL) -m 644 mmc.1 $(DESTDIR)$(mandir)/man1
 
 -include $(foreach obj,$(objects), $(dir $(obj))/.$(notdir $(obj)).d)
 
diff --git a/mmc.1 b/mmc.1
new file mode 100644
index 0000000..888b8b6
--- /dev/null
+++ b/mmc.1
@@ -0,0 +1,308 @@
+.TH mmc\-utils 1 "April 2024" "User Manual"
+.SH NAME
+mmc \-  a tool for configuring MMC storage devices
+.SH SYNOPSIS
+.B mmc
+[\fIoptions\fR] [\ mmc\-block\-device\fR]...
+.SH DESCRIPTION
+.B mmc-utils
+is a single-threaded tool that will perform a particular type of mmc action as specified by the user.
+.br
+The typical use of mmc-utils is to access the mmc device either for configuring or reading its configuration registers.
+.SH OPTIONS
+.TP
+.BI extcsd " " read " " \fIdevice\fR
+Read and prints the extended csd register
+.TP
+.BI extcsd " " write " " \fIoffset\fR " " \fIvalue\fR " " \fIdevice\fR
+Write \fIvalue\fR at \fIoffset\fR to the device's extcsd
+.TP
+.BI writeprotect " " boot " " get " " \fIdevice\fR
+Print the boot partitions write protect status
+.TP
+.BI writeprotect " " boot " " set " " \fIdevice\fR " " [\fInumber\fR]
+Set the boot partition write protect status for the device.
+.br
+If \fInumber\fR is passed (0 or 1), only protect that particular eMMC boot partition, otherwise protect both.
+.br
+It will be write-protected until the next boot.
+.TP
+.BI writeprotect " " user " " set " " \fItype\fR " " \fIstart\-block\fR " " \fIblocks\fR " " \fIdevice\fR
+Set the write protect configuration for the specified region of the user area for the device.
+.br
+\fIstart\-block\fR specifies the first block of the protected area.
+.br
+\fIblocks\fR specifies the size of the protected area in blocks.
+.br
+NOTE! The area must start and end on Write Protect Group boundaries, Use the "writeprotect user get" command to get the Write Protect Group size.
+ \fItype\fR is one of the following:
+.RS
+.RS
+.TP
+.B none
+Clear temporary write protection.
+.TP
+.B temp
+Set temporary write protection.
+.TP
+.B pwron
+Set write protection until the next power on.
+.RE
+.RE
+.TP
+.BI writeprotect " " user " " get " " \fIdevice\fR
+Print the user areas write protect configuration for the device.
+.TP
+.BI disable " " 512B " " emulation " " \fIdevice\fR
+Set the eMMC data sector size to 4KB by disabling emulation on the device.
+.TP
+.BI gp " " create " " \fIdry\-run\fR " " \fIlength\-KiB\fR " " \fIpartition\fR  " " \fIenh\-attr\fR " " \fIext\-attr\fR " " \fIdevice\fR
+Create general purpose partition for the the device.
+.br
+NOTE!  This is a one-time programmable (unreversible) change.
+.br
+To set enhanced attribute to general partition being created set \fIenh\-attr\fR to 1 else set it to 0.
+.br
+To set extended attribute to general partition set \fIenh\-attr\fR to 1,2 else set it to 0.
+.br
+\fIdry\-run\fR is one of the following:
+.RS
+.RS
+.TP
+.B \-y
+PARTITION_SETTING_COMPLETED in the extcsd will get set and the partisioning operation will take effect and finalized.
+.TP
+.B \-c
+more partitioning settings are still to come - partitioning operation will not take effect.
+.TP
+.B otherwise
+These changes will not take effect neither now nor after a power cycle.
+.RE
+.RE
+.TP
+.BI enh_area " " set " " \fIdry\-run\fR " " \fIstart\-KiB\fR " " \fIlength\-KiB\fR " " \fIdevice\fR
+Enable the enhanced user area for the device.
+.br
+NOTE!  This is a one-time programmable (unreversible) change.
+\fIdry\-run\fR is as above.
+.TP
+.BI write_reliability " " set " " " \fIdry\-run\fR " " \fIpartition\fR " " \fIdevice\fR
+Enable write reliability per partition for the device.
+.br
+NOTE!  This is a one-time programmable (unreversible) change.
+\fIdry\-run\fR is as above.
+.TP
+.BI status " " get " " \fIdevice\fR
+Print the response to STATUS_SEND (CMD13).
+.TP
+.BI bootpart " " enable " " \fIboot\-partition\fR " " \fIsend\-ackn\fR " " \fIdevice\fR
+Enable the boot partition for the device.
+Disable the boot partition for the device if is \fIboot\-partition\fR set to 0.
+.br
+To receive acknowledgment of boot from the card set \fIsend\-ackn\fR to 1, else set it to 0.
+.TP
+.BI bootbus " " set " " \fIboot\-mode\fR " " \fIreset\-boot\-bus\-conditions\fR " " \fIboot\-bus\-width\fR " " \fIdevice\fR
+Set Boot Bus Conditions.
+.br
+\fIboot\-mode\fR is one of the following: single_backward, single_hs, or dual.
+.br
+\fIreset\-boot\-bus\-conditions\fR is one of the following: x1 or retain.
+.br
+\fIboot\-bus\-width\fR is one of the following: x1, x4, or x8.
+.TP
+.BI bkops_en " " \fImode\fR " " \fIdevice\fR
+Enable the eMMC BKOPS feature on the device.
+The auto (AUTO_EN) setting is only supported on eMMC 5.0 or newer.
+.br
+NOTE!  Setting manual (MANUAL_EN) is one-time programmable (unreversible) change.
+.br
+\fImode\fR is one of the following:
+.RS
+.RS
+.TP
+.B auto
+Auto backops is set
+.TP
+.B manual
+Manual bkops is set
+.RE
+.RE
+.TP
+.BI hwreset " " enable " " \fIdevice\fR
+Permanently enable the eMMC H/W Reset feature on the device.
+.br
+NOTE!  This is a one-time programmable (unreversible) change.
+.TP
+.BI hwreset " " disable " " \fIdevice\fR
+Permanently disable the eMMC H/W Reset feature on the device.
+.br
+NOTE!  This is a one-time programmable (unreversible) change.
+.TP
+.BI sanitize " " \fIdevice\fR " " \fI[timeout_ms]\fR
+Send Sanitize command to the device.
+This will delete the unmapped memory region of the device.
+.TP
+.BI rpmb " " write\-key " " \fIrpmb\-device\fR " " \fIkey\-file\fR
+Program authentication key which is 32 bytes length and stored in the specified file.
+.br
+Also you can specify '-' instead of key file path to read the key from stdin.
+.br
+NOTE!  This is a one-time programmable (unreversible) change.
+.TP
+.BI rpmb " " read\-counter " " \fIrpmb\-device\fR
+Counter value for the \fIrpmb\-device\fR will be read to stdout.
+.TP
+.BI rpmb " " read\-block " " \fIrpmb\-device\fR " " \fIaddress\fR " " \fIblocks-\count\fR " " \fIoutput-\file\fR " " [\fIkey\-file\fR]
+Blocks of 256 bytes will be read from \fIrpmb\-device\fR to output
+file or stdout if '-' is specified. If key is specified - read
+data will be verified.
+.TP
+.BI rpmb " " write\-block " " \fIrpmb\-device\fR " " \fIaddress\fR " "  \fI256\-byte\-data\-file\fR " " \fIkey\-file\fR
+Block of 256 bytes will be written from data file to
+\fIrpmb\-device\fR. 
+.br
+Also you can specify '-' instead of key file path or data file to read the data from stdin.
+.TP
+.BI cache " " enable " " \fIdevice\fR
+Enable the eMMC cache feature on the device.
+.br
+NOTE! The cache is an optional feature on devices >= eMMC4.5.
+.TP
+.BI cache disable " " \fIdevice\fR
+Disable the eMMC cache feature on the device.
+.br
+NOTE! The cache is an optional feature on devices >= eMMC4.5.
+.TP
+.BI csd " " read " " \fidevice\-path\fR
+Print CSD data from \fIdevice\-path\fR.
+The device path should specify the csd sysfs file directory.
+.TP
+.BI cid " " read " " \fIdevice\-path\fR
+Print CID data from \fIdevice\-path\fR.
+The device path should specify the cid sysfs file directory.
+.TP
+.BI scr " " read " " \fIdevice\-path\fR
+Print SCR data from \fIdevice\-path\fR.
+The device path should specify the scr sysfs file directory.
+.TP
+.BI ffu " " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Run Field Firmware Update with \fIimage\-file\-name\fR on the device.
+.br
+[\fIchunk\-bytes\fR] is optional and defaults to its max - 512k. should be in decimal bytes and sector aligned.
+.br
+if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the largest possible chunks: max(image-file, 512k).
+.TP
+.BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
+Send Erase CMD38 with specific argument to the device.
+.br
+NOTE!: This will delete all user data in the specified region of the device.
+.br
+\fItype\fR is one of the following: legacy, discard, secure-erase, secure-trim1, secure-trim2, or trim.
+.TP
+.BI gen_cmd " " read " \fidevice\fR [\fIarg\fR]
+Send GEN_CMD (CMD56) to read vendor-specific format/meaning data from the device.
+.br
+NOTE!: [\fIarg\fR] is optional and defaults to 0x1. If [\fIarg\fR] is specified, then [\fIarg\fR]
+must be a 32-bit hexadecimal number, prefixed with 0x/0X. And bit0 in [\fIarg\fR] must be 1.
+Normally this command is aimed to extract a device-health info from the device.
+.TP
+.BI softreset " " \fIdevice\fR
+Issues a CMD0 softreset, e.g. for testing if hardware reset for UHS works
+.TP
+.BI boot_operation " " \fIboot\-data\-file\fR " " \fIdevice\fR
+ Does the alternative boot operation and writes the specified starting blocks of boot data into the requested file.
+Note some limitations:
+.RS
+.RS
+.TP
+.B 1)
+The boot operation must be configured first, e.g. via bootbus and/or bootpart commands
+.TP
+.B 2) 
+The MMC must currently be running at the bus mode that is configured for the boot operation (HS200 and HS400 not supported at all).
+.TP
+.B 3)
+Only up to 512K bytes of boot data will be transferred.
+.TP
+.B 4)
+The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.
+.RE
+.RE
+.TP
+.BI \-\-help " " | " " help " " | " " \-h
+Show the help
+.TP
+.BI \fIcmd\fR " " \-\-help
+Show detailed help for that specific \fIcmd\fR or subset of commands.
+.SH "RPMB COMMANDS"
+The RPMB partition on the eMMC devices is a special area used for storing cryptographically safe information signed by a
+special secret key.
+.br
+To write and read records from this special area, authentication is needed.
+.br
+The RPMB area is *only* and *exclusively* accessed using ioctl()s from user-space.
+.br
+RPMB commands are send using the mmc multi-ioctl, thus ensures that the atomic nature of the rpmb access operation.
+.br
+The rpmb device given as a parameter to the rpmb commands is not a block device but a char device.
+.br
+This was done to help the mmc driver to account for some of the rpmb peculiarities.
+.SH "EXAMPLES"
+.RE
+.P
+.B RPMB examples
+.RS
+Program rpmb key using the stdin option:
+.RS
+.P
+$ echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | mmc rpmb write-key /dev/mmcblk0rpmb -
+.RE
+.P
+Read 2 blocks starting address 2 and output the received content to stdout. Verify the received frames using the key (not mandatory):
+.RS
+.P
+$ echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH | mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 -
+.RE
+.P
+Read 2 blocks without verification starting address 2 and output the received content to /tmp/block:
+.RS
+.P
+$mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 /tmp/block
+.RE
+.P
+Write a string of 'a's to address 2. both the input and key uses stdin interface:
+.RS
+.P
+$ (awk 'BEGIN {while (c++<256) printf "a"}' | echo -n AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHH) | mmc rpmb write-block /dev/mmcblk0rpmb 0x02 - -
+.RE
+.P
+.RE
+.P
+.B Field Firmware Update (ffu) examples
+.RS
+Do ffu using max-possible chunk size:  If the fluf size < 512k, it will be flushed in a single write sequence.
+.RS
+.P
+$ mmc ffu IO4e0aC2056001801M1100042AE1.fluf /dev/mmcblk0
+.RE
+.P
+Same as above, this time use a 4k chunks:
+.RS
+.P
+$ mmc ffu IO4e0aC2056001801M1100042AE1.fluf /dev/mmcblk0 4096
+.RE
+.P
+.RE
+.SH AUTHORS
+.B mmc-utils
+was written by Chris Ball <cjb@laptop.org> and <chris@printf.net>.
+.br
+It is currently maintained by Ulf Hansson <ulf.hansson@linaro.org>.
+.SH "REPORTING BUGS"
+Report bugs to the \fBmmc\fR mailing list <linux-mmc@vger.kernel.org>.
+.SH "SEE ALSO"
+For further documentation see \fBREADME\fR.
+.br
+A short intro - https://docs.kernel.org/driver-api/mmc/mmc-tools.html
+.br
+official git tree - https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
-- 
2.42.0

