From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH] mmc-utils: improve the parsing of the EXT_CSD registers
Date: Mon, 20 Feb 2012 09:45:29 +0100
Message-ID: <1329727529-3120-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:49499 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751760Ab2BTIqa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 03:46:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: sebras@gmail.com, cjb@laptop.org, linus.walleij@linaro.org, youssef.triki@st.com, Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch enhances the debug information reported
for the mmc card by parsing the extended CSD registers
obviously according to all the current specifications.

I have no HW to test eMMC 4.5 at this moment. In any case,
the patch supports JEDEC Standard No. 84-B45.
No issues on JESD84-A441 and older specs raised on my side.

This patch indeed want to start providing a full parsing
of the all EXT_CSD registers in the following layout:

Name [FIELD: <value>]

Voluntarily, I added the FIELD because it can actually help on
searching though the SPEC in case of doubts.
In fact, in this stage, not all the register bits are yet parsed.
Currently this has been done for a small subset of registers
(e.g. 173, 160 ...) where IMO it's quite useful for an end-user
to get some details. I do hope this will be improved in the near
feature (also for write operations).

P.S. The original patch posted time ago for the Kernel has been
reviewed-by Sebastian Rasmussen, acked-by: Linus Walleij and reported
by Youssef Tiki.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 mmc.h      |   16 ++-
 mmc_cmds.c |  415 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 408 insertions(+), 23 deletions(-)

diff --git a/mmc.h b/mmc.h
index 8540f3d..3af36f1 100644
--- a/mmc.h
+++ b/mmc.h
@@ -29,17 +29,29 @@
 /*
  * EXT_CSD fields
  */
-#define EXT_CSD_BOOT_WP			173	/* R/W */
-#define EXT_CSD_PART_SWITCH_TIME	199	/* RO */
+#define EXT_CSD_S_CMD_SET		504
+#define EXT_CSD_HPI_FEATURE		503
+#define EXT_CSD_BOOT_INFO		228	/* R/W */
+#define EXT_CSD_PART_SWITCH_TIME	199
+#define EXT_CSD_BOOT_CFG		179
+#define EXT_CSD_BOOT_WP			173
 
 /*
  * EXT_CSD field definitions
  */
+#define EXT_CSD_HPI_SUPP		(1<<0)
+#define EXT_CSD_HPI_IMPL		(1<<1)
 #define EXT_CSD_CMD_SET_NORMAL		(1<<0)
 #define EXT_CSD_BOOT_WP_B_PWR_WP_DIS	(0x40)
 #define EXT_CSD_BOOT_WP_B_PERM_WP_DIS	(0x10)
 #define EXT_CSD_BOOT_WP_B_PERM_WP_EN	(0x04)
 #define EXT_CSD_BOOT_WP_B_PWR_WP_EN	(0x01)
+#define EXT_CSD_BOOT_INFO_HS_MODE	(1<<2)
+#define EXT_CSD_BOOT_INFO_DDR_DDR	(1<<1)
+#define EXT_CSD_BOOT_INFO_ALT		(1<<0)
+#define EXT_CSD_BOOT_CFG_ACK		(1<<6)
+#define EXT_CSD_BOOT_CFG_EN		(0x38)
+#define EXT_CSD_BOOT_CFG_ACC		(0x03)
 
 /* From kernel linux/mmc/core.h */
 #define MMC_RSP_PRESENT	(1 << 0)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index dce3ecc..36731e2 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -74,9 +74,10 @@ int write_extcsd_value(int fd, __u8 index, __u8 value)
 
 int do_read_extcsd(int nargs, char **argv)
 {
-	__u8 ext_csd[512];
+	__u8 ext_csd[512], ext_csd_rev, reg;
 	int fd, ret;
 	char *device;
+	const char *str;
 
 	CHECK(nargs != 2, "Usage: mmc </path/to/mmcblkX>\n", exit(1));
 
@@ -94,26 +95,398 @@ int do_read_extcsd(int nargs, char **argv)
 		exit(1);
 	}
 
-	printf("Power ro locking: ");
-	if (ext_csd[EXT_CSD_BOOT_WP] & EXT_CSD_BOOT_WP_B_PWR_WP_DIS)
-		printf("not possible\n");
-	else
-		printf("possible\n");
-        
-	printf("Permanent ro locking: ");
-	if (ext_csd[EXT_CSD_BOOT_WP] & EXT_CSD_BOOT_WP_B_PERM_WP_DIS)
-		printf("not possible\n");
-	else
-		printf("possible\n");
-        
-	printf("ro lock status: ");
-	if (ext_csd[EXT_CSD_BOOT_WP] & EXT_CSD_BOOT_WP_B_PWR_WP_EN)
-		printf("locked until next power on\n");
-	else if (ext_csd[EXT_CSD_BOOT_WP] &
-		 EXT_CSD_BOOT_WP_B_PERM_WP_EN)
-		printf("locked permanently\n");
-	else
-		printf("not locked\n");
+	ext_csd_rev = ext_csd[192];
+
+	switch (ext_csd_rev) {
+	case 6:
+		str = "4.5";
+		break;
+	case 5:
+		str = "4.41";
+		break;
+	case 3:
+		str = "4.3";
+		break;
+	case 2:
+		str = "4.2";
+		break;
+	case 1:
+		str = "4.1";
+		break;
+	case 0:
+		str = "4.0";
+		break;
+	default:
+		goto out_free;
+	}
+	printf("=============================================\n");
+	printf("  Extended CSD rev 1.%d (MMC %s)\n", ext_csd_rev, str);
+	printf("=============================================\n\n");
+
+	if (ext_csd_rev < 3)
+		goto out_free; /* No ext_csd */
+
+	/* Parse the Extended CSD registers.
+	 * Reserved bit should be read as "0" in case of spec older
+	 * than A441.
+	 */
+	reg = ext_csd[EXT_CSD_S_CMD_SET];
+	printf("Card Supported Command sets [S_CMD_SET: 0x%02x]\n", reg);
+	if (!reg)
+		printf(" - Standard MMC coomand sets\n");
+
+	reg = ext_csd[EXT_CSD_HPI_FEATURE];
+	printf("HPI Features [HPI_FEATURE: 0x%02x]: ", reg);
+	if (reg & EXT_CSD_HPI_SUPP) {
+		if (reg & EXT_CSD_HPI_IMPL)
+			printf("implementationbased on CMD12\n");
+		else
+			printf("implementation based on CMD13\n");
+	}
+
+	printf("Background operations support [BKOPS_SUPPORT: 0x%02x]\n",
+		ext_csd[502]);
+
+	if (ext_csd_rev >= 6) {
+		printf("Max Packet Read Cmd [MAX_PACKED_READS: 0x%02x]\n",
+			ext_csd[501]);
+		printf("Max Packet Write Cmd [MAX_PACKED_WRITES: 0x%02x]\n",
+			ext_csd[500]);
+		printf("Data TAG support [DATA_TAG_SUPPORT: 0x%02x]\n",
+			ext_csd[499]);
+
+		printf("Data TAG Unit Size [TAG_UNIT_SIZE: 0x%02x]\n",
+			ext_csd[498]);
+		printf("Tag Resources Size [TAG_RES_SIZE: 0x%02x]\n",
+			ext_csd[497]);
+		printf("Context Management Capabilities"
+			" [CONTEXT_CAPABILITIES: 0x%02x]\n", ext_csd[496]);
+		printf("Large Unit Size [LARGE_UNIT_SIZE_M1: 0x%02x]\n",
+			ext_csd[495]);
+		printf("Extended partition attribute support"
+			" [EXT_SUPPORT: 0x%02x]\n", ext_csd[494]);
+		printf("Generic CMD6 Timer [GENERIC_CMD6_TIME: 0x%02x]\n",
+			ext_csd[248]);
+		printf("Power off notification [POWER_OFF_LONG_TIME: 0x%02x]\n",
+			ext_csd[247]);
+		printf("Cache Size [CACHE_SIZE] is %d KiB\n",
+			ext_csd[249] << 0 | (ext_csd[250] << 8) |
+			(ext_csd[251] << 16) | (ext_csd[252] << 24));
+	}
+
+	/* A441: Reserved [501:247]
+	    A43: reserved [246:229] */
+	if (ext_csd_rev >= 5) {
+
+		printf("Background operations status"
+			"[BKOPS_STATUS: 0x%02x]\n", ext_csd[246]);
+
+		/* CORRECTLY_PRG_SECTORS_NUM [245:242] TODO */
+
+		printf("1st Initialisation Time after programmed sector"
+			" [INI_TIMEOUT_AP: 0x%02x]\n", ext_csd[241]);
+
+		/* A441: reserved [240] */
+
+		printf("Power class for 52MHz, DDR at 3.6V"
+			" [PWR_CL_DDR_52_360: 0x%02x]\n", ext_csd[239]);
+		printf("Power class for 52MHz, DDR at 1.95V"
+			" [PWR_CL_DDR_52_195: 0x%02x]\n", ext_csd[238]);
+
+		/* A441: reserved [237-236] */
+
+		if (ext_csd_rev >= 6) {
+			printf("Power class for 200MHz at 3.6V"
+				" [PWR_CL_200_360: 0x%02x]\n", ext_csd[237]);
+			printf("Power class for 200MHz, at 1.95V"
+				" [PWR_CL_200_195: 0x%02x]\n", ext_csd[236]);
+		}
+		printf("Minimum Performances for 8bit at 52MHz in DDR mode:\n");
+		printf(" [MIN_PERF_DDR_W_8_52: 0x%02x]\n", ext_csd[235]);
+		printf(" [MIN_PERF_DDR_R_8_52: 0x%02x]\n", ext_csd[234]);
+		/* A441: reserved [233] */
+		printf("TRIM Multiplier [TRIM_MULT: 0x%02x]\n", ext_csd[232]);
+		printf("Secure Feature support [SEC_FEATURE_SUPPORT: 0x%02x]\n",
+			ext_csd[231]);
+	}
+	if (ext_csd_rev == 5) { /* Obsolete in 4.5 */
+		printf("Secure Erase Multiplier [SEC_ERASE_MULT: 0x%02x]\n",
+			ext_csd[230]);
+		printf("Secure TRIM Multiplier [SEC_TRIM_MULT: 0x%02x]\n",
+			ext_csd[229]);
+	}
+	reg = ext_csd[EXT_CSD_BOOT_INFO];
+	printf("Boot Information [BOOT_INFO: 0x%02x]\n", reg);
+	if (reg & EXT_CSD_BOOT_INFO_ALT)
+		printf(" Device supports alternative boot method\n");
+	if (reg & EXT_CSD_BOOT_INFO_DDR_DDR)
+		printf(" Device supports dual data rate during boot\n");
+	if (reg & EXT_CSD_BOOT_INFO_HS_MODE)
+		printf(" Device supports high speed timing during boot\n");
+
+	/* A441/A43: reserved [227] */
+	printf("Boot partition size [BOOT_SIZE_MULTI: 0x%02x]\n", ext_csd[226]);
+	printf("Access size [ACC_SIZE: 0x%02x]\n", ext_csd[225]);
+	printf("High-capacity erase unit size [HC_ERASE_GRP_SIZE: 0x%02x]\n",
+		ext_csd[224]);
+	printf("High-capacity erase timeout [ERASE_TIMEOUT_MULT: 0x%02x]\n",
+		ext_csd[223]);
+	printf("Reliable write sector count [REL_WR_SEC_C: 0x%02x]\n",
+		ext_csd[222]);
+	printf("High-capacity W protect group size [HC_WP_GRP_SIZE: 0x%02x]\n",
+		ext_csd[221]);
+	printf("Sleep current (VCC) [S_C_VCC: 0x%02x]\n", ext_csd[220]);
+	printf("Sleep current (VCCQ) [S_C_VCCQ: 0x%02x]\n", ext_csd[219]);
+	/* A441/A43: reserved [218] */
+	printf("Sleep/awake timeout [S_A_TIMEOUT: 0x%02x]\n", ext_csd[217]);
+	/* A441/A43: reserved [216] */
+	printf("Sector Count [SEC_COUNT: 0x%08x]\n", (ext_csd[215] << 24) |
+		      (ext_csd[214] << 16) | (ext_csd[213] << 8)  |
+		      ext_csd[212]);
+	/* A441/A43: reserved [211] */
+	printf("Minimum Write Performance for 8bit:\n");
+	printf(" [MIN_PERF_W_8_52: 0x%02x]\n", ext_csd[210]);
+	printf(" [MIN_PERF_R_8_52: 0x%02x]\n", ext_csd[209]);
+	printf(" [MIN_PERF_W_8_26_4_52: 0x%02x]\n", ext_csd[208]);
+	printf(" [MIN_PERF_R_8_26_4_52: 0x%02x]\n", ext_csd[207]);
+	printf("Minimum Write Performance for 4bit:\n");
+	printf(" [MIN_PERF_W_4_26: 0x%02x]\n", ext_csd[206]);
+	printf(" [MIN_PERF_R_4_26: 0x%02x]\n", ext_csd[205]);
+	/* A441/A43: reserved [204] */
+	printf("Power classes registers:\n");
+	printf(" [PWR_CL_26_360: 0x%02x]\n", ext_csd[203]);
+	printf(" [PWR_CL_52_360: 0x%02x]\n", ext_csd[202]);
+	printf(" [PWR_CL_26_195: 0x%02x]\n", ext_csd[201]);
+	printf(" [PWR_CL_52_195: 0x%02x]\n", ext_csd[200]);
+
+	/* A43: reserved [199:198] */
+	if (ext_csd_rev >= 5) {
+		printf("Partition switching timing "
+			"[PARTITION_SWITCH_TIME: 0x%02x]\n", ext_csd[199]);
+		printf("Out-of-interrupt busy timing"
+			" [OUT_OF_INTERRUPT_TIME: 0x%02x]\n", ext_csd[198]);
+	}
+
+	/* A441/A43: reserved	[197] [195] [193] [190] [188]
+	 * [186] [184] [182] [180] [176] */
+
+	if (ext_csd_rev >= 6)
+		printf("I/O Driver Strength [DRIVER_STRENGTH: 0x%02x]\n",
+			ext_csd[197]);
+
+	printf("Card Type [CARD_TYPE: 0x%02x]\n", ext_csd[196]);
+	/* DEVICE_TYPE in A45 */
+	switch (reg) {
+	case 5:
+		printf("HS200 Single Data Rate eMMC @200MHz 1.2VI/O\n");
+		break;
+	case 4:
+		printf("HS200 Single Data Rate eMMC @200MHz 1.8VI/O\n");
+		break;
+	case 3:
+		printf("HS Dual Data Rate eMMC @52MHz 1.2VI/O\n");
+
+		break;
+	case 2:
+		printf("HS Dual Data Rate eMMC @52MHz 1.8V or 3VI/O\n");
+		break;
+	case 1:
+		printf("HS eMMC @52MHz - at rated device voltage(s)\n");
+		break;
+	case 0:
+		printf("HS eMMC @26MHz - at rated device voltage(s)\n");
+		break;
+	}
+	printf("CSD structure version [CSD_STRUCTURE: 0x%02x]\n", ext_csd[194]);
+	/* ext_csd_rev = ext_csd[192] (already done!!!) */
+	printf("Command set [CMD_SET: 0x%02x]\n", ext_csd[191]);
+	printf("Command set revision [CMD_SET_REV: 0x%02x]\n", ext_csd[189]);
+	printf("Power class [POWER_CLASS: 0x%02x]\n", ext_csd[187]);
+	printf("High-speed interface timing [HS_TIMING: 0x%02x]\n",
+		ext_csd[185]);
+	/* bus_width: ext_csd[183] not readable */
+	printf("Erased memory content [ERASED_MEM_CONT: 0x%02x]\n",
+		ext_csd[181]);
+	reg = ext_csd[EXT_CSD_BOOT_CFG];
+	printf("Boot configuration bytes [PARTITION_CONFIG: 0x%02x]\n", reg);
+	switch (reg & EXT_CSD_BOOT_CFG_EN) {
+	case 0x0:
+		printf(" Not boot enable\n");
+		break;
+	case 0x1:
+		printf(" Boot Partition 1 enabled\n");
+		break;
+	case 0x2:
+		printf(" Boot Partition 2 enabled\n");
+		break;
+	case 0x7:
+		printf(" User Area Enabled for boot\n");
+		break;
+	}
+	switch (reg & EXT_CSD_BOOT_CFG_ACC) {
+	case 0x0:
+		printf(" No access to boot partition\n");
+		break;
+	case 0x1:
+		printf(" R/W Boot Partition 1\n");
+		break;
+	case 0x2:
+		printf(" R/W Boot Partition 2\n");
+		break;
+	default:
+		printf(" Access to General Purpuse partition %d\n",
+			(reg & EXT_CSD_BOOT_CFG_ACC) - 3);
+		break;
+	}
+
+	printf("Boot config protection [BOOT_CONFIG_PROT: 0x%02x]\n",
+		ext_csd[178]);
+	printf("Boot bus Conditions [BOOT_BUS_CONDITIONS: 0x%02x]\n",
+		ext_csd[177]);
+	printf("High-density erase group definition"
+		" [ERASE_GROUP_DEF: 0x%02x]\n", ext_csd[175]);
+
+	/* A43: reserved [174:0] */
+	if (ext_csd_rev >= 5) {
+		printf("Boot write protection status registers"
+			" [BOOT_WP_STATUS]: 0x%02x\n", ext_csd[174]);
+
+		reg = ext_csd[EXT_CSD_BOOT_WP];
+		printf("Boot Area Write protection [BOOT_WP]: 0x%02x\n", reg);
+		printf(" Power ro locking: ");
+		if (reg & EXT_CSD_BOOT_WP_B_PWR_WP_DIS)
+			printf("not possible\n");
+		else
+			printf("possible\n");
+
+		printf(" Permanent ro locking: ");
+		if (reg & EXT_CSD_BOOT_WP_B_PERM_WP_DIS)
+			printf("not possible\n");
+		else
+			printf("possible\n");
+
+		printf(" ro lock status: ");
+		if (reg & EXT_CSD_BOOT_WP_B_PWR_WP_EN)
+			printf("locked until next power on\n");
+		else if (reg &
+			 EXT_CSD_BOOT_WP_B_PERM_WP_EN)
+			printf("locked permanently\n");
+		else
+			printf("not locked\n");
+
+		/* A441]: reserved [172] */
+		printf("User area write protection register"
+			" [USER_WP]: 0x%02x\n", ext_csd[171]);
+		/* A441]: reserved [170] */
+		printf("FW configuration [FW_CONFIG]: 0x%02x\n", ext_csd[169]);
+		printf("RPMB Size [RPMB_SIZE_MULT]: 0x%02x\n", ext_csd[168]);
+		printf("Write reliability setting register"
+			" [WR_REL_SET]: 0x%02x\n", ext_csd[167]);
+		printf("Write reliability parameter register"
+			" [WR_REL_PARAM]: 0x%02x\n", ext_csd[166]);
+		/* sanitize_start ext_csd[165]]: not readable
+		 * bkops_start ext_csd[164]]: only writable */
+		printf("Enable background operations handshake"
+			" [BKOPS_EN]: 0x%02x\n", ext_csd[163]);
+		printf("H/W reset function"
+			" [RST_N_FUNCTION]: 0x%02x\n", ext_csd[162]);
+		printf("HPI management [HPI_MGMT]: 0x%02x\n", ext_csd[161]);
+		reg = ext_csd[160];
+		printf("Partitioning Support [PARTITIONING_SUPPORT]: 0x%02x\n",
+			reg);
+		if (reg & 0x1)
+			printf(" Device support partitioning feature\n");
+		else
+			printf(" Device NOT support partitioning feature\n");
+		if (reg & 0x2)
+			printf(" Device can have enhanced tech.\n");
+		else
+			printf(" Device cannot have enhanced tech.\n");
+
+		printf("Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x%06x\n",
+			   (ext_csd[159] << 16) | (ext_csd[158] << 8) |
+			    ext_csd[157]);
+		printf("Partitions attribute [PARTITIONS_ATTRIBUTE]: 0x%02x\n",
+			ext_csd[156]);
+		printf("Partitioning Setting"
+			" [PARTITION_SETTING_COMPLETED]: 0x%02x\n",
+			ext_csd[155]);
+		printf("General Purpose Partition Size\n"
+			" [GP_SIZE_MULT_4]: 0x%06x\n", (ext_csd[154] << 16) |
+			(ext_csd[153] << 8) | ext_csd[152]);
+		printf(" [GP_SIZE_MULT_3]: 0x%06x\n", (ext_csd[151] << 16) |
+			   (ext_csd[150] << 8) | ext_csd[149]);
+		printf(" [GP_SIZE_MULT_2]: 0x%06x\n", (ext_csd[148] << 16) |
+			   (ext_csd[147] << 8) | ext_csd[146]);
+		printf(" [GP_SIZE_MULT_1]: 0x%06x\n", (ext_csd[145] << 16) |
+			   (ext_csd[144] << 8) | ext_csd[143]);
+
+		printf("Enhanced User Data Area Size"
+			" [ENH_SIZE_MULT]: 0x%06x\n", (ext_csd[142] << 16) |
+			(ext_csd[141] << 8) | ext_csd[140]);
+		printf("Enhanced User Data Start Address"
+			" [ENH_START_ADDR]: 0x%06x\n", (ext_csd[139] << 16) |
+			   (ext_csd[138] << 8) | ext_csd[137]);
+
+		/* A441]: reserved [135] */
+		printf("Bad Block Management mode"
+			" [SEC_BAD_BLK_MGMNT]: 0x%02x\n", ext_csd[134]);
+		/* A441: reserved [133:0] */
+	}
+	/* B45 */
+	if (ext_csd_rev >= 6) {
+		int j;
+		/* tcase_support ext_csd[132] not readable */
+		printf("Periodic Wake-up [PERIODIC_WAKEUP]: 0x%02x\n",
+			ext_csd[131]);
+		printf("Program CID/CSD in DDR mode support"
+			" [PROGRAM_CID_CSD_DDR_SUPPORT]: 0x%02x\n",
+			   ext_csd[130]);
+
+		for (j = 127; j >= 64; j--)
+			printf("Vendor Specific Fields"
+				" [VENDOR_SPECIFIC_FIELD[%d]]: 0x%02x\n",
+				j, ext_csd[j]);
+
+		printf("Native sector size [NATIVE_SECTOR_SIZE]: 0x%02x\n",
+			ext_csd[63]);
+		printf("Sector size emulation [USE_NATIVE_SECTOR]: 0x%02x\n",
+			ext_csd[62]);
+		printf("Sector size [DATA_SECTOR_SIZE]: 0x%02x\n", ext_csd[61]);
+		printf("1st initialization after disabling sector"
+			" size emulation [INI_TIMEOUT_EMU]: 0x%02x\n",
+			ext_csd[60]);
+		printf("Class 6 commands control [CLASS_6_CTRL]: 0x%02x\n",
+			ext_csd[59]);
+		printf("Number of addressed group to be Released"
+			"[DYNCAP_NEEDED]: 0x%02x\n", ext_csd[58]);
+		printf("Exception events control"
+			" [EXCEPTION_EVENTS_CTRL]: 0x%04x\n",
+			(ext_csd[57] << 8) | ext_csd[56]);
+		printf("Exception events status"
+			"[EXCEPTION_EVENTS_STATUS]: 0x%04x\n",
+			(ext_csd[55] << 8) | ext_csd[54]);
+		printf("Extended Partitions Attribute"
+			" [EXT_PARTITIONS_ATTRIBUTE]: 0x%04x\n",
+			(ext_csd[53] << 8) | ext_csd[52]);
+
+		for (j = 51; j >= 37; j--)
+			printf("Context configuration"
+				" [CONTEXT_CONF[%d]]: 0x%02x\n", j, ext_csd[j]);
+
+		printf("Packed command status"
+			" [PACKED_COMMAND_STATUS]: 0x%02x\n", ext_csd[36]);
+		printf("Packed command failure index"
+			" [PACKED_FAILURE_INDEX]: 0x%02x\n", ext_csd[35]);
+		printf("Power Off Notification"
+			" [POWER_OFF_NOTIFICATION]: 0x%02x\n", ext_csd[34]);
+		printf("Control to turn the Cache ON/OFF"
+			" [CACHE_CTRL]: 0x%02x\n", ext_csd[33]);
+		/* flush_cache ext_csd[32] not readable */
+		/*Reserved [31:0] */
+	}
+
+out_free:
 
 	return ret;
 }
-- 
1.7.4.4

