From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 03/16] mmc: core: refactor mmc_request_done()
Date: Tue, 28 Feb 2017 15:56:26 +0100
Message-ID: <24010300.RcWSA2N5Oi@amdc3058>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-4-linus.walleij@linaro.org>
 <CGME20170228145627epcas1p18fb6390b7ae14a6961fac9703712e0a0@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-block-owner@vger.kernel.org>
In-reply-to: <20170209153403.9730-4-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org


On Thursday, February 09, 2017 04:33:50 PM Linus Walleij wrote:
> We have this construction:
> 
> if (a && b && !c)
>    finalize;
> else
>    block;
>    finalize;
> 
> Which is equivalent by boolean logic to:
> 
> if (!a || !b || c)
>    block;
> finalize;
> 
> Which is simpler code.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
