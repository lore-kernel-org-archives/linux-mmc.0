From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: undefined reference to `mmc_pm_notify' when selected MMC
	without PM.
Date: Mon, 16 Aug 2010 07:17:21 +0200
Message-ID: <20100816051721.GA17903@pengutronix.de>
References: <009801cb3adb$6550e400$2ff2ac00$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36543 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab0HPFR2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 01:17:28 -0400
Content-Disposition: inline
In-Reply-To: <009801cb3adb$6550e400$2ff2ac00$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Andrew Morton' <akpm@linux-foundation.org>, 'Maxim Levitsky' <maximlevitsky@gmail.com>, ben-linux@fluff.org

Hello,

On Fri, Aug 13, 2010 at 08:33:40PM +0900, Kukjin Kim wrote:
> Kukjin Kim wrote:
> >=20
> > Hi,
> >=20
> > Following is build error when selected MMC without PM.
> >=20
> > drivers/built-in.o: In function `mmc_alloc_host':
> > drivers/mmc/core/host.c:108: undefined reference to `mmc_pm_notify'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > make: *** [sub-make] Error 2
> >=20
> > That is added from Maxim's ' mmc: fix all hangs related to mmc/sd c=
ard
> > insert/removal during suspend/resume '
> > (commit ID: 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e)
> >=20
> > Below is temporary patch for avoiding build error.
> > But I'm not sure about this... :-(
> >=20
> > ---
> >=20
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 0efe631..d80cfdc 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct=
 device
> > *dev)
> >         init_waitqueue_head(&host->wq);
> >         INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> >         INIT_DELAYED_WORK_DEFERRABLE(&host->disable,
> > mmc_host_deeper_disable);
> > +#ifdef CONFIG_PM
> >         host->pm_notify.notifier_call =3D mmc_pm_notify;
> > +#endif
> >=20
> >         /*
> >          * By default, hosts do not support SGIO or large requests.
> >=20
> > ---
>=20
> Kindly ignore this stuff because I found Uwe's same patch just now ;-=
)
> Sorry for bothering.
=46or those who care:

	http://mid.gmane.org/1281691473-15481-1-git-send-email-u.kleine-koenig=
@pengutronix.de

Kgene, do you care to ack this change as it may prod akpm in taking the
fix a bit earlier?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
