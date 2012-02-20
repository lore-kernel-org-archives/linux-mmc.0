From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc-utils: improve the parsing of the EXT_CSD registers
Date: Mon, 20 Feb 2012 12:43:17 -0500
Message-ID: <m28vjx5rka.fsf@bob.laptop.org>
References: <1329727529-3120-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52060 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103Ab2BTRng (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Feb 2012 12:43:36 -0500
In-Reply-To: <1329727529-3120-1-git-send-email-peppe.cavallaro@st.com>
	(Giuseppe CAVALLARO's message of "Mon, 20 Feb 2012 09:45:29 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org, sebras@gmail.com, linus.walleij@linaro.org, youssef.triki@st.com, Johan RUDHOLM <johan.rudholm@stericsson.com>

Hi Giuseppe,

On Mon, Feb 20 2012, Giuseppe CAVALLARO wrote:
> This patch enhances the debug information reported
> for the mmc card by parsing the extended CSD registers
> obviously according to all the current specifications.

Thanks, this is great!  I've pushed your patch.

I also moved Johan's writeprotect code into its own function, so now
the command set is:

	mmc extcsd read <device>
		Print extcsd data from <device>.
	mmc writeprotect get <device>
		Determine the eMMC writeprotect status of <device>.
	mmc writeprotect set <device>
		Set the eMMC writeprotect status of <device>.

(And "mmc writeprotect get" shares code for parsing that section of the
ext_csd with "mmc extcsd read".)

I don't think I have eMMC 4.5 hardware yet either; here's output from a
4.41 device:

=============================================
  Extended CSD rev 1.5 (MMC 4.41)
=============================================

Card Supported Command sets [S_CMD_SET: 0x01]
HPI Features [HPI_FEATURE: 0x01]: implementation based on CMD13
Background operations support [BKOPS_SUPPORT: 0x00]
Background operations status [BKOPS_STATUS: 0x00]
1st Initialisation Time after programmed sector [INI_TIMEOUT_AP: 0x0a]
Power class for 52MHz, DDR at 3.6V [PWR_CL_DDR_52_360: 0x00]
Power class for 52MHz, DDR at 1.95V [PWR_CL_DDR_52_195: 0x00]
Minimum Performance for 8bit at 52MHz in DDR mode:
 [MIN_PERF_DDR_W_8_52: 0x00]
 [MIN_PERF_DDR_R_8_52: 0x00]
TRIM Multiplier [TRIM_MULT: 0x02]
Secure Feature support [SEC_FEATURE_SUPPORT: 0x15]
Secure Erase Multiplier [SEC_ERASE_MULT: 0x96]
Secure TRIM Multiplier [SEC_TRIM_MULT: 0x96]
Boot Information [BOOT_INFO: 0x07]
 Device supports alternative boot method
 Device supports dual data rate during boot
 Device supports high speed timing during boot
Boot partition size [BOOT_SIZE_MULTI: 0x08]
Access size [ACC_SIZE: 0x06]
High-capacity erase unit size [HC_ERASE_GRP_SIZE: 0x04]
High-capacity erase timeout [ERASE_TIMEOUT_MULT: 0x01]
Reliable write sector count [REL_WR_SEC_C: 0x01]
High-capacity W protect group size [HC_WP_GRP_SIZE: 0x04]
Sleep current (VCC) [S_C_VCC: 0x08]
Sleep current (VCCQ) [S_C_VCCQ: 0x07]
Sleep/awake timeout [S_A_TIMEOUT: 0x11]
Sector Count [SEC_COUNT: 0x00760000]
Minimum Write Performance for 8bit:
 [MIN_PERF_W_8_52: 0x0a]
 [MIN_PERF_R_8_52: 0x0a]
 [MIN_PERF_W_8_26_4_52: 0x0a]
 [MIN_PERF_R_8_26_4_52: 0x0a]
Minimum Write Performance for 4bit:
 [MIN_PERF_W_4_26: 0x0a]
 [MIN_PERF_R_4_26: 0x0a]
Power classes registers:
 [PWR_CL_26_360: 0x00]
 [PWR_CL_52_360: 0x00]
 [PWR_CL_26_195: 0x00]
 [PWR_CL_52_195: 0x00]
Partition switching timing [PARTITION_SWITCH_TIME: 0x01]
Out-of-interrupt busy timing [OUT_OF_INTERRUPT_TIME: 0x02]
Card Type [CARD_TYPE: 0x07]
CSD structure version [CSD_STRUCTURE: 0x02]
Command set [CMD_SET: 0x00]
Command set revision [CMD_SET_REV: 0x00]
Power class [POWER_CLASS: 0x00]
High-speed interface timing [HS_TIMING: 0x01]
Erased memory content [ERASED_MEM_CONT: 0x00]
Boot configuration bytes [PARTITION_CONFIG: 0x00]
 Not boot enable
 No access to boot partition
Boot config protection [BOOT_CONFIG_PROT: 0x00]
Boot bus Conditions [BOOT_BUS_CONDITIONS: 0x00]
High-density erase group definition [ERASE_GROUP_DEF: 0x00]
Boot write protection status registers [BOOT_WP_STATUS]: 0x00
Boot Area Write protection [BOOT_WP]: 0x00
 Power ro locking: possible
 Permanent ro locking: possible
 ro lock status: not locked
User area write protection register [USER_WP]: 0x00
FW configuration [FW_CONFIG]: 0x00
RPMB Size [RPMB_SIZE_MULT]: 0x01
Write reliability setting register [WR_REL_SET]: 0x1f
Write reliability parameter register [WR_REL_PARAM]: 0x04
Enable background operations handshake [BKOPS_EN]: 0x00
H/W reset function [RST_N_FUNCTION]: 0x00
HPI management [HPI_MGMT]: 0x00
Partitioning Support [PARTITIONING_SUPPORT]: 0x03
 Device support partitioning feature
 Device can have enhanced tech.
Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x0000ec
Partitions attribute [PARTITIONS_ATTRIBUTE]: 0x00
Partitioning Setting [PARTITION_SETTING_COMPLETED]: 0x00
General Purpose Partition Size
 [GP_SIZE_MULT_4]: 0x000000
 [GP_SIZE_MULT_3]: 0x000000
 [GP_SIZE_MULT_2]: 0x000000
 [GP_SIZE_MULT_1]: 0x000000
Enhanced User Data Area Size [ENH_SIZE_MULT]: 0x000000
Enhanced User Data Start Address [ENH_START_ADDR]: 0x000000
Bad Block Management mode [SEC_BAD_BLK_MGMNT]: 0x00

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
