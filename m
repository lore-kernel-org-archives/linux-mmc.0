From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: Linux v5.0-rc7: bcm2835 MMC issues
Date: Fri, 29 Mar 2019 00:58:18 +0200
Message-ID: <20190328225818.GE16484@darkstar.musicnaut.iki.fi>
References: <20190224150746.GC26495@darkstar.musicnaut.iki.fi>
 <155745885.93258.1551034990363@email.ionos.de>
 <20190226011509.GB31163@darkstar.musicnaut.iki.fi>
 <06528ceb-ff1d-626b-f520-477b0ea49d6f@i2se.com>
 <20190227185101.GA28051@darkstar.musicnaut.iki.fi>
 <1685719010.348465.1552129077871@email.ionos.de>
 <20190310005131.GF30189@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190310005131.GF30189-4/PLUo9XfK9owWHViPbQSXlKr5M7+etX9Sl0XMgJPXI@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Mar 10, 2019 at 02:51:31AM +0200, Aaro Koskinen wrote:
> On Sat, Mar 09, 2019 at 11:57:57AM +0100, Stefan Wahren wrote:
> > > Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org> hat am 27. Februar 2019 um 19:51 geschrieben:
> > > On Tue, Feb 26, 2019 at 09:31:14AM +0100, Stefan Wahren wrote:
> > > > it will take some time for to setup this test scenario. Could you please
> > > > do me a favor and test 4.20.12 which has some backports of recent mmc /
> > > > DMA fixes.
> > > 
> > > Both 4.20 and 4.20.12 work fine. Only 5.0-rc fails reliably.
> > 
> > I tried to reproduce the issue by compiling gcc and using stress on
> > Raspberry Pi 3 (arm64/defconfig) with Arch Linux ARM without any luck.
> > 
> > Were you able to reproduce the issue using stress?
> 
> No, not yet. I'll let you know if I'm able to come up with a more reliable
> reproducer.

I tried GCC bootstrap again with 5.1-rc2 and LOCKDEP enabled, and get
the below warning. Might some different unrelated issue, however.

[ 1164.390902] 
[ 1164.398302] ======================================================
[ 1164.416501] WARNING: possible circular locking dependency detected
[ 1164.434710] 5.1.0-rc2-rpi3-los_6ba38c+-00247-g9936328b41ce-dirty #1 Not tainted
[ 1164.454495] ------------------------------------------------------
[ 1164.472908] cc1plus/30873 is trying to acquire lock:
[ 1164.489750] 0000000040a8ff57 (&mq->complete_lock){+.+.}, at: mmc_blk_mq_complete_prev_req.part.12+0x3c/0x220
[ 1164.518548] 
[ 1164.518548] but task is already holding lock:
[ 1164.541662] 0000000059d7e9bb (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part.19+0x0/0x40
[ 1164.567105] 
[ 1164.567105] which lock already depends on the new lock.
[ 1164.567105] 
[ 1164.595691] 
[ 1164.595691] the existing dependency chain (in reverse order) is:
[ 1164.616711] 
[ 1164.616711] -> #2 (fs_reclaim){+.+.}:
[ 1164.630507]        lock_acquire+0xe8/0x250
[ 1164.638922]        fs_reclaim_acquire.part.19+0x34/0x40
[ 1164.652170]        fs_reclaim_acquire+0x20/0x28
[ 1164.665139]        __kmalloc+0x50/0x390
[ 1164.673717]        bcm2835_dma_create_cb_chain+0x70/0x270
[ 1164.688863]        bcm2835_dma_prep_slave_sg+0xf4/0x280
[ 1164.704061]        bcm2835_request+0x300/0x3f8
[ 1164.718923]        __mmc_start_request+0xb8/0x2b0
[ 1164.734415]        mmc_start_request+0x74/0x98
[ 1164.749591]        mmc_blk_mq_issue_rq+0x328/0x774
[ 1164.765346]        mmc_mq_queue_rq+0x108/0x278
[ 1164.780772]        blk_mq_try_issue_directly+0x13c/0x240
[ 1164.797298]        blk_mq_make_request+0x494/0x820
[ 1164.813224]        generic_make_request+0x25c/0x4a8
[ 1164.829126]        submit_bio+0x38/0x1c0
[ 1164.838778]        submit_bh_wbc.isra.11+0x168/0x1d0
[ 1164.854312]        block_read_full_page+0x298/0x3a8
[ 1164.869741]        blkdev_readpage+0x18/0x20
[ 1164.884479]        do_read_cache_page+0x1b8/0x378
[ 1164.899756]        read_cache_page+0x10/0x18
[ 1164.914504]        read_dev_sector+0x34/0xb8
[ 1164.929506]        msdos_partition+0x68/0x628
[ 1164.944814]        check_partition+0x108/0x210
[ 1164.960213]        rescan_partitions+0xb8/0x3a8
[ 1164.975682]        __blkdev_get+0x2f0/0x3f8
[ 1164.990768]        blkdev_get+0x148/0x340
[ 1165.000495]        __device_add_disk+0x3ac/0x458
[ 1165.015811]        device_add_disk+0x10/0x18
[ 1165.030725]        mmc_add_disk+0x34/0x11c
[ 1165.040460]        mmc_blk_probe+0x25c/0x640
[ 1165.055042]        mmc_bus_probe+0x1c/0x28
[ 1165.064621]        really_probe+0xd8/0x298
[ 1165.074075]        driver_probe_device+0x54/0xe8
[ 1165.088485]        __device_attach_driver+0x9c/0xd8
[ 1165.103403]        bus_for_each_drv+0x78/0xc8
[ 1165.117702]        __device_attach+0xd4/0x130
[ 1165.132180]        device_initial_probe+0x10/0x18
[ 1165.147239]        bus_probe_device+0x98/0xa0
[ 1165.162333]        device_add+0x3ac/0x5d8
[ 1165.172090]        mmc_add_card+0x1f8/0x2c8
[ 1165.186913]        mmc_attach_sd+0xec/0x168
[ 1165.201705]        mmc_rescan+0x298/0x370
[ 1165.211301]        process_one_work+0x2ac/0x6f8
[ 1165.226087]        worker_thread+0x40/0x448
[ 1165.240461]        kthread+0x128/0x130
[ 1165.249507]        ret_from_fork+0x10/0x1c
[ 1165.258809] 
[ 1165.258809] -> #1 (&host->mutex){+.+.}:
[ 1165.273924]        lock_acquire+0xe8/0x250
[ 1165.283052]        __mutex_lock+0x8c/0x840
[ 1165.291983]        mutex_lock_nested+0x1c/0x28
[ 1165.305449]        bcm2835_request+0xc0/0x3f8
[ 1165.318987]        __mmc_start_request+0xb8/0x2b0
[ 1165.333011]        mmc_start_request+0x74/0x98
[ 1165.347223]        mmc_wait_for_req+0x68/0xe8
[ 1165.361806]        mmc_wait_for_cmd+0x7c/0xa8
[ 1165.376982]        __mmc_send_status+0x70/0xa0
[ 1165.392393]        card_busy_detect.isra.7+0x68/0x120
[ 1165.408500]        mmc_blk_mq_complete_prev_req.part.12+0x134/0x220
[ 1165.426099]        mmc_blk_mq_complete_work+0x2c/0x38
[ 1165.442580]        process_one_work+0x2ac/0x6f8
[ 1165.458455]        worker_thread+0x40/0x448
[ 1165.473919]        kthread+0x128/0x130
[ 1165.483508]        ret_from_fork+0x10/0x1c
[ 1165.493342] 
[ 1165.493342] -> #0 (&mq->complete_lock){+.+.}:
[ 1165.514773]        __lock_acquire+0xcbc/0x12a8
[ 1165.529403]        lock_acquire+0xe8/0x250
[ 1165.538896]        __mutex_lock+0x8c/0x840
[ 1165.548198]        mutex_lock_nested+0x1c/0x28
[ 1165.562147]        mmc_blk_mq_complete_prev_req.part.12+0x3c/0x220
[ 1165.578490]        mmc_blk_rw_wait+0x88/0x150
[ 1165.593514]        mmc_blk_mq_issue_rq+0x30c/0x774
[ 1165.609020]        mmc_mq_queue_rq+0x108/0x278
[ 1165.624125]        blk_mq_try_issue_directly+0x13c/0x240
[ 1165.640763]        blk_mq_try_issue_list_directly+0x7c/0xe0
[ 1165.657851]        blk_mq_sched_insert_requests+0x84/0xa0
[ 1165.674561]        blk_mq_flush_plug_list+0x22c/0x4f0
[ 1165.690782]        blk_flush_plug_list+0xd4/0x100
[ 1165.706603]        blk_finish_plug+0x30/0x40
[ 1165.721924]        shrink_node_memcg.constprop.19+0x4f0/0x6d0
[ 1165.739046]        shrink_node+0x7c/0x300
[ 1165.748985]        try_to_free_pages+0x1d8/0x6b0
[ 1165.764594]        __alloc_pages_nodemask+0x4c8/0x10c0
[ 1165.780768]        __handle_mm_fault+0x378/0xb10
[ 1165.796317]        handle_mm_fault+0x98/0xe0
[ 1165.811461]        do_page_fault+0x120/0x460
[ 1165.826546]        do_translation_fault+0x50/0x58
[ 1165.842096]        do_mem_abort+0x3c/0x98
[ 1165.851830]        el0_da+0x20/0x24
[ 1165.860835] 
[ 1165.860835] other info that might help us debug this:
[ 1165.860835] 
[ 1165.888360] Chain exists of:
[ 1165.888360]   &mq->complete_lock --> &host->mutex --> fs_reclaim
[ 1165.888360] 
[ 1165.916434]  Possible unsafe locking scenario:
[ 1165.916434] 
[ 1165.934797]        CPU0                    CPU1
[ 1165.947234]        ----                    ----
[ 1165.959140]   lock(fs_reclaim);
[ 1165.966281]                                lock(&host->mutex);
[ 1165.979605]                                lock(fs_reclaim);
[ 1165.992221]   lock(&mq->complete_lock);
[ 1165.999628] 
[ 1165.999628]  *** DEADLOCK ***
[ 1165.999628] 
[ 1166.015913] 3 locks held by cc1plus/30873:
[ 1166.024001]  #0: 00000000163613c2 (&mm->mmap_sem){++++}, at: do_page_fault+0xc8/0x460
[ 1166.040348]  #1: 0000000059d7e9bb (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part.19+0x0/0x40
[ 1166.063019]  #2: 0000000081e56ff0 (hctx->srcu){....}, at: hctx_lock+0x70/0xe8
[ 1166.080956] 
[ 1166.080956] stack backtrace:
[ 1166.095758] CPU: 3 PID: 30873 Comm: cc1plus Not tainted 5.1.0-rc2-rpi3-los_6ba38c+-00247-g9936328b41ce-dirty #1
[ 1166.123148] Hardware name: Raspberry Pi 3 Model B (DT)
[ 1166.139641] Call trace:
[ 1166.147494]  dump_backtrace+0x0/0x120
[ 1166.156570]  show_stack+0x14/0x20
[ 1166.165072]  dump_stack+0xd4/0x11c
[ 1166.173320]  print_circular_bug.isra.20+0x26c/0x2d8
[ 1166.187945]  check_prev_add.constprop.28+0x610/0xc80
[ 1166.203228]  __lock_acquire+0xcbc/0x12a8
[ 1166.212469]  lock_acquire+0xe8/0x250
[ 1166.221217]  __mutex_lock+0x8c/0x840
[ 1166.229745]  mutex_lock_nested+0x1c/0x28
[ 1166.238735]  mmc_blk_mq_complete_prev_req.part.12+0x3c/0x220
[ 1166.254447]  mmc_blk_rw_wait+0x88/0x150
[ 1166.263940]  mmc_blk_mq_issue_rq+0x30c/0x774
[ 1166.278741]  mmc_mq_queue_rq+0x108/0x278
[ 1166.288203]  blk_mq_try_issue_directly+0x13c/0x240
[ 1166.303322]  blk_mq_try_issue_list_directly+0x7c/0xe0
[ 1166.319311]  blk_mq_sched_insert_requests+0x84/0xa0
[ 1166.335859]  blk_mq_flush_plug_list+0x22c/0x4f0
[ 1166.352129]  blk_flush_plug_list+0xd4/0x100
[ 1166.368455]  blk_finish_plug+0x30/0x40
[ 1166.378500]  shrink_node_memcg.constprop.19+0x4f0/0x6d0
[ 1166.396035]  shrink_node+0x7c/0x300
[ 1166.405729]  try_to_free_pages+0x1d8/0x6b0
[ 1166.416012]  __alloc_pages_nodemask+0x4c8/0x10c0
[ 1166.432173]  __handle_mm_fault+0x378/0xb10
[ 1166.442314]  handle_mm_fault+0x98/0xe0
[ 1166.451920]  do_page_fault+0x120/0x460
[ 1166.461355]  do_translation_fault+0x50/0x58
[ 1166.476086]  do_mem_abort+0x3c/0x98
[ 1166.485124]  el0_da+0x20/0x24

A.
