From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] cmds/read_extcsd: add a few new mmc 5.0 fields
Date: Thu,  5 Mar 2015 14:19:25 +0100
Message-ID: <1425561565-24806-4-git-send-email-bigeasy@linutronix.de>
References: <1425561565-24806-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49814 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbbCENTk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 08:19:40 -0500
In-Reply-To: <1425561565-24806-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The output then starts with:

|=============================================
|  Extended CSD rev 1.7 (MMC 5.0)
|=============================================
|
|Card Supported Command sets [S_CMD_SET: 0x01]
|HPI Features [HPI_FEATURE: 0x01]: implementation based on CMD13
|Background operations support [BKOPS_SUPPORT: 0x01]
|Extended Security Commands Error [EXT_SECURITY_ERR: 0x00]
|Device life time estimation type B [DEVICE_LIFE_TIME_EST_TYP_B: 01]
| i.e. 0% - 10% device life time used
|Device life time estimation type A [DEVICE_LIFE_TIME_EST_TYP_A: 01]
| i.e. 0% - 10% device life time used
|Pre EOL information [PRE_EOL_INFO: 01]
| i.e. normal
|Device version [DEVICE_VERSION: 38 05]
|Firmware version [FIRMWARE_VERSION: 00 00 00 00 00 00 00 03
| i.e.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mmc_cmds.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 8addd35046d7..195506b7b7ab 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -698,6 +698,28 @@ int do_write_reliability_set(int nargs, char **argv)
 	return 0;
 }
 
+static const char *ext_csd_get_lifetime(unsigned int val)
+{
+	static char lifetime[80];
+	switch (val) {
+	case 1 ... 0xa:
+		snprintf(lifetime, sizeof(lifetime),
+			 "%u%% - %u%% device life time used",
+			 (val - 1) * 10,
+			 (val - 0) * 10);
+		break;
+	case 0xb:
+		strncpy(lifetime, "Exceeded its maximum estimated "
+			"device life time", sizeof(lifetime));
+		break;
+	case 0:
+	default:
+		strncpy(lifetime, "Not defined", sizeof(lifetime));
+		break;
+	}
+	return lifetime;
+}
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
@@ -778,6 +800,53 @@ int do_read_extcsd(int nargs, char **argv)
 	printf("Background operations support [BKOPS_SUPPORT: 0x%02x]\n",
 		ext_csd[502]);
 
+	if (ext_csd_rev >= 7) {
+		const char *str;
+
+		printf("Extended Security Commands Error "
+		       "[EXT_SECURITY_ERR: 0x%02x]\n", ext_csd[505]);
+
+		printf("Device life time estimation type B "
+		       "[DEVICE_LIFE_TIME_EST_TYP_B: %02x]\n", ext_csd[269]);
+		printf(" i.e. %s\n", ext_csd_get_lifetime(ext_csd[269]));
+		printf("Device life time estimation type A "
+		       "[DEVICE_LIFE_TIME_EST_TYP_A: %02x]\n", ext_csd[268]);
+		printf(" i.e. %s\n", ext_csd_get_lifetime(ext_csd[268]));
+
+		printf("Pre EOL information [PRE_EOL_INFO: %02x]\n",
+		       ext_csd[267]);
+		switch (ext_csd[267]) {
+		case 1: str = "normal";
+			break;
+		case 2: str = "warning, consumed 80% of reserved block";
+			break;
+		case 3: str = "urgend";
+			break;
+		case 0:
+		default:
+			str = "Not defined";
+			break;
+		}
+		printf(" i.e. %s\n", str);
+		/* optimal read, write, trim size */
+
+		printf("Device version [DEVICE_VERSION: %02x %02x]\n",
+		       ext_csd[263], ext_csd[262]);
+		printf("Firmware version [FIRMWARE_VERSION: "
+		       "%02x %02x %02x %02x %02x %02x %02x %02x \n",
+		       ext_csd[261], ext_csd[260], ext_csd[259], ext_csd[258],
+		       ext_csd[257], ext_csd[256], ext_csd[255], ext_csd[254]);
+		printf(" i.e. %c%c%c%c%c%c%c%c\n",
+		       isprint(ext_csd[261]) ? ext_csd[261] : ' ',
+		       isprint(ext_csd[260]) ? ext_csd[260] : ' ',
+		       isprint(ext_csd[259]) ? ext_csd[259] : ' ',
+		       isprint(ext_csd[258]) ? ext_csd[258] : ' ',
+		       isprint(ext_csd[257]) ? ext_csd[257] : ' ',
+		       isprint(ext_csd[256]) ? ext_csd[256] : ' ',
+		       isprint(ext_csd[255]) ? ext_csd[255] : ' ',
+		       isprint(ext_csd[254]) ? ext_csd[254] : ' ');
+	}
+
 	if (ext_csd_rev >= 6) {
 		printf("Max Packet Read Cmd [MAX_PACKED_READS: 0x%02x]\n",
 			ext_csd[501]);
-- 
2.1.4

