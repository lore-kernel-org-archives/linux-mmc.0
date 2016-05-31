From: "Baranowska, BeataX" <beatax.baranowska@intel.com>
Subject: RE: [PATCH] mmc: sdhci: use udelay instead of mdelay
Date: Tue, 31 May 2016 09:38:26 +0000
Message-ID: <CC22646CC0522A488A20F7A66BFD619308D5FB@irsmsx105.ger.corp.intel.com>
References: <CC22646CC0522A488A20F7A66BFD619308D47B@irsmsx105.ger.corp.intel.com>
 <6616684.XTKejIxGbJ@wuerfel>
 <CC22646CC0522A488A20F7A66BFD619308D5D7@irsmsx105.ger.corp.intel.com>
 <5535547.CKl9RgC1aK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2815 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756877AbcEaJia convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2016 05:38:30 -0400
In-Reply-To: <5535547.CKl9RgC1aK@wuerfel>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Jarosz, SebastianX" <sebastianx.jarosz@intel.com>



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Tuesday, May 31, 2016 11:17 AM
> To: Baranowska, BeataX <beatax.baranowska@intel.com>
> Cc: Hunter, Adrian <adrian.hunter@intel.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Dong, Chuanxiao <chuanxiao.dong@intel.com>;
> Jarosz, SebastianX <sebastianx.jarosz@intel.com>
> Subject: Re: [PATCH] mmc: sdhci: use udelay instead of mdelay
> 
> On Tuesday, May 31, 2016 8:53:18 AM CEST Baranowska, BeataX wrote:
> > >
> > > On Monday, May 30, 2016 7:55:55 AM CEST Baranowska, BeataX wrote:
> > > > From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > > >
> > > > This patch will use udelay instead of mdelay when waiting for
> > > > SDHCI hardware to be stable. udelay can help to reduce the waiting
> > > > time when is in critical region which is protected by spinlock.
> > > >
> > > > With this patch, __sdhci_set_ios only take a few microseconds to
> > > > be done.
> > > >
> > > > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > > > ---
> > > > drivers/mmc/host/sdhci.c | 18 +++++++++---------
> > > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > > index
> > > > e010ea4eb6f5..56d2c7567d97 100644
> > > > --- a/drivers/mmc/host/sdhci.c
> > > > +++ b/drivers/mmc/host/sdhci.c
> > > > @@ -173,8 +173,8 @@ void sdhci_reset(struct sdhci_host *host, u8
> mask)
> > > >                         sdhci_runtime_pm_bus_off(host);
> > > >         }
> > > >
> > > > -       /* Wait max 100 ms */
> > > > -       timeout = 100;
> > > > +       /* Wait max 10000 ms */
> > > > +       timeout = 10000;
> > > >
> > > >         /* hw clears the bit when it's done */
> > > >         while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> > > > @@
> > > > -185,7 +185,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
> > > >                         return;
> > > >                 }
> > > >                 timeout--;
> > > > -               mdelay(1);
> > > > +               udelay(10);
> > > >         }
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(sdhci_reset);
> > >
> > > This can significantly increase the timeout length. I think you
> > > should instead use time_before() to see how many jiffies have passed
> since the start.
> > >
> > > However, the real question is why the reset function gets called
> > > under a spinlock in the first place. Can you try to rearrange the
> > > code so it doesn't need the lock at all and you can just use msleep()
> instead?
> > >
> > >       Arnd
> >
> > Thank you for your quick reply.
> > Could you please clarify what do you mean is called under a spinlock?
> > Any is not used here?
> 
> You write that the function is called in a critical region protected by the
> spinlock, so I was wondering if that is actually necessary.
> 
> Usually a device reset should be done in normal process context without any
> spinlocks so you can call normal sleeping functions.
> 
> 	Arnd

Ok I understand now. Thank you.

Beata Baranowska
