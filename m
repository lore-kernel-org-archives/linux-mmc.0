From: James Nuss <jamesnuss@nanometrics.ca>
Subject: [PATCH 4/7] mmc-utils: Introduce write_reliability set_register command
Date: Tue,  9 Oct 2018 13:31:08 -0400
Message-ID: <09cceeb5de497ac2abd19de93a364af747ce51b1.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

"write-reliability" setting must be performed on all required partitions
in one command.

Introduce new command "write_reliability set_register" to allow setting
of write-reliability for all required partitions.

This command is a one-time programmable action. It cannot not be undone
by power-cycling the unit.

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.c      |  9 +++++++++
 mmc_cmds.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 3 files changed, 69 insertions(+)

diff --git a/mmc.c b/mmc.c
index 50c9c9e..aaefd3d 100644
--- a/mmc.c
+++ b/mmc.c
@@ -102,6 +102,15 @@ static struct Command commands[] = {
 		"Enable write reliability per partition for the <device>.\nDry-run only unless -y or -c is passed.\nUse -c if more partitioning settings are still to come.\nNOTE!  This is a one-time programmable (unreversible) change.",
 	  NULL
 	},
+	{ do_write_reliability_set_register, -2,
+	  "write_reliability set_register", "<partition-mask> " "<device>\n"
+		"Set the write-reliability register (WR_REL_SET) for the <device>.\n"
+		"User area=bit0, GP1=bit1, GP2=bit2, GP3=bit3, GP4=bit4\n"
+		"e.g setting register to 0x03 will set 'User Area' and 'GP1' partitions \n"
+		"with write-reliability, and all others without write-reliability.\n"
+		"NOTE!  This is a one-time programmable (irreversible) change.",
+	  NULL
+	},
 	{ do_status_get, -1,
 	  "status get", "<device>\n"
 	  "Print the response to STATUS_SEND (CMD13).",
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 756aa2f..68c73ef 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1244,6 +1244,65 @@ int do_enh_area_set(int nargs, char **argv)
 	return 0;
 }
 
+int do_write_reliability_set_register(int nargs, char **argv)
+{
+	__u8 ext_csd[512];
+	int fd, ret;
+	long partition_mask;
+	char *device;
+	char *endptr;
+
+	if (nargs != 3) {
+		fprintf(stderr,"Usage: mmc write_reliability set_register <partition-mask> </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	errno = 0;
+	partition_mask = strtol(argv[1], &endptr, 0);
+	if (errno != 0 || endptr == argv[1] || *endptr != 0 || partition_mask < 0 || partition_mask > 0x1f) {
+		fprintf(stderr, "Partition mask invalid: %s\n", argv[1]);
+		exit(1);
+	}
+
+	device = argv[2];
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
+	/* assert not PARTITION_SETTING_COMPLETED */
+	if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED])
+	{
+		fprintf(stderr, "Device is already partitioned\n");
+		exit(1);
+	}
+
+	/* assert HS_CTRL_REL */
+	if (!(ext_csd[EXT_CSD_WR_REL_PARAM] & HS_CTRL_REL)) {
+		fprintf(stderr, "Cannot set write reliability parameters, WR_REL_SET is "
+				"read-only\n");
+		exit(1);
+	}
+
+	ret = write_extcsd_value(fd, EXT_CSD_WR_REL_SET, (__u8)partition_mask);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+				(__u8)partition_mask, EXT_CSD_WR_REL_SET, device);
+		exit(1);
+	}
+	fprintf(stderr, "Done setting EXT_CSD_WR_REL_SET to 0x%02x on %s\n",
+		(__u8)partition_mask, device);
+
+	return 0;
+}
+
 int do_write_reliability_set(int nargs, char **argv)
 {
 	__u8 value;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 9d3246c..8ca9ac9 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -35,6 +35,7 @@ int do_status_get(int nargs, char **argv);
 int do_create_gp_partition(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
 int do_write_reliability_set(int nargs, char **argv);
+int do_write_reliability_set_register(int nargs, char **argv);
 int do_rpmb_write_key(int nargs, char **argv);
 int do_rpmb_read_counter(int nargs, char **argv);
 int do_rpmb_read_block(int nargs, char **argv);
-- 
2.7.4


-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.
