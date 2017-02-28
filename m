From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 01/16] mmc: core: move some code in mmc_start_areq()
Date: Tue, 28 Feb 2017 15:55:04 +0100
Message-ID: <1836181.4AbMozTzyb@amdc3058>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-2-linus.walleij@linaro.org>
 <CGME20170228145506epcas1p1dd72cc5738c3f36df97ac06603ad2731@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42994 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdB1O5T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2017 09:57:19 -0500
In-reply-to: <20170209153403.9730-2-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>


On Thursday, February 09, 2017 04:33:48 PM Linus Walleij wrote:
> "previous" is a better name for the variable storing the previous
> asynchronous request, better than the opaque name "data" atleast.
> We see that we assign the return status to the returned variable
> on all code paths, so we might as well just do that immediately
> after calling mmc_finalize_areq().
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

