From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] mmc: mmci: reduce max_blk_count to avoid overflowing
 max_req_size
Date: Wed, 29 Feb 2012 18:41:54 +0000
Message-ID: <20120229184154.GN2983@mudshark.cambridge.arm.com>
References: <1330082721-6021-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51272 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965939Ab2B2SmQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Feb 2012 13:42:16 -0500
Content-Disposition: inline
In-Reply-To: <1330082721-6021-1-git-send-email-will.deacon@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Pierre Ossman <pierre@ossman.eu>, Chris Ball <cjb@laptop.org>

[adding Pierre with the correct email address]

On Fri, Feb 24, 2012 at 11:25:21AM +0000, Will Deacon wrote:
> On a system with large pages (64k in my case), the following BUG is
> triggered in MMC core:
> 
> [    2.338023] BUG: failure at drivers/mmc/core/core.c:221/mmc_start_request()!
> [    2.338102] Kernel panic - not syncing: BUG!
> [    2.338155] Call trace:
> [    2.338228] [<ffffffc00008635c>] dump_backtrace+0x0/0x120
> [    2.338317] [<ffffffc0003365ec>] dump_stack+0x14/0x1c
> [    2.338403] [<ffffffc000336990>] panic+0xbc/0x1f0
> [    2.338498] [<ffffffc00027a494>] mmc_start_request+0x154/0x184
> [    2.338600] [<ffffffc00027abdc>] mmc_start_req+0x110/0x140
> [    2.338701] [<ffffffc00028604c>] mmc_blk_issue_rw_rq+0x7c/0x39c
> [    2.338804] [<ffffffc00028652c>] mmc_blk_issue_rq+0x1c0/0x468
> [    2.338905] [<ffffffc000287564>] mmc_queue_thread+0x68/0x118
> [    2.338995] [<ffffffc0000bc308>] kthread+0x84/0x8c
> 
> This is because of a 64k request with a max_req_size of 64k-1 bytes.
> 
> The following patch fixes the problem by limiting the max_blk_count
> such that max_blk_count * max_blk_size == max_req_size. I couldn't
> pursuade the compiler to emit a shift instead of a div without encoding
> the shift explicitly.
> 
> Cc: Pierre Ossman <drzeus@drzeus.cx>
> Cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/mmc/host/mmci.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 0d955ff..11e589c 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1271,12 +1271,13 @@ static int __devinit mmci_probe(struct amba_device *dev,
>  	/*
>  	 * Block size can be up to 2048 bytes, but must be a power of two.
>  	 */
> -	mmc->max_blk_size = 2048;
> +	mmc->max_blk_size = 1 << 11;
>  
>  	/*
> -	 * No limit on the number of blocks transferred.
> +	 * Limit the number of blocks transferred so that we don't overflow
> +	 * the maximum request size.
>  	 */
> -	mmc->max_blk_count = mmc->max_req_size;
> +	mmc->max_blk_count = mmc->max_req_size >> 11;
>  
>  	spin_lock_init(&host->lock);
>  
> -- 
> 1.7.4.1

Any thoughts on this? I'm by no means an MMC expert, so I'm open to
suggestions if there's a more suitable fix.

Cheers,

Will

