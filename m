From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [SHDCI] Heavy (thousands) DMA leaks
Date: Mon, 3 Aug 2015 09:30:33 +0000
Message-ID: <BY1PR03MB138811AD7FAB3C561CC683679A770@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <55B9EF02.7040404@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0116.outbound.protection.outlook.com ([65.55.169.116]:15200
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751756AbbHCJaf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Aug 2015 05:30:35 -0400
In-Reply-To: <55B9EF02.7040404@suse.cz>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>

Hi Js,

I carefully review my patch, all the DMA memory mapped in sdhci_pre_req() is unmapped in sdhci_post_req.

Can you provide the method of your testing DMA leaks?  You said over 4000 leaked mappings during one card transfer, if true, 
We can't map any dma memory after some sd transfer, do you meet this?


Best Regards
Haibo Chen



> -----Original Message-----
> From: Jiri Slaby [mailto:jslaby@suse.cz]
> Sent: Thursday, July 30, 2015 5:32 PM
> To: Chen Haibo-B51421
> Cc: Ulf Hansson; linux-mmc@vger.kernel.org; Linux kernel mailing list
> Subject: [SHDCI] Heavy (thousands) DMA leaks
> 
> Hi,
> 
> after
> commit 348487cb28e66b032bae1b38424d81bf5b444408
> Author: Haibo Chen <haibo.chen@freescale.com>
> Date:   Tue Dec 9 17:04:05 2014 +0800
> 
>     mmc: sdhci: use pipeline mmc requests to improve performance
> 
> I see heavy DMA leaks which result in warnings of the dma api debug code:
> WARNING: CPU: 0 PID: 0 at lib/dma-debug.c:509 add_dma_entry+0x138/0x150()
> DMA-API: exceeded 7 overlapping mappings of cacheline 0x000000000b20ec00
> 
> 
> 
> And mainly this one upon sdhci module removal. It is over 4000 leaked
> mappings during one card transfer.
> mmc0: card e624 removed
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 1263 at lib/dma-debug.c:974
> dma_debug_device_change+0x158/0x1c0()
> pci 0000:02:00.0: DMA-API: device driver has pending DMA allocations
> while released from device [count=4041] One of leaked entries details:
> [device address=0x00000000ddff0000]
> [size=65536 bytes] [mapped with DMA_FROM_DEVICE] [mapped as scather-
> gather] Modules linked in:
> CPU: 2 PID: 1263 Comm: bash Tainted: G        W       4.2.0-rc4 #12
> Hardware name: LENOVO 23252SG/23252SG, BIOS G2ET33WW (1.13 ) 07/24/2012
>  ffffffff81cc5e32 ffff8800d03c3b68 ffffffff81820938 0000000000000000
>  ffff8800d03c3bb8 ffff8800d03c3ba8 ffffffff810b827a 0000000100260021
>  ffff88030e500000 0000000000000fc9 ffff88030d95aeb8 ffff88030e4ddd68 Call
> Trace:
>  [<ffffffff81820938>] dump_stack+0x4c/0x6e  [<ffffffff810b827a>]
> warn_slowpath_common+0x8a/0xc0  [<ffffffff810b82f6>]
> warn_slowpath_fmt+0x46/0x50  [<ffffffff813248c8>]
> dma_debug_device_change+0x158/0x1c0
>  [<ffffffff810d4e9d>] notifier_call_chain+0x4d/0x80  [<ffffffff810d51fd>]
> __blocking_notifier_call_chain+0x4d/0x70
>  [<ffffffff810d5236>] blocking_notifier_call_chain+0x16/0x20
>  [<ffffffff814db395>] __device_release_driver+0x105/0x130
>  [<ffffffff814db3e3>] device_release_driver+0x23/0x30
> [<ffffffff814d95ca>] unbind_store+0xba/0xe0  [<ffffffff8123c638>] ?
> kernfs_fop_write+0xe8/0x170  [<ffffffff814d8ac4>]
> drv_attr_store+0x24/0x30  [<ffffffff8123ce4a>] sysfs_kf_write+0x3a/0x50
> [<ffffffff8123c670>] kernfs_fop_write+0x120/0x170  [<ffffffff811ce9e8>]
> __vfs_write+0x28/0xe0  [<ffffffff811d1209>] ? __sb_start_write+0x49/0xe0
> [<ffffffff810e3ba5>] ? local_clock+0x25/0x30  [<ffffffff811cf041>]
> vfs_write+0xa1/0x170  [<ffffffff810e43c4>] ? vtime_account_user+0x54/0x60
> [<ffffffff811cfce6>] SyS_write+0x46/0xa0  [<ffffffff81180f83>] ?
> context_tracking_user_exit+0x13/0x20
>  [<ffffffff8182a017>] entry_SYSCALL_64_fastpath+0x12/0x6a
> ---[ end trace 398181ad32332b33 ]---
> Mapped at:
>  [<ffffffff81324492>] debug_dma_map_sg+0x122/0x140  [<ffffffff81616dd3>]
> sdhci_pre_dma_transfer+0xc3/0x1b0  [<ffffffff81616f02>]
> sdhci_pre_req+0x42/0x70  [<ffffffff81601492>] mmc_pre_req+0x42/0x60
> [<ffffffff8160290e>] mmc_start_req+0x3e/0x400
> 
> I already fixed one symptom -- memory corruption. Could you revisit the
> commit once again, as there is surely at least one more bug?
> 
> thanks,
> --
> js
> suse labs
