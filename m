From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: BUG: SDHCI fails to DMA-unmap, and other warnings
Date: Thu, 17 Dec 2015 22:00:45 +0000
Message-ID: <20151217220045.GA27072@n2100.arm.linux.org.uk>
References: <20151217215140.GK8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59297 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932226AbbLQWAv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 17:00:51 -0500
Content-Disposition: inline
In-Reply-To: <20151217215140.GK8644@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org

And another one:

"mmcblk0: retrying because a re-tune was needed"

static int mmc_blk_err_check(struct mmc_card *card,
                             struct mmc_async_req *areq)
{
...
        if (brq->data.error) {
                if (need_retune && !brq->retune_retry_done) {
                        pr_info("%s: retrying because a re-tune was needed\n",
                                req->rq_disk->disk_name);
                        brq->retune_retry_done = 1;
                        return MMC_BLK_RETRY;

This looks like it'll spam the kernel log regularly if MMC/SD is used
heavily with a UHS card, which (iirc) requires regular retunes.  Why is
this message at info level, and not debug level?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
