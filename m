From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: Question: kick SDIO irq when resume
Date: Mon, 31 Oct 2011 17:33:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110311534180.3307@xanadu.home>
References: <CAGA24MKE-FLRBk2zHk_Wy2Apg8-epC6Q38W2csTs7YSN1gHzhg@mail.gmail.com> <alpine.LFD.2.02.1110310824120.3307@xanadu.home> <CAGA24MLv9Z8USwCeGdKgW06Fdz7b55qyS-m03hVHkun-7i0TFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-873541506-1320089624=:3307"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45114 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab1JaVdT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2011 17:33:19 -0400
Received: by vws1 with SMTP id 1so5279382vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 31 Oct 2011 14:33:18 -0700 (PDT)
In-Reply-To: <CAGA24MLv9Z8USwCeGdKgW06Fdz7b55qyS-m03hVHkun-7i0TFA@mail.gmail.com>
Content-ID: <alpine.LFD.2.02.1110311732540.3307@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <niej0001@gmail.com>
Cc: Bing Zhao <bzhao@marvell.com>, frankh@marvell.com, yongd@marvell.com, tianfh@marvell.com, njun@marvell.com, linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-873541506-1320089624=:3307
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LFD.2.02.1110311732541.3307@xanadu.home>

On Mon, 31 Oct 2011, Jun Nie wrote:

> 2011/10/31 Nicolas Pitre <nicolas.pitre@linaro.org>:
> > On Mon, 31 Oct 2011, Jun Nie wrote:
> >
> >> Hi Nico,
> >>     We are debugging fake SDIO irq when 8787 SDIO card resume and
> >> found below patch. The issue is that 8787 driver can not handle card
> >> irq if neither 8787 nor host trigger resume event in some cases. Do
> >> you remember what SDIO card need below patch? What's your idea on this
> >> issue? How about add a SDIO function flag to decide the irq thread
> >> kick off in resume?
> >
> > This is needed because in some cases the card interrupt is already
> > consumed for the wake-up event.  Kicking this thread shouldn't cause any
> > issue though, as the card is just polled for the actual presence of an
> > IRQ ...
> >
> > ... or maybe not.  In this case commit 06e8935feb "optimized SDIO IRQ
> > handling for single irq" may certainly cause problems.
> >
> > The fix here would be to clear card->sdio_single_irq before calling
> > mmc_signal_sdio_irq() in mmc_sdio_resume() and restore its original
> > value eventually, or better yet ignore that flag when the IRQ thread is
> > ran for the first time after a resume.
> 8787 case(bug) is similar with sdio_signel_irq case, but not same.
> 8787 can not response to reading sdio card interrupt status correctly
> if 8787 is still in suspend mode. The read operation will get value of
> previous CMD52 read, no matter previous CMD52 is for what purpose. So
> host should avoid read from 8787 before call sdio function resume in
> normal resume process. Otherwise, 8787 may lead lead host to handle
> fake interrupt and result further error.
> >
> > In any case you may disable that optimization in the IRQ demux handler
> > to see if this fixes your problem.
> So the fix to 8787 is either adding a flag, such as NO_LOST_WAKEUP_IRQ
> for func/card, or moving kick off to after sdio function resume. I do
> not know which one you prefer.

Moving the kick-off after the resume will be a good thing, and it should 
also be conditional on the presence of CCCR_INTx being non zero.



Nicolas
--8323328-873541506-1320089624=:3307--
