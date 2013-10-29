From: Richard Retanubun <RichardRetanubun@RuggedCom.com>
Subject: [PATCH 2/2] Add 'mmc partition access' command
Date: Tue, 29 Oct 2013 16:43:22 -0400
Message-ID: <1383079402-20918-1-git-send-email-RichardRetanubun@RuggedCom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2.ruggedcom.com ([204.50.148.11]:22814 "EHLO
	mail2.ruggedcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab3J2Un7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2013 16:43:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: ben.l.gardiner@gmail.com, linux-mmc@vger.kernel.org, Richard Retanubun <RichardRetanubun@RuggedCom.com>

This command alters the PARTITION_CONFIG[PARTITION_ACCESS] bits to allow
R/W to the various partition that exist on the device.
---
 Hi Chris and mmc-utils maintainers,

 WARNING: While this alters the bits that I want, it actually does not work.
 Any subsequent access (e.g. mmc extcsd read) ends up with the system being
 unresponsive. I have obviously done something uneducatedly stupid.

 I am posting to show exactly what I have done and hoping that someone 
 can point me in the right direction.

 I am trying to put MLO and u-boot into the boot partition (/dev/mmcblk1boot0)
 and then boot from it. I thought if I set the PARTITION_ACCESS to allow boot0
 I can then dd into it. So far all dd attempts returns with write operation
 not permitted.

 What am I missing?

 Thanks for everyone's time.

 Richard Retanubun

 mmc.c      |    5 +++++
 mmc_cmds.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |    1 +
 3 files changed, 59 insertions(+)

diff --git a/mmc.c b/mmc.c
index 926e92f..985db33 100644
--- a/mmc.c
+++ b/mmc.c
@@ -90,6 +90,11 @@ static struct Command commands[] = {
 		"Enable the boot partition for the <device>.\nTo receive acknowledgment of boot from the card set <send_ack>\nto 1, else set it to 0.",
 	  NULL
 	},
+	{ do_write_partition_access, -2,
+	  "partition access", "<partition_number> " "<device>\n"
+		"Enable R/W access to the specified partition on <device>.",
+	  NULL
+	},
 	{ do_write_bkops_en, -1,
 	  "bkops enable", "<device>\n"
 		"Enable the eMMC BKOPS feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
diff --git a/mmc_cmds.c b/mmc_cmds.c
index af6f09f..d67004d 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -302,6 +302,59 @@ int do_write_boot_en(int nargs, char **argv)
 	return ret;
 }
 
+int do_write_partition_access(int nargs, char **argv)
+{
+	__u8 ext_csd[512];
+	__u8 value = 0;
+	int fd, ret;
+	char *device;
+	int partition;
+
+	CHECK(nargs != 3, "Usage: mmc partition access <partition_number> "
+			  "</path/to/mmcblkX>\n", exit(1));
+
+	/*
+	 * If <send_ack> is 1, the device will send acknowledgment
+	 * pattern "010" to the host when boot operation begins.
+	 * If <send_ack> is 0, it won't.
+	 */
+	partition = strtol(argv[1], NULL, 10);
+	device = argv[2];
+
+	if (partition < 0 || partition > 7) {
+		fprintf(stderr, "Cannot set access to partition %d "
+			"range [0-7] \n", partition);
+		exit(1);
+	}
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		exit(1);
+	}
+
+	value = ext_csd[EXT_CSD_PART_CONFIG];
+
+	/* Sanitize and set the PARTITION_ACCESS bits */
+	value &= 0xF8;
+	value |= partition;
+
+	ret = write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n",
+			value, EXT_CSD_PART_CONFIG, device);
+		exit(1);
+	}
+	return ret;
+}
+
 int do_hwreset(int value, int nargs, char **argv)
 {
 	__u8 ext_csd[512];
diff --git a/mmc_cmds.h b/mmc_cmds.h
index f06cc10..3ba9660 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -21,6 +21,7 @@ int do_writeprotect_get(int nargs, char **argv);
 int do_writeprotect_set(int nargs, char **argv);
 int do_disable_512B_emulation(int nargs, char **argv);
 int do_write_boot_en(int nargs, char **argv);
+int do_write_partition_access(int nargs, char **argv);
 int do_write_bkops_en(int nargs, char **argv);
 int do_hwreset_en(int nargs, char **argv);
 int do_hwreset_dis(int nargs, char **argv);
-- 
1.7.10.4

