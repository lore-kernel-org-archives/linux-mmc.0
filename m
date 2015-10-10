From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: Write errors on Cherrytrail eMMC
Date: Sat, 10 Oct 2015 09:05:44 +0800
Message-ID: <56186468.80805@rock-chips.com>
References: <1444436356.28661.47.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:42129 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbbJJBF6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2015 21:05:58 -0400
In-Reply-To: <1444436356.28661.47.camel@hadess.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com

On 2015/10/10 8:19, Bastien Nocera wrote:
> Heya,
>
> On a Cherrytrail device (the MS Surface 3), trying to install to the
> internal eMMC, I get write errors with the controller timing out.
>
> I'm using a self built 4.3.0-0.rc4.git3.2.fc24.x86_64.
>
> Any ideas?
>
> Cheers
>
> Oct 09 18:09:24 localhost kernel: mmc0: starting CMD25 arg 05ba4800 flags 000000b5
> Oct 09 18:09:24 localhost kernel: mmc0:     blksz 512 blocks 1024 flags 00000100 tsac 1200 ms nsac 8000
> Oct 09 18:09:24 localhost kernel: mmc0:     CMD12 arg 00000000 flags 0000049d
> Oct 09 18:09:24 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> Oct 09 18:09:34 localhost kernel: mmc0: Timeout waiting for hardware interrupt.
> Oct 09 18:09:34 localhost kernel: sdhci: =========== REGISTER DUMP (mmc0)===========
> Oct 09 18:09:34 localhost kernel: sdhci: Sys addr: 0x00000400 | Version:  0x00001002
> Oct 09 18:09:34 localhost kernel: sdhci: Blk size: 0x00007200 | Blk cnt:  0x00000203

HC doesn't decrements blk cnt to zero means your data path is blocked.
So I guess it's either a Noc/Qos problem of your chip or "too busy" for 
emmc to pragramme the data.

> Oct 09 18:09:34 localhost kernel: sdhci: Argument: 0x05ba4800 | Trn mode: 0x0000002b
> Oct 09 18:09:34 localhost kernel: sdhci: Present:  0x1fff0106 | Host ctl: 0x00000035
> Oct 09 18:09:34 localhost kernel: sdhci: Power:    0x0000000b | Blk gap:  0x00000080
> Oct 09 18:09:34 localhost kernel: sdhci: Wake-up:  0x00000000 | Clock:    0x00000007
> Oct 09 18:09:34 localhost kernel: sdhci: Timeout:  0x00000008 | Int stat: 0x00000000
> Oct 09 18:09:34 localhost kernel: sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
> Oct 09 18:09:34 localhost kernel: sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> Oct 09 18:09:34 localhost kernel: sdhci: Caps:     0x446cc8b2 | Caps_1:   0x00000007
> Oct 09 18:09:34 localhost kernel: sdhci: Cmd:      0x0000193a | Max curr: 0x00000000
> Oct 09 18:09:34 localhost kernel: sdhci: Host ctl2: 0x0000008b
> Oct 09 18:09:34 localhost kernel: sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x3fbf90e0
> Oct 09 18:09:34 localhost kernel: sdhci: ===========================================
> Oct 09 18:09:34 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> Oct 09 18:09:34 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002

No, sdhci finally complete the tansfer. So, you can try to augment the 
timeout [here, mod_timer(&host->timer, timeout)] to see how the things 
going.

> Oct 09 18:09:34 localhost kernel: mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
> Oct 09 18:09:34 localhost kernel: mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> Oct 09 18:09:34 localhost kernel: mmc0:     0 bytes transferred: -110
> Oct 09 18:09:34 localhost kernel: mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> Oct 09 18:09:34 localhost kernel: mmc0: starting CMD13 arg 00010000 flags 00000195
> Oct 09 18:09:34 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> Oct 09 18:09:34 localhost kernel: mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> Oct 09 18:09:34 localhost kernel: mmc0: starting CMD13 arg 00010000 flags 00000195
> Oct 09 18:09:34 localhost kernel: sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> Oct 09 18:09:34 localhost kernel: mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> Oct 09 18:09:34 localhost kernel: mmcblk0: error -110 transferring data, sector 96094208, nr 1024, cmd response 0x900, card status 0xd00
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094208
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094216
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094224
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094232
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094240
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094248
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094256
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094264
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094272
> Oct 09 18:09:34 localhost kernel: blk_update_request: I/O error, dev mmcblk0, sector 96094280
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Best Regards
Shawn Lin

