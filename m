From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 0/2] sdio: make sdio_single_irq optional due to suprious
 IRQ
Date: Wed, 1 Jun 2011 10:29:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106011027580.30544@xanadu.home>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org> <BANLkTimRB8z16wjyH1fuXbiybQuaJL4Qug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44994 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab1FAO3e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 10:29:34 -0400
Received: by qwk3 with SMTP id 3so2607613qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2011 07:29:33 -0700 (PDT)
In-Reply-To: <BANLkTimRB8z16wjyH1fuXbiybQuaJL4Qug@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Per Forlin <per.forlin@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>

On Tue, 31 May 2011, Daniel Drake wrote:

> On 31 May 2011 21:33, Per Forlin <per.forlin@linaro.org> wrote:
> > Daniel Drake reported an issue in the libertas sdio client that was
> > triggered by the sdio_single_irq functionality. His SDIO device seems to
> > raise an interrupt even though there are no bits set in the CCCR_INTx
> > register. This behaviour is not supported by the sdio_single_irq feature nor
> > the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
> > overhead of checking the CCCR_INTx registers, this result in no error
> > handling of the case if there is a pending IRQ with none CCCR_INTx bits set.
> 
> Thanks a lot for diagnosing this and nice work on figuring out the
> root cause presumably without even having access to the hardware!
> 
> I've looked further, based on your findings, and have found that you
> are correct. During initialisation, exactly one interrupt is received
> with CCCR_INTx=0. Previously the mmc stack threw this interrupt away,
> after the optimization it now calls into libertas before it is ready
> to handle interrupts, leading to the crash. From that point, all other
> interrupts that come in are "normal".
> 
> This is definitely a weird hardware issue, and it would annoy me for
> this hardware to cause a second generic mmc layer feature be disabled
> by default! And actually it is not much work to harden up the libertas
> driver to be able to accept that spurious IRQ, and during the process
> of fixing that it actually made the spurious IRQ go away completely.
> 
> Patch attached.
> 
> So, I vote for that we work around this little hardware issue in the
> libertas driver, and leave this optimization enabled by default until
> we find a hardware issue that is more difficult to workaround. I can
> take on submission of the libertas patch.
> 
> Thoughts?

This is definitively the best approach.  Thanks for fixing the root 
cause.


Nicolas
