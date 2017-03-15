From: Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 0/7] mmc: bcm2835: Add new driver for the sdhost controller
Date: Wed, 15 Mar 2017 10:06:18 +0000
Message-ID: <CALeDE9MVJvKxdKO3tTMfmM0fhNY14feE5GxgtgkjxC+zLWRMZA@mail.gmail.com>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
 <CALeDE9Oaqe_7spH9r5-Bth9AvrwviFsZ4woEyE_Zyrws0jM9Dw@mail.gmail.com> <1489566118.15659.27.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36273 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbdCOKGU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 06:06:20 -0400
In-Reply-To: <1489566118.15659.27.camel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, f.fainelli@gmail.com, sbranden@broadcom.com, rjui@broadcom.com, lee@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com, catalin.marinas@arm.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Mar 15, 2017 at 8:21 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> First the flipping of the mmc host driver for the SD card slot will
>> cause issues for users that build it as a module. When I tested this
>> on Fedora the first update I ended up with a system that didn't boot.
>
> Yep, switching drivers is a pain point here indeed.
>
> Possibly we could fix that by adding a MODULE_SOFTDEP() to the iproc
> driver?  Comments?  Better ideas?
>
>> Also i often see the device hang for a long period when systemd probes
>> for rfkill status, sometimes it needs to be reset but it generally
>> gets there.
>
> What device is that?  rpi3 with wifi?

Yes, RPi3, with the brcmfmac43430-sdio.txt added so the firmware
loads, interface works.

>> [    6.529079] Hardware name: Generic DT based system
>> [    6.529106] [<c0311708>] (unwind_backtrace) from [<c030c438>]
>> (show_stack+0x18/0x1c)
>> [    6.529122] [<c030c438>] (show_stack) from [<c0639b44>]
>> (dump_stack+0x80/0xa0)
>> [    6.529137] [<c0639b44>] (dump_stack) from [<c034ca3c>] (__warn+0xe4/0x104)
>> [    6.529150] [<c034ca3c>] (__warn) from [<c034ca98>]
>> (warn_slowpath_fmt+0x3c/0x4c)
>> [    6.529166] [<c034ca98>] (warn_slowpath_fmt) from [<c0363b2c>]
>> (check_flush_dependency+0xac/0x134)
>> [    6.529184] [<c0363b2c>] (check_flush_dependency) from [<c036433c>]
>> (flush_work+0xa0/0x178)
>> [    6.529201] [<c036433c>] (flush_work) from [<c0458084>]
>> (drain_all_pages+0x1a8/0x1cc)
>> [    6.529221] [<c0458084>] (drain_all_pages) from [<c04b1d90>]
>> (start_isolate_page_range+0x168/0x1b4)
>> [    6.529239] [<c04b1d90>] (start_isolate_page_range) from
>> [<c045b854>] (alloc_contig_range+0xd4/0x314)
>> [    6.529258] [<c045b854>] (alloc_contig_range) from [<c04b6660>]
>> (cma_alloc+0x188/0x300)
>> [    6.529275] [<c04b6660>] (cma_alloc) from [<c03161e8>]
>> (__alloc_from_contiguous+0x40/0xd8)
>> [    6.529290] [<c03161e8>] (__alloc_from_contiguous) from
>> [<c03162bc>] (cma_allocator_alloc+0x3c/0x44)
>> [    6.529303] [<c03162bc>] (cma_allocator_alloc) from [<c0316504>]
>> (__dma_alloc+0x1d4/0x2f0)
>> [    6.529317] [<c0316504>] (__dma_alloc) from [<c0316698>]
>> (arm_dma_alloc+0x3c/0x48)
>> [    6.529331] [<c0316698>] (arm_dma_alloc) from [<c049d120>]
>> (dma_pool_alloc+0x124/0x240)
>> [    6.529356] [<c049d120>] (dma_pool_alloc) from [<bf009568>]
>> (bcm2835_dma_create_cb_chain+0xb0/0x1dc [bcm2835_dma])
>> [    6.529385] [<bf009568>] (bcm2835_dma_create_cb_chain
>> [bcm2835_dma]) from [<bf009ad4>] (bcm2835_dma_prep_slave_sg+0xf0/0x25c
>> [bcm2835_dma])
>> [    6.529418] [<bf009ad4>] (bcm2835_dma_prep_slave_sg [bcm2835_dma])
>> from [<bf04af04>] (bcm2835_request+0x2a4/0x3f4 [bcm2835])
>> [    6.529548] [<bf04af04>] (bcm2835_request [bcm2835]) from
>> [<bf0145d0>] (mmc_start_request+0x1f8/0x264 [mmc_core])
>> [    6.529756] [<bf0145d0>] (mmc_start_request [mmc_core]) from
>> [<bf016204>] (mmc_start_areq+0x2c8/0x318 [mmc_core])
>> [    6.529890] [<bf016204>] (mmc_start_areq [mmc_core]) from
>> [<bf07fa1c>] (mmc_blk_issue_rw_rq+0xc0/0x308 [mmc_block])
>> [    6.529943] [<bf07fa1c>] (mmc_blk_issue_rw_rq [mmc_block]) from
>> [<bf080f84>] (mmc_blk_issue_rq+0x418/0x428 [mmc_block])
>> [    6.529997] [<bf080f84>] (mmc_blk_issue_rq [mmc_block]) from
>> [<bf081138>] (mmc_queue_thread+0x148/0x1bc [mmc_block])
>> [    6.530031] [<bf081138>] (mmc_queue_thread [mmc_block]) from
>> [<c036ae30>] (kthread+0x120/0x138)
>> [    6.530049] [<c036ae30>] (kthread) from [<c0307e58>]
>> (ret_from_fork+0x14/0x3c)
>> [    6.530055] ---[ end trace 221a5a14ca55fa22 ]---
>> [    6.545765]  mmcblk0: p1 p2 p3 p4
>> [    6.566015] random: fast init done
>> [    6.623699] mmc1: new high speed SDIO card at address 0001
>
> Looks more like a cma allocator issue on a quick glance.

Possibly, but only started once I added the dma drive into the initrd
and happens right when the MMC driver loads, we're not even past
switch root which is long before loading the vc4 driver which is the
main cma consumer.
