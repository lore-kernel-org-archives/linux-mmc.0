From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Thu, 2 Jun 2011 21:49:47 +0200
Message-ID: <201106022149.47936.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, andreiw@motorola.com
List-Id: linux-mmc@vger.kernel.org

Hi,

after upgrading my development kernel from 2.6.38 to 3.0rc1 I get flooded (i.e. 
it never stops) by messages of the form:

mmc1: Got data interrupt 0x00100000 even though no data operation was in 
progress.
  sdhci: =========== REGISTER DUMP (mmc1)===========
  sdhci: Sys addr: 0x37b1b000 | Version:  0x00000401
  sdhci: Blk size: 0x00007200 | Blk cnt:  0x00000000
  sdhci: Argument: 0x00010000 | Trn mode: 0x00000033
  sdhci: Present:  0x01e70002 | Host ctl: 0x00000012
  sdhci: Power:    0x0000000a | Blk gap:  0x00000000
  sdhci: Wake-up:  0x00000000 | Clock:    0x0000020f
  sdhci: Timeout:  0x0000000e | Int stat: 0x00108000
  sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
  sdhci: AC12 err: 0x00000000 | Slot int: 0x00000001
  sdhci: Caps:     0x05e80080 | Caps_1:   0x00000000
  sdhci: Cmd:      0x00000d1a | Max curr: 0x00000000
  sdhci: Host ctl2: 0x00000000
  sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x37846808
  sdhci: ===========================================


hardware: S3C2416 based board, mmc0 is an external micro-SD and mmc1 is a
  mmc1: new high speed MMC card at address 0001
  mmcblk1: mmc1:0001 HYNIX  1.88 GiB 
  mmcblk1boot0: mmc1:0001 HYNIX  partition 1 256 KiB
  mmcblk1boot1: mmc1:0001 HYNIX  partition 2 256 KiB
   mmcblk1: p1 p2 p3
   mmcblk1boot1: unknown partition table
   mmcblk1boot0: unknown partition table

it uses therefore the sdhci-s3c driver.


I did some prodding in the code and found the following peculiarities:

- When I remove Kyungmins AUTO_CMD12-quirk in sdhci-s3c it seems I get one 
functional boot and have only the following messages in the kernel log

  mmcblk1boot0: retrying using single block read
  mmc1: ADMA error
  mmcblk1boot0: error -5 transferring data, sector 448, nr 32, card status 
0x900
  end_request: I/O error, dev mmcblk1boot0, sector 448
  Buffer I/O error on device mmcblk1boot0, logical block 56
  mmcblk1boot1: retrying using single block read
  mmc1: ADMA error
  mmcblk1boot1: error -5 transferring data, sector 448, nr 32, card status 
0x900
  end_request: I/O error, dev mmcblk1boot1, sector 448

But after a soft reset the irq message flood seems to return.

- When I completely remove the boot partition registration in 
mmc_blk_alloc_parts() in card/block.c it seems that everything return to 
normal, i.e. no strange messages at all


I'm not sure if this is a problem of only my board or if it happens on more 
hardware.


Heiko
