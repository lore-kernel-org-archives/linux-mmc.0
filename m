From: James Nuss <jamesnuss@nanometrics.ca>
Subject: [PATCH 2/7] mmc-utils: treat FIRMWARE_VERSION as binary field instead of string
Date: Tue,  9 Oct 2018 13:31:06 -0400
Message-ID: <e2b6431104a6a822840d4e7b984d7aa23048a0af.1539103468.git.jamesnuss@nanometrics.ca>
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

The FIRMWARE_VERSION field is 8-bytes in size and contains non-printable
characters.

Treat this field as binary and print individual byte values in hex

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.h      |  9 ++++++++-
 mmc_cmds.c | 11 +++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/mmc.h b/mmc.h
index 5d8a7e3..86e209a 100644
--- a/mmc.h
+++ b/mmc.h
@@ -59,7 +59,14 @@
 #define EXT_CSD_OPTIMAL_READ_SIZE	266	/* RO */
 #define EXT_CSD_OPTIMAL_WRITE_SIZE	265	/* RO */
 #define EXT_CSD_OPTIMAL_TRIM_UNIT_SIZE	264	/* RO */
-#define EXT_CSD_FIRMWARE_VERSION	254	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_7	261	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_6	260	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_5	259	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_4	258	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_3	257	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_2	256	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_1	255	/* RO */
+#define EXT_CSD_FIRMWARE_VERSION_0	254	/* RO */
 #define EXT_CSD_CACHE_SIZE_3		252
 #define EXT_CSD_CACHE_SIZE_2		251
 #define EXT_CSD_CACHE_SIZE_1		250
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 97ea111..45aa4c0 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1758,8 +1758,15 @@ int do_read_extcsd(int nargs, char **argv)
 	}
 
 	if (ext_csd_rev >= 7) {
-		printf("eMMC Firmware Version: %s\n",
-			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
+		printf("Firmware Version: 0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_7],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_6],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_5],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_4],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_3],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_2],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_1],
+			ext_csd[EXT_CSD_FIRMWARE_VERSION_0]);
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
 		printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
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
