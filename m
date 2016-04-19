From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Wed, 20 Apr 2016 01:57:08 +0200
Message-ID: <3904622.mKVlLT0JKv@wuerfel>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <37975265.p6gUi9hTMt@wuerfel> <5716BEC7.5000706@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:61188 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbcDSX5d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 19:57:33 -0400
In-Reply-To: <5716BEC7.5000706@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

On Tuesday 19 April 2016 16:27:03 David Daney wrote:
> The way the MMC driver works is that the driver's .request() method is 
> called to initiate a request.   After .request() is finished, it returns 
> back to the kernel so other work can be done.
> 
>  From the interrupt handler, when the request is complete, the interrupt 
> handler calls req->done(req); to terminate the whole thing.
> 
> 
>    So we have:
> 
>    CPU-A                      CPU-B                  CPU-C
> 
>    octeon_mmc_request(0)        .                     .
>       down()                    .                     .
>       queue_request(0);         .                     .
>       return;                   .                     .
>    other_useful_work            .                     .
>     .                           .                     .
>     .                           .                     .
>     .                           .                     .
>    octeon_mmc_request(1)        .                     .
>       down() -> blocks          .                     .
>                              octeon_mmc_interrupt()   .
>                                  up() -> unblocks     .
>       down() <-unblocks          req->done(0)         .
>       queue_request(1);          return;              .
>       return;                   .                     .
>    other_useful_work            .                     .
>     .                           .                octeon_mmc_interrupt()
>     .                           .                     up()
>     .                           .                     req->done(1)
>     .                           .                     return;
>     .                           .                     .
> 
> 
> We don't want to have the thread on CPU-A wait around in an extra mutex 
> or completion for the command to finish.  The MMC core already has its 
> own request waiting code, but it doesn't handle the concept of a slot. 
> These commands can take hundreds or thousands of mS to terminate.  The 
> whole idea of the MMC framework is to queue the request and get back to 
> doing other work ASAP.

Right. This usecase seems to be one of the few that legitimately use
semaphores. However, there has been a long effort to eliminate the
remaining semaphores from the kernel (mostly much stalled since 2.6.32,
but we still try to prevent new ones from creeping in).

I had at one point a patch series that removed all the remaining
semaphores, but didn't get it merged at the time, and now there
are a few dozen new users.

> In the case of this octeon_mmc driver we need to serialize the commands 
> issued to multiple slots, for this we use the semaphore.  If you don't 
> like struct semaphore, we would have to invent a proprietary wait queue 
> mechanism that has semantics nearly identical to struct semaphore, and 
> people would complain that we are reinventing the semaphore.
> 
> It doesn't seem clean to cobble up multiple waiting structures 
> (completion + mutex + logic that surely would contain errors) where a 
> single (well debugged) struct semaphore does what we want.

I think using a wait_event() call could make do this with basically
the same amount of code and by naming it right, this could be just
as expressive. For the usecase you describe, a single completion
structure would actually serve the purpose as well (no need for the
mutex), but it would be unusual to wait for the completion before
starting the work.

If you do this

	wait_event(&host->wq, !host->current_req);

in the request function as well as 

	wake_up(&host->wq);

after setting host->current_req to NULL, I think you end up with
the same level of readability as the semaphore, and slightly
better object code, and you can drop the 'WARN_ON(host->current_req);'
which would be known to be impossible.

	Arnd
