From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: undefined reference to `mmc_pm_notify' when selected MMC
	without PM.
Date: Mon, 16 Aug 2010 08:12:39 -0700
Message-ID: <20100816081239.c5ae02ef.randy.dunlap@oracle.com>
References: <009801cb3adb$6550e400$2ff2ac00$%kim@samsung.com>
	<20100816051721.GA17903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100816051721.GA17903@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, 'Maxim Levitsky' <maximlevitsky@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, 'Andrew Morton' <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 16 Aug 2010 07:17:21 +0200 Uwe Kleine-K=F6nig wrote:

> Hello,
> =

> On Fri, Aug 13, 2010 at 08:33:40PM +0900, Kukjin Kim wrote:
> > Kukjin Kim wrote:
> > > =

> > > Hi,
> > > =

> > > Following is build error when selected MMC without PM.
> > > =

> > > drivers/built-in.o: In function `mmc_alloc_host':
> > > drivers/mmc/core/host.c:108: undefined reference to `mmc_pm_notify'
> > > make[1]: *** [.tmp_vmlinux1] Error 1
> > > make: *** [sub-make] Error 2
> > > =

> > > That is added from Maxim's ' mmc: fix all hangs related to mmc/sd card
> > > insert/removal during suspend/resume '
> > > (commit ID: 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e)
> > > =

> > > Below is temporary patch for avoiding build error.
> > > But I'm not sure about this... :-(
> > > =

> > > ---
> > > =

> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > index 0efe631..d80cfdc 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct d=
evice
> > > *dev)
> > >         init_waitqueue_head(&host->wq);
> > >         INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> > >         INIT_DELAYED_WORK_DEFERRABLE(&host->disable,
> > > mmc_host_deeper_disable);
> > > +#ifdef CONFIG_PM
> > >         host->pm_notify.notifier_call =3D mmc_pm_notify;
> > > +#endif
> > > =

> > >         /*
> > >          * By default, hosts do not support SGIO or large requests.
> > > =

> > > ---
> > =

> > Kindly ignore this stuff because I found Uwe's same patch just now ;-)
> > Sorry for bothering.
> For those who care:
> =

> 	http://mid.gmane.org/1281691473-15481-1-git-send-email-u.kleine-koenig@p=
engutronix.de
> =

> Kgene, do you care to ack this change as it may prod akpm in taking the
> fix a bit earlier?

or this one from earlier:
http://lkml.org/lkml/2010/8/12/207

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
