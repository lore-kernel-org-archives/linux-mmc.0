From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [comments] MMC: Reliable write support.
Date: Fri, 25 Mar 2011 16:14:29 +0100
Message-ID: <201103251614.29893.arnd@arndb.de>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com> <1301001751-30785-2-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51491 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab1CYPOj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 11:14:39 -0400
In-Reply-To: <1301001751-30785-2-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Thursday 24 March 2011, Andrei Warkentin wrote:
> This is a request-for-comments patch. Please provide your feedback.
> 
> Allows reliable writes to be used for MMC writes. Reliable writes are used
> to service write REQ_FUA/REQ_META requests. Handles both the legacy and the enhanced
> reliable write support in MMC cards.
> 
> Beyond REQ_FUA/REQ_META, this was meant to be used by a following patch that aimed
> to reduce write amplification issues in cards employing a small (usually flash page-sized)
> buffer and a large (usually erase-block sized) buffer, at the expense of performance.

Looks good to me, but I don't really understand some of the block layer
specifics here. One question:

> +static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
> +{
> +	struct mmc_blk_data *md = mq->data;
> +
> +	/*
> +	   No-op, only service this because we need REQ_FUA
> +	   for reliable writes.
> +	*/
> +	spin_lock_irq(&md->lock);
> +	__blk_end_request_all(req, 0);
> +	spin_unlock_irq(&md->lock);
> +
> +	return 1;
> +}

How does this work when you have a flush that does not directly follow
a REQ_FUA or REQ_META request? I would assume that we still need to
flush in some way, which you don't seem to do here.

	Arnd
