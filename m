From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: BUG: SDHCI fails to DMA-unmap, and other warnings
Date: Thu, 17 Dec 2015 22:18:09 +0000
Message-ID: <20151217221808.GL8644@n2100.arm.linux.org.uk>
References: <20151217215140.GK8644@n2100.arm.linux.org.uk>
 <20151217220045.GA27072@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151217220045.GA27072@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 17, 2015 at 10:00:45PM +0000, Russell King - ARM Linux wrote:
> And another one:
> 
> "mmcblk0: retrying because a re-tune was needed"
> 
> static int mmc_blk_err_check(struct mmc_card *card,
>                              struct mmc_async_req *areq)
> {
> ...
>         if (brq->data.error) {
>                 if (need_retune && !brq->retune_retry_done) {
>                         pr_info("%s: retrying because a re-tune was needed\n",
>                                 req->rq_disk->disk_name);
>                         brq->retune_retry_done = 1;
>                         return MMC_BLK_RETRY;
> 
> This looks like it'll spam the kernel log regularly if MMC/SD is used
> heavily with a UHS card, which (iirc) requires regular retunes.  Why is
> this message at info level, and not debug level?

And... if three problems aren't enough, have another one... running:

while :; do hdparm -t /dev/mmcblk0; done

eventually causes:

[ 3465.671526] mmc0: tuning execution failed
[ 3465.675746] mmcblk0: response CRC error sending r/w cmd command, card status 0x900
[ 3622.758988] mmc0: tuning execution failed
[ 3622.763227] mmcblk0: response CRC error sending r/w cmd command, card status 0x900
[ 3858.363555] mmc0: tuning execution failed
[ 3858.368857] mmcblk0: response CRC error sending r/w cmd command, card status 0x900
[ 3880.388048] mmc0: tuning execution failed
[ 3880.392292] mmcblk0: response CRC error sending r/w cmd command, card status 0x900

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
