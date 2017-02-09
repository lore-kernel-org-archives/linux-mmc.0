From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/16] multiqueue for MMC/SD third try
Date: Thu, 9 Feb 2017 16:39:18 +0100
Message-ID: <20170209153918.GA16084@lst.de>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

> What immediately jumps out at you is that linear read/writes
> perform just as nicely or actually better with MQ than with the
> old block layer.
> 
> What is amazing is that just a little randomness, such as the
> find . > /dev/null immediately seems to visibly regress with MQ.
> My best guess is that it is caused by the absence of the block
> scheduler.

The block tree now has a basic deadline scheduler.  So for now I'd
suggest to kick off the discussion on all these prep patches,
and then retest with 4.11-rc1 or 2 that will have the scheduler.
