From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: bypass the queue even if usage is present for hotplug
Date: Thu, 3 Aug 2017 12:51:20 +0200
Message-ID: <CAPDyKFqFCbRHSKQ2A2_SgvYFLUuv0yaCMsT1Evod2iyDnmsmXw@mail.gmail.com>
References: <1500945088-202242-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1500945088-202242-1-git-send-email-shawn.lin@rock-chips.com>
Sender: stable-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Grzegorz Sluja <grzegorzx.sluja@intel.com>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 25 July 2017 at 03:11, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> commit 304419d8a7e ("mmc: core: Allocate per-request data using
> the block layer core") refactored mechanism of queue handling
> caused mmc_init_request() can be called just after mmc_cleanup_queue()
> caused null pointer dereference.
>
> commit bbdc74dc19e09a ("mmc: block: Prevent new req entering queue
> after its cleanup")tried to fix the problem. However it actually miss
> one corner case.
>
> We could still reproduce the issue mentioned with these steps:
> (1) insert a SD card and mount it
> (2) hotplug it, so it will leave md->usage still be counted
> (3) reboot the system which will sync data and umount the card
>
> [Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> [user pgtable: 4k pages, 48-bit VAs, pgd = ffff80007bab3000
> [[0000000000000000] *pgd=000000007a828003, *pud=0000000078dce003,
> *pmd=000000007aab6003, *pte=0000000000000000
> [Internal error: Oops: 96000007 [#1] PREEMPT SMP
> [Modules linked in:
> [CPU: 3 PID: 3507 Comm: umount Tainted: G        W
> 4.13.0-rc1-next-20170720-00012-g9d9bf45 #33
> [Hardware name: Firefly-RK3399 Board (DT)
> [task: ffff80007a1de200 task.stack: ffff80007a01c000
> [PC is at mmc_init_request+0x14/0xc4
> [LR is at alloc_request_size+0x4c/0x74
> [pc : [<ffff0000087d7150>] lr : [<ffff000008378fe0>] pstate: 600001c5
> [sp : ffff80007a01f8f0
>
> ....
>
> [[<ffff0000087d7150>] mmc_init_request+0x14/0xc4
> [[<ffff000008378fe0>] alloc_request_size+0x4c/0x74
> [[<ffff00000817ac28>] mempool_create_node+0xb8/0x17c
> [[<ffff00000837aadc>] blk_init_rl+0x9c/0x120
> [[<ffff000008396580>] blkg_alloc+0x110/0x234
> [[<ffff000008396ac8>] blkg_create+0x424/0x468
> [[<ffff00000839877c>] blkg_lookup_create+0xd8/0x14c
> [[<ffff0000083796bc>] generic_make_request_checks+0x368/0x3b0
> [[<ffff00000837b050>] generic_make_request+0x1c/0x240
>
> So mmc_blk_put wouldn't calling blk_cleanup_queue which actually
> the QUEUE_FLAG_DYING and QUEUE_FLAG_BYPASS should stay. Block core
> expect blk_queue_bypass_{start, end} internally to bypass/drain the
> queue before actually dying the queue, so it didn't expose API to
> set the queue bypass. I think we should set QUEUE_FLAG_BYPASS whenever
> queue is removed, although the md->usage is still counted, as no dispatch
> queue could be found then.
>
> commit 304419d8a7e9 ("mmc: core: Allocate per-request data using the block layer core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for fixes!

I looked over the commit hashes and make sure those all were caped at
12 digits, and also removed the stable tag, as 304419d8a7e9 is only in
4.13 rcs.

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 40f0d59..a11bead 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2168,6 +2168,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>                  * from being accepted.
>                  */
>                 card = md->queue.card;
> +               queue_flag_set(QUEUE_FLAG_BYPASS, md->queue.queue);
>                 blk_set_queue_dying(md->queue.queue);
>                 mmc_cleanup_queue(&md->queue);
>                 if (md->disk->flags & GENHD_FL_UP) {
> --
> 1.9.1
>
>
