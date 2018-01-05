From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: [PATCH] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri,  5 Jan 2018 08:51:59 +0100 (CET)
Message-ID: <OF2F4F13DD.1FAE7453-ONC125820C.00262A12-C125820C.002B3610@rittal.de>
References: <20180104201045.31139-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw03.loh-group.com ([195.226.74.51]:53014 "EHLO
        mailgw03.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeAEHwB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jan 2018 02:52:01 -0500
In-Reply-To: <20180104201045.31139-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

> I would be surprised if this works, which is why i sprinkled a
> few extra prints all over the place so we can see what goes
> wrong. If it would happen to work, try to comment out the noisy
> prints ("bouncing read/write data") so they don't disturb test
> results.

I can comfort you, it doesn't work :). I tried both, with your print 
outs and without. After I patched the kernel it doesn't find the root
filesystem anymore. Here is the kernel log:

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
SDMA with bounce buffer: bounce up to 1024 segments into one, max segment size 524288 bytes
mmc0: SDHCI controller on 53fb4000.esdhc [53fb4000.esdhc] using DMA
sdhci-esdhc-imx 53fb8000.esdhc: Got CD GPIO
sdhci-esdhc-imx 53fb8000.esdhc: Got WP GPIO
SDMA with bounce buffer: bounce up to 1024 segments into one, max segment size 524288 bytes
mmc1: SDHCI controller on 53fb8000.esdhc [53fb8000.esdhc] using DMA
bouncing read data
bouncing read data
mmc0: new high speed MMC card at address 0001
oprofile: no performance counters
mmcblk0: mmc0:0001 002G00 1.83 GiB 
mmcblk0boot0: mmc0:0001 002G00 partition 1 512 KiB
mmcblk0boot1: mmc0:0001 002G00 partition 2 512 KiB
mmcblk0rpmb: mmc0:0001 002G00 partition 3 128 KiB
bouncing read data
bouncing read data
bouncing read data
bouncing read data
bouncing read data
bouncing read data
bouncing read data
 mmcblk0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
oprofile: using timer interrupt.
NET: Registered protocol family 10
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
can: controller area network core (rev 20170425 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20170425)
can: broadcast manager protocol (rev 20170425 t)
can: netlink gateway (rev 20170425) max_hops=1
input: gpio-keys as /devices/platform/gpio-keys/input/input1
imxdi_rtc 53ffc000.dryice: setting system clock to 1970-01-03 00:50:58 UTC (175858)
bouncing read data
EXT4-fs (mmcblk0p8): couldn't mount as ext3 due to feature incompatibilities
bouncing read data
EXT4-fs (mmcblk0p8): couldn't mount as ext2 due to feature incompatibilities
bouncing read data
bouncing read data
EXT4-fs (mmcblk0p8): ext4_check_descriptors: Block bitmap for group 6 not in group (block 0)!
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
random: crng init done

Suprisingly there is a mmcblk0rpmb partition now. I don't know what that is 
and if this was there before, but normally it has nothing to do 
with our system. On our other systems it is not present. 

After I flashed another kernel without your patch it's booting without error. 




