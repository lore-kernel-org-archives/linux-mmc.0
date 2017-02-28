From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 14/16] mmc: queue: get/put struct mmc_queue_req
Date: Tue, 28 Feb 2017 19:21:47 +0100
Message-ID: <5050667.2Ad8qcsgns@amdc3058>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-15-linus.walleij@linaro.org>
 <CGME20170228182149epcas1p28789bce5433cee1579e8b8d083ba5811@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-block-owner@vger.kernel.org>
In-reply-to: <20170209153403.9730-15-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On Thursday, February 09, 2017 04:34:01 PM Linus Walleij wrote:
> The per-hardware-transaction struct mmc_queue_req is assigned
> from a pool of 2 requests using a current/previous scheme and
> then swapped around.
> 
> This is confusing, especially if we need more than two to make
> our work efficient and parallel.
> 
> Rewrite the mechanism to have a pool of struct mmc_queue_req
> and take one when we need one and put it back when we don't
> need it anymore.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
