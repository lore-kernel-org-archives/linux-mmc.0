From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] mmc: build fix: mmc_pm_notify is only available with
 CONFIG_PM=y
Date: Mon, 16 Aug 2010 10:51:11 +0300
Message-ID: <1281945071.3449.4.camel@maxim-laptop>
References: <1276809814-28683-1-git-send-email-maximlevitsky@gmail.com>
	 <1281691473-15481-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <1281693667.4160.0.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38354 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab0HPHvT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 03:51:19 -0400
In-Reply-To: <1281693667.4160.0.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2010-08-13 at 13:01 +0300, Maxim Levitsky wrote:=20
> On Fri, 2010-08-13 at 11:24 +0200, Uwe Kleine-K=C3=B6nig wrote:=20
> > This fixes a build breakage introduced by
> >=20
> > 	4c2ef25 (mmc: fix all hangs related to mmc/sd card insert/removal =
during suspend/resume)
> >=20
> > Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> > Cc: David Brownell <david-b@pacbell.net>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: linux-mmc@vger.kernel.org
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
> > ---
> >  drivers/mmc/core/host.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 0efe631..d80cfdc 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct=
 device *dev)
> >  	init_waitqueue_head(&host->wq);
> >  	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> >  	INIT_DELAYED_WORK_DEFERRABLE(&host->disable, mmc_host_deeper_disa=
ble);
> > +#ifdef CONFIG_PM
> >  	host->pm_notify.notifier_call =3D mmc_pm_notify;
> > +#endif
> > =20
> >  	/*
> >  	 * By default, hosts do not support SGIO or large requests.
>=20
> Hi,
>=20
> Sorry about that!


Hi folks,

Sorry again for this bug.
>From now on I will test compilation rigorously.=20

If you need it,
Acked-by: Maxim Levitsky <maximlevitsky@gmail.com>

Best regards,
Maxim Levitsky

