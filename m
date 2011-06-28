From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Tue, 28 Jun 2011 16:32:48 -0700
Message-ID: <87mxh1v8f3.fsf@ti.com>
References: <1309282049-23739-1-git-send-email-balajitk@ti.com>
	<1309282049-23739-3-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:44548 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751289Ab1F1Xcx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 19:32:53 -0400
In-Reply-To: <1309282049-23739-3-git-send-email-balajitk@ti.com> (Balaji
	T. K.'s message of "Tue, 28 Jun 2011 22:57:28 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com, svenkatr@ti.com, "Nayak, Rajendra" <rnayak@ti.com>

+Rajendra

Balaji T K <balajitk@ti.com> writes:

> add runtime pm support to HSMMC host controller
> Use runtime pm API to enable/disable HSMMC clock
> Use runtime autosuspend APIs to enable auto suspend delay
>
> Based on OMAP HSMMC runtime implementation by Kevin Hilman, Kishore Kadiyala
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

I tried to test this series along with Benoit's clkdm/modulemode/hwmod
cleanups and something strange is happening on OMAP4.

First, this series by itself is working as I would expect, but testing
in combination with Benoit's series, it's different...

First, I'm using Benoit's branch:

       git://gitorious.org/omap-pm/linux.git for_3.0.1/7_hwmod_modulemode

in combination with your series.

I've also reverted these two commits:

   OMAP4: PM: TEMP: Prevent l3init from idling/force sleep
   OMAP3+: hwmod data: TEMP: Do not idle MMC1 & MMC2 after boot

which are temporary workarounds for not having MMC runtime PM.

I turned the dev_dbg calls in the runtime PM callbacks into dev_info
callbacks to see exactly when the device is enabled/disabled via runtime
PM.

To my surprise, I didn't see the device being enabled/disabled when
writing do the device.

First, I mounted:

root@foo:~# mount /dev/mmcblk0p2 /media/mmc2
[  730.392944] omap_hsmmc omap_hsmmc.0: host: enabled
[  730.445831] EXT3-fs: barriers not enabled
[  730.453124] kjournald starting.  Commit interval 5 seconds
[  730.459045] EXT3-fs (mmcblk0p2): warning: maximal mount count reached, runnid
[  730.474731] EXT3-fs (mmcblk0p2): using internal journal
[  730.480316] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode
[  730.522613] omap_hsmmc omap_hsmmc.0: disabled                                

As expected, the device is enabled for mount, and soon disabled
(presumably after the autosuspend timeout.)

Then, I cd'd to the card:

root@foo:~# cd /media/mmc2/tmp                                                
[  744.350921] omap_hsmmc omap_hsmmc.0: host: enabled                           
[  744.413238] omap_hsmmc omap_hsmmc.0: disabled    

and see a brief enable/disable, probably to get the directory contents.

Now the strange part.  I wrote a chunk of random data to the device,
but didn't see any enable/disable activity until the unmount.  Not even
after I did a sync.

root@foo:/media/mmc2/tmp# dd if=/dev/urandom of=rand.bin bs=1M count=4        
4+0 records in                                                                  
4+0 records out                                                                 
4194304 bytes (4.2 MB) copied, 9.91346 s, 423 kB/s                              
root@foo:/media/mmc2/tmp# sync                                                
root@foo:/media/mmc2/tmp# cd                                                  
root@foo:~# umount /media/mmc2                                                
[ 1026.711578] omap_hsmmc omap_hsmmc.0: host: enabled                           
[ 1026.772918] omap_hsmmc omap_hsmmc.0: disabled                                
root@foo:~# 


Using this series standalone I see a few enable/disable cycles during
the write, presumably as the MMC core buffers and bursts writes.

Any ideas why the same isn't happening when used with Benoit's series?

Kevin

P.S. note that the debug messages don't quite match.  One says 'host:
enabled' the other says 'disabled' (without the host: prefix.)  making
the prefixes match would be more readable.

