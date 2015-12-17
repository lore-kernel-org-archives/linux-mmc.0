From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: BUG: SDHCI fails to DMA-unmap, and other warnings
Date: Thu, 17 Dec 2015 22:37:10 +0000
Message-ID: <20151217223709.GM8644@n2100.arm.linux.org.uk>
References: <20151217215140.GK8644@n2100.arm.linux.org.uk>
 <20151217220045.GA27072@n2100.arm.linux.org.uk>
 <20151217221808.GL8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59374 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932946AbbLQWhS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 17:37:18 -0500
Content-Disposition: inline
In-Reply-To: <20151217221808.GL8644@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org

On Thu, Dec 17, 2015 at 10:18:09PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 17, 2015 at 10:00:45PM +0000, Russell King - ARM Linux wrote:
> > And another one:
> > 
> > "mmcblk0: retrying because a re-tune was needed"
> > 
> > static int mmc_blk_err_check(struct mmc_card *card,
> >                              struct mmc_async_req *areq)
> > {
> > ...
> >         if (brq->data.error) {
> >                 if (need_retune && !brq->retune_retry_done) {
> >                         pr_info("%s: retrying because a re-tune was needed\n",
> >                                 req->rq_disk->disk_name);
> >                         brq->retune_retry_done = 1;
> >                         return MMC_BLK_RETRY;
> > 
> > This looks like it'll spam the kernel log regularly if MMC/SD is used
> > heavily with a UHS card, which (iirc) requires regular retunes.  Why is
> > this message at info level, and not debug level?
> 
> And... if three problems aren't enough, have another one... running:
> 
> while :; do hdparm -t /dev/mmcblk0; done
> 
> eventually causes:
> 
> [ 3465.671526] mmc0: tuning execution failed
> [ 3465.675746] mmcblk0: response CRC error sending r/w cmd command, card status 0x900
> [ 3622.758988] mmc0: tuning execution failed
> [ 3622.763227] mmcblk0: response CRC error sending r/w cmd command, card status 0x900
> [ 3858.363555] mmc0: tuning execution failed
> [ 3858.368857] mmcblk0: response CRC error sending r/w cmd command, card status 0x900
> [ 3880.388048] mmc0: tuning execution failed
> [ 3880.392292] mmcblk0: response CRC error sending r/w cmd command, card status 0x900

And finally, I get the bug that was reported to me by a SolidRun user:

[ 4507.373536] mmc0: Got data interrupt 0x00000002 even though no data operation was in progress.

So, that's a total of five MMC/SD bugs in 4.4-rc5 which need
investigation.

Another issue that I've spotted is this cruddy code - which I use
the term "crud" with a certain amount of distaste, given that there
was a big effort to "streamline" DMA-API mapping/unmapping events a
few years back.  So why does sdhci-adma code now do this:

        if (has_unaligned && data->flags & MMC_DATA_READ) {
                dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
                        data->sg_len, direction);

                align = host->align_buffer;
...
        if (data->host_cookie == COOKIE_MAPPED) {
                dma_unmap_sg(mmc_dev(host->mmc), data->sg,
                        data->sg_len, direction);
                data->host_cookie = COOKIE_UNMAPPED;
        }

What this has the effect of doing is invalidating the caches over
the range in dma_sync_sg_for_cpu(), and then doing it all over again
in dma_unmap_sg() _or_ later when we come to do the "streamlined"
unmap.  In either case, this is completely unnecessary to walk the
entire scatterlist twice.

If you're going to have to do that dma_sync_sg_for_cpu() there
because you need to write the unaligned data into the buffer, you
might as well unmap the buffer at that point and be done with it -
whether or not you're using the "streamlined" DMA-API hack that
MMC pulls.

Doing otherwise is nothing but a pure unadulterated waste of CPU
cycles.

So make that six issues now. :)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
