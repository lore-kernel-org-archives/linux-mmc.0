From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 0/3] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Tue, 10 May 2016 14:52:01 +0900
Message-ID: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi,

this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
SDR-50 support to the same driver.

This series enables UHS-I SDR-104 on the r8a7790/Lager where
UHS-I SDR-50 is already enabled.

It is based on a merge of:
* The next branch of the mmc tree
* The renesas-next-20160427v2-v4.6-rc1 tag of the renesas tree
* The sh-pfc-for-v4.7-tag1 tag of the renesas-drivers tree

The first two mmc driver patches are targeted at the next branch of the mmc
tree. The last DT patch is targeted at the devel branch of the renesas tree.

To aid review this series is provided in the _temporary_ topic/sdr104 branch
of the renesas tree.

A description of testing performed follows:

* Environment

  SoC/Board: r8a7790/Lager
  SanDisk Card: SanDisk Ultra 64Gb microSDXC UHS-1
                Identifier on Packaging: SDSQUNC-064G-GN6MA
  Samsung Card: Samsung 32Gb microSDHC Card Class 10 UHS-1 U3
                ModelCode: MB-MG32EA/FFP

* Wit these patches (topic/sdr104 branch)

  # mount -t debugfs none /sys/kernel/debug
  # cat /sys/kernel/debug/mmc1/ios

  clock:          195000000 Hz
  vdd:            21 (3.3 ~ 3.4 V)
  bus mode:       2 (push-pull)
  chip select:    0 (don't care)
  power mode:     2 (on)
  bus width:      2 (4 bits)
  timing spec:    6 (sd uhs SDR104)
  signal voltage: 1 (1.80 V)
  driver type:    0 (driver type B)

  SanDisk Card:
  # dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null
  536870912 bytes (537 MB) copied, 13.6713 s, 39.3 MB/s

  Samsung Card:
  # dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null
  536870912 bytes (537 MB) copied, 16.4952 s, 32.5 MB/s


* Without these patches (base of topic/sdr104 branch)

  # mount -t debugfs none /sys/kernel/debug
  # cat /sys/kernel/debug/mmc1/ios

  clock:          100000000 Hz
  vdd:            21 (3.3 ~ 3.4 V)
  bus mode:       2 (push-pull)
  chip select:    0 (don't care)
  power mode:     2 (on)
  bus width:      2 (4 bits)
  timing spec:    5 (sd uhs SDR50)
  signal voltage: 1 (1.80 V)
  driver type:    0 (driver type B)

  SanDisk Card:
  # dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null
  536870912 bytes (537 MB) copied, 17.7253 s, 30.3 MB/s

  Samsung Card:
  # dd bs=1M count=512 iflag=direct if=/dev/mmcblk1 of=/dev/null
  536870912 bytes (537 MB) copied, 20.7866 s, 25.8 MB/s



Ai Kyuse (2):
  mmc: tmio: Add tuning support
  mmc: sh_mobile_sdhi: Add tuning support

Simon Horman (1):
  ARM: dts: r8a7790: lager: Enable UHS-I SDR-104

 arch/arm/boot/dts/r8a7790-lager.dts |   1 +
 drivers/mmc/host/sh_mobile_sdhi.c   | 264 +++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc.h         |  10 ++
 drivers/mmc/host/tmio_mmc_pio.c     | 249 ++++++++++++++++++++++++++++++++--
 include/linux/mfd/tmio.h            |   3 +
 5 files changed, 518 insertions(+), 9 deletions(-)

-- 
2.1.4
