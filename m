From: James Nuss <jamesnuss@nanometrics.ca>
Subject: [PATCH 5/7] mmc-utils: remove write_reliability set command
Date: Tue,  9 Oct 2018 13:31:09 -0400
Message-ID: <212d6c6557b21584f9e3254ff72d57ca2682e2b2.1539103468.git.jamesnuss@nanometrics.ca>
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

The "write_reliability set" command is dangerous since it will only set
write-reliability on one partition per command and this command is a
one-time programmable action. This makes it impossible to set
write-reliability on multiple partitions.

Remove the command so it cannot be used in the future.
Use "write_reliability set_register" instead.

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.c      |  5 -----
 mmc_cmds.c | 67 --------------------------------------------------------------
 mmc_cmds.h |  1 -
 3 files changed, 73 deletions(-)

diff --git a/mmc.c b/mmc.c
index aaefd3d..655546b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -97,11 +97,6 @@ static struct Command commands[] = {
 		"Enable the enhanced user area for the <device>.\nDry-run only unless -y or -c is passed.\nUse -c if more partitioning settings are still to come.\nNOTE!  This is a one-time programmable (unreversible) change.",
 	  NULL
 	},
-	{ do_write_reliability_set, -2,
-	  "write_reliability set", "<-y|-n|-c> " "<partition> " "<device>\n"
-		"Enable write reliability per partition for the <device>.\nDry-run only unless -y or -c is passed.\nUse -c if more partitioning settings are still to come.\nNOTE!  This is a one-time programmable (unreversible) change.",
-	  NULL
-	},
 	{ do_write_reliability_set_register, -2,
 	  "write_reliability set_register", "<partition-mask> " "<device>\n"
 		"Set the write-reliability register (WR_REL_SET) for the <device>.\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 68c73ef..9565bc9 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1303,73 +1303,6 @@ int do_write_reliability_set_register(int nargs, char **argv)
 	return 0;
 }
 
-int do_write_reliability_set(int nargs, char **argv)
-{
-	__u8 value;
-	__u8 ext_csd[512];
-	int fd, ret;
-
-	int dry_run = 1;
-	int partition;
-	char *device;
-
-	if (nargs != 4) {
-		fprintf(stderr,"Usage: mmc write_reliability set <-y|-n|-c> <partition> </path/to/mmcblkX>\n");
-		exit(1);
-	}
-
-	if (!strcmp("-y", argv[1])) {
-		dry_run = 0;
-	} else if (!strcmp("-c", argv[1])) {
-		dry_run = 2;
-	}
-
-	partition = strtol(argv[2], NULL, 10);
-	device = argv[3];
-
-	fd = open(device, O_RDWR);
-	if (fd < 0) {
-		perror("open");
-		exit(1);
-	}
-
-	ret = read_extcsd(fd, ext_csd);
-	if (ret) {
-		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-		exit(1);
-	}
-
-	/* assert not PARTITION_SETTING_COMPLETED */
-	if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED])
-	{
-		printf(" Device is already partitioned\n");
-		exit(1);
-	}
-
-	/* assert HS_CTRL_REL */
-	if (!(ext_csd[EXT_CSD_WR_REL_PARAM] & HS_CTRL_REL)) {
-		printf("Cannot set write reliability parameters, WR_REL_SET is "
-				"read-only\n");
-		exit(1);
-	}
-
-	value = ext_csd[EXT_CSD_WR_REL_SET] | (1<<partition);
-	ret = write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value);
-	if (ret) {
-		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
-				value, EXT_CSD_WR_REL_SET, device);
-		exit(1);
-	}
-
-	printf("Done setting EXT_CSD_WR_REL_SET to 0x%02x on %s\n",
-		value, device);
-
-	if (set_partitioning_setting_completed(dry_run, device, fd))
-		exit(1);
-
-	return 0;
-}
-
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 8ca9ac9..cf6c6fb 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -34,7 +34,6 @@ int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
 int do_create_gp_partition(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
-int do_write_reliability_set(int nargs, char **argv);
 int do_write_reliability_set_register(int nargs, char **argv);
 int do_rpmb_write_key(int nargs, char **argv);
 int do_rpmb_read_counter(int nargs, char **argv);
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
