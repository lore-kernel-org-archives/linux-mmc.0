From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA error on tx channel
Date: Thu, 06 Apr 2017 08:42:18 +0200
Message-ID: <87shlmf35h.fsf@belgarion.home>
References: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz>
        <877f3zwwgo.fsf@belgarion.home>
        <feb39d00-d40d-f935-751c-8119f40b4df4@tul.cz>
        <871stzh8bx.fsf@belgarion.home>
        <ab2c9dcb-1718-46da-2f31-1f4721719b01@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:36576 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932295AbdDFGm0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Apr 2017 02:42:26 -0400
In-Reply-To: <ab2c9dcb-1718-46da-2f31-1f4721719b01@tul.cz> (Petr Cvek's
        message of "Sun, 26 Mar 2017 04:43:18 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: vinod.koul@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

Hi Petr,

Sorry I was on holidays away from computers.

> I think I was able to finally find the problem with the PXA MCI and DMA. It
> seems to be a problem with a race condition with vchan_complete() tasklet.
I completely agree with this analysis.

... zip the analysis, good catch ...

> Solution:
>
> I commented the error handling parts of the callback function and the driver
> works, but it is only for the testing purposes, there can be a partially
> filled FIFO (BUF_PART_FULL) which will not be handled. Problem is the driver
> won't wait on the completion before starting a new transmission. But this
> waiting on completion will probably slow down the MMC communication :-/.
I has to, the PXA can handle only one request at a time.

> The best thing would be to handle the partial buffer somewhere else and get
> rid of the callback completely. If it is possible, probably not as I assume
> the partially filled buffer will not create pxamci interrupt? In the other
> case then maybe in pxamci_data_done()?
That looks a bit over complicated, but you can try to send a patch for this.
I would try a simpler road if I were you :
 - in pxamci_irq()
 - call pxamci_data_done() _only_ in the error case or if host->data = NULL,
 ie. if "stat" states that the transfer was in error or the transfer is without
 data.

Either way you choose, pxamci_data_done() should only be called once per
transfer, and this is the fix you're aiming at.

Actually the title might be amended, as the bug is not as much in the dmaengine
driver as in the pxamci driver. I was thinking that 6464b7140951 ("mmc: pxamci:
switch over to dmaengine use") had broken it, but it looks to me the same
pattern was there, but without a tasklet, and the bug didn't occurr because of
the fast dma interrupt handling.

Cheers.

-- 
Robert
