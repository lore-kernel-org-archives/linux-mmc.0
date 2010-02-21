From: "George G. Davis" <gdavis@mvista.com>
Subject: Re: drivers/mmc/card/queue.c: 5 * redundant conditions
Date: Sun, 21 Feb 2010 08:56:40 -0500
Message-ID: <20100221135640.GB4892@mvista.com>
References: <BLU108-W228981D80AF186D993C529C440@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:60960 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab0BUN4n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Feb 2010 08:56:43 -0500
Received: by qw-out-2122.google.com with SMTP id 8so305245qwh.37
        for <linux-mmc@vger.kernel.org>; Sun, 21 Feb 2010 05:56:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BLU108-W228981D80AF186D993C529C440@phx.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: d binderman <dcb314@hotmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Sun, Feb 21, 2010 at 09:21:27AM +0000, d binderman wrote:
> 
> 
> Hello there,
> 
> I just ran the sourceforge tool cppcheck over the source code of the
> new Linux kernel 2.6.33-rc8
> 
> It said
> 
> Checking ./drivers/mmc/card/queue.c...
> [./drivers/mmc/card/queue.c:212]: (style) Redundant condition. It is safe to deallocate a NULL pointer
> [./drivers/mmc/card/queue.c:215]: (style) Redundant condition. It is safe to deallocate a NULL pointer
> [./drivers/mmc/card/queue.c:208]: (style) Redundant condition. It is safe to deallocate a NULL pointer
> [./drivers/mmc/card/queue.c:239]: (style) Redundant condition. It is safe to deallocate a NULL pointer
> [./drivers/mmc/card/queue.c:246]: (style) Redundant condition. It is safe to deallocate a NULL pointer

This report appears to be using a kernel config with CONFIG_MMC_BLOCK_BOUNCE=y.
What does cppcheck report for the CONFIG_MMC_BLOCK_BOUNCE=n case?  I believe
you will find that it is not sage to remove those conditions for the
CONFIG_MMC_BLOCK_BOUNCE=n case.

--
Regards,
George

> 
> I checked the source code and I agree with cppcheck. 
> Patch file attached.
> 
> Regards
> 
> David Binderman
> 
>  		 	   		  
> _________________________________________________________________
> Got a cool Hotmail story? Tell us now
> http://clk.atdmt.com/UKM/go/195013117/direct/01/

> --- drivers/mmc/card/queue.c.sav	2010-02-21 09:08:45.000000000 +0000
> +++ drivers/mmc/card/queue.c	2010-02-21 09:09:51.000000000 +0000
> @@ -205,15 +205,12 @@ int mmc_init_queue(struct mmc_queue *mq,
>  
>  	return 0;
>   free_bounce_sg:
> - 	if (mq->bounce_sg)
> - 		kfree(mq->bounce_sg);
> +	kfree(mq->bounce_sg);
>   	mq->bounce_sg = NULL;
>   cleanup_queue:
> - 	if (mq->sg)
> -		kfree(mq->sg);
> +	kfree(mq->sg);
>  	mq->sg = NULL;
> -	if (mq->bounce_buf)
> -		kfree(mq->bounce_buf);
> +	kfree(mq->bounce_buf);
>  	mq->bounce_buf = NULL;
>  	blk_cleanup_queue(mq->queue);
>  	return ret;
> @@ -236,15 +233,13 @@ void mmc_cleanup_queue(struct mmc_queue
>  	blk_start_queue(q);
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  
> - 	if (mq->bounce_sg)
> - 		kfree(mq->bounce_sg);
> +	kfree(mq->bounce_sg);
>   	mq->bounce_sg = NULL;
>  
>  	kfree(mq->sg);
>  	mq->sg = NULL;
>  
> -	if (mq->bounce_buf)
> -		kfree(mq->bounce_buf);
> +	kfree(mq->bounce_buf);
>  	mq->bounce_buf = NULL;
>  
>  	mq->card = NULL;

