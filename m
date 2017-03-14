From: Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 0/7] mmc: bcm2835: Add new driver for the sdhost controller
Date: Tue, 14 Mar 2017 14:22:19 +0000
Message-ID: <CALeDE9Oaqe_7spH9r5-Bth9AvrwviFsZ4woEyE_Zyrws0jM9Dw@mail.gmail.com>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-rpi-kernel@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, f.fainelli@gmail.com, sbranden@broadcom.com, rjui@broadcom.com, lee@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com, catalin.marinas@arm.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Gerd,

> Next version if the bcm2835 sdhost patch series.
>
> New in v3:
>  * squashed in cleanups by Stefan.
>  * use one dma channel only.
>  * improve commit messages.
>
> New in v2:
>  * DMA fixed.
>  * updated docs (kconfig, file comment, commit message) clarifying
>    the two sd controller situation.
>  * some code cleanups, as pointed out by Stefan.
>  * dt bindings use mmc@... now.
>  * added patches to update defconfigs.
>  * added patch for rpi3 device tree, so wifi is actually enabled.
>
> please review & test,
>   Gerd
>
> Eric Anholt (2):
>   dt-bindings: Add binding for brcm,bcm2835-sdhost.
>   mmc: bcm2835: Add new driver for the sdhost controller.
>
> Gerd Hoffmann (5):
>   mmc: bcm2835: add sdhost controller to devicetree
>   arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig and
>     multi_v7_defconfig
>   arm64: set CONFIG_MMC_BCM2835=y in defconfig
>   ARM: dts: bcm283x: switch from &sdhci to &sdhost
>   ARM: dts: bcm2837: add &sdhci and &sdhost

I know there's a v4, which is the one I tested, but I don't see it on
the rpi list. A few things I've found.

First the flipping of the mmc host driver for the SD card slot will
cause issues for users that build it as a module. When I tested this
on Fedora the first update I ended up with a system that didn't boot.
I'm handling in Fedora with a dracut snippet which will pull both in
both until that settles down.

Also i often see the device hang for a long period when systemd probes
for rfkill status, sometimes it needs to be reset but it generally
gets there.

Finally also seeing the following crash with the patches on 4.11rc2

[    6.337148] sdhci: Secure Digital Host Controller Interface driver
[    6.349263] sdhci: Copyright(c) Pierre Ossman
[    6.362401] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.381331] sdhost-bcm2835 3f202000.mmc: loaded - DMA enabled (>1)
[    6.412548] mmc1: SDHCI controller on 3f300000.sdhci
[3f300000.sdhci] using PIO
[    6.445766] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    6.460651] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    6.473431] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    6.487820] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    6.509590] mmc0: host does not support reading read-only switch,
assuming write-enable
[    6.511929] mmc0: new high speed SDHC card at address aaaa
[    6.527859] mmcblk0: mmc0:aaaa SL16G 14.8 GiB
[    6.528991] ------------[ cut here ]------------
[    6.529018] WARNING: CPU: 2 PID: 326 at kernel/workqueue.c:2417
check_flush_dependency+0xac/0x134
[    6.529033] workqueue: PF_MEMALLOC task 326(mmcqd/0) is flushing
!WQ_MEM_RECLAIM events:drain_local_pages_wq
[    6.529036] Modules linked in: mmc_block(+) sdhci_iproc sdhci_pltfm
sdhci pwm_bcm2835 bcm2835 i2c_bcm2835 mmc_core bcm2835_dma i2c_dev
[    6.529075] CPU: 2 PID: 326 Comm: mmcqd/0 Not tainted
4.11.0-0.rc2.git0.1.fc26.armv7hl #1
[    6.529079] Hardware name: Generic DT based system
[    6.529106] [<c0311708>] (unwind_backtrace) from [<c030c438>]
(show_stack+0x18/0x1c)
[    6.529122] [<c030c438>] (show_stack) from [<c0639b44>]
(dump_stack+0x80/0xa0)
[    6.529137] [<c0639b44>] (dump_stack) from [<c034ca3c>] (__warn+0xe4/0x104)
[    6.529150] [<c034ca3c>] (__warn) from [<c034ca98>]
(warn_slowpath_fmt+0x3c/0x4c)
[    6.529166] [<c034ca98>] (warn_slowpath_fmt) from [<c0363b2c>]
(check_flush_dependency+0xac/0x134)
[    6.529184] [<c0363b2c>] (check_flush_dependency) from [<c036433c>]
(flush_work+0xa0/0x178)
[    6.529201] [<c036433c>] (flush_work) from [<c0458084>]
(drain_all_pages+0x1a8/0x1cc)
[    6.529221] [<c0458084>] (drain_all_pages) from [<c04b1d90>]
(start_isolate_page_range+0x168/0x1b4)
[    6.529239] [<c04b1d90>] (start_isolate_page_range) from
[<c045b854>] (alloc_contig_range+0xd4/0x314)
[    6.529258] [<c045b854>] (alloc_contig_range) from [<c04b6660>]
(cma_alloc+0x188/0x300)
[    6.529275] [<c04b6660>] (cma_alloc) from [<c03161e8>]
(__alloc_from_contiguous+0x40/0xd8)
[    6.529290] [<c03161e8>] (__alloc_from_contiguous) from
[<c03162bc>] (cma_allocator_alloc+0x3c/0x44)
[    6.529303] [<c03162bc>] (cma_allocator_alloc) from [<c0316504>]
(__dma_alloc+0x1d4/0x2f0)
[    6.529317] [<c0316504>] (__dma_alloc) from [<c0316698>]
(arm_dma_alloc+0x3c/0x48)
[    6.529331] [<c0316698>] (arm_dma_alloc) from [<c049d120>]
(dma_pool_alloc+0x124/0x240)
[    6.529356] [<c049d120>] (dma_pool_alloc) from [<bf009568>]
(bcm2835_dma_create_cb_chain+0xb0/0x1dc [bcm2835_dma])
[    6.529385] [<bf009568>] (bcm2835_dma_create_cb_chain
[bcm2835_dma]) from [<bf009ad4>] (bcm2835_dma_prep_slave_sg+0xf0/0x25c
[bcm2835_dma])
[    6.529418] [<bf009ad4>] (bcm2835_dma_prep_slave_sg [bcm2835_dma])
from [<bf04af04>] (bcm2835_request+0x2a4/0x3f4 [bcm2835])
[    6.529548] [<bf04af04>] (bcm2835_request [bcm2835]) from
[<bf0145d0>] (mmc_start_request+0x1f8/0x264 [mmc_core])
[    6.529756] [<bf0145d0>] (mmc_start_request [mmc_core]) from
[<bf016204>] (mmc_start_areq+0x2c8/0x318 [mmc_core])
[    6.529890] [<bf016204>] (mmc_start_areq [mmc_core]) from
[<bf07fa1c>] (mmc_blk_issue_rw_rq+0xc0/0x308 [mmc_block])
[    6.529943] [<bf07fa1c>] (mmc_blk_issue_rw_rq [mmc_block]) from
[<bf080f84>] (mmc_blk_issue_rq+0x418/0x428 [mmc_block])
[    6.529997] [<bf080f84>] (mmc_blk_issue_rq [mmc_block]) from
[<bf081138>] (mmc_queue_thread+0x148/0x1bc [mmc_block])
[    6.530031] [<bf081138>] (mmc_queue_thread [mmc_block]) from
[<c036ae30>] (kthread+0x120/0x138)
[    6.530049] [<c036ae30>] (kthread) from [<c0307e58>]
(ret_from_fork+0x14/0x3c)
[    6.530055] ---[ end trace 221a5a14ca55fa22 ]---
[    6.545765]  mmcblk0: p1 p2 p3 p4
[    6.566015] random: fast init done
[    6.623699] mmc1: new high speed SDIO card at address 0001

Other than that you can add a Tested-by for me:
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Peter
