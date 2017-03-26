From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] mmc: bcm2835: Fix possible NULL ptr dereference in
 bcm2835_request
Date: Sun, 26 Mar 2017 15:39:52 +0200 (CEST)
Message-ID: <1465943071.170635.1490535593059@email.1und1.de>
References: <1490447820-751-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9O6HuJ4iUqnnHMawcLx556ecuEXz+tEZqf7PBomQ=Z2Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63255 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdCZNpq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Mar 2017 09:45:46 -0400
In-Reply-To: <CALeDE9O6HuJ4iUqnnHMawcLx556ecuEXz+tEZqf7PBomQ=Z2Jw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Anholt <eric@anholt.net>, Dan Carpenter <dan.carpenter@oracle.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-rpi-kernel@lists.infradead.org


> Peter Robinson <pbrobinson@gmail.com> hat am 26. März 2017 um 14:53 geschrieben:
> 
> 
> On Sat, Mar 25, 2017 at 1:17 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > This fixes a NULL pointer dereference in case of a MMC request with a
> > set block count command and no data.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> I've tested this with a 4.11 latest patch and it works for me.
> 
> Tested-by: Peter Robinson <pbrobinson@gmail.com>

Thanks

> 
> I also see this crash regularly with the driver too, generally when
> it's probing partitions on boot
> 

Please don't mix issues and send a separate bug report including the answer to the following questions:
Are you sure the system is unuseable after this warning?
Which hardware did you use (i assume RPi3 ARM64)?
Please reproduce and provide a dump of a mainline kernel.
In case it's not reproducible with the defconfig provide your kernel config.

Btw: This looks more a DMA issue to me.

Stefan

> [   17.228214] mmcblk0: mmc0:aaaa SL16G 14.8 GiB
> [   17.247492] ------------[ cut here ]------------
> [   17.254100] WARNING: CPU: 1 PID: 428 at kernel/workqueue.c:2418
> check_flush_dependency+0xac/0x134
> [   17.254118] workqueue: PF_MEMALLOC task 428(mmcqd/0) is flushing
> !WQ_MEM_RECLAIM events:drain_local_pages_wq
> [   17.254125] Modules linked in: mmc_block(+) vc4(+) snd_soc_core
> ac97_bus snd_pcm_dmaengine snd_pcm snd_timer snd soundcore
> drm_kms_helper syscopyarea sdhci_iproc sysfillrect sysimgblt
> sdhci_pltfm fb_sys_fops
> sdhci drm bcm2835 pwm_bcm2835 mmc_core i2c_bcm2835 bcm2835_dma
> scsi_transport_iscsi
> [   17.254282] CPU: 1 PID: 428 Comm: mmcqd/0 Not tainted
> 4.11.0-0.rc3.git2.1.fc26.armv7hl #1
> [   17.254288] Hardware name: Generic DT based system
> [   17.254315] [<c0312684>] (unwind_backtrace) from [<c030cee0>]
> (show_stack+0x18/0x1c)
> [   17.254335] [<c030cee0>] (show_stack) from [<c06caec4>]
> (dump_stack+0xa0/0xd8)
> [   17.254356] [<c06caec4>] (dump_stack) from [<c034fca4>] (__warn+0xe4/0x104)
> [   17.254371] [<c034fca4>] (__warn) from [<c034fd00>]
> (warn_slowpath_fmt+0x3c/0x4c)
> [   17.254391] [<c034fd00>] (warn_slowpath_fmt) from [<c036d6bc>]
> (check_flush_dependency+0xac/0x134)
> [   17.254412] [<c036d6bc>] (check_flush_dependency) from [<c036df68>]
> (flush_work+0x68/0x274)
> [   17.254433] [<c036df68>] (flush_work) from [<c04a25e0>]
> (drain_all_pages+0x2a0/0x30c)
> [   17.254457] [<c04a25e0>] (drain_all_pages) from [<c050dfe0>]
> (start_isolate_page_range+0x168/0x1b4)
> [   17.254477] [<c050dfe0>] (start_isolate_page_range) from
> [<c04a6b84>] (alloc_contig_range+0xd4/0x314)
> [   17.254493] [<c04a6b84>] (alloc_contig_range) from [<c05128d8>]
> (cma_alloc+0x194/0x4a4)
> [   17.254512] [<c05128d8>] (cma_alloc) from [<c0317748>]
> (__alloc_from_contiguous+0x40/0xd8)
> [   17.254530] [<c0317748>] (__alloc_from_contiguous) from
> [<c031781c>] (cma_allocator_alloc+0x3c/0x44)
> [   17.254547] [<c031781c>] (cma_allocator_alloc) from [<c0317aac>]
> (__dma_alloc+0x21c/0x33c)
> [   17.254564] [<c0317aac>] (__dma_alloc) from [<c0317c44>]
> (arm_dma_alloc+0x3c/0x48)
> [   17.254582] [<c0317c44>] (arm_dma_alloc) from [<c04f1f30>]
> (dma_pool_alloc+0x20c/0x270)
> [   17.254611] [<c04f1f30>] (dma_pool_alloc) from [<bf02355c>]
> (bcm2835_dma_create_cb_chain+0xb0/0x1dc [bcm2835_dma])
> [   17.254911] [<bf02355c>] (bcm2835_dma_create_cb_chain
> [bcm2835_dma]) from [<bf023ac8>] (bcm2835_dma_prep_slave_sg+0xf0/0x25c
> [bcm2835_dma])
> [   17.254953] [<bf023ac8>] (bcm2835_dma_prep_slave_sg [bcm2835_dma])
> from [<bf0ab098>] (bcm2835_request+0x320/0x480 [bcm2835])
> [   17.255093] [<bf0ab098>] (bcm2835_request [bcm2835]) from
> [<bf036ad4>] (mmc_start_request+0x1f8/0x264 [mmc_core])
> [   17.255314] [<bf036ad4>] (mmc_start_request [mmc_core]) from
> [<bf0385f8>] (mmc_start_areq+0x2e0/0x334 [mmc_core])
> [   17.255459] [<bf0385f8>] (mmc_start_areq [mmc_core]) from
> [<bf25ea58>] (mmc_blk_issue_rw_rq+0xc0/0x308 [mmc_block])
> [   17.255516] [<bf25ea58>] (mmc_blk_issue_rw_rq [mmc_block]) from
> [<bf25ffc4>] (mmc_blk_issue_rq+0x418/0x428 [mmc_block])
> [   17.255573] [<bf25ffc4>] (mmc_blk_issue_rq [mmc_block]) from
> [<bf260168>] (mmc_queue_thread+0x138/0x1dc [mmc_block])
> [   17.255616] [<bf260168>] (mmc_queue_thread [mmc_block]) from
> [<c0376d7c>] (kthread+0x130/0x14c)
> [   17.255640] [<c0376d7c>] (kthread) from [<c03080b0>]
> (ret_from_fork+0x14/0x24)
> [   17.255650] ---[ end trace d0b22302bc09134b ]---
> [   17.276776]  mmcblk0: p1 p2 p3 p4
>
