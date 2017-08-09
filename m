From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc/block: fix lockdep splat when removing mmc_block module
Date: Wed, 9 Aug 2017 13:26:47 +0200
Message-ID: <CAPDyKFr+amVc=iwyDJ_ynSxeZ9gF4nO+Xo3Ra2mNXrC=bP7y6w@mail.gmail.com>
References: <c684886f6f54531687e375fd81c36886f4013b41.1502235933.git.mirq-linux@rere.qmqm.pl>
 <c03b9028-d587-e007-a21d-bf1609ac9a85@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:37787 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbdHIL0s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2017 07:26:48 -0400
Received: by mail-qt0-f174.google.com with SMTP id 16so34360017qtz.4
        for <linux-mmc@vger.kernel.org>; Wed, 09 Aug 2017 04:26:48 -0700 (PDT)
In-Reply-To: <c03b9028-d587-e007-a21d-bf1609ac9a85@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 9 August 2017 at 03:29, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi
>
> On 2017/8/9 7:48, Micha=C5=82 Miros=C5=82aw wrote:
>>
>> Fix lockdep splat introduced in v4.13-rc4.
>>
>> [  266.297226] ------------[ cut here ]------------
>> [  266.300078] WARNING: CPU: 2 PID: 176 at
>> /mnt/src/jaja/git/tf300t/include/linux/blkdev.h:657
>> mmc_blk_remove_req+0xd0/0xe8 [mmc_block]
>> [  266.302937] Modules linked in: mmc_block(-) sdhci_tegra sdhci_pltfm
>> sdhci pwrseq_simple pwrseq_emmc mmc_core
>> [  266.305941] CPU: 2 PID: 176 Comm: rmmod Tainted: G        W
>> 4.13.0-rc4mq-00208-gb691e67724b8-dirty #694
>> [  266.308852] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>> [  266.311719] [<b011144c>] (unwind_backtrace) from [<b010ca54>]
>> (show_stack+0x18/0x1c)
>> [  266.314664] [<b010ca54>] (show_stack) from [<b062e3f4>]
>> (dump_stack+0x84/0x98)
>> [  266.317644] [<b062e3f4>] (dump_stack) from [<b01214f4>]
>> (__warn+0xf4/0x10c)
>> [  266.320542] [<b01214f4>] (__warn) from [<b01215d4>]
>> (warn_slowpath_null+0x28/0x30)
>> [  266.323534] [<b01215d4>] (warn_slowpath_null) from [<af067858>]
>> (mmc_blk_remove_req+0xd0/0xe8 [mmc_block])
>> [  266.326568] [<af067858>] (mmc_blk_remove_req [mmc_block]) from
>> [<af068f40>] (mmc_blk_remove_parts.constprop.6+0x50/0x64 [mmc_block])
>> [  266.329678] [<af068f40>] (mmc_blk_remove_parts.constprop.6 [mmc_block=
])
>> from [<af0693b8>] (mmc_blk_remove+0x24/0x140 [mmc_block])
>> [  266.332894] [<af0693b8>] (mmc_blk_remove [mmc_block]) from [<af0052ec=
>]
>> (mmc_bus_remove+0x20/0x28 [mmc_core])
>> [  266.336198] [<af0052ec>] (mmc_bus_remove [mmc_core]) from [<b046aa64>=
]
>> (device_release_driver_internal+0x164/0x200)
>> [  266.339367] [<b046aa64>] (device_release_driver_internal) from
>> [<b046ab54>] (driver_detach+0x40/0x74)
>> [  266.342537] [<b046ab54>] (driver_detach) from [<b046982c>]
>> (bus_remove_driver+0x68/0xdc)
>> [  266.345660] [<b046982c>] (bus_remove_driver) from [<af06ad40>]
>> (mmc_blk_exit+0xc/0x2cc [mmc_block])
>> [  266.348875] [<af06ad40>] (mmc_blk_exit [mmc_block]) from [<b01aee30>]
>> (SyS_delete_module+0x1c4/0x254)
>> [  266.352068] [<b01aee30>] (SyS_delete_module) from [<b0108480>]
>> (ret_fast_syscall+0x0/0x34)
>> [  266.355308] ---[ end trace f68728a0d3053b72 ]---
>>
>
>
> Ouch... 7c84b8b43d3d *also* races the q->bypass_depth with blk layer, so
> in principle, QUEUE_FLAG_BYPASS shouldn't be used outside the blk layer.
> However we have to use it when we couldn't do these within
> blk_cleanup_queue..

As quick fix, this will have to do.

However, to me this clearly shows that we need to continue the
re-factorization and convert to blkmq asap. While doing that, we must
also make sure to smoke out all the odd things that goes on in the
current mmc block/queue code related to hotplug.

>
> My current system couldn't boot with a modular mmc-blk, so i can't test
> this case but obvious the race and lockdep case is here. Great to find
> this fatal mistake, mea culpa.
>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>
>
>
>> Fixes: 7c84b8b43d3d ("mmc: block: bypass the queue even if usage is
>> present for hotplug")
>> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Applied for fixes!

Thanks both of you for looking into this and fixing the problem!

Kind regards
Uffe

>> ---
>>   drivers/mmc/core/block.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index e5938c791330..f1bbfd389367 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -2170,7 +2170,9 @@ static void mmc_blk_remove_req(struct mmc_blk_data
>> *md)
>>                  * from being accepted.
>>                  */
>>                 card =3D md->queue.card;
>> +               spin_lock_irq(md->queue.queue->queue_lock);
>>                 queue_flag_set(QUEUE_FLAG_BYPASS, md->queue.queue);
>> +               spin_unlock_irq(md->queue.queue->queue_lock);
>>                 blk_set_queue_dying(md->queue.queue);
>>                 mmc_cleanup_queue(&md->queue);
>>                 if (md->disk->flags & GENHD_FL_UP) {
>>
>
