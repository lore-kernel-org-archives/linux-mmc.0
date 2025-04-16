Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B67A55
	for <linux-mmc@vger.kernel.org>; Wed, 16 Apr 2025 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762407; cv=none; b=WrHIs8EEiaiOB6IRIyc9s1ubDPIE/08LZ2aKqyTC21rmjB+iawqJM61CFtbz+RPxwod4/g9wHGZW0S8lw1Y1HmlUTsmNvx0ABlJJO08Bu6SzXb8/qpDI415wh9TZld/JA6xYOMQtRJSmVv0pvhF3nHrTs54NMlPeYS7itmdzV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762407; c=relaxed/simple;
	bh=lJRUbisq2xM53uic0rlcwOfMnNR9lWZjizEM/eS7lAs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rT0WZg2Nbf7mhGcGAK5AUhPFv+KbyXGJ57Ok7L11Zq+ZQdEKQYapWecxOcC98vMoLKr1pcB0wr/9jSxfNsfXki0FANZLENXUAWEdI8tJu669KTYV6zcbP5/9GOrigXnZFcJ64vArShbUJDx/OEclCJHLDZWfLh8xF9ImW+qt3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=kNYFOBfk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kNYFOBfk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb39c45b4eso35056766b.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Apr 2025 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1744762402; x=1745367202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQEfOycosIUeagZIKLB3NYD7IJjYfX0nEy55Z/5xEX4=;
        b=kNYFOBfkfXtEYfkAnrYxB+Lv5P9dzS0XgxjoGR7bW+0hrsT+CFuW3Q7RU0KKLAMAZD
         UoRXWBw/bywqlqsTycufbzuoFnAWU4AEedajwQ0hqFnsaQHZqYyGp2buvgommKUYRP9Q
         FS4funsAEIjJiuIY+RlMsBky6xYzH+KqlQCw6fAqtQAkVUsAYt0YYlCdmm84/JhjlCDV
         GniVU1UscZL4OSmbJaJkfqzijs1+GkhDKoYHkd1Wkp8oYCLzwiiBDuKeL/gAxmrxXTme
         c7fRrHd09jBv3oD4r7gpYWqX+JQuVPpRRn9N9LRtOC6IxHvJ/WZQ9HLAGShykrgnpzKa
         Fpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744762402; x=1745367202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQEfOycosIUeagZIKLB3NYD7IJjYfX0nEy55Z/5xEX4=;
        b=fJojmanVVkwLwxJ7PnmINblfgLfJhvf+29TN7ZCjPbqi/TnK79ezYyStnJvez99nkf
         7aEifWPNe+Lws2rOpEISXTsRHJj/cuHZeT+gCAvO27TmqzzvMK322AYZSSd18WN6YvXD
         zw4LKtRbtP5gOG4jInam+TzV7kaziAtcQxreOf0d7frO7x+TldwJroPcPQ/9fQuPRCqg
         uNpc6v6SDCHVswaCwjvPCuftIM2F8ZCv7IN3afOEbg6itPIAybzcyO0IRJtDqVTtxBqi
         W4PJHJp+G8aMaHV8Fs/R1BQ6xBxtEwx0lQyQJMB7/LBxNEumcFmlpU8uGvYI9icrSpIJ
         OxWA==
X-Gm-Message-State: AOJu0YwCWWv3eYV/IZ5+7xhGhjLEMGFnuq3akJekCPYHfCBrpDcSQNVS
	7UOodfc3zKNihVt0ln7cjIp0QYIqw5L7z3DDSGKf/w+oHAWXzOJtUSq649XgLb4SFuOqv/wIy3F
	icl4Jm19k36LkDGIQbq6ARLgdsxeJEAjcNKYS3UEB0cz5iCCGww==
X-Gm-Gg: ASbGncvzIWTPamqAJIxGpkH4Xta72wxQv9+JN+/A7uqStmgAv9K11VVNwcx05H1zU0e
	KmhUe22oPR2YlqdkXcH13o1w0E9UDFKyowdb3hcOFKsDZLs/rmNAUg1Lh7D4kmea6arG8BQeX2+
	KHH+gLcHJQr1TdBg8IYFRZ/yeBbv2UwPeV9ExlhOMvG/X4EmmHTO3HzQ==
X-Google-Smtp-Source: AGHT+IHgkMbrZoLCCHGwjn2wF67i6wc7uQBCZz5gTcttRuzrbN5gKFCh2mv16HWxBLhfNBMWrLVHWC5aCGyAmku66+c=
X-Received: by 2002:a17:907:3d8c:b0:ac8:1bb3:35b0 with SMTP id
 a640c23a62f3a-acb3822b90amr82524266b.20.1744762402424; Tue, 15 Apr 2025
 17:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Prasad Koya <prasad@arista.com>
Date: Tue, 15 Apr 2025 17:13:10 -0700
X-Gm-Features: ATxdqUHrK06Yntk9OSP5_7oHWP7Umh4DoyMfNbQTm3Kkbpb3kJp9rBDQW-JzbUw
Message-ID: <CAKh1g556YvHE9eib3WJG+mBHyyr88rxYSbNUHxpFYsUHcdOoUg@mail.gmail.com>
Subject: eMMC timeout reproduction. Can I send a block of data from the host
 to the card with invalid CRC?
To: linux-mmc@vger.kernel.org
Cc: Baptiste Covolato <baptiste@arista.com>, Sushrut Shirole <sushrut@arista.com>, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

We use eMMC as a boot drive. At a random time, maybe a month or an
year of uptime, we run into an issue where we see the eMMC driver
prints this in the kernel logs and the drive no longer responds after
that. We see this issue in the field on linux kernel 4.19.142 and
5.10.165. From the SDHCI register dump, it looks like CMD25 ran into a
timeout first. After the first timeout, we see CMD12 in the second
SDHCI register dump. Status returned by the card at that point in
card_busy_detect() is 0xE00.

I looked at the recent commits up to 6.15 and I do not see anything
obvious that addresses issue like below.

We are trying to reproduce the issue in our lab and understand the
driver code. Is there a way I can send a block of data as part of
CMD25 with invalid CRC?  Appreciate any pointers.

Below are the kernel logs and some more information about our drive
from debugfs.

[43976878.027119] mmc0: Timeout waiting for hardware interrupt.
[43976878.094848] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI R=
EGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[43976878.175087] mmc0: sdhci: Sys addr:  0xd3c00600 | Version:  0x00001002
[43976878.255333] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x0000000d
[43976878.335565] mmc0: sdhci: Argument:  0x00460810 | Trn mode: 0x00000023
[43976878.415798] mmc0: sdhci: Present:   0x01ef0106 | Host ctl: 0x00000007
[43976878.496029] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[43976878.576261] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000207
[43976878.656492] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[43976878.736724] mmc0: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
[43976878.816958] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x000000ff
[43976878.897189] mmc0: sdhci: Caps:      0x75fec8b2 | Caps_1:   0x00002501
[43976878.977421] mmc0: sdhci: Cmd:       0x0000193a | Max curr: 0x00c80064
[43976879.057651] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[43976879.137882] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x00d04f01
[43976879.218116] mmc0: sdhci: Host ctl2: 0x00000000
[43976879.274385] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[43976888.267487] mmc0: Timeout waiting for hardware interrupt.
[43976888.335221] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI R=
EGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[43976888.415455] mmc0: sdhci: Sys addr:  0xd3c00600 | Version:  0x00001002
[43976888.495687] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x0000000d
[43976888.575920] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[43976888.656150] mmc0: sdhci: Present:   0x01ef0006 | Host ctl: 0x00000007
[43976888.736377] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[43976888.816606] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000207
[43976888.896829] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[43976888.977051] mmc0: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
[43976889.057271] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x000000ff
[43976889.137494] mmc0: sdhci: Caps:      0x75fec8b2 | Caps_1:   0x00002501
[43976889.217718] mmc0: sdhci: Cmd:       0x00000c1b | Max curr: 0x00c80064
[43976889.297948] mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0xffffffff
[43976889.378178] mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x00d04f01
[43976889.458408] mmc0: sdhci: Host ctl2: 0x00000000
[43976889.514671] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[43976891.203641] sdhci-pci 0000:00:14.7: Card stuck in wrong state!
card_busy_detect status: 0xe00
[43976891.309110] mmc0: cache flush error -110
[43976892.599663] mmc0: tried to HW reset card, got error -110
[43976892.599668] mmcblk0: recovery failed!
[43976892.656500] print_req_error: I/O error, dev mmcblk0, sector 4589584
[43976892.663560] sdhci-pci 0000:00:14.7: error -110 requesting status
[43976892.734746] EXT4-fs warning (device mmcblk0p1):
ext4_end_bio:317: I/O error 10 writing to inode 129797 (offset 0 size
8192 starting block 573700)
[43976892.809713] Buffer I/O error on device mmcblk0p1, logical block 57344=
2
[43976892.809741] mmcblk0: recovery failed!


/sys/kernel/debug/mmc0/caps
0x4007040f
/sys/kernel/debug/mmc0/caps2
0x00024000
/sys/kernel/debug/mmc0/clock
52000000
/sys/kernel/debug/mmc0/ios
clock:          52000000 Hz
actual clock:   50000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    1 (mmc high-speed)
signal voltage: 0 (3.30 V)
driver type:    0 (driver type B)

-bash-4.2# cat /sys/kernel/debug/mmc0/mmc0\:0001/ext_csd
00000000000000000000000000000000010100c074000000000000000000000000010100000=
000000000000000000000000000000000000000000000000000000000000001000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000020000020000000000100000000000000000000000000000000000000=
00000000000000d701000701000000000500200000000000000100000000000000010001000=
00000000007000200571f04030000000000080808080808000080eb000f1314080801011110=
07200007010155110000000000000001640800000000ff19000400000002000000000000000=
000010801010b02000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000001ffff00000000010307050003013c3c01010=
100000000000000
-bash-4.2#

-bash-4.2# ./mmcutils extcsd read /dev/mmcblk0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Extended CSD rev 1.7 (MMC 5.0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Card Supported Command sets [S_CMD_SET: 0x01]
HPI Features [HPI_FEATURE: 0x01]: implementation based on CMD13
Background operations support [BKOPS_SUPPORT: 0x01]
Max Packet Read Cmd [MAX_PACKED_READS: 0x3c]
Max Packet Write Cmd [MAX_PACKED_WRITES: 0x3c]
Data TAG support [DATA_TAG_SUPPORT: 0x01]
Data TAG Unit Size [TAG_UNIT_SIZE: 0x03]
Tag Resources Size [TAG_RES_SIZE: 0x00]
Context Management Capabilities [CONTEXT_CAPABILITIES: 0x05]
Large Unit Size [LARGE_UNIT_SIZE_M1: 0x07]
Extended partition attribute support [EXT_SUPPORT: 0x03]
Generic CMD6 Timer [GENERIC_CMD6_TIME: 0x19]
Power off notification [POWER_OFF_LONG_TIME: 0xff]
Cache Size [CACHE_SIZE] is 128 KiB
Background operations status [BKOPS_STATUS: 0x00]
1st Initialisation Time after programmed sector [INI_TIMEOUT_AP: 0x64]
Power class for 52MHz, DDR at 3.6V [PWR_CL_DDR_52_360: 0x00]
Power class for 52MHz, DDR at 1.95V [PWR_CL_DDR_52_195: 0x00]
Power class for 200MHz at 3.6V [PWR_CL_200_360: 0x00]
Power class for 200MHz, at 1.95V [PWR_CL_200_195: 0x00]
Minimum Performance for 8bit at 52MHz in DDR mode:
 [MIN_PERF_DDR_W_8_52: 0x00]
 [MIN_PERF_DDR_R_8_52: 0x00]
TRIM Multiplier [TRIM_MULT: 0x11]
Secure Feature support [SEC_FEATURE_SUPPORT: 0x55]
Boot Information [BOOT_INFO: 0x07]
 Device supports alternative boot method
 Device supports dual data rate during boot
 Device supports high speed timing during boot
Boot partition size [BOOT_SIZE_MULTI: 0x20]
Access size [ACC_SIZE: 0x07]
High-capacity erase unit size [HC_ERASE_GRP_SIZE: 0x10]
 i.e. 8192 KiB
High-capacity erase timeout [ERASE_TIMEOUT_MULT: 0x11]
Reliable write sector count [REL_WR_SEC_C: 0x01]
High-capacity W protect group size [HC_WP_GRP_SIZE: 0x01]
 i.e. 8192 KiB
Sleep current (VCC) [S_C_VCC: 0x08]
Sleep current (VCCQ) [S_C_VCCQ: 0x08]
Sleep/awake timeout [S_A_TIMEOUT: 0x13]
Sector Count [SEC_COUNT: 0x00eb8000]
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
Partition switching timing [PARTITION_SWITCH_TIME: 0x03]
Out-of-interrupt busy timing [OUT_OF_INTERRUPT_TIME: 0x04]
I/O Driver Strength [DRIVER_STRENGTH: 0x1f]
Card Type [CARD_TYPE: 0x57]
 HS400 Dual Data Rate eMMC @200MHz 1.8VI/O
 HS200 Single Data Rate eMMC @200MHz 1.8VI/O
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
 partition 0 ro lock status: not locked
 partition 1 ro lock status: not locked
User area write protection register [USER_WP]: 0x00
FW configuration [FW_CONFIG]: 0x00
RPMB Size [RPMB_SIZE_MULT]: 0x20
Write reliability setting register [WR_REL_SET]: 0x00
 user area: existing data is at risk if a power failure occurs during
a write operation
 partition 1: existing data is at risk if a power failure occurs
during a write operation
 partition 2: existing data is at risk if a power failure occurs
during a write operation
 partition 3: existing data is at risk if a power failure occurs
during a write operation
 partition 4: existing data is at risk if a power failure occurs
during a write operation
Write reliability parameter register [WR_REL_PARAM]: 0x05
 Device supports writing EXT_CSD_WR_REL_SET
 Device supports the enhanced def. of reliable write
Enable background operations handshake [BKOPS_EN]: 0x00
H/W reset function [RST_N_FUNCTION]: 0x00
HPI management [HPI_MGMT]: 0x01
Partitioning Support [PARTITIONING_SUPPORT]: 0x07
 Device support partitioning feature
 Device can have enhanced tech.
Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x0001d7
 i.e. 3858432 KiB
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
Enhanced User Data Start Address [ENH_START_ADDR]: 0x00000000
 i.e. 0 bytes offset
Bad Block Management mode [SEC_BAD_BLK_MGMNT]: 0x00
Periodic Wake-up [PERIODIC_WAKEUP]: 0x00
Program CID/CSD in DDR mode support [PROGRAM_CID_CSD_DDR_SUPPORT]: 0x01
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[127]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[126]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[125]]: 0x20
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[124]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[123]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[122]]: 0x20
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[121]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[120]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[119]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[118]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[117]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[116]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[115]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[114]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[113]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[112]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[111]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[112]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[111]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[110]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[109]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[108]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[107]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[106]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[105]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[104]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[103]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[102]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[101]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[100]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[99]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[98]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[97]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[96]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[95]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[94]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[93]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[92]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[91]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[90]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[89]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[88]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[87]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[86]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[85]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[84]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[83]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[82]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[81]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[80]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[79]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[78]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[77]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[76]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[75]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[74]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[73]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[72]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[71]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[70]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[69]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[68]]: 0x01
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[67]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[66]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[65]]: 0x00
Vendor Specific Fields [VENDOR_SPECIFIC_FIELD[64]]: 0x00
Native sector size [NATIVE_SECTOR_SIZE]: 0x00
Sector size emulation [USE_NATIVE_SECTOR]: 0x00
Sector size emulation [USE_NATIVE_SECTOR]: 0x00
Sector size [DATA_SECTOR_SIZE]: 0x00
1st initialization after disabling sector size emulation [INI_TIMEOUT_EMU]:=
 0x00
Class 6 commands control [CLASS_6_CTRL]: 0x00
Number of addressed group to be Released[DYNCAP_NEEDED]: 0x00
Exception events control [EXCEPTION_EVENTS_CTRL]: 0x0000
Exception events status[EXCEPTION_EVENTS_STATUS]: 0x0000
Extended Partitions Attribute [EXT_PARTITIONS_ATTRIBUTE]: 0x0000
Context configuration [CONTEXT_CONF[51]]: 0x00
Context configuration [CONTEXT_CONF[50]]: 0x00
Context configuration [CONTEXT_CONF[49]]: 0x00
Context configuration [CONTEXT_CONF[48]]: 0x00
Context configuration [CONTEXT_CONF[47]]: 0x00
Context configuration [CONTEXT_CONF[46]]: 0x00
Context configuration [CONTEXT_CONF[45]]: 0x00
Context configuration [CONTEXT_CONF[44]]: 0x00
Context configuration [CONTEXT_CONF[43]]: 0x00
Context configuration [CONTEXT_CONF[42]]: 0x00
Context configuration [CONTEXT_CONF[41]]: 0x00
Context configuration [CONTEXT_CONF[40]]: 0x00
Context configuration [CONTEXT_CONF[39]]: 0x00
Context configuration [CONTEXT_CONF[38]]: 0x00
Context configuration [CONTEXT_CONF[37]]: 0x00
Packed command status [PACKED_COMMAND_STATUS]: 0x00
Packed command failure index [PACKED_FAILURE_INDEX]: 0x00
Power Off Notification [POWER_OFF_NOTIFICATION]: 0x01
Control to turn the Cache ON/OFF [CACHE_CTRL]: 0x01
Control to turn the Cache Barrier ON/OFF [BARRIER_CTRL]: 0x00
eMMC Firmware Version:
eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x0b
eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x02
eMMC Pre EOL information [EXT_CSD_PRE_EOL_INFO]: 0x01
Secure Removal Type [SECURE_REMOVAL_TYPE]: 0x01
 information is configured to be removed by an erase of the physical memory
 Supported Secure Removal Type:
  information removed by an erase of the physical memory
-bash-4.2#

Thank you.
