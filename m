From: James Nuss <jamesnuss@nanometrics.ca>
Subject: [PATCH 1/7] mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
Date: Tue,  9 Oct 2018 13:31:05 -0400
Message-ID: <4a016f761d388a989059467507f2bc948ba26c6c.1539103468.git.jamesnuss@nanometrics.ca>
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

eMMC 5.0 introduced OPTIMAL_READ_SIZE, OPTIMAL_WRITE_SIZE and OPTIMAL
TRIM_UNIT_SIZE fields in the extcsd

Interpret these fields when reading out the extcsd with human-readable
results

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.h      |  3 +++
 mmc_cmds.c | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/mmc.h b/mmc.h
index 285c1f1..5d8a7e3 100644
--- a/mmc.h
+++ b/mmc.h
@@ -56,6 +56,9 @@
 #define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B 	269	/* RO */
 #define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A 	268	/* RO */
 #define EXT_CSD_PRE_EOL_INFO		267	/* RO */
+#define EXT_CSD_OPTIMAL_READ_SIZE	266	/* RO */
+#define EXT_CSD_OPTIMAL_WRITE_SIZE	265	/* RO */
+#define EXT_CSD_OPTIMAL_TRIM_UNIT_SIZE	264	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO */
 #define EXT_CSD_CACHE_SIZE_3		252
 #define EXT_CSD_CACHE_SIZE_2		251
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 44623fe..97ea111 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1766,6 +1766,24 @@ int do_read_extcsd(int nargs, char **argv)
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]);
 		printf("eMMC Pre EOL information [EXT_CSD_PRE_EOL_INFO]: 0x%02x\n",
 			ext_csd[EXT_CSD_PRE_EOL_INFO]);
+
+		reg = ext_csd[EXT_CSD_OPTIMAL_READ_SIZE];
+		printf("Minimum optimal read unit size (for the device) "
+			"[OPTIMAL_READ_SIZE]: 0x%02x\n", reg);
+		printf(" i.e. %lu KiB\n", reg * 4UL);
+
+		reg = ext_csd[EXT_CSD_OPTIMAL_WRITE_SIZE];
+		printf("Minimum optimal write unit size (for the device) "
+			"[OPTIMAL_WRITE_SIZE]: 0x%02x\n", reg);
+		printf(" i.e. %lu KiB\n", reg * 4UL);
+
+		reg = ext_csd[EXT_CSD_OPTIMAL_TRIM_UNIT_SIZE];
+		printf("Minimum optimal trim unit size (for the device) "
+			"[OPTIMAL_TRIM_UNIT_SIZE]: 0x%02x\n", reg);
+		if (reg == 0 || reg > 21)
+			printf("error: invalid OPTIMAL_TRIM_UNIT_SIZE\n");
+		else
+			printf(" i.e. %lu KiB\n", (1UL << (reg - 1)) * 4);
 	}
 
 	if (ext_csd_rev >= 8) {
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
