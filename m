From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci: use udelay instead of mdelay
Date: Tue, 31 May 2016 11:16:56 +0200
Message-ID: <5535547.CKl9RgC1aK@wuerfel>
References: <CC22646CC0522A488A20F7A66BFD619308D47B@irsmsx105.ger.corp.intel.com> <6616684.XTKejIxGbJ@wuerfel> <CC22646CC0522A488A20F7A66BFD619308D5D7@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CC22646CC0522A488A20F7A66BFD619308D5D7@irsmsx105.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Baranowska, BeataX" <beatax.baranowska@intel.com>
Cc: "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Jarosz, SebastianX" <sebastianx.jarosz@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Tuesday, May 31, 2016 8:53:18 AM CEST Baranowska, BeataX wrote:
> > 
> > On Monday, May 30, 2016 7:55:55 AM CEST Baranowska, BeataX wrote:
> > > From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > >
> > > This patch will use udelay instead of mdelay when waiting for SDHCI
> > > hardware to be stable. udelay can help to reduce the waiting time when
> > > is in critical region which is protected by spinlock.
> > >
> > > With this patch, __sdhci_set_ios only take a few microseconds to be
> > > done.
> > >
> > > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > > ---
> > > drivers/mmc/host/sdhci.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> > > e010ea4eb6f5..56d2c7567d97 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -173,8 +173,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
> > >                         sdhci_runtime_pm_bus_off(host);
> > >         }
> > >
> > > -       /* Wait max 100 ms */
> > > -       timeout = 100;
> > > +       /* Wait max 10000 ms */
> > > +       timeout = 10000;
> > >
> > >         /* hw clears the bit when it's done */
> > >         while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) { @@
> > > -185,7 +185,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
> > >                         return;
> > >                 }
> > >                 timeout--;
> > > -               mdelay(1);
> > > +               udelay(10);
> > >         }
> > >  }
> > >  EXPORT_SYMBOL_GPL(sdhci_reset);
> > 
> > This can significantly increase the timeout length. I think you should instead
> > use time_before() to see how many jiffies have passed since the start.
> > 
> > However, the real question is why the reset function gets called under a
> > spinlock in the first place. Can you try to rearrange the code so it doesn't
> > need the lock at all and you can just use msleep() instead?
> > 
> >       Arnd
> 
> Thank you for your quick reply.
> Could you please clarify what do you mean is called under a spinlock?
> Any is not used here?

You write that the function is called in a critical region protected
by the spinlock, so I was wondering if that is actually necessary.

Usually a device reset should be done in normal process context without
any spinlocks so you can call normal sleeping functions.

	Arnd
