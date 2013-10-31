From: Abbas Raza <abbas_raza@mentor.com>
Subject: Re: Hynix eMMC RPMB: Access timeouts, broken?
Date: Thu, 31 Oct 2013 17:48:09 +0000 (UTC)
Message-ID: <loom.20131031T183348-104@post.gmane.org>
References: <51ADD03F.5030407@de.bosch.com> <51D3BFCD.4080603@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54983 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab3JaRuF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 31 Oct 2013 13:50:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VbwNe-0003vB-T9
	for linux-mmc@vger.kernel.org; Thu, 31 Oct 2013 18:50:03 +0100
Received: from tw212-static98.tw1.com ([tw212-static98.tw1.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 31 Oct 2013 18:50:02 +0100
Received: from abbas_raza by tw212-static98.tw1.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 31 Oct 2013 18:50:02 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Krishna Konda <kkonda <at> codeaurora.org> writes:

> 
> On 6/4/2013 4:32 AM, Dirk Behme wrote:
> >
> > Using some recent Hynix eMMC devices [1] on our Freescale i.MX6 boards
> > we get harmless (?), but annoying access timeouts accessing the RPMB
> > partition:
> >
> > mmcblk1rpmb: error -110 transferring data, sector 0, nr 32, cmd response
> > 0x900, card status 0xb00
> > mmcblk1rpmb: retrying using single block read
> > ...
> >
> > The output with MMC debug enabled below [2].
> >
> > This seems to be harmless because it stops, but is annoying due to some
> > auto mounter trying to access all available partitions.
> >
> The RPMB partition should never be mounted. Its not a regular partition
> and does not a file system on it. So my suggestion would to be to modify
> the auto mounter to not mount RPMB paritions.
> 

Hi Dirk, Krishna

These issues are not caused by udev/auto-mounting, but by the mmc block
driver initialisation code.
During the mmc initialisation, all the non zero sized partitions (read from
ext_csd register) are added in card structures. Then at the time of mmc
block driver probing, mmc_blk_alloc_part function is called for each
partition which initialises the mmc request queue and and starts mmc queue
thread for each partition as shown below

root@mx6q35:~# ps x | grep mmc
   46 ?        S      0:00 [mmcqd/1]
  397 ?        S      0:00 [mmcqd/2]
  400 ?        S      0:00 [mmcqd/2boot0]
  401 ?        S      0:00 [mmcqd/2boot1]
  402 ?        S      0:00 [mmcqd/2rpmb]

mmc queue thread for each partition gets scheduled and calls
mmc_blk_issue_rq, and here it sends CMD6 using mmc_blk_part_switch,
CMD23-->CMD18 using mmc_blk_issue_rw_rq. When executed for RPMB partition,
logs can be seen below

[  109.972564] mmc2: starting CMD6 arg 03b30b01 flags 0000049d --> switch to
RPMB area
[  109.972600] sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
[  109.972625] mmc2: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[  109.977781] mmc2: starting CMD13 arg 00010000 flags 00000195
[  109.977823] sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
[  109.977849] mmc2: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  109.983013] <mmc2: starting CMD23 arg 00000080 flags 00000015>
[  109.983024] mmc2: starting CMD18 arg 00000000 flags 000000b5
[  109.983037] mmc2:     blksz 512 blocks 128 flags 00000200 tsac 100 ms nsac 0
[  109.983048] mmc2:     CMD12 arg 00000000 flags 0000049d
[  109.983083] sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
[  109.983218] sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
[  109.986505] sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x0000000a
[  109.986518] sdhci [sdhci_data_irq()]: mmc2: DMA base 0x3caf0000,
transferred 0x010000 bytes, next 0x3cb00000
[  109.986672] mmc2: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[  109.986691] mmc2:     65536 bytes transferred: 0
[  109.986709] mmc2:     (CMD12): 0: 00000000 00000000 00000000 00000000
[  109.992355] <mmc2: starting CMD23 arg 00000080 flags 00000015>
[  109.992368] mmc2: starting CMD18 arg 00000080 flags 000000b5
[  109.992381] mmc2:     blksz 512 blocks 128 flags 00000200 tsac 100 ms nsac 0
[  109.992392] mmc2:     CMD12 arg 00000000 flags 0000049d
[  109.992424] sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
[  109.992724] sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
[  109.996010] sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x0000000a
[  109.996025] sdhci [sdhci_data_irq()]: mmc2: DMA base 0x3cb40000,
transferred 0x040000 bytes, next 0x3cb80000
[  109.996160] mmc2: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[  109.996169] mmc2:     65536 bytes transferred: 0
[  109.996179] mmc2:     (CMD12): 0: 00000000 00000000 00000000 00000000
[  110.002250] mmc2: starting CMD6 arg 03b30a01 flags 0000049d --> switch to
Boot Partition 2 area
[  110.002292] sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
[  110.002318] mmc2: req done (CMD6): 0: 00000800 00000000 00000000 00000000

This is the point where you are facing issues with Hynix devices. A good way
to reproduce the issue can be by unbinding/binding the eMMC device with
block driver as follows

root@mx6q35:~# echo mmc2:0001 > /sys/bus/mmc/drivers/mmcblk/unbind
root@mx6q35:~# echo mmc2:0001 > /sys/bus/mmc/drivers/mmcblk/bind


Krishna, since RPMB is not a regular partition and a different command
sequence(CMD6-->CMD23-->CMD25-->CMD23-->CMD18) as mentioned in JEDEC
Standard No. 84-A441, is required to access it, then why mmc initialisation
code is using the wrong command sequence(CMD6-->CMD23-->CMD18) to access it?

Thanks .
Abbas Raza


