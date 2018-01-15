From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: [PATCH v5] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Mon, 15 Jan 2018 07:07:51 +0100 (CET)
Message-ID: <OF22397E1F.A032896A-ONC1258216.00217280-C1258216.0021AD1D@rittal.de>
References: <20180112141907.18203-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180112141907.18203-1-linus.walleij@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?ISO-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Good morning,

> - Requesting a test of this on i.MX. (Sorry Benjamin.)

No worries. I did another test with your v5 patch, but it doesn't work.
Here is the kernel log: 

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
mmcblk0boot0: mmc0:0001 002G00 partition 1 512 KiB
NET: Registered protocol family 10
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
imxdi_rtc 53ffc000.dryice: setting system clock to 1970-01-05 20:50:24 UTC (420624)
 mmcblk0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
EXT4-fs (mmcblk0p8): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (mmcblk0p8): couldn't mount as ext2 due to feature incompatibilities
EXT4-fs (mmcblk0p8): INFO: recovery required on readonly filesystem
EXT4-fs (mmcblk0p8): write access will be enabled during recovery
EXT4-fs (mmcblk0p8): recovery complete
EXT4-fs (mmcblk0p8): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 259:0.
devtmpfs: mounted
Freeing unused kernel memory: 248K
This architecture does not have kernel memory protection.
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


Kind regards,
Benjamin Beckmeyer
