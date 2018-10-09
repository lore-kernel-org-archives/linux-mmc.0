From: James Nuss <jamesnuss@nanometrics.ca>
Subject: [PATCH 3/7] mmc-utils: interpret DEVICE_VERSION when printing extcsd
Date: Tue,  9 Oct 2018 13:31:07 -0400
Message-ID: <f3e073c1088ac17d0d749cb095e1adda8edda00b.1539103468.git.jamesnuss@nanometrics.ca>
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

The DEVICE_VERSION is a 2-byte field

Print the individual byte values in hex

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.h      | 2 ++
 mmc_cmds.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/mmc.h b/mmc.h
index 86e209a..f25869e 100644
--- a/mmc.h
+++ b/mmc.h
@@ -59,6 +59,8 @@
 #define EXT_CSD_OPTIMAL_READ_SIZE	266	/* RO */
 #define EXT_CSD_OPTIMAL_WRITE_SIZE	265	/* RO */
 #define EXT_CSD_OPTIMAL_TRIM_UNIT_SIZE	264	/* RO */
+#define EXT_CSD_DEVICE_VERSION_1	263	/* RO */
+#define EXT_CSD_DEVICE_VERSION_0	262	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION_7	261	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION_6	260	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION_5	259	/* RO */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 45aa4c0..756aa2f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1758,6 +1758,9 @@ int do_read_extcsd(int nargs, char **argv)
 	}
 
 	if (ext_csd_rev >= 7) {
+		printf("Device Version: 0x%02x%02x\n",
+			ext_csd[EXT_CSD_DEVICE_VERSION_1],
+			ext_csd[EXT_CSD_DEVICE_VERSION_0]);
 		printf("Firmware Version: 0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
 			ext_csd[EXT_CSD_FIRMWARE_VERSION_7],
 			ext_csd[EXT_CSD_FIRMWARE_VERSION_6],
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
