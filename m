From: Per Forlin <per.forlin@linaro.org>
Subject: Re: SDIO single IRQ optimization breaks libertas
Date: Mon, 30 May 2011 09:38:17 +0000 (UTC)
Message-ID: <loom.20110530T111921-497@post.gmane.org>
References: <BANLkTi=xWwWh2z2r3THvf5DzvhUCX_ZB7A@mail.gmail.com> <BANLkTi=Y3rq_xnq5m6wj97uHHi5+ZCpURQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55292 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab1E3JpN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 May 2011 05:45:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1QQz21-0005XQ-1m
	for linux-mmc@vger.kernel.org; Mon, 30 May 2011 11:45:07 +0200
Received: from 57.79.167.152 ([57.79.167.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 11:45:05 +0200
Received: from per.forlin by 57.79.167.152 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 11:45:05 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi Daniel,

> 
> On 29 May 2011 15:26, Daniel Drake <dsd <at> laptop.org> wrote:
> > Hi,
> >
> > The following commit in 2.6.39 causes instant death for libertas_sdio
> > when it receives its first interrupt during initialization:
> >
> > commit 06e8935febe687e2a561707d4c7ca4245d261dbe
> 
> The crash happens on this line of code in if_sdio_interrupt:
> 
> cause = sdio_readb(card->func, IF_SDIO_H_INT_STATUS, &ret);
> 
> card is NULL here
Thanks for you detailed report. It fails due to sdio_get_drvdata() returns NULL.

I am thinking of if the timing has changed due to this "single irq" patch or if
the functionality is broken.
To answer that I have a question on the if_sdio.c in libertas.

if_sdio.c
 sdio_claim_host();
 sdio_claim_irq()
 ...
 sdio_release_host()
 sdio_set_drvdata(func, card)
Just a sanity question, can the interrupt occur before sdio_set_drvdata()?

Do you get the same error if it looks like this.
if_sdio.c
 sdio_claim_host();
 sdio_set_drvdata(func, card)
 sdio_claim_irq()
 ...
 sdio_release_host()

Thanks,
Per


