From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: block: Delete gendisk before cleaning up the request
 queue
Date: Thu, 22 Mar 2018 10:47:27 +0100
Message-ID: <CAPDyKFrHsg1+3w7iOjKZGCuho-K37PN8Skta_H-uy4dnVMbd9A@mail.gmail.com>
References: <1521704940-45406-1-git-send-email-shawn.lin@rock-chips.com>
 <f1c54ab8-aa38-69bc-b55a-fd8decc67d2d@intel.com>
 <ba973085-9321-c782-2eb1-68a1ff67366c@rock-chips.com>
 <1e104a4a-0508-97ee-4235-12de3e38b417@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1e104a4a-0508-97ee-4235-12de3e38b417-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 22 March 2018 at 10:31, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On 22/03/18 10:43, Shawn Lin wrote:
>> On 2018/3/22 16:26, Adrian Hunter wrote:
>>> On 22/03/18 09:49, Shawn Lin wrote:
>>>> dd if=/dev/urandom of=/dev/mmcblk1 bs=4k count=10000
>>>> with a SD card hotplug during transfer reports a warning below:
>>>
>>> What kernel version / commit was it?
>>
>> Actually the log below has it, it is clean : 4.16.0-rc6-next-20180321
>
> Ok so it seems to be coming from this patch in next:
>
> commit a063057d7c731cffa7d10740e8ebc2970df8dbb3
> Author: Bart Van Assche <bart.vanassche-Sjgp3cTcYWE@public.gmane.org>
> Date:   Wed Feb 28 10:15:33 2018 -0800
>
>     block: Fix a race between request queue removal and the block cgroup controller
>
>     Avoid that the following race can occur:
>
>     blk_cleanup_queue()               blkcg_print_blkgs()
>       spin_lock_irq(lock) (1)           spin_lock_irq(blkg->q->queue_lock) (2,5)
>         q->queue_lock = &q->__queue_lock (3)
>       spin_unlock_irq(lock) (4)
>                                         spin_unlock_irq(blkg->q->queue_lock) (6)
>
>     (1) take driver lock;
>     (2) busy loop for driver lock;
>     (3) override driver lock with internal lock;
>     (4) unlock driver lock;
>     (5) can take driver lock now;
>     (6) but unlock internal lock.
>
>     This change is safe because only the SCSI core and the NVME core keep
>     a reference on a request queue after having called blk_cleanup_queue().
>     Neither driver accesses any of the removed data structures between its
>     blk_cleanup_queue() and blk_put_queue() calls.
>
>     Reported-by: Joseph Qi <joseph.qi-KPsoFbNs7GizrGE5bRqYAgC/G2K4zDHf@public.gmane.org>
>     Signed-off-by: Bart Van Assche <bart.vanassche-Sjgp3cTcYWE@public.gmane.org>
>     Reviewed-by: Joseph Qi <joseph.qi-KPsoFbNs7GizrGE5bRqYAgC/G2K4zDHf@public.gmane.org>
>     Cc: Jan Kara <jack-IBi9RG/b67k@public.gmane.org>
>     Signed-off-by: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>

Looks like a reasonable analyze!

Shawn, could you please re-post your patch to linux-block, Jens,
cc:mmc-list, me and Adrian.

I think the patch should be picked up by Jens and go via his tree.

Kind regards
Uffe

>
>
>>
>>>
>>>>
>>>> Remove the disk, partition and bdi sysfs attributes before cleaning
>>>> up the request queue associated with the disk.
>>>>
>>>> [  410.331226] mmc1: card 59b4 removed
>>>> [  410.348583] WARNING: CPU: 0 PID: 5 at block/blk-core.c:785
>>>> blk_cleanup_queue+0x138/0x140
>>>> [  410.349294] Modules linked in:
>>>> [  410.349570] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted
>>>> 4.16.0-rc6-next-20180321-00004-gc2ad6a7 #263
>>>> [  410.350363] Hardware name: Excavator-RK3399 Board (DT)
>>>> [  410.350819] Workqueue: events_freezable mmc_rescan
>>>> [  410.351242] pstate: 60000005 (nZCv daif -PAN -UAO)
>>>> [  410.351663] pc : blk_cleanup_queue+0x138/0x140
>>>> [  410.352054] lr : blk_cleanup_queue+0xac/0x140
>>>> [  410.352436] sp : ffff0000092cbb90
>>>> [  410.352727] x29: ffff0000092cbb90 x28: 0000000000000000
>>>> [  410.353195] x27: ffff8000f6f23030 x26: ffff00000904e610
>>>> [  410.353662] x25: ffff8000f17cc808 x24: ffff8000f1038200
>>>> [  410.354128] x23: 0000000000000060 x22: 0000000000000000
>>>> [  410.354595] x21: ffff8000f11748d8 x20: ffff8000f1038200
>>>> [  410.355061] x19: ffff8000f1174200 x18: 0000ffff936347d8
>>>> [  410.355528] x17: 0000ffff935b93c0 x16: ffff0000081263f8
>>>> [  410.355994] x15: 0000000000000000 x14: 0000000000000400
>>>> [  410.356461] x13: 0000000000000001 x12: 0000000000000001
>>>> [  410.356927] x11: 0000000000000040 x10: ffff8000f2400028
>>>> [  410.357393] x9 : ffff8000f2400040 x8 : 0000000000000000
>>>> [  410.357860] x7 : ffff8000f6f3a340 x6 : ffff8000f6f3a340
>>>> [  410.358326] x5 : ffff8000f2400000 x4 : ffff8000f6f3a340
>>>> [  410.358792] x3 : 0000000000000000 x2 : 39c1333e45670800
>>>> [  410.359259] x1 : 0000000000000000 x0 : 0000000000000003
>>>> [  410.359726] Call trace:
>>>> [  410.359943]  blk_cleanup_queue+0x138/0x140
>>>> [  410.360305]  mmc_cleanup_queue+0x2c/0x48
>>>> [  410.360652]  mmc_blk_remove_req+0x1c/0x98
>>>> [  410.361005]  mmc_blk_remove+0x180/0x1c0
>>>> [  410.361343]  mmc_bus_remove+0x1c/0x28
>>>> [  410.361670]  device_release_driver_internal+0x154/0x1f0
>>>> [  410.362128]  device_release_driver+0x14/0x20
>>>> [  410.362504]  bus_remove_device+0xc8/0x108
>>>> [  410.362858]  device_del+0x120/0x350
>>>> [  410.363167]  mmc_remove_card+0x5c/0xb8
>>>> [  410.363498]  mmc_sd_detect+0x40/0x78
>>>> [  410.363813]  mmc_rescan+0x19c/0x368
>>>> [  410.364123]  process_one_work+0x1ac/0x318
>>>> [  410.364477]  worker_thread+0x50/0x450
>>>> [  410.364801]  kthread+0xf8/0x128
>>>> [  410.365081]  ret_from_fork+0x10/0x18
>>>> [  410.365395] ---[ end trace 268e87a46c28968c ]---
>>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>> ---
>>>>
>>>>   drivers/mmc/core/block.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>>> index a2b9c25..02485e3 100644
>>>> --- a/drivers/mmc/core/block.c
>>>> +++ b/drivers/mmc/core/block.c
>>>> @@ -2659,7 +2659,6 @@ static void mmc_blk_remove_req(struct mmc_blk_data
>>>> *md)
>>>>            * from being accepted.
>>>>            */
>>>>           card = md->queue.card;
>>>> -        mmc_cleanup_queue(&md->queue);
>>>>           if (md->disk->flags & GENHD_FL_UP) {
>>>>               device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>>>>               if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
>>>> @@ -2669,6 +2668,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data
>>>> *md)
>>>>                 del_gendisk(md->disk);
>>>>           }
>>>> +        mmc_cleanup_queue(&md->queue);
>>>>           mmc_blk_put(md);
>>>>       }
>>>>   }
>>>>
>>>
>>>
>>>
>>>
>>
>>
>
