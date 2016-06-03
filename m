From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: mmc-utils: fully configure emmc user data area for enhanced mode
Date: Fri, 03 Jun 2016 20:12:18 +0200
Message-ID: <1be67b76a4dc301ace66185036789fe0@mail.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:12662 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbcFCTKr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2016 15:10:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org

Hi,

I want to configure an entire eMMC chip to enhanced mode (pseudoSLC).

The mmc-util(s) seem to be the right choice. But what values do I need
to pass for the entire chip for start and length?

mmc enh_area set -y <start KiB> <length KiB> /dev/mmcblk0

This is what extcsd says on my system:

root@mybox:~# mmc extcsd read /dev/mmcblk0
=============================================
   Extended CSD rev 1.5 (MMC 4.41)
=============================================

Card Supported Command sets [S_CMD_SET: 0x01]
HPI Features [HPI_FEATURE: 0x03]: implementation based on CMD12
Background operations support [BKOPS_SUPPORT: 0x01]
Background operations status [BKOPS_STATUS: 0x02]
1st Initialisation Time after programmed sector [INI_TIMEOUT_AP: 0x7a]
Power class for 52MHz, DDR at 3.6V [PWR_CL_DDR_52_360: 0x00]
Power class for 52MHz, DDR at 1.95V [PWR_CL_DDR_52_195: 0x00]
Minimum Performance for 8bit at 52MHz in DDR mode:
  [MIN_PERF_DDR_W_8_52: 0x00]
  [MIN_PERF_DDR_R_8_52: 0x00]
TRIM Multiplier [TRIM_MULT: 0x06]
Secure Feature support [SEC_FEATURE_SUPPORT: 0x15]
Secure Erase Multiplier [SEC_ERASE_MULT: 0x02]
Secure TRIM Multiplier [SEC_TRIM_MULT: 0x03]
Boot Information [BOOT_INFO: 0x07]
  Device supports alternative boot method
  Device supports dual data rate during boot
  Device supports high speed timing during boot
Boot partition size [BOOT_SIZE_MULTI: 0x08]
Access size [ACC_SIZE: 0x05]
High-capacity erase unit size [HC_ERASE_GRP_SIZE: 0x00]
  i.e. 0 KiB
High-capacity erase timeout [ERASE_TIMEOUT_MULT: 0x01]
Reliable write sector count [REL_WR_SEC_C: 0x01]
High-capacity W protect group size [HC_WP_GRP_SIZE: 0x00]
  i.e. 0 KiB
Sleep current (VCC) [S_C_VCC: 0x08]
Sleep current (VCCQ) [S_C_VCCQ: 0x08]
Sleep/awake timeout [S_A_TIMEOUT: 0x10]
Sector Count [SEC_COUNT: 0x00000000]
  Device is NOT block-addressed
Minimum Write Performance for 8bit:
  [MIN_PERF_W_8_52: 0x08]
  [MIN_PERF_R_8_52: 0x08]
  [MIN_PERF_W_8_26_4_52: 0x08]
  [MIN_PERF_R_8_26_4_52: 0x08]
Minimum Write Performance for 4bit:
  [MIN_PERF_W_4_26: 0x08]
  [MIN_PERF_R_4_26: 0x08]
Power classes registers:
  [PWR_CL_26_360: 0x00]
  [PWR_CL_52_360: 0x00]
  [PWR_CL_26_195: 0x00]
  [PWR_CL_52_195: 0x00]
Partition switching timing [PARTITION_SWITCH_TIME: 0x01]
Out-of-interrupt busy timing [OUT_OF_INTERRUPT_TIME: 0x02]
Card Type [CARD_TYPE: 0x07]
  HS Dual Data Rate eMMC @52MHz 1.8V or 3VI/O
  HS eMMC @52MHz - at rated device voltage(s)
  HS eMMC @26MHz - at rated device voltage(s)
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
Write reliability setting register [WR_REL_SET]: 0x00
  user area: existing data is at risk if a power failure occurs during a 
write operation
  partition 1: existing data is at risk if a power failure occurs during 
a write operation
  partition 2: existing data is at risk if a power failure occurs during 
a write operation
  partition 3: existing data is at risk if a power failure occurs during 
a write operation
  partition 4: existing data is at risk if a power failure occurs during 
a write operation
Write reliability parameter register [WR_REL_PARAM]: 0x05
  Device supports writing EXT_CSD_WR_REL_SET
  Device supports the enhanced def. of reliable write
Enable background operations handshake [BKOPS_EN]: 0x00
H/W reset function [RST_N_FUNCTION]: 0x00
HPI management [HPI_MGMT]: 0x01
Partitioning Support [PARTITIONING_SUPPORT]: 0x03
  Device support partitioning feature
  Device can have enhanced tech.
Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x0001ca
  i.e. 0 KiB
Partitions attribute [PARTITIONS_ATTRIBUTE]: 0x00
Partitioning Setting [PARTITION_SETTING_COMPLETED]: 0x00
  Device partition setting NOT complete
General Purpose Partition Size
  [GP_SIZE_MULT_4]: 0x000000
  [GP_SIZE_MULT_3]: 0x000000
  [GP_SIZE_MULT_2]: 0x000000
  [GP_SIZE_MULT_1]: 0x000000
Enhanced User Data Area Size [ENH_SIZE_MULT]: 0x000000
  i.e. 0 KiB
Enhanced User Data Start Address [ENH_START_ADDR]: 0x000000
  i.e. 0 bytes offset
Bad Block Management mode [SEC_BAD_BLK_MGMNT]: 0x00

Regards,
Matthias
