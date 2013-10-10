From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] mmc: fix null pointer use in mmc_blk_remove_req
Date: Thu, 10 Oct 2013 16:18:18 -0700
Message-ID: <20131010231818.GJ4301@kroah.com>
References: <1374671868-606-1-git-send-email-franck.jullien@gmail.com>
 <87d2p2sbcp.fsf@octavius.laptop.org>
 <525276B3.4060809@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <525276B3.4060809@intel.com>
Sender: stable-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org, Chris Ball <cjb@laptop.org>, franck.jullien@gmail.com, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 07, 2013 at 11:54:11AM +0300, Adrian Hunter wrote:
> On 25/08/13 06:22, Chris Ball wrote:
> > Hi Franck,
> > 
> > On Wed, Jul 24 2013, franck.jullien@gmail.com wrote:
> >> From: Franck Jullien <franck.jullien@gmail.com>
> >>
> >> A previous commit (fdfa20c1631210d0) reordered the
> >> shutdown sequence in mmc_blk_remove_req. However,
> >> mmc_cleanup_queue is now called before we get the
> >> card pointer and, sadly, mmc_cleanup_queue set
> >> mq->card to NULL.
> >>
> >> This patch moves the card pointer assignment before
> >> mmc_cleanup_queue.
> >>
> >> Signed-off-by: Franck Jullien <franck.jullien@gmail.com>
> >> ---
> >>  drivers/mmc/card/block.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> >> index cd0b7f4..f4a0bea 100644
> >> --- a/drivers/mmc/card/block.c
> >> +++ b/drivers/mmc/card/block.c
> >> @@ -2191,10 +2191,10 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
> >>  		 * is freeing the queue that stops new requests
> >>  		 * from being accepted.
> >>  		 */
> >> +		card = md->queue.card;
> >>  		mmc_cleanup_queue(&md->queue);
> >>  		if (md->flags & MMC_BLK_PACKED_CMD)
> >>  			mmc_packed_clean(&md->queue);
> >> -		card = md->queue.card;
> >>  		if (md->disk->flags & GENHD_FL_UP) {
> >>  			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
> >>  			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
> > 
> > Thanks for the patch, pushed to mmc-next for 3.12.
> > 
> > - Chris.
> > 
> 
> Hi
> 
> The regression is in 3.11, and causes an oops (see below)
> Adding linux-stable (third time lucky?!?!)
> 
> The fix is now in linus' tree with commit id:
> 
> 	8efb83a2f8518a6ffcc074177f8d659c5165ef37
> 
> Please cherry-pick this for 3.11

Now applied, thanks.

greg k-h
