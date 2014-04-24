From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/38] mmc: sdio_irq: rework sdio irq handling
Date: Thu, 24 Apr 2014 09:46:16 +0100
Message-ID: <20140424084616.GE26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <E1Wd2Up-0003uJ-7k@rmk-PC.arm.linux.org.uk> <CAPDyKFpqJQ4pA6JEWjBwxbuoZ9HkiUAz89O_5YVVBaVh13XeMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:47196 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752715AbaDXIrI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 04:47:08 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpqJQ4pA6JEWjBwxbuoZ9HkiUAz89O_5YVVBaVh13XeMQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 24, 2014 at 09:58:55AM +0200, Ulf Hansson wrote:
> On 23 April 2014 21:06, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > +               if (!(host->caps2 & MMC_CAP2_SDIO_NOTHREAD)) {
> > +                       atomic_set(&host->sdio_irq_thread_abort, 0);
> > +                       host->sdio_irq_thread =
> > +                               kthread_run(sdio_irq_thread, host,
> > +                                           "ksdioirqd/%s", mmc_hostname(host));
> > +                       if (IS_ERR(host->sdio_irq_thread)) {
> > +                               int err = PTR_ERR(host->sdio_irq_thread);
> > +                               host->sdio_irqs--;
> > +                               return err;
> > +                       }
> > +               } else {
> 
> I suppose you need to check for MMC_CAP_SDIO_IRQ here?

Why would you set MMC_CAP2_SDIO_NOTHREAD if you didn't have MMC_CAP_SDIO_IRQ ?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
