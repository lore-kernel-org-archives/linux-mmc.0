From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: Block new req entering queue after its
 cleanup
Date: Mon, 24 Jul 2017 17:33:33 +0800
Message-ID: <9e88c392-1027-2b6a-571c-3edd9a1b3a42@rock-chips.com>
References: <20170713091758.2975-1-linus.walleij@linaro.org>
 <CAPDyKFpmkE7gKsCgcKRVgn2yoeNJOLd01V0ngEwH-aFXbhvM8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:42538 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753384AbdGXJdp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jul 2017 05:33:45 -0400
In-Reply-To: <CAPDyKFpmkE7gKsCgcKRVgn2yoeNJOLd01V0ngEwH-aFXbhvM8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grzegorz Sluja <grzegorzx.sluja@intel.com>

Hi

On 2017/7/13 17:46, Ulf Hansson wrote:
> On 13 July 2017 at 11:17, Linus Walleij <linus.walleij@linaro.org> wrote:
>> From: Grzegorz Sluja <grzegorzx.sluja@intel.com>
>>
>> commit 304419d8a7e9204c5d19b704467b814df8c8f5b1
>> 'mmc: core: Allocate per-request data using the block layer core'
>> refactored mechanism of queue handling caused mmc_init_request() can
>> be called just after mmc_cleanup_queue() caused null pointer dereference:
>>
>> dmesg:
>> [  683.123791] BUG: unable to handle kernel NULL pointer dereference at (null)
>> [  683.123801] IP: mmc_init_request+0x2c/0xf0 [mmc_block]
>> ...
>> [  683.123905] Call Trace:
>> [  683.123913]  alloc_request_size+0x4f/0x70
>> [  683.123919]  mempool_alloc+0x5f/0x150
>> [  683.123925]  ? __enqueue_entity+0x6c/0x70
>> [  683.123928]  get_request+0x3ad/0x720
>> [  683.123933]  ? prepare_to_wait_event+0x110/0x110
>> [  683.123937]  blk_queue_bio+0xc1/0x3a0
>> [  683.123940]  generic_make_request+0xf8/0x2a0
>> [  683.123942]  submit_bio+0x75/0x150
>> [  683.123947]  submit_bio_wait+0x51/0x70
>> [  683.123951]  blkdev_issue_flush+0x5c/0x90
>> [  683.123956]  ext4_sync_fs+0x171/0x1b0
>> [  683.123961]  sync_filesystem+0x73/0x90
>> [  683.123965]  fsync_bdev+0x24/0x50
>> [  683.123971]  invalidate_partition+0x24/0x50
>> [  683.123973]  del_gendisk+0xb2/0x2a0
>> [  683.123977]  mmc_blk_remove_req.part.38+0x71/0xa0 [mmc_block]
>> [  683.123980]  mmc_blk_remove+0xba/0x190 [mmc_block]
>> [  683.123990]  mmc_bus_remove+0x1a/0x20 [mmc_core]
>> [  683.123995]  device_release_driver_internal+0x141/0x200
>> [  683.123999]  device_release_driver+0x12/0x20
>> [  683.124001]  bus_remove_device+0xfd/0x170
>> [  683.124004]  device_del+0x1e8/0x330
>> [  683.124012]  mmc_remove_card+0x60/0xc0 [mmc_core]
>> [  683.124019]  mmc_remove+0x19/0x30 [mmc_core]
>> [  683.124025]  mmc_stop_host+0xfb/0x1a0 [mmc_core]
>> [  683.124032]  mmc_remove_host+0x1a/0x40 [mmc_core]
>> [  683.124037]  sdhci_remove_host+0x2e/0x1c0 [mmc_sdhci]
>> [  683.124042]  sdhci_pci_remove_slot+0x3f/0x80 [sdhci_pci]
>> [  683.124045]  sdhci_pci_remove+0x39/0x70 [sdhci_pci]
>> [  683.124049]  pci_device_remove+0x39/0xc0
>> [  683.124052]  device_release_driver_internal+0x141/0x200
>> [  683.124056]  driver_detach+0x3f/0x80
>> [  683.124059]  bus_remove_driver+0x55/0xd0
>> [  683.124062]  driver_unregister+0x2c/0x50
>> [  683.124065]  pci_unregister_driver+0x29/0x90
>> [  683.124069]  sdhci_driver_exit+0x10/0x4f3 [sdhci_pci]
>> [  683.124073]  SyS_delete_module+0x171/0x250
>> [  683.124078]  entry_SYSCALL_64_fastpath+0x1e/0xa9
>>
>> Set queue DYING flag just before its cleaning blocked new req entering
>> the queue afterwards.
>>
>> Signed-off-by: Grzegorz Sluja <grzegorzx.sluja@intel.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Thanks, applied for fixes!
> 
> I added a fixes tag and updated the changelog a bit.
> 

It doesn't fix all the issues.

I still can see this problem for running linux-next-20170720 which
already has this fix. I will try to debug it but any suggestion
was welcomed.


[ 1312.684588] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
[ 1312.685358] user pgtable: 4k pages, 48-bit VAs, pgd = ffff80007bab3000
[ 1312.685939] [0000000000000000] *pgd=000000007a828003, 
*pud=0000000078dce003, *pmd=000000007aab6003, *pte=0000000000000000
[ 1312.686936] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[ 1312.687444] Modules linked in:
[ 1312.687751] CPU: 3 PID: 3507 Comm: umount Tainted: G        W 
4.13.0-rc1-next-20170720-00012-g9d9bf45 #33
[ 1312.688639] Hardware name: Firefly-RK3399 Board (DT)
[ 1312.689085] task: ffff80007a1de200 task.stack: ffff80007a01c000
[ 1312.689624] PC is at mmc_init_request+0x14/0xc4
[ 1312.690041] LR is at alloc_request_size+0x4c/0x74
[ 1312.690465] pc : [<ffff0000087d7150>] lr : [<ffff000008378fe0>] 
pstate: 600001c5
[ 1312.691118] sp : ffff80007a01f8f0
[ 1312.691419] x29: ffff80007a01f8f0 x28: ffff000009020c60
[ 1312.691903] x27: ffff80007a935400 x26: ffff80007b14a568
[ 1312.692387] x25: ffff80007b1820e0 x24: ffff000008378f5c
[ 1312.692871] x23: 0000000000000004 x22: 0000000001000200
[ 1312.693354] x21: 0000000001000200 x20: ffff80007b14a000
[ 1312.693836] x19: ffff80007b14a148 x18: 0000000000000000
[ 1312.694319] x17: 0000000000000000 x16: ffff000008090a70
[ 1312.694801] x15: 0000000000000000 x14: 00002a3000002a29
[ 1312.695284] x13: 00002a2100002a19 x12: 00002a4d00002a49
[ 1312.695767] x11: 00002a4000002a39 x10: 00002a6900002a61
[ 1312.696250] x9 : 0000000000000000 x8 : ffff80007b53a480
[ 1312.696731] x7 : 0000000000000000 x6 : 000000000000003f
[ 1312.697213] x5 : 0000000000000040 x4 : 0000000000000000
[ 1312.697694] x3 : ffff0000087d713c x2 : 0000000001000200
[ 1312.698176] x1 : ffff80007b14a000 x0 : 0000000000000000
[ 1312.698661] Process umount (pid: 3507, stack limit = 0xffff80007a01c000)
[ 1312.699258] Stack: (0xffff80007a01f8f0 to 0xffff80007a020000)
[ 1312.699776] f8e0:                                   ffff80007a01f920 
ffff000008378fe0
[ 1312.700475] f900: ffff80007b1820e0 ffff80007b14a000 ffff80007a935400 
0000000001000200
[ 1312.701174] f920: ffff80007a01f950 ffff00000817ac28 ffff80007b53a400 
ffff80007b53af80
[ 1312.701873] f940: ffff000008378f94 ffff80007b1820e0 ffff80007a01f9a0 
ffff00000837aadc
[ 1312.702573] f960: ffff80007b14a440 ffff80007b1820e0 ffff0000090202e0 
ffff80007b1820e0
[ 1312.703272] f980: ffff000009020000 ffff000009020d78 ffff80007b14a608 
ffff80007a935400
[ 1312.703969] f9a0: ffff80007a01f9e0 ffff000008396580 0000000000000004 
ffff80007b14a400
[ 1312.704667] f9c0: 0000000001000200 ffff80007b14a400 0000000001000200 
0000000001000200
[ 1312.705366] f9e0: ffff80007a01fa50 ffff000008396ac8 0000000000000000 
ffff80007a935400
[ 1312.706065] fa00: 0000000000000001 ffff80007b1820e0 ffff80007a935400 
ffff80007b53a100
[ 1312.706762] fa20: ffff00000822f2e4 ffff000008230104 0000000000000001 
0000000000000100
[ 1312.707460] fa40: 0000000000000001 ffff000009020c48 ffff80007a01fa90 
ffff00000839877c
[ 1312.708159] fa60: ffff000009020c60 ffff80007b1820e0 ffff80007a935400 
ffff000009020c60
[ 1312.708858] fa80: ffff80007a935400 0000000000000000 ffff80007a01fad0 
ffff0000083796bc
[ 1312.709556] faa0: ffff80007a0f4500 ffff80007b1820e0 0000000000000000 
ffff80007a935400
[ 1312.710255] fac0: 0000000000000000 0000000000000000 ffff80007a01fb20 
ffff00000837b050
[ 1312.710953] fae0: ffff80007a0f4500 ffff80007a0f4500 0000000000080000 
0000000000000000
[ 1312.711652] fb00: ffff80007a01fb90 ffff000008375054 ffff80007c37c750 
ffff80007bef7500
[ 1312.712351] fb20: ffff80007a01fb80 ffff00000837b324 ffff80007a0f4500 
0000000000000001
[ 1312.713047] fb40: 0000000000080000 0000000000000000 0000000000000000 
0000000000000000
[ 1312.713746] fb60: ffff80007a01fbb0 ffff000008230d54 0000000000000000 
ffff000008eac000
[ 1312.714444] fb80: ffff80007a01fbf0 ffff00000823226c ffff80007c37c750 
ffff80007a0f4500
[ 1312.715142] fba0: 0000000000080000 ffff80007a01fca0 0000000000080000 
0000000000000000
[ 1312.715840] fbc0: 0000000000000000 0000000000000000 ffff80007a01fbf0 
ffff000008232244
[ 1312.716537] fbe0: ffff80007c37c750 0000000000000008 ffff80007a01fc30 
ffff000008232dac
[ 1312.717237] fc00: ffff80007c37c750 ffff80007a01fca0 0000000000000000 
ffff80007a01fca0
[ 1312.717934] fc20: 0000000000000000 0000000000080000 ffff80007a01fc80 
ffff000008232ea0
[ 1312.718633] fc40: ffff800078d9c000 0000000000000000 ffff0000089bf9a8 
ffff80007bb1e800
[ 1312.719330] fc60: 0000000000000000 00000000000000ff 0000000000000100 
0000000000000001
[ 1312.720030] fc80: ffff80007a01fca0 ffff0000082e050c ffff80007a01fca0 
ffff80007c37c750
[ 1312.720728] fca0: ffff80007a01fd60 ffff0000082e1ed0 000000000000b380 
ffff800078d9c000
[ 1312.721425] fcc0: ffff800079eb3b40 0000000000fae378 0000000000070030 
0000000000000011
[ 1312.722123] fce0: 000000000000018e 000000000000010a ffff000008994000 
ffff80007a1de200
[ 1312.722821] fd00: ffff80007c045cc0 ffff800078d9c048 0000000200001005 
000000080000015e
[ 1312.723518] fd20: 0000000000000ac2 ffff800000000002 0000000000000000 
0000000000000011
[ 1312.724214] fd40: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1312.724914] fd60: ffff80007a01fda0 ffff00000822e320 ffff80007a01fe48 
ffff800079eb3b40
[ 1312.725612] fd80: ffff80007a01fe48 ffff800079eb3b40 ffff80007a01fe48 
ffff80007a01fe48
[ 1312.726312] fda0: ffff80007a01fdc0 ffff00000822e35c ffff80007a01fe48 
ffff80007a01fe10
[ 1312.727010] fdc0: ffff80007a01fde0 ffff00000822e438 0000000000000000 
0000000000000005
[ 1312.727709] fde0: ffff80007a01fe20 ffff00000822e770 00000000ffa85150 
00008000760bc000
[ 1312.728409] fe00: ffffffffffffffff 00000000f79446f6 ffff80007b4abca0 
ffff800079eb3b40
[ 1312.729106] fe20: 0000000000000000 ffff000008082f30 0000000000400000 
000081a4000007ff
[ 1312.729803] fe40: 0000100000000001 0000000000000000 0000000000000000 
0000000000000000
[ 1312.730500] fe60: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1312.731197] fe80: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1312.731893] fea0: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1312.732590] fec0: 0000000000fae378 0000000000000058 00000000ffa85150 
00000000f7a5a000
[ 1312.733288] fee0: 0000000000fae250 00000000ffa85150 00000000f7a5a000 
000000000000010a
[ 1312.733986] ff00: 0000000000fae378 0000000000000000 0000000000013c10 
00000000ffa853d4
[ 1312.734684] ff20: 000000000000010a 00000000ffa850b4 00000000f79b7443 
0000000000000000
[ 1312.735381] ff40: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1312.736077] ff60: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1312.736774] ff80: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1312.737472] ffa0: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 1312.738169] ffc0: 00000000f79446f6 0000000000070030 0000000000fae378 
000000000000010a
[ 1312.738868] ffe0: 0000000000000000 0000000000000000 ffff80007a01fff0 
ffff80007a01fff0
[ 1312.739559] Call trace:
[ 1312.739793] Exception stack(0xffff80007a01f720 to 0xffff80007a01f850)
[ 1312.740372] f720: ffff80007b14a148 0001000000000000 ffff80007a01f8f0 
ffff0000087d7150
[ 1312.741069] f740: 0000000000000003 0000000000000001 000000010003dce7 
ffff80007bc63600
[ 1312.741767] f760: ffff80007a01f880 0000000000000002 0000000000000000 
00000000016080c0
[ 1312.742464] f780: ffff80007a01f880 ffff80007ad1b7e8 ffff80007be0b000 
0000000000000200
[ 1312.743162] f7a0: ffff80007a01f7c0 ffff00000836798c ffff80007a01f880 
0000000000000800
[ 1312.743859] f7c0: 0000000000000000 ffff80007b14a000 0000000001000200 
ffff0000087d713c
[ 1312.744556] f7e0: 0000000000000000 0000000000000040 000000000000003f 
0000000000000000
[ 1312.745255] f800: ffff80007b53a480 0000000000000000 00002a6900002a61 
00002a4000002a39
[ 1312.745952] f820: 00002a4d00002a49 00002a2100002a19 00002a3000002a29 
0000000000000000
[ 1312.746646] f840: ffff000008090a70 0000000000000000
[ 1312.747092] [<ffff0000087d7150>] mmc_init_request+0x14/0xc4
[ 1312.747597] [<ffff000008378fe0>] alloc_request_size+0x4c/0x74
[ 1312.748120] [<ffff00000817ac28>] mempool_create_node+0xb8/0x17c
[ 1312.748651] [<ffff00000837aadc>] blk_init_rl+0x9c/0x120
[ 1312.749123] [<ffff000008396580>] blkg_alloc+0x110/0x234
[ 1312.749594] [<ffff000008396ac8>] blkg_create+0x424/0x468
[ 1312.750074] [<ffff00000839877c>] blkg_lookup_create+0xd8/0x14c
[ 1312.750603] [<ffff0000083796bc>] generic_make_request_checks+0x368/0x3b0
[ 1312.751201] [<ffff00000837b050>] generic_make_request+0x1c/0x240
[ 1312.751740] [<ffff00000837b324>] submit_bio+0xb0/0x188
[ 1312.752207] [<ffff00000823226c>] submit_bh_wbc+0x130/0x170
[ 1312.752703] [<ffff000008232dac>] ll_rw_block+0xc0/0x128
[ 1312.753176] [<ffff000008232ea0>] __breadahead+0x2c/0x40
[ 1312.753653] [<ffff0000082e050c>] fat_count_free_clusters+0x248/0x254
[ 1312.754225] [<ffff0000082e1ed0>] fat_statfs+0xc0/0xd0
[ 1312.754680] [<ffff00000822e320>] statfs_by_dentry+0x70/0x90
[ 1312.755180] [<ffff00000822e35c>] vfs_statfs+0x1c/0xb0
[ 1312.755634] [<ffff00000822e438>] user_statfs+0x48/0x90
[ 1312.756099] [<ffff00000822e770>] compat_SyS_statfs64+0x20/0x54
[ 1312.756624] [<ffff000008082f30>] el0_svc_naked+0x24/0x28
[ 1312.757110] Code: 910003fd a90153f3 91052033 f940d000 (f9400014)
[ 1312.758176] ---[ end trace d4d57b463eb386ea ]---
[ 1312.758658] note: umount[3507] exited with preempt_count 1



> Kind regards
> Uffe
> 
>> ---
>> Hi Ulf, forwarding an important fix from Grzegorz at Intel, please
>> apply!
>>
>> Linus
>> ---
>>   drivers/mmc/core/block.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 0cfac2d39107..5ddde7dc9075 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -2167,6 +2167,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>>                   * from being accepted.
>>                   */
>>                  card = md->queue.card;
>> +               blk_set_queue_dying(md->queue.queue);
>>                  mmc_cleanup_queue(&md->queue);
>>                  if (md->disk->flags & GENHD_FL_UP) {
>>                          device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>> --
>> 2.9.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

