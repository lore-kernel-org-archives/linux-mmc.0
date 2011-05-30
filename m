From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: SDIO single IRQ optimization breaks libertas
Date: Mon, 30 May 2011 10:38:56 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1105301028310.30544@xanadu.home>
References: <BANLkTi=xWwWh2z2r3THvf5DzvhUCX_ZB7A@mail.gmail.com> <BANLkTi=Y3rq_xnq5m6wj97uHHi5+ZCpURQ@mail.gmail.com> <loom.20110530T111921-497@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55998 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653Ab1E3OjB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 10:39:01 -0400
Received: by qwk3 with SMTP id 3so1698307qwk.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 07:39:00 -0700 (PDT)
In-Reply-To: <loom.20110530T111921-497@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org

On Mon, 30 May 2011, Per Forlin wrote:

> Hi Daniel,
> 
> > 
> > On 29 May 2011 15:26, Daniel Drake <dsd <at> laptop.org> wrote:
> > > Hi,
> > >
> > > The following commit in 2.6.39 causes instant death for libertas_sdio
> > > when it receives its first interrupt during initialization:
> > >
> > > commit 06e8935febe687e2a561707d4c7ca4245d261dbe
> > 
> > The crash happens on this line of code in if_sdio_interrupt:
> > 
> > cause = sdio_readb(card->func, IF_SDIO_H_INT_STATUS, &ret);
> > 
> > card is NULL here
> Thanks for you detailed report. It fails due to sdio_get_drvdata() returns NULL.
> 
> I am thinking of if the timing has changed due to this "single irq" patch or if
> the functionality is broken.
> To answer that I have a question on the if_sdio.c in libertas.
> 
> if_sdio.c
>  sdio_claim_host();
>  sdio_claim_irq()
>  ...
>  sdio_release_host()
>  sdio_set_drvdata(func, card)

This looks wrong to me.  the driver must be ready to receive interrupts 
the moment it registers for it, or make sure the hardware is not 
generating any.

> Just a sanity question, can the interrupt occur before sdio_set_drvdata()?

What might be happening here is that for some reasons the card is 
asserting the interrupt line, but none of the function bits in CCCR_INTx 
is set.


Nicolas
