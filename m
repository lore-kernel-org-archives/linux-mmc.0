From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Sun, 1 Oct 2017 19:57:09 +0900
Message-ID: <201710011957.ICF15708.OOLOHFSQMFFVJt@I-love.SAKURA.ne.jp>
References: <20170905194739.GA31241@amd>
	<20171001093704.GA12626@amd>
	<20171001102647.GA23908@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20171001102647.GA23908@amd>
Sender: owner-linux-mm@kvack.org
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-mmc@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> > I inserted u-SD card, only to realize that it is not detected as it
> > should be. And dmesg indeed reveals:
> 
> Tetsuo asked me to report this to linux-mm.
> 
> But 2^4 is 16 pages, IIRC that can't be expected to work reliably, and
> thus this sounds like MMC bug, not mm bug.

Yes, 16 pages is costly allocations which will fail without invoking the
OOM killer. But I thought this is an interesting case, for mempool
allocation should be able to handle memory allocation failure except
initial allocations, and initial allocation is failing.

I think that using kvmalloc() (and converting corresponding kfree() to
kvfree()) will make initial allocations succeed, but that might cause
needlessly succeeding subsequent mempool allocations under memory pressure?

> 
> > [10994.299846] mmc0: new high speed SDHC card at address 0003
> > [10994.302196] kworker/2:1: page allocation failure: order:4,
> > mode:0x16040c0(GFP_KERNEL|__GFP_COMP|__GFP_NOTRACK), nodemask=(null)
> > [10994.302212] CPU: 2 PID: 9500 Comm: kworker/2:1 Not tainted
> > 4.14.0-rc2 #135
> > [10994.302215] Hardware name: LENOVO 42872WU/42872WU, BIOS 8DET73WW
> > (1.43 ) 10/12/2016
> > [10994.302222] Workqueue: events_freezable mmc_rescan
> > [10994.302227] Call Trace:
> > [10994.302233]  dump_stack+0x4d/0x67
> > [10994.302239]  warn_alloc+0xde/0x180
> > [10994.302243]  __alloc_pages_nodemask+0xaa4/0xd30
> > [10994.302249]  ? cache_alloc_refill+0xb73/0xc10
> > [10994.302252]  cache_alloc_refill+0x101/0xc10
> > [10994.302258]  ? mmc_init_request+0x2d/0xd0
> > [10994.302262]  ? mmc_init_request+0x2d/0xd0
> > [10994.302265]  __kmalloc+0xaf/0xe0
> > [10994.302269]  mmc_init_request+0x2d/0xd0
> > [10994.302273]  alloc_request_size+0x45/0x60
> > [10994.302276]  ? free_request_size+0x30/0x30
> > [10994.302280]  mempool_create_node+0xd7/0x130
> > [10994.302283]  ? alloc_request_simple+0x20/0x20
> > [10994.302287]  blk_init_rl+0xe8/0x110
> > [10994.302290]  blk_init_allocated_queue+0x70/0x180
> > [10994.302294]  mmc_init_queue+0xdd/0x370
> > [10994.302297]  mmc_blk_alloc_req+0xf6/0x340
> > [10994.302301]  mmc_blk_probe+0x18b/0x4e0
> > [10994.302305]  mmc_bus_probe+0x12/0x20
> > [10994.302309]  driver_probe_device+0x2f4/0x490
> > 
> > Order 4 allocations are not supposed to be reliable...
> > 
> > Any ideas?
> > 
> > Thanks,
> > 									Pavel
> > 
> 
> 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
