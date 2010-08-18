From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: undefined reference to `mmc_pm_notify' when selected MMC
	without PM.
Date: Wed, 18 Aug 2010 08:38:12 +0200
Message-ID: <20100818063812.GC16956@pengutronix.de>
References: <009801cb3adb$6550e400$2ff2ac00$%kim@samsung.com> <20100816051721.GA17903@pengutronix.de> <20100816081239.c5ae02ef.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40364 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab0HRGiU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2010 02:38:20 -0400
Content-Disposition: inline
In-Reply-To: <20100816081239.c5ae02ef.randy.dunlap@oracle.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, 'Maxim Levitsky' <maximlevitsky@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, 'Andrew Morton' <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

Hello Randy,

On Mon, Aug 16, 2010 at 08:12:39AM -0700, Randy Dunlap wrote:
> On Mon, 16 Aug 2010 07:17:21 +0200 Uwe Kleine-K=F6nig wrote:
>=20
> > Hello,
> >=20
> > On Fri, Aug 13, 2010 at 08:33:40PM +0900, Kukjin Kim wrote:
> > > Kukjin Kim wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > Following is build error when selected MMC without PM.
> > > >=20
> > > > drivers/built-in.o: In function `mmc_alloc_host':
> > > > drivers/mmc/core/host.c:108: undefined reference to `mmc_pm_not=
ify'
> > > > make[1]: *** [.tmp_vmlinux1] Error 1
> > > > make: *** [sub-make] Error 2
> > > >=20
> > > > That is added from Maxim's ' mmc: fix all hangs related to mmc/=
sd card
> > > > insert/removal during suspend/resume '
> > > > (commit ID: 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e)
> > > >=20
> > > > Below is temporary patch for avoiding build error.
> > > > But I'm not sure about this... :-(
> > > >=20
> > > > ---
> > > >=20
> > > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > > index 0efe631..d80cfdc 100644
> > > > --- a/drivers/mmc/core/host.c
> > > > +++ b/drivers/mmc/core/host.c
> > > > @@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extra, st=
ruct device
> > > > *dev)
> > > >         init_waitqueue_head(&host->wq);
> > > >         INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> > > >         INIT_DELAYED_WORK_DEFERRABLE(&host->disable,
> > > > mmc_host_deeper_disable);
> > > > +#ifdef CONFIG_PM
> > > >         host->pm_notify.notifier_call =3D mmc_pm_notify;
> > > > +#endif
> > > >=20
> > > >         /*
> > > >          * By default, hosts do not support SGIO or large reque=
sts.
> > > >=20
> > > > ---
> > >=20
> > > Kindly ignore this stuff because I found Uwe's same patch just no=
w ;-)
> > > Sorry for bothering.
> > For those who care:
> >=20
> > 	http://mid.gmane.org/1281691473-15481-1-git-send-email-u.kleine-ko=
enig@pengutronix.de
> >=20
> > Kgene, do you care to ack this change as it may prod akpm in taking=
 the
> > fix a bit earlier?
>=20
> or this one from earlier:
> http://lkml.org/lkml/2010/8/12/207

If I found your patch on gmane I could answer it with an Ack, on lkml
and kerneltrap (where I found it) I don't get the Message-Id header.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
