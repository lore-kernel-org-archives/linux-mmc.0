From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 1/5] mmc: renesas-sdhi, tmio: make dma more modular
Date: Tue, 2 May 2017 15:03:11 +0200
Message-ID: <20170502130311.GA3518@verge.net.au>
References: <1493723743-22821-1-git-send-email-horms+renesas@verge.net.au>
 <1493723743-22821-2-git-send-email-horms+renesas@verge.net.au>
 <CAK8P3a2RDm-ithQizfrZotFWkg9N8mrw-723jt7A=V7f-oKJQw@mail.gmail.com>
 <20170502125721.GA3160@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58168 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdEBNDR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 May 2017 09:03:17 -0400
Content-Disposition: inline
In-Reply-To: <20170502125721.GA3160@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, May 02, 2017 at 02:57:23PM +0200, Simon Horman wrote:
> On Tue, May 02, 2017 at 02:01:28PM +0200, Arnd Bergmann wrote:
> > On Tue, May 2, 2017 at 1:15 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > 
> > > @@ -202,6 +214,15 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
> > >  void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
> > >  irqreturn_t tmio_mmc_irq(int irq, void *devid);
> > >
> > > +#if IS_ENABLED(CONFIG_MMC_SDHI)
> > > +const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void);
> > > +#else
> > > +static inline const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void)
> > > +{
> > > +       return NULL;
> > > +}
> > > +#endif
> > > +
> > >  static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
> > >                                          unsigned long *flags)
> > >  {
> > 
> > Here you return a NULL pointer for the operations structure
> > 
> > > +
> > > +static inline void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
> > > +{
> > > +       if (host->dma_ops->enable)
> > > +               host->dma_ops->enable(host, enable);
> > > +}
> > >
> > 
> > And here you check the ->enable callback but not the dma_ops pointer.
> > In the other callbacks you check the dma_ops pointer but not the callback.
> > Is that intentional? Maybe always check the dma_ops pointer first for
> > consistency, as a NULL operations structure (resulting from a future bug)
> > might lead running user space with kernel privileges.
> 
> Thanks for noticing.
> 
> I resolved that problem but it seems to have crept back in again.
> I'll check to see how that happened.

I take back my comment above - I fixed a different problem and it looks
like I sent out the latest local patches (phew!).

Regardless, I'll look into the problem you mention with a view to fixing it
in v2.
