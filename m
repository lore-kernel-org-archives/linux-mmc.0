From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: [PATCH v6] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Mon, 22 Jan 2018 09:33:11 +0100 (CET)
Message-ID: <OF64BA4616.A552893D-ONC125821D.002E9E83-C125821D.002EFBB2@rittal.de>
References: <CACRpkdYZMa7-F8pR8rKHKfXgqRMFknniLDr-vtQ-BW2fZLk+qw@mail.gmail.com>,
        <20180119145303.4097-1-linus.walleij@linaro.org> <OFE718A5EC.F4E3005B-ONC125821D.00225D5B-C125821D.00229F17@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYZMa7-F8pR8rKHKfXgqRMFknniLDr-vtQ-BW2fZLk+qw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?ISO-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hey Linus,

> Annoying ... since the i.MX and x86 PCI version so clearly differs
> here I'm left to trial and error over the mailing list.

I know, can I do something that it makes it easier for you?

> Could you try this on top of the patch?

Built in and here is the output. I think, it's what you want, 
but it doesn't work either.

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0 bounce up to 127 segments into one, max segment size 65535 bytes
mmc0: SDHCI controller on 53fb4000.esdhc [53fb4000.esdhc] using DMA
sdhci-esdhc-imx 53fb8000.esdhc: Got CD GPIO
sdhci-esdhc-imx 53fb8000.esdhc: Got WP GPIO
mmc1 bounce up to 127 segments into one, max segment size 65535 bytes
mmc1: SDHCI controller on 53fb8000.esdhc [53fb8000.esdhc] using DMA
oprofile: no performance counters
oprofile: using timer interrupt.
mmc0: new high speed MMC card at address 0001
NET: Registered protocol family 10
mmcblk0: mmc0:0001 002G00 1.83 GiB 
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
mmcblk0boot0: mmc0:0001 002G00 partition 1 512 KiB
mmcblk0boot1: mmc0:0001 002G00 partition 2 512 KiB
NET: Registered protocol family 17
can: controller area network core (rev 20170425 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20170425)
can: broadcast manager protocol (rev 20170425 t)
can: netlink gateway (rev 20170425) max_hops=1
input: gpio-keys as /devices/platform/gpio-keys/input/input1
mmcblk0rpmb: mmc0:0001 002G00 partition 3 128 KiB
imxdi_rtc 53ffc000.dryice: setting system clock to 1970-01-12 23:15:39 UTC (1034139)
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

  b305           16384 mmcblk0p5 00000000-05

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
 

Kind regards,
Benjamin Beckmeyer
