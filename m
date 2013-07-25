From: Franck Jullien <franck.jullien@gmail.com>
Subject: Re: [PATCH] mmc: fix null pointer use in mmc_blk_remove_req
Date: Thu, 25 Jul 2013 09:20:17 +0200
Message-ID: <CAJfOKBwVJA61pH+1quRFLYswkSjy7doVj8brvG9tBDCJOAYR5A@mail.gmail.com>
References: <1374671868-606-1-git-send-email-franck.jullien@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:47335 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3GYHUS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2013 03:20:18 -0400
Received: by mail-we0-f170.google.com with SMTP id w60so299935wes.15
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2013 00:20:17 -0700 (PDT)
In-Reply-To: <1374671868-606-1-git-send-email-franck.jullien@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: taysom@chromium.org

2013/7/24  <franck.jullien@gmail.com>:
> From: Franck Jullien <franck.jullien@gmail.com>
>
> A previous commit (fdfa20c1631210d0) reordered the
> shutdown sequence in mmc_blk_remove_req. However,
> mmc_cleanup_queue is now called before we get the
> card pointer and, sadly, mmc_cleanup_queue set
> mq->card to NULL.
>
> This patch moves the card pointer assignment before
> mmc_cleanup_queue.
>
> Signed-off-by: Franck Jullien <franck.jullien@gmail.com>
> ---
>  drivers/mmc/card/block.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index cd0b7f4..f4a0bea 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2191,10 +2191,10 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>                  * is freeing the queue that stops new requests
>                  * from being accepted.
>                  */
> +               card = md->queue.card;
>                 mmc_cleanup_queue(&md->queue);
>                 if (md->flags & MMC_BLK_PACKED_CMD)
>                         mmc_packed_clean(&md->queue);
> -               card = md->queue.card;
>                 if (md->disk->flags & GENHD_FL_UP) {
>                         device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>                         if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
> --
> 1.7.1
>

This is how I got this (mmc_test is unusable right now):

/ # echo mmc0:0001 > /sys/bus/mmc/drivers/mmcblk/unbind

Unable to handle kernel paging request for data at address 0x000001f0
Faulting instruction address: 0xc0316bf4
Oops: Kernel access of bad area, sig: 11 [#1]
P1020 RDB
Modules linked in:
CPU: 0 PID: 1237 Comm: echo Not tainted 3.10.0-next-20130709-dirty #12
task: ef3489c0 ti: ef2e0000 task.ti: ef2e0000
NIP: c0316bf4 LR: c0316be8 CTR: 00000000
REGS: ef2e1d70 TRAP: 0300   Not tainted  (3.10.0-next-20130709-dirty)
MSR: 00029000 <CE,EE,ME>  CR: 42004042  XER: 20000000
DEAR: 000001f0, ESR: 00000000

GPR00: c0316be8 ef2e1e20 ef3489c0 00000000 ef2de9b0 c05612e4 00000000 00000000
GPR08: ef3728d0 00000002 00000002 00000000 00001aee 10174934 00000000 00000000
GPR16: 00000000 00000000 10133928 1015718e bfe9c268 1017221c 00000000 00000001
GPR24: 00000001 c0476384 ef2e1f18 ef2b6060 00100100 00200200 00000000 ef2f1800
NIP [c0316bf4] mmc_blk_remove_req+0x90/0xbc
LR [c0316be8] mmc_blk_remove_req+0x84/0xbc
Call Trace:
[ef2e1e20] [c0316be8] mmc_blk_remove_req+0x84/0xbc (unreliable)
[ef2e1e30] [c03183c8] mmc_blk_remove_parts.isra.22+0x88/0xac
[ef2e1e50] [c0318414] mmc_blk_remove+0x28/0xc8
[ef2e1e70] [c030b5b4] mmc_bus_remove+0x20/0x34
[ef2e1e80] [c024c5ac] __device_release_driver+0x68/0x114
[ef2e1e90] [c024c680] device_release_driver+0x28/0x40
[ef2e1ea0] [c024b370] driver_unbind+0x64/0xd0
[ef2e1ec0] [c0120010] sysfs_write_file+0xfc/0x190
[ef2e1ef0] [c00c82fc] vfs_write+0xc8/0x1b0
[ef2e1f10] [c00c876c] SyS_write+0x4c/0xac
[ef2e1f40] [c000d318] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0x100bd3e8
    LR = 0x1008a4d8
Instruction dump:
48003c81 807f0000 83df0004 812301ac 712a0010 4182ffd0 38630068 389f027c
4bf31e79 813f029c 712a0002 41a2ffb8 <893e01f0> 2f890000 419effac 807f0000
---[ end trace 2908d8b93b8cdd75 ]---

Segmentation fault

Franck.
