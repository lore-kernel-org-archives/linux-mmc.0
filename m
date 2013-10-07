From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: fix null pointer use in mmc_blk_remove_req
Date: Mon, 07 Oct 2013 11:48:00 +0300
Message-ID: <52527540.501@intel.com>
References: <1374671868-606-1-git-send-email-franck.jullien@gmail.com> <87d2p2sbcp.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14019 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab3JGItM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Oct 2013 04:49:12 -0400
In-Reply-To: <87d2p2sbcp.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-stable@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, franck.jullien@gmail.com, linux-mmc@vger.kernel.org

On 25/08/13 06:22, Chris Ball wrote:
> Hi Franck,
> 
> On Wed, Jul 24 2013, franck.jullien@gmail.com wrote:
>> From: Franck Jullien <franck.jullien@gmail.com>
>>
>> A previous commit (fdfa20c1631210d0) reordered the
>> shutdown sequence in mmc_blk_remove_req. However,
>> mmc_cleanup_queue is now called before we get the
>> card pointer and, sadly, mmc_cleanup_queue set
>> mq->card to NULL.
>>
>> This patch moves the card pointer assignment before
>> mmc_cleanup_queue.
>>
>> Signed-off-by: Franck Jullien <franck.jullien@gmail.com>
>> ---
>>  drivers/mmc/card/block.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index cd0b7f4..f4a0bea 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -2191,10 +2191,10 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>>  		 * is freeing the queue that stops new requests
>>  		 * from being accepted.
>>  		 */
>> +		card = md->queue.card;
>>  		mmc_cleanup_queue(&md->queue);
>>  		if (md->flags & MMC_BLK_PACKED_CMD)
>>  			mmc_packed_clean(&md->queue);
>> -		card = md->queue.card;
>>  		if (md->disk->flags & GENHD_FL_UP) {
>>  			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>>  			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
> 
> Thanks for the patch, pushed to mmc-next for 3.12.

Hi

The regression is in 3.11, and causes an oops (see below)
Adding linux-stable

The fix is now in linus' tree with commit id:

	8efb83a2f8518a6ffcc074177f8d659c5165ef37

Please cherry-pick this for 3.11


[  107.814928] BUG: unable to handle kernel NULL pointer dereference at 0000000000000398
[  107.823706] IP: [<ffffffffa000d201>] mmc_blk_remove_req+0x56/0x8b [mmc_block]
[  107.831709] PGD 134323067 PUD 1343c2067 PMD 0 
[  107.836703] Oops: 0000 [#1] PREEMPT SMP 
[  107.841098] Modules linked in: sdhci_acpi(-) mmc_block sdhci
[  107.847468] CPU: 1 PID: 133 Comm: rmmod Not tainted 3.11.3+ #15
[  107.854090] task: ffff8801341dc440 ti: ffff88013426c000 task.ti: ffff88013426c000
[  107.862456] RIP: 0010:[<ffffffffa000d201>]  [<ffffffffa000d201>] mmc_blk_remove_req+0x56/0x8b [mmc_block]
[  107.873172] RSP: 0018:ffff88013426dbe8  EFLAGS: 00010202
[  107.879111] RAX: ffff8801341e63a8 RBX: ffff8801341e6000 RCX: 00000000000160a0
[  107.887088] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000023
[  107.895058] RBP: ffff88013426dbf8 R08: ffff88013b443180 R09: ffff88013426dfd8
[  107.903035] R10: 000000000000273c R11: ffff880134330e00 R12: 0000000000000000
[  107.911005] R13: ffff8801341e5000 R14: ffffffffa001c098 R15: 0000000000000000
[  107.918985] FS:  00007f9bab888700(0000) GS:ffff88013fc80000(0000) knlGS:0000000000000000
[  107.928031] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  107.934455] CR2: 0000000000000398 CR3: 0000000134263000 CR4: 00000000001007e0
[  107.942422] Stack:
[  107.944669]  ffff8801341e5ba8 ffff8801341e53a8 ffff88013426dc18 ffffffffa000dbfa
[  107.952965]  ffff8801341e4800 ffff8801341e4808 ffff88013426dc48 ffffffffa000fca0
[  107.961260]  000000000000bbc9 ffff8801341e4808 ffffffffa0012010 ffffffff81a82210
[  107.969556] Call Trace:
[  107.972307]  [<ffffffffa000dbfa>] mmc_blk_remove_parts.isra.16+0x5c/0x6c [mmc_block]
[  107.980980]  [<ffffffffa000fca0>] mmc_blk_remove+0x25/0xa9 [mmc_block]
[  107.988289]  [<ffffffff8140dd6c>] mmc_bus_remove+0x15/0x19
[  107.994432]  [<ffffffff812f14a8>] __device_release_driver+0x86/0xdc
[  108.001448]  [<ffffffff812f175d>] device_release_driver+0x1e/0x2b
[  108.008269]  [<ffffffff812f10bc>] bus_remove_device+0xe5/0xfa
[  108.014701]  [<ffffffff812eeb96>] device_del+0x12c/0x186
[  108.020646]  [<ffffffff8140e2cc>] mmc_remove_card+0x66/0x76
[  108.026884]  [<ffffffff8140ec55>] mmc_remove+0x23/0x32
[  108.032636]  [<ffffffff8140dbb2>] mmc_stop_host+0x58/0x9f
[  108.038678]  [<ffffffff8140e301>] mmc_remove_host+0x1d/0x3e
[  108.044923]  [<ffffffffa0001d76>] sdhci_remove_host+0x94/0x122 [sdhci]
[  108.052235]  [<ffffffffa001a145>] sdhci_acpi_remove+0x79/0x8b [sdhci_acpi]
[  108.059932]  [<ffffffff812f2e50>] platform_drv_remove+0x1a/0x3e
[  108.066559]  [<ffffffff812f14a8>] __device_release_driver+0x86/0xdc
[  108.073574]  [<ffffffff812f1c9f>] driver_detach+0x81/0xb2
[  108.079611]  [<ffffffff812f1357>] bus_remove_driver+0x6f/0xb4
[  108.086045]  [<ffffffffa001a568>] ? sdhci_acpi_probe+0x411/0x411 [sdhci_acpi]
[  108.094031]  [<ffffffff812f20a3>] driver_unregister+0x4e/0x73
[  108.100464]  [<ffffffff812f2d26>] platform_driver_unregister+0xd/0xf
[  108.107578]  [<ffffffffa001a578>] sdhci_acpi_driver_exit+0x10/0xa98 [sdhci_acpi]
[  108.115859]  [<ffffffff8107eac3>] SyS_delete_module+0x1b6/0x244
[  108.122488]  [<ffffffff8102c638>] ? do_page_fault+0x9/0xd
[  108.128535]  [<ffffffff815cd052>] system_call_fastpath+0x16/0x1b
[  108.135250] Code: 00 48 8b 7b 08 4c 8b 63 10 f6 87 60 03 00 00 10 74 41 48 8d b3 d8 03 00 00 48 83 c7 70 e8 26 10 2e e1 f6 83 18 04 00 00 02 74 1f <41> 80 bc 24 98 03 00 00 00 74 14 48 8b 7b 08 48 8d b3 f8 03 00 
[  108.156804] RIP  [<ffffffffa000d201>] mmc_blk_remove_req+0x56/0x8b [mmc_block]
[  108.164895]  RSP <ffff88013426dbe8>
[  108.168794] CR2: 0000000000000398
[  108.174595] ---[ end trace b9c7313fc09b25d8 ]---

