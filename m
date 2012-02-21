From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc-utils: improve the parsing of the EXT_CSD registers
Date: Tue, 21 Feb 2012 13:43:08 +0900
Message-ID: <4F4320DC.6010501@samsung.com>
References: <1329727529-3120-1-git-send-email-peppe.cavallaro@st.com>
 <m28vjx5rka.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44497 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab2BUEnL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 23:43:11 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZQ00GIX7RXHW60@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Feb 2012 13:43:09 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZQ008ZZ7RWSQ60@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Feb 2012 13:43:09 +0900 (KST)
In-reply-to: <m28vjx5rka.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Giuseppe CAVALLARO <peppe.cavallaro@st.com>, linux-mmc@vger.kernel.org, sebras@gmail.com, linus.walleij@linaro.org, youssef.triki@st.com, Johan RUDHOLM <johan.rudholm@stericsson.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 02/21/2012 02:43 AM, Chris Ball wrote:

> Hi Giuseppe,
> 
> On Mon, Feb 20 2012, Giuseppe CAVALLARO wrote:
>> This patch enhances the debug information reported
>> for the mmc card by parsing the extended CSD registers
>> obviously according to all the current specifications.
> 
> Thanks, this is great!  I've pushed your patch.
> 
> I also moved Johan's writeprotect code into its own function, so now
> the command set is:
> 
> 	mmc extcsd read <device>
> 		Print extcsd data from <device>.
> 	mmc writeprotect get <device>
> 		Determine the eMMC writeprotect status of <device>.
> 	mmc writeprotect set <device>
> 		Set the eMMC writeprotect status of <device>.
> 
> (And "mmc writeprotect get" shares code for parsing that section of the
> ext_csd with "mmc extcsd read".)

Hi Chris.

Write protect is only supported the "power-on".
If there is no problem to support "permanent", i will send the patch.
Is any problem to support "permanent"?

> 
> I don't think I have eMMC 4.5 hardware yet either; here's output from a
> 4.41 device:
> 
> =============================================
>   Extended CSD rev 1.5 (MMC 4.41)
> =============================================
> 
> Card Supported Command sets [S_CMD_SET: 0x01]
> HPI Features [HPI_FEATURE: 0x01]: implementation based on CMD13
> Background operations support [BKOPS_SUPPORT: 0x00]
> Background operations status [BKOPS_STATUS: 0x00]
> 1st Initialisation Time after programmed sector [INI_TIMEOUT_AP: 0x0a]
> Power class for 52MHz, DDR at 3.6V [PWR_CL_DDR_52_360: 0x00]
> Power class for 52MHz, DDR at 1.95V [PWR_CL_DDR_52_195: 0x00]
> Minimum Performance for 8bit at 52MHz in DDR mode:
>  [MIN_PERF_DDR_W_8_52: 0x00]
>  [MIN_PERF_DDR_R_8_52: 0x00]
> TRIM Multiplier [TRIM_MULT: 0x02]
> Secure Feature support [SEC_FEATURE_SUPPORT: 0x15]
> Secure Erase Multiplier [SEC_ERASE_MULT: 0x96]
> Secure TRIM Multiplier [SEC_TRIM_MULT: 0x96]
> Boot Information [BOOT_INFO: 0x07]
>  Device supports alternative boot method
>  Device supports dual data rate during boot
>  Device supports high speed timing during boot
> Boot partition size [BOOT_SIZE_MULTI: 0x08]
> Access size [ACC_SIZE: 0x06]
> High-capacity erase unit size [HC_ERASE_GRP_SIZE: 0x04]
> High-capacity erase timeout [ERASE_TIMEOUT_MULT: 0x01]
> Reliable write sector count [REL_WR_SEC_C: 0x01]
> High-capacity W protect group size [HC_WP_GRP_SIZE: 0x04]
> Sleep current (VCC) [S_C_VCC: 0x08]
> Sleep current (VCCQ) [S_C_VCCQ: 0x07]
> Sleep/awake timeout [S_A_TIMEOUT: 0x11]
> Sector Count [SEC_COUNT: 0x00760000]
> Minimum Write Performance for 8bit:
>  [MIN_PERF_W_8_52: 0x0a]
>  [MIN_PERF_R_8_52: 0x0a]
>  [MIN_PERF_W_8_26_4_52: 0x0a]
>  [MIN_PERF_R_8_26_4_52: 0x0a]
> Minimum Write Performance for 4bit:
>  [MIN_PERF_W_4_26: 0x0a]
>  [MIN_PERF_R_4_26: 0x0a]
> Power classes registers:
>  [PWR_CL_26_360: 0x00]
>  [PWR_CL_52_360: 0x00]
>  [PWR_CL_26_195: 0x00]
>  [PWR_CL_52_195: 0x00]
> Partition switching timing [PARTITION_SWITCH_TIME: 0x01]
> Out-of-interrupt busy timing [OUT_OF_INTERRUPT_TIME: 0x02]
> Card Type [CARD_TYPE: 0x07]
> CSD structure version [CSD_STRUCTURE: 0x02]
> Command set [CMD_SET: 0x00]
> Command set revision [CMD_SET_REV: 0x00]
> Power class [POWER_CLASS: 0x00]
> High-speed interface timing [HS_TIMING: 0x01]
> Erased memory content [ERASED_MEM_CONT: 0x00]
> Boot configuration bytes [PARTITION_CONFIG: 0x00]
>  Not boot enable
>  No access to boot partition
> Boot config protection [BOOT_CONFIG_PROT: 0x00]
> Boot bus Conditions [BOOT_BUS_CONDITIONS: 0x00]
> High-density erase group definition [ERASE_GROUP_DEF: 0x00]
> Boot write protection status registers [BOOT_WP_STATUS]: 0x00
> Boot Area Write protection [BOOT_WP]: 0x00
>  Power ro locking: possible
>  Permanent ro locking: possible
>  ro lock status: not locked
> User area write protection register [USER_WP]: 0x00
> FW configuration [FW_CONFIG]: 0x00
> RPMB Size [RPMB_SIZE_MULT]: 0x01
> Write reliability setting register [WR_REL_SET]: 0x1f
> Write reliability parameter register [WR_REL_PARAM]: 0x04
> Enable background operations handshake [BKOPS_EN]: 0x00
> H/W reset function [RST_N_FUNCTION]: 0x00
> HPI management [HPI_MGMT]: 0x00
> Partitioning Support [PARTITIONING_SUPPORT]: 0x03
>  Device support partitioning feature
>  Device can have enhanced tech.
> Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x0000ec
> Partitions attribute [PARTITIONS_ATTRIBUTE]: 0x00
> Partitioning Setting [PARTITION_SETTING_COMPLETED]: 0x00
> General Purpose Partition Size
>  [GP_SIZE_MULT_4]: 0x000000
>  [GP_SIZE_MULT_3]: 0x000000
>  [GP_SIZE_MULT_2]: 0x000000
>  [GP_SIZE_MULT_1]: 0x000000
> Enhanced User Data Area Size [ENH_SIZE_MULT]: 0x000000
> Enhanced User Data Start Address [ENH_START_ADDR]: 0x000000
> Bad Block Management mode [SEC_BAD_BLK_MGMNT]: 0x00
> 


Here's output from eMMC4.5 device.

=============================================
  Extended CSD rev 1.6 (MMC 4.5)
=============================================

Card Supported Command sets [S_CMD_SET: 0x01]
HPI Features [HPI_FEATURE: 0x01]: implementation based on CMD13
Background operations support [BKOPS_SUPPORT: 0x01]
Max Packet Read Cmd [MAX_PACKED_READS: 0x3f]
Max Packet Write Cmd [MAX_PACKED_WRITES: 0x3f]
Data TAG support [DATA_TAG_SUPPORT: 0x01]
Data TAG Unit Size [TAG_UNIT_SIZE: 0x04]
Tag Resources Size [TAG_RES_SIZE: 0x00]
Context Management Capabilities [CONTEXT_CAPABILITIES: 0x05]
Large Unit Size [LARGE_UNIT_SIZE_M1: 0x07]
Extended partition attribute support [EXT_SUPPORT: 0x03]
Generic CMD6 Timer [GENERIC_CMD6_TIME: 0x0a]
Power off notification [POWER_OFF_LONG_TIME: 0x3c]
Cache Size [CACHE_SIZE] is 65536 KiB
Background operations status [BKOPS_STATUS: 0x00]
1st Initialisation Time after programmed sector [INI_TIMEOUT_AP: 0x1e]
Power class for 52MHz, DDR at 3.6V [PWR_CL_DDR_52_360: 0x00]
Power class for 52MHz, DDR at 1.95V [PWR_CL_DDR_52_195: 0x00]
Power class for 200MHz at 3.6V [PWR_CL_200_360: 0x00]
Power class for 200MHz, at 1.95V [PWR_CL_200_195: 0x00]
Minimum Performance for 8bit at 52MHz in DDR mode:
 [MIN_PERF_DDR_W_8_52: 0x00]
 [MIN_PERF_DDR_R_8_52: 0x00]
TRIM Multiplier [TRIM_MULT: 0x02]
Secure Feature support [SEC_FEATURE_SUPPORT: 0x55]
Boot Information [BOOT_INFO: 0x07]
 Device supports alternative boot method
 Device supports dual data rate during boot
 Device supports high speed timing during boot
Boot partition size [BOOT_SIZE_MULTI: 0x10]
Access size [ACC_SIZE: 0x07]
High-capacity erase unit size [HC_ERASE_GRP_SIZE: 0x01]
High-capacity erase timeout [ERASE_TIMEOUT_MULT: 0x01]
Reliable write sector count [REL_WR_SEC_C: 0x01]
High-capacity W protect group size [HC_WP_GRP_SIZE: 0x50]
Sleep current (VCC) [S_C_VCC: 0x07]
Sleep current (VCCQ) [S_C_VCCQ: 0x07]
Sleep/awake timeout [S_A_TIMEOUT: 0x11]
Sector Count [SEC_COUNT: 0x01d5a000]
Minimum Write Performance for 8bit:
 [MIN_PERF_W_8_52: 0x00]
 [MIN_PERF_R_8_52: 0x00]
 [MIN_PERF_W_8_26_4_52: 0x00]
 [MIN_PERF_R_8_26_4_52: 0x00]
Minimum Write Performance for 4bit:
 [MIN_PERF_W_4_26: 0x00]
 [MIN_PERF_R_4_26: 0x00]
Power classes registers:
 [PWR_CL_26_360: 0x00]
 [PWR_CL_52_360: 0x00]
 [PWR_CL_26_195: 0x00]
 [PWR_CL_52_195: 0x00]
Partition switching timing [PARTITION_SWITCH_TIME: 0x01]
Out-of-interrupt busy timing [OUT_OF_INTERRUPT_TIME: 0x03]
I/O Driver Strength [DRIVER_STRENGTH: 0x00]
Card Type [CARD_TYPE: 0x07]
CSD structure version [CSD_STRUCTURE: 0x02]
Command set [CMD_SET: 0x00]
Command set revision [CMD_SET_REV: 0x00]
Power class [POWER_CLASS: 0x00]
High-speed interface timing [HS_TIMING: 0x01]
Erased memory content [ERASED_MEM_CONT: 0x00]
Boot configuration bytes [PARTITION_CONFIG: 0x48]
 No access to boot partition
Boot config protection [BOOT_CONFIG_PROT: 0x01]
Boot bus Conditions [BOOT_BUS_CONDITIONS: 0x01]
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
Write reliability parameter register [WR_REL_PARAM]: 0x05
Enable background operations handshake [BKOPS_EN]: 0x00
H/W reset function [RST_N_FUNCTION]: 0x00
HPI management [HPI_MGMT]: 0x01
Partitioning Support [PARTITIONING_SUPPORT]: 0x07
 Device support partitioning feature
 Device can have enhanced tech.
Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x0000bb
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
Periodic Wake-up [PERIODIC_WAKEUP]: 0x00
Program CID/CSD in DDR mode support [PROGRAM_CID_CSD_DDR_SUPPORT]: 0x01

