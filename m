From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 06/16] mmc: core: replace waitqueue with worker
Date: Wed, 22 Feb 2017 15:29:29 +0200
Message-ID: <00989e26-cdb9-48d7-2e46-ae6ef66e59a7@intel.com>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-7-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28689 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932481AbdBVNe4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 22 Feb 2017 08:34:56 -0500
In-Reply-To: <20170209153403.9730-7-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>

On 09/02/17 17:33, Linus Walleij wrote:
> The waitqueue in the host context is there to signal back from
> mmc_request_done() through mmc_wait_data_done() that the hardware
> is done with a command, and when the wait is over, the core
> will typically submit the next asynchronous request that is pending
> just waiting for the hardware to be available.
> 
> This is in the way for letting the mmc_request_done() trigger the
> report up to the block layer that a block request is finished.
> 
> Re-jig this as a first step, remvoving the waitqueue and introducing
> a work that will run after a completed asynchronous request,
> finalizing that request, including retransmissions, and eventually
> reporting back with a completion and a status code to the
> asynchronous issue method.
> 
> This had the upside that we can remove the MMC_BLK_NEW_REQUEST
> status code and the "new_request" state in the request queue
> that is only there to make the state machine spin out
> the first time we send a request.
> 
> Introduce a workqueue in the host for handling just this, and
> then a work and completion in the asynchronous request to deal
> with this mechanism.
> 
> This is a central change that let us do many other changes since
> we have broken the submit and complete code paths in two, and we
> can potentially remove the NULL flushing of the asynchronous
> pipeline and report block requests as finished directly from
> the worker.

This needs more thought.  The completion should go straight to the mmc block
driver from the ->done() callback.  And from there straight back to the
block layer if recovery is not needed.  We want to stop using
mmc_start_areq() altogether because we never want to wait - we always want
to issue (if possible) and return.

The core API to use is __mmc_start_req() but the block driver should
populate mrq->done with its own handler. i.e. change __mmc_start_req()

-	mrq->done = mmc_wait_done;
+	if (!mrq->done)
+		mrq->done = mmc_wait_done;

mrq->done() would complete the request (e.g. via blk_complete_request()) if
it has no errors (and doesn't need polling), and wake up the queue thread to
finish up everything else and start the next request.

For the blk-mq port, the queue thread should also be retained, partly
because it solves some synchronization problems, but mostly because, at this
stage, we anyway don't have solutions for all the different ways the driver
can block.
(as listed here https://marc.info/?l=linux-mmc&m=148336571720463&w=2 )

