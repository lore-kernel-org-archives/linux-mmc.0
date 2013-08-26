From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 3/3] mmc: card: fix the remove of blk on suspend
Date: Mon, 26 Aug 2013 15:47:05 +0900
Message-ID: <002801cea228$1400ee80$3c02cb80$%jun@samsung.com>
References: <002401ce9e6b$ea967020$bfc35060$%jun@samsung.com>
 <CAPDyKFojXeBB=m+bWK_PuOfdG1vhte1uqdhLti0gYxUMonz4tQ@mail.gmail.com>
 <52176E08.5060706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27804 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935Ab3HZGrI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Aug 2013 02:47:08 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MS4004AGLIFRZP0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Aug 2013 15:47:06 +0900 (KST)
In-reply-to: <52176E08.5060706@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Alban Browaeys' <prahal@yahoo.com>

On Friday, August 23 2013, Jaehoon Chung wrote:
> On 08/23/2013 06:23 PM, Ulf Hansson wrote:
> > On 21 August 2013 14:42, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> From 029a839ddf6f13a1e1a8bf4d4bc32b67712593ec Mon Sep 17 00:00:00 2001
> >> From: Seungwon Jeon <tgih.jun@samsung.com>
> >> Date: Wed, 21 Aug 2013 17:30:02 +0900
> >> Subject: [PATCH 3/3] mmc: fix the remove of blk on suspend
> >>
> >> As mmc_cleanup_queue() is moved, NULL pointer access to card of
> >> mmc_queue is happened since commit fdfa20c1(mmc: reordered shutdown
> >> sequence mmc_bld_remove_req).
> >>
> >> Here, mmc_cleanup_queue is split into two parts.
> >> One is to quit the mmc_queue and two is to clean up the resource
> >> of mmc_queue.
> >>
> >> The following is log message related to the problem.
> >>
> >> Unable to handle kernel NULL pointer dereference at virtual address 000002a8
> >> pgd = ecd9c000
> >> [000002a8] *pgd=6d082831, *pte=00000000, *ppte=00000000
> >> Internal error: Oops: 17 [#1] SMP ARM
> >> Modules linked in: bnep rfcomm smsc95xx usbnet mii bluetooth nfsd lockd nfs_acl exportfs
> auth_rpcgss sunrpc oid_registry vfat fat btrfs raid6_pq xor zlib_deflate
> >> CPU: 3 PID: 2384 Comm: bash Not tainted 3.11.0-rc4-00869-ga7143f1-dirty #60
> >> task: c46d9b00 ti: ecefc000 task.ti: ecefc000
> >> PC is at mmc_blk_remove_req+0x58/0x88
> >> LR is at _raw_spin_unlock_irqrestore+0xc/0x14
> >> pc : [<c034e7d8>]    lr : [<c0494ac8>]    psr: 200f0053
> >> sp : ecefddf8  ip : 00000000  fp : 000dc1e8
> >> r10: c058ead8  r9 : ecce3f18  r8 : 00100100
> >> r7 : 00200200  r6 : c26b7118  r5 : 00000000  r4 : c26b1dc0
> >> r3 : 00000002  r2 : 00000000  r1 : 200f0053  r0 : 00000000
> >> Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment user
> >> Control: 10c5387d  Table: 6cd9c04a  DAC: 00000015
> >> Process bash (pid: 2384, stack limit = 0xecefc240)
> >> Stack: (0xecefddf8 to 0xecefe000)
> >> <...>
> >> [<c034e7d8>] (mmc_blk_remove_req+0x58/0x88) from [<c03512d0>]
> >> (mmc_blk_remove_parts.isra.5+0x90/0xa8)
> >> [<c03512d0>] (mmc_blk_remove_parts.isra.5+0x90/0xa8) from
> >> [<c0351308>] (mmc_blk_remove+0x20/0x128)
> >> [<c0351308>] (mmc_blk_remove+0x20/0x128) from [<c034409c>] (mmc_bus_remove+0x18/0x20)
> >> [<c034409c>] (mmc_bus_remove+0x18/0x20) from [<c0265a20>] (__device_release_driver+0x7c/0xc8)
> >> [<c0265a20>] (__device_release_driver+0x7c/0xc8) from [<c0265a88>] (device_release_driver+0x1c/0x28)
> >> [<c0265a88>] (device_release_driver+0x1c/0x28) from [<c0265410>] (bus_remove_device+0x100/0x11c)
> >> [<c0265410>] (bus_remove_device+0x100/0x11c) from [<c0262c04>] (device_del+0x110/0x174)
> >> [<c0262c04>] (device_del+0x110/0x174) from [<c034463c>] (mmc_remove_card+0x64/0x78)
> >> [<c034463c>] (mmc_remove_card+0x64/0x78) from [<c0345124>] (mmc_remove+0x24/0x30)
> >> [<c0345124>] (mmc_remove+0x24/0x30) from [<c0343fb0>] (mmc_pm_notify+0x94/0xf8)
> >> [<c0343fb0>] (mmc_pm_notify+0x94/0xf8) from [<c00413b4>] (notifier_call_chain+0x44/0x84)
> >> [<c00413b4>] (notifier_call_chain+0x44/0x84) from [<c00417b4>]
> (__blocking_notifier_call_chain+0x48/0x60)
> >> [<c00417b4>] (__blocking_notifier_call_chain+0x48/0x60) from [<c00417e4>]
> (blocking_notifier_call_chain+0x18/0x20)
> >> [<c00417e4>] (blocking_notifier_call_chain+0x18/0x20) from [<c0059d48>]
> (pm_notifier_call_chain+0x14/0x2c)
> >> [<c0059d48>] (pm_notifier_call_chain+0x14/0x2c) from [<c005aa9c>] (pm_suspend+0xac/0x24c)
> >> [<c005aa9c>] (pm_suspend+0xac/0x24c) from [<c0059a68>] (state_store+0xb0/0xc4)
> >> [<c0059a68>] (state_store+0xb0/0xc4) from [<c01d610c>] (kobj_attr_store+0x14/0x20)
> >> [<c01d610c>] (kobj_attr_store+0x14/0x20) from [<c012b224>] (sysfs_write_file+0x118/0x164)
> >> [<c012b224>] (sysfs_write_file+0x118/0x164) from [<c00d59d4>] (vfs_write+0xd8/0x178)
> >> [<c00d59d4>] (vfs_write+0xd8/0x178) from [<c00d5d3c>] (SyS_write+0x40/0x68)
> >> [<c00d5d3c>] (SyS_write+0x40/0x68) from [<c000ea20>] (ret_fast_syscall+0x0/0x30)
> >> Code: ebfc509b e59432dc e3130002 0a000006 (e5d532a8)
> >>
> >> Reported-by: Alban Browaeys <prahal@yahoo.com>
> >> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Best Regards,
> Jaehoon Chung

Ulf and Jaehoon, 
Thank you for acks.

But it could be replaced with [PATCH] mmc: fix null pointer use in mmc_blk_remove_req.
We would have found that. It has been merged.

Thanks,
Seungwon Jeon

> >
> >> ---
> >>  drivers/mmc/card/block.c |    9 ++++++---
> >>  drivers/mmc/card/queue.c |   11 ++++++++---
> >>  drivers/mmc/card/queue.h |    1 +
> >>  3 files changed, 15 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> >> index cd0b7f4..1e6726d 100644
> >> --- a/drivers/mmc/card/block.c
> >> +++ b/drivers/mmc/card/block.c
> >> @@ -2191,9 +2191,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
> >>                  * is freeing the queue that stops new requests
> >>                  * from being accepted.
> >>                  */
> >> -               mmc_cleanup_queue(&md->queue);
> >> -               if (md->flags & MMC_BLK_PACKED_CMD)
> >> -                       mmc_packed_clean(&md->queue);
> >> +               mmc_quit_queue(&md->queue);
> >>                 card = md->queue.card;
> >>                 if (md->disk->flags & GENHD_FL_UP) {
> >>                         device_remove_file(disk_to_dev(md->disk), &md->force_ro);
> >> @@ -2204,6 +2202,11 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
> >>
> >>                         del_gendisk(md->disk);
> >>                 }
> >> +
> >> +               mmc_cleanup_queue(&md->queue);
> >> +               if (md->flags & MMC_BLK_PACKED_CMD)
> >> +                       mmc_packed_clean(&md->queue);
> >> +
> >>                 mmc_blk_put(md);
> >>         }
> >>  }
> >> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> >> index fa9632e..82e5550 100644
> >> --- a/drivers/mmc/card/queue.c
> >> +++ b/drivers/mmc/card/queue.c
> >> @@ -318,12 +318,10 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
> >>         return ret;
> >>  }
> >>
> >> -void mmc_cleanup_queue(struct mmc_queue *mq)
> >> +void mmc_quit_queue(struct mmc_queue *mq)
> >>  {
> >>         struct request_queue *q = mq->queue;
> >>         unsigned long flags;
> >> -       struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
> >> -       struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
> >>
> >>         /* Make sure the queue isn't suspended, as that will deadlock */
> >>         mmc_queue_resume(mq);
> >> @@ -336,6 +334,13 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
> >>         q->queuedata = NULL;
> >>         blk_start_queue(q);
> >>         spin_unlock_irqrestore(q->queue_lock, flags);
> >> +}
> >> +EXPORT_SYMBOL(mmc_quit_queue);
> >> +
> >> +void mmc_cleanup_queue(struct mmc_queue *mq)
> >> +{
> >> +       struct mmc_queue_req *mqrq_cur = mq->mqrq_cur;
> >> +       struct mmc_queue_req *mqrq_prev = mq->mqrq_prev;
> >>
> >>         kfree(mqrq_cur->bounce_sg);
> >>         mqrq_cur->bounce_sg = NULL;
> >> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> >> index 5752d50..a3d89a2 100644
> >> --- a/drivers/mmc/card/queue.h
> >> +++ b/drivers/mmc/card/queue.h
> >> @@ -61,6 +61,7 @@ struct mmc_queue {
> >>
> >>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
> >>                           const char *);
> >> +extern void mmc_quit_queue(struct mmc_queue *);
> >>  extern void mmc_cleanup_queue(struct mmc_queue *);
> >>  extern void mmc_queue_suspend(struct mmc_queue *);
> >>  extern void mmc_queue_resume(struct mmc_queue *);
> >> --
> >> 1.7.0.4
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

