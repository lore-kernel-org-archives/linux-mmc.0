From: Kyle Evans <kvans32@gmail.com>
Subject: SDHCI multiblock transfer failure
Date: Tue, 13 Feb 2018 12:03:18 -0500
Message-ID: <20180213170318.GA1256@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:41267 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964863AbeBMRDb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Feb 2018 12:03:31 -0500
Received: by mail-io0-f169.google.com with SMTP id f4so22027488ioh.8
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2018 09:03:31 -0800 (PST)
Received: from localhost.localdomain ([2607:fcc8:e7a3:1b00::2])
        by smtp.gmail.com with ESMTPSA id 188sm14262421iou.80.2018.02.13.09.03.28
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2018 09:03:28 -0800 (PST)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I am experiencing an error under certain write conditions.
I ran badblocks on the device and all 4 passes were successfull. But
when I try to rsync my system from the sdcard to the eMMC, I get the 
following:

[ 3915.676749] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0xe00

The system must be powered down to recover. I have read information that 
indicate this could be a firmware bug, or a buffer overflow.

The error is quite repeatable. My initial system rsync got about half 
way before hanging on a kernel git repo, and would hang every time 
thereafter. I can copy single large files successfully, e.g. `cp 
/mnt/llvm-3.7.1.src.tar .; sync`. However, extracting the same file to 
the device will kill it every time, e.g. `tar -xf /mnt/llvm-3.7.1.src.tar 
.`  

If I use SDHCI_QUIRK_NO_MULTIBLOCK, the controller fails to initialize. 
A value of 2 works and a value of 4 works, but 8 is too much and far 
from the hard coded 64K.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d2a4adc50a84..4c306a626d8a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3577,7 +3577,7 @@ int sdhci_setup_host(struct sdhci_host *host)
        /*
         * Maximum block count.
         */
-       mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
+       mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 4;

        return 0;

How can I debug this further to get to a solution?


mmc extcsd read /dev/mmcblk0:
=============================================
  Extended CSD rev 1.5 (MMC 4.41)
=============================================

Card Supported Command sets [S_CMD_SET: 0x01]
HPI Features [HPI_FEATURE: 0x03]: implementation based on CMD12
Background operations support [BKOPS_SUPPORT: 0x01]
Background operations status [BKOPS_STATUS: 0x00]
1st Initialisation Time after programmed sector [INI_TIMEOUT_AP: 0xff]
Power class for 52MHz, DDR at 3.6V [PWR_CL_DDR_52_360: 0x00]
Power class for 52MHz, DDR at 1.95V [PWR_CL_DDR_52_195: 0x00]
Minimum Performance for 8bit at 52MHz in DDR mode:
 [MIN_PERF_DDR_W_8_52: 0x00]
 [MIN_PERF_DDR_R_8_52: 0x00]
TRIM Multiplier [TRIM_MULT: 0x00]
Secure Feature support [SEC_FEATURE_SUPPORT: 0x15]
Secure Erase Multiplier [SEC_ERASE_MULT: 0x00]
Secure TRIM Multiplier [SEC_TRIM_MULT: 0x00]
Boot Information [BOOT_INFO: 0x07]
 Device supports alternative boot method
 Device supports dual data rate during boot
 Device supports high speed timing during boot
Boot partition size [BOOT_SIZE_MULTI: 0x10]
Access size [ACC_SIZE: 0x07]
High-capacity erase unit size [HC_ERASE_GRP_SIZE: 0x08]
 i.e. 4096 KiB
High-capacity erase timeout [ERASE_TIMEOUT_MULT: 0x00]
Reliable write sector count [REL_WR_SEC_C: 0x08]
High-capacity W protect group size [HC_WP_GRP_SIZE: 0x08]
 i.e. 32768 KiB
Sleep current (VCC) [S_C_VCC: 0x08]
Sleep current (VCCQ) [S_C_VCCQ: 0x08]
Sleep/awake timeout [S_A_TIMEOUT: 0x10]
Sector Count [SEC_COUNT: 0x0399e000]
 Device is block-addressed
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
Card Type [CARD_TYPE: 0x0f]
 HS Dual Data Rate eMMC @52MHz 1.2VI/O
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
High-density erase group definition [ERASE_GROUP_DEF: 0x01]
Boot write protection status registers [BOOT_WP_STATUS]: 0x00
Boot Area Write protection [BOOT_WP]: 0x00
 Power ro locking: possible
 Permanent ro locking: possible
 ro lock status: not locked
User area write protection register [USER_WP]: 0x00
FW configuration [FW_CONFIG]: 0x00
RPMB Size [RPMB_SIZE_MULT]: 0x01
Write reliability setting register [WR_REL_SET]: 0x00
 user area: existing data is at risk if a power failure occurs during a write operation
 partition 1: existing data is at risk if a power failure occurs during a write operation
 partition 2: existing data is at risk if a power failure occurs during a write operation
 partition 3: existing data is at risk if a power failure occurs during a write operation
 partition 4: existing data is at risk if a power failure occurs during a write operation
Write reliability parameter register [WR_REL_PARAM]: 0x00
Enable background operations handshake [BKOPS_EN]: 0x01
H/W reset function [RST_N_FUNCTION]: 0x00
HPI management [HPI_MGMT]: 0x01
Partitioning Support [PARTITIONING_SUPPORT]: 0x03
 Device support partitioning feature
 Device can have enhanced tech.
Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x0001c9
 i.e. 14974976 KiB
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
