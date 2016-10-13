From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Detected aborted journal error in Kernel 3.12
Date: Thu, 13 Oct 2016 22:24:37 +0200
Message-ID: <CAALWOA_RHBW8gYq=HncNgw8k2yKipieRgmCaNyz=kvLF4RSAwg@mail.gmail.com>
References: <CAFvPE2qruGv6hdGCkuagq9hHEgsmncBPfqD6ftpRLcY6tou9Bw@mail.gmail.com>
 <20160917154123.mfkkhptwvrzavs7y@atomide.com>
 <CAFvPE2ph+bGBkgvjPQfYzn3xwdXrTSXVEBHMo_CEDcdiR6-ekQ@mail.gmail.com>
 <20160919181541.45ahl6ktojawwtui@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32810 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754376AbcJMUni (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2016 16:43:38 -0400
Content-Disposition: inline
In-Reply-To: <20160919181541.45ahl6ktojawwtui@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ankur Tank <ankurtank.linux@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

On 19 September 2016 at 20:15, Tony Lindgren <tony@atomide.com> wrote:
> Well in that case you should be able to test it easily with v4.7
> too :) If you have it reproducable with a beaglebone, please provide
> some script to reproduce. Otherwise chances are this is something
> specific to your hardware and we have no way of helping you out.

It would indeed be very useful to have a reproducible case on an
uptodate kernel, but it is definitely not specific to his hardware.
Someone on the beagleboard forum also hit this issue, but sporadically:

https://groups.google.com/d/msg/beagleboard/5ZwTUQwGSx4/r15mENdfAwAJ

I'll quote my reply to it:

On 4 October 2016 at 21:00, Matthijs van Duin <matthijsvanduin@gmail.com> wrote:
> I've also run into this once during an apt-get upgrade, leaving the system
> in a pretty hosed state. I managed to recover it but it required a lot of
> effort. Although evidently rare, this is clearly a very serious issue.
>
> The direct cause is edma_prep_slave_sg() failing to allocate memory for the
> struct edma_desc. I don't know whether the kernel is genuinely out of memory
> or if it simply cannot free it up immediately (the allocation is done with
> GPF_ATOMIC), and whether this is because it is filled with a backlog of
> writes or whether a leak of some sort is going on.
>
> Instead of deferring until memory is available, or even just proceeding
> without DMA, the omap_hsmmc driver immediately fails the request with an
> error, thus pretty much guaranteeing loss of data or even filesystem
> corruption. I personally think this is completely unacceptable behaviour of
> a block driver.
>
> I've been meaning to persue this matter on the linux-mmc and/or linux-omap
> lists, but since it was a single isolated incident and I have lots of other
> stuff to do I haven't been able to find the time and motivation yet.

If Ankur has a reproducible case then I think it's time to get
motivated. Ankur, can you please try 4.7 or 4.8 ?


For those who might be interested, I've included an abbreviated kernel
log from my crash below, containing the first allocation failure and
some fragments of all later failures (since it was mostly more of the
same) until the journal was aborted.


[1388370.068396] mmcqd/1: page allocation failure: order:4, mode:0x204020
[1388370.068423] CPU: 0 PID: 67 Comm: mmcqd/1 Not tainted 4.2.0-bone2-dd1 #3
[1388370.068430] Hardware name: Generic AM33XX (Flattened Device Tree)
[1388370.068483] [<c0012e91>] (unwind_backtrace) from [<c00110d1>] (show_stack+0x11/0x14)
[1388370.068507] [<c00110d1>] (show_stack) from [<c00bd2c9>] (warn_alloc_failed+0x99/0xcc)
[1388370.068524] [<c00bd2c9>] (warn_alloc_failed) from [<c00bf3cf>] (__alloc_pages_nodemask+0x4db/0x5f4)
[1388370.068544] [<c00bf3cf>] (__alloc_pages_nodemask) from [<c00e6b75>] (cache_alloc_refill+0x1f5/0x3c4)
[1388370.068558] [<c00e6b75>] (cache_alloc_refill) from [<c00e6ec5>] (__kmalloc+0xb5/0xcc)
[1388370.068575] [<c00e6ec5>] (__kmalloc) from [<c0224083>] (edma_prep_slave_sg+0x77/0x224)
[1388370.068599] [<c0224083>] (edma_prep_slave_sg) from [<c0296097>] (omap_hsmmc_request+0x30f/0x3c8)
[1388370.068629] [<c0296097>] (omap_hsmmc_request) from [<c02833df>] (mmc_start_request+0xcb/0x1b0)
[1388370.068642] [<c02833df>] (mmc_start_request) from [<c0283a37>] (mmc_start_req+0x1e3/0x2ac)
[1388370.068654] [<c0283a37>] (mmc_start_req) from [<c028f435>] (mmc_blk_issue_rw_rq+0x8d/0x77c)
[1388370.068667] [<c028f435>] (mmc_blk_issue_rw_rq) from [<c028fc4f>] (mmc_blk_issue_rq+0x12b/0x34c)
[1388370.068678] [<c028fc4f>] (mmc_blk_issue_rq) from [<c029041f>] (mmc_queue_thread+0x6b/0x104)
[1388370.068701] [<c029041f>] (mmc_queue_thread) from [<c003d74b>] (kthread+0x9b/0xb0)
[1388370.068717] [<c003d74b>] (kthread) from [<c000e601>] (ret_from_fork+0x11/0x30)
[1388370.068723] Mem-Info:
[1388370.068742] active_anon:16913 inactive_anon:3153 isolated_anon:0
                  active_file:57786 inactive_file:27763 isolated_file:0
                  unevictable:0 dirty:186 writeback:5367 unstable:0
                  slab_reclaimable:16912 slab_unreclaimable:1471
                  mapped:16290 shmem:3216 pagetables:378 bounce:0
                  free:2918 free_pcp:93 free_cma:0
[1388370.068781] Normal free:11672kB min:2860kB low:3572kB high:4288kB active_anon:67652kB inactive_anon:12612kB active_file:231144kB inactive_file:111052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:524288kB managed:512036kB mlocked:0kB dirty:744kB writeback:21468kB mapped:65160kB shmem:12864kB slab_reclaimable:67648kB slab_unreclaimable:5884kB kernel_stack:704kB pagetables:1512kB unstable:0kB bounce:0kB free_pcp:372kB local_pcp:372kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[1388370.068790] lowmem_reserve[]: 0 0
[1388370.068800] Normal: 1546*4kB (UE) 488*8kB (UE) 95*16kB (UE) 2*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 11672kB
[1388370.068835] 88765 total pagecache pages
[1388370.068847] 0 pages in swap cache
[1388370.068854] Swap cache stats: add 0, delete 0, find 0/0
[1388370.068858] Free swap  = 0kB
[1388370.068862] Total swap = 0kB
[1388370.068867] 131072 pages RAM
[1388370.068872] 0 pages HighMem/MovableOnly
[1388370.068877] 4294964215 pages reserved
[1388370.068882] 6144 pages cma reserved
[1388370.068899] edma-dma-engine edma-dma-engine.0: edma_prep_slave_sg: Failed to allocate a descriptor
[1388370.078545] omap_hsmmc 481d8000.mmc: prep_slave_sg() failed
[1388370.084583] omap_hsmmc 481d8000.mmc: MMC start dma failure
[1388370.100106] mmcblk0: unknown error -1 sending read/write command, card status 0x900
[1388370.108621] blk_update_request: I/O error, dev mmcblk0, sector 5965856
[1388370.116079] blk_update_request: I/O error, dev mmcblk0, sector 5965864
[1388370.123424] blk_update_request: I/O error, dev mmcblk0, sector 5965872
[1388370.130744] blk_update_request: I/O error, dev mmcblk0, sector 5965880
[1388370.138080] blk_update_request: I/O error, dev mmcblk0, sector 5965888
[1388370.145453] blk_update_request: I/O error, dev mmcblk0, sector 5965896
[1388370.152789] blk_update_request: I/O error, dev mmcblk0, sector 5965904
[1388370.160148] blk_update_request: I/O error, dev mmcblk0, sector 5965912
[1388370.167483] blk_update_request: I/O error, dev mmcblk0, sector 5965920
[1388370.174811] blk_update_request: I/O error, dev mmcblk0, sector 5965928
[1388370.250530] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 20480 size 8368128 starting block 745988)
[1388370.250544] Buffer I/O error on device mmcblk0p1, logical block 745476
[1388370.257602] Buffer I/O error on device mmcblk0p1, logical block 745477
[1388370.264680] Buffer I/O error on device mmcblk0p1, logical block 745478
[1388370.271721] Buffer I/O error on device mmcblk0p1, logical block 745479
[1388370.278748] Buffer I/O error on device mmcblk0p1, logical block 745480
[1388370.285786] Buffer I/O error on device mmcblk0p1, logical block 745481
[1388370.292841] Buffer I/O error on device mmcblk0p1, logical block 745482
[1388370.299868] Buffer I/O error on device mmcblk0p1, logical block 745483
[1388370.306906] Buffer I/O error on device mmcblk0p1, logical block 745484
[1388370.313983] Buffer I/O error on device mmcblk0p1, logical block 745485
[1388370.385585] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 20480 size 8368128 starting block 746244)
[1388370.442558] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 20480 size 8368128 starting block 746500)
[1388370.492046] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 20480 size 8368128 starting block 746756)
[1388370.533845] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 20480 size 8368128 starting block 747012)
[1388370.568064] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 20480 size 8368128 starting block 747268)
[1388370.594972] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 20480 size 8368128 starting block 747524)
[1388370.613990] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 20480 size 8368128 starting block 747776)
[1388370.625719] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 8388608 size 8388608 starting block 748032)
[1388370.629917] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 52 (offset 8388608 size 8388608 starting block 748288)



[1404756.401859] mmcqd/1: page allocation failure: order:3, mode:0x204020
	...
[1404756.402206] active_anon:20306 inactive_anon:3152 isolated_anon:0
                  active_file:42883 inactive_file:40510 isolated_file:0
                  unevictable:0 dirty:15 writeback:712 unstable:0
                  slab_reclaimable:17377 slab_unreclaimable:1433
                  mapped:10552 shmem:3218 pagetables:394 bounce:0
                  free:1161 free_pcp:116 free_cma:5
[1404756.402245] Normal free:4644kB min:2860kB low:3572kB high:4288kB active_anon:81224kB inactive_anon:12608kB active_file:171532kB inactive_file:162040kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:524288kB managed:512036kB mlocked:0kB dirty:60kB writeback:2848kB mapped:42208kB shmem:12872kB slab_reclaimable:69508kB slab_unreclaimable:5732kB kernel_stack:736kB pagetables:1576kB unstable:0kB bounce:0kB free_pcp:464kB local_pcp:464kB free_cma:20kB writeback_tmp:0kB pages_scanned:44 all_unreclaimable? no
[1404756.402254] lowmem_reserve[]: 0 0
[1404756.402264] Normal: 1095*4kB (UEMC) 21*8kB (UMC) 6*16kB (UM) 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 4644kB
[1404756.402296] 86611 total pagecache pages
	...
[1404756.402339] 4294964215 pages reserved
[1404756.402344] 6144 pages cma reserved
	...
[1404756.460563] blk_update_request: 2546 callbacks suppressed
[1404756.460573] blk_update_request: I/O error, dev mmcblk0, sector 6277632
	...
[1404756.547542] buffer_io_error: 2546 callbacks suppressed
[1404756.547551] Buffer I/O error on device mmcblk0p1, logical block 784448
[1404756.554588] Buffer I/O error on device mmcblk0p1, logical block 784449
[1404756.561625] Buffer I/O error on device mmcblk0p1, logical block 784450
[1404756.568663] Buffer I/O error on device mmcblk0p1, logical block 784451
[1404756.575689] Buffer I/O error on device mmcblk0p1, logical block 784452
[1404756.582767] Buffer I/O error on device mmcblk0p1, logical block 784453
[1404756.589822] Buffer I/O error on device mmcblk0p1, logical block 784454
[1404756.596861] Buffer I/O error on device mmcblk0p1, logical block 784455
[1404756.603888] Buffer I/O error on device mmcblk0p1, logical block 784456
[1404756.610923] Buffer I/O error on device mmcblk0p1, logical block 784457
[1404756.627519] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 38392 (offset 0 size 2916352 starting block 785216)
[1404756.630152] EXT4-fs warning (device mmcblk0p1): ext4_end_bio:332: I/O error -5 writing to inode 38392 (offset 0 size 2916352 starting block 785416)



[1404845.787954] mmcqd/1: page allocation failure: order:4, mode:0x204020
	...
[1404845.788299] active_anon:20955 inactive_anon:3152 isolated_anon:0
                  active_file:41364 inactive_file:40956 isolated_file:0
                  unevictable:0 dirty:7360 writeback:1024 unstable:0
                  slab_reclaimable:16950 slab_unreclaimable:1441
                  mapped:10343 shmem:3218 pagetables:397 bounce:0
                  free:1976 free_pcp:140 free_cma:2
[1404845.788338] Normal free:7904kB min:2860kB low:3572kB high:4288kB active_anon:83820kB inactive_anon:12608kB active_file:165456kB inactive_file:163824kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:524288kB managed:512036kB mlocked:0kB dirty:29440kB writeback:4096kB mapped:41372kB shmem:12872kB slab_reclaimable:67800kB slab_unreclaimable:5764kB kernel_stack:736kB pagetables:1588kB unstable:0kB bounce:0kB free_pcp:560kB local_pcp:560kB free_cma:8kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[1404845.788348] lowmem_reserve[]: 0 0
[1404845.788357] Normal: 1628*4kB (UEMC) 122*8kB (UEM) 14*16kB (UM) 6*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 7904kB
[1404845.788391] 85540 total pagecache pages
	...


[1404847.076047] mmcqd/1: page allocation failure: order:4, mode:0x204020
	...
[1404847.076394] active_anon:20955 inactive_anon:3152 isolated_anon:0
                  active_file:41397 inactive_file:41282 isolated_file:0
                  unevictable:0 dirty:7316 writeback:1024 unstable:0
                  slab_reclaimable:16935 slab_unreclaimable:1441
                  mapped:10349 shmem:3218 pagetables:397 bounce:0
                  free:1738 free_pcp:35 free_cma:7
[1404847.076433] Normal free:6952kB min:2860kB low:3572kB high:4288kB active_anon:83820kB inactive_anon:12608kB active_file:165588kB inactive_file:165128kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:524288kB managed:512036kB mlocked:0kB dirty:29264kB writeback:4096kB mapped:41396kB shmem:12872kB slab_reclaimable:67740kB slab_unreclaimable:5764kB kernel_stack:736kB pagetables:1588kB unstable:0kB bounce:0kB free_pcp:140kB local_pcp:140kB free_cma:28kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[1404847.076442] lowmem_reserve[]: 0 0
[1404847.076452] Normal: 1328*4kB (UEMC) 141*8kB (UEM) 20*16kB (UM) 6*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 6952kB
[1404847.076486] 85897 total pagecache pages
	...


	...
	...
	...

[1405129.992113] mmcqd/1: page allocation failure: order:4, mode:0x204020
	...
[1405129.992456] active_anon:19748 inactive_anon:3152 isolated_anon:0
                  active_file:40227 inactive_file:49987 isolated_file:0
                  unevictable:0 dirty:520 writeback:1627 unstable:0
                  slab_reclaimable:11113 slab_unreclaimable:1456
                  mapped:8668 shmem:3218 pagetables:385 bounce:0
                  free:1133 free_pcp:155 free_cma:22
[1405129.992495] Normal free:4532kB min:2860kB low:3572kB high:4288kB active_anon:78992kB inactive_anon:12608kB active_file:160908kB inactive_file:199948kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:524288kB managed:512036kB mlocked:0kB dirty:2080kB writeback:6508kB mapped:34672kB shmem:12872kB slab_reclaimable:44452kB slab_unreclaimable:5824kB kernel_stack:728kB pagetables:1540kB unstable:0kB bounce:0kB free_pcp:620kB local_pcp:620kB free_cma:88kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[1405129.992504] lowmem_reserve[]: 0 0
[1405129.992514] Normal: 1009*4kB (UEMC) 46*8kB (EMC) 6*16kB (E) 1*32kB (M) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 4532kB
[1405129.992548] 93432 total pagecache pages
	...

[1405264.702468] mmcqd/1: page allocation failure: order:3, mode:0x204020
	...
[1405264.702813] active_anon:18935 inactive_anon:3151 isolated_anon:0
                  active_file:41990 inactive_file:48264 isolated_file:0
                  unevictable:0 dirty:450 writeback:0 unstable:0
                  slab_reclaimable:10709 slab_unreclaimable:1473
                  mapped:9511 shmem:3219 pagetables:376 bounce:0
                  free:2373 free_pcp:88 free_cma:73
[1405264.702854] Normal free:9492kB min:2860kB low:3572kB high:4288kB active_anon:75740kB inactive_anon:12604kB active_file:167960kB inactive_file:193056kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:524288kB managed:512036kB mlocked:0kB dirty:1800kB writeback:0kB mapped:38044kB shmem:12876kB slab_reclaimable:42836kB slab_unreclaimable:5892kB kernel_stack:728kB pagetables:1504kB unstable:0kB bounce:0kB free_pcp:352kB local_pcp:352kB free_cma:292kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[1405264.702862] lowmem_reserve[]: 0 0
[1405264.702872] Normal: 1519*4kB (UEMC) 421*8kB (UEMC) 3*16kB (E) 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 9492kB
[1405264.702905] 93474 total pagecache pages
	...
[1405264.851288] Aborting journal on device mmcblk0p1-8.
[1405264.916239] EXT4-fs error (device mmcblk0p1): ext4_journal_check_start:56: Detected aborted journal
[1405264.925972] EXT4-fs (mmcblk0p1): Remounting filesystem read-only
[1405264.933063] EXT4-fs error (device mmcblk0p1): ext4_journal_check_start:56: Detected aborted journal

-- 
Matthijs
