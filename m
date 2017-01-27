From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] mmc: core/mmci: restore pre/post_req behaviour
Date: Fri, 27 Jan 2017 14:44:32 +0000
Message-ID: <1f63461b-e4c0-93fb-f30f-73147c72e33b@linaro.org>
References: <20170127140454.7990-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35020 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754814AbdA0Oof (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jan 2017 09:44:35 -0500
Received: by mail-wm0-f43.google.com with SMTP id r126so120206623wmr.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jan 2017 06:44:34 -0800 (PST)
In-Reply-To: <20170127140454.7990-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>



On 27/01/17 14:04, Linus Walleij wrote:
> commit 64b12a68a9f74bb32d8efd7af1ad8a2ba02fc884
> "mmc: core: fix prepared requests while doing bkops"
> is fixing a bug in the wrong way. A bug in the MMCI
> device driver is fixed by amending the MMC core.
>
> Thinking about it: what the pre- and post-callbacks
> are doing is to essentially map and unmap SG lists
> for DMA transfers. Why would we not be able to do that
> just because a BKOPS command is sent inbetween?
> Having to unprepare/prepare the next asynchronous
> request for DMA seems wrong.
>
> Looking the backtrace in that commit we can see what
> the real problem actually is:
>
> mmci_data_irq() is calling mmci_dma_unmap() twice
> which is goung to call arm_dma_unmap_sg() twice
> and v7_dma_inv_range() twice for the same sglist
> and that will crash.
>
> This happens because a request is prepared, then
> a BKOPS is sent. The IRQ completing the BKOPS command
> goes through mmci_data_irq() and thinks that a DMA
> operation has just been completed because
> dma_inprogress() reports true. It then proceeds to
> unmap the sglist.
>
> But that was wrong! dma_inprogress() should NOT be
> true because no DMA was actually in progress! We had
> just prepared the sglist, and the DMA channel
> dma_current has been configured, but NOT started!
>
> Because of this, the sglist is already unmapped when
> we get our actual data completion IRQ, and we are
> unmapping the sglist once more, and we get this crash.
>
> Therefore, we need to revert this solution pushing
> the problem to the core and causing problems, and
> instead augment the implementation such that
> dma_inprogress() only reports true if some DMA has
> actually been started.
>
> After this we can keep the request prepared during the
> BKOPS and we need not unprepare/reprepare it.

Thanks for detailed explanation and fixing it properly.

Tested it on IFC6410.

>
> Fixes: 64b12a68a9f7 ("mmc: core: fix prepared requests while doing bkops")
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
