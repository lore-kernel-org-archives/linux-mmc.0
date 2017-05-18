From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6 v2] mmc: core: Allocate per-request data using the
        block layer core
Date: Thu, 18 May 2017 11:32:39 +0200
Message-ID: <20170518093239.GA9250@lst.de>
References: <20170518092936.9277-1-linus.walleij@linaro.org> <20170518092936.9277-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57769 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754978AbdERJcq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 18 May 2017 05:32:46 -0400
Content-Disposition: inline
In-Reply-To: <20170518092936.9277-2-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>

Btw, you can also remove the struct request backpointer in
struct mmc_queue_req now - blk_mq_rq_from_pdu will do it for you
without the need for a pointer.
