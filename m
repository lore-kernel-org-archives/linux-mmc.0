From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 05/16] mmc: core: add a kthread for completing requests
Date: Tue, 28 Feb 2017 15:57:17 +0100
Message-ID: <2092930.gXijKn7316@amdc3058>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-6-linus.walleij@linaro.org>
 <CGME20170228145719epcas5p33d013fd48483bfba477b3f607dcdccb4@epcas5p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42994 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbdB1O6M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2017 09:58:12 -0500
In-reply-to: <20170209153403.9730-6-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>


On Thursday, February 09, 2017 04:33:52 PM Linus Walleij wrote:
> As we want to complete requests autonomously from feeding the
> host with new requests, we create a worker thread to deal with
> this specifically in response to the callback from a host driver.
> 
> This patch just adds the worker, later patches will make use of
> it.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

