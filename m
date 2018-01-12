From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: [PATCH v4] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri, 12 Jan 2018 12:11:52 +0100 (CET)
Message-ID: <OF8FC8E998.7A21E1C5-ONC1258213.003D371A-C1258213.003D82BC@rittal.de>
References: <20180112100022.3191-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180112100022.3191-1-linus.walleij@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?ISO-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

> - Tested on the PCI SDHCI on my laptop: requesting a new test
>   on i.MX from Benjamin. (Please!)

Hey Linus,

sorry to say that but in my case the kernel doesn't boot anymore.
Again, after I "patched out" the bounce buffer it's running fine.
Here is the kernel output..

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
sdhci-esdhc-imx 53fb4000.esdhc: host only supports SDMA, activate bounce buffer
sdhci-esdhc-imx 53fb4000.esdhc: bounce buffer: bounce up to 128 segments into one, max segment size 65536 bytes
mmc0: SDHCI controller on 53fb4000.esdhc [53fb4000.esdhc] using DMA
sdhci-esdhc-imx 53fb8000.esdhc: Got CD GPIO
sdhci-esdhc-imx 53fb8000.esdhc: Got WP GPIO
sdhci-esdhc-imx 53fb8000.esdhc: host only supports SDMA, activate bounce buffer
sdhci-esdhc-imx 53fb8000.esdhc: bounce buffer: bounce up to 128 segments into one, max segment size 65536 bytes
mmc1: SDHCI controller on 53fb8000.esdhc [53fb8000.esdhc] using DMA
mmc0: new high speed MMC card at address 0001
oprofile: no performance counters
oprofile: using timer interrupt.
mmcblk0: mmc0:0001 002G00 1.83 GiB 
NET: Registered protocol family 10
mmcblk0boot0: mmc0:0001 002G00 partition 1 512 KiB
mmcblk0boot1: mmc0:0001 002G00 partition 2 512 KiB
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
can: controller area network core (rev 20170425 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20170425)
can: broadcast manager protocol (rev 20170425 t)
can: netlink gateway (rev 20170425) max_hops=1
input: gpio-keys as /devices/platform/gpio-keys/input/input1
mmcblk0rpmb: mmc0:0001 002G00 partition 3 128 KiB
imxdi_rtc 53ffc000.dryice: setting system clock to 1970-01-03 01:46:38 UTC (179198)
 mmcblk0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
EXT4-fs (mmcblk0p8): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (mmcblk0p8): couldn't mount as ext2 due to feature incompatibilities
EXT4-fs (mmcblk0p8): ext4_check_descriptors: Checksum for group 3 failed (1874!=0)
EXT4-fs (mmcblk0p8): ext4_check_descriptors: Block bitmap for group 4 not in group (block 0)!
EXT4-fs (mmcblk0p8): group descriptors corrupted!
VFS: Cannot open root device "mmcblk0p8" or unknown-block(259,0): error -117
Please append a correct "root=" boot option; here are the available partitions:
b300         1916928 mmcblk0 
 driver: mmcblk
  b301             767 mmcblk0p1 00000000-01

  b302             128 mmcblk0p2 00000000-02

  b303             128 mmcblk0p3 00000000-03

  b304               1 mmcblk0p4 

  b305             767 mmcblk0p5 00000000-05

  b306          409599 mmcblk0p6 00000000-06

  b307           16383 mmcblk0p7 00000000-07

  103:00000     409599 mmcblk0p8 00000000-08

  103:00001     102399 mmcblk0p9 00000000-09

  103:00002     961535 mmcblk0p10 00000000-0a

b318             128 mmcblk0rpmb 
 (driver?)
b310             512 mmcblk0boot1 
 (driver?)
b308             512 mmcblk0boot0 
 (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(259,0)
---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(259,0)
