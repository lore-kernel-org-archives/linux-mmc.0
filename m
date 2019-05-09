From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in
 mmc_init_request
Date: Thu, 9 May 2019 12:42:34 -0600
Message-ID: <20190509184234.GA197434@google.com>
References: <20190508185833.187068-1-rrangel@chromium.org>
 <20190509060456.GA17096@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190509060456.GA17096@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, May 08, 2019 at 11:04:56PM -0700, Christoph Hellwig wrote:
> On Wed, May 08, 2019 at 12:58:32PM -0600, Raul E Rangel wrote:
> > It is possible for queuedata to be cleared in mmc_cleanup_queue before
> > the request has been started.
> 
> Errm.  I think we need to fix that problem instead of working around it.
So mmc_request_fn already has a null check, it was just missing on
mmc_init_request.

I could move `blk_cleanup_queue(q)` above `q->queuedata = NULL` and the
lock. So that would mean cherry-picking
https://lore.kernel.org/patchwork/patch/856512/ and then a patch with
moving blk_cleanup_queue.

Should I do that instead?

Thanks,
Raul
