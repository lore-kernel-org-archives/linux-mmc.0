From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] mmc: build fix: mmc_pm_notify is only available with
 CONFIG_PM=y
Date: Fri, 13 Aug 2010 13:01:07 +0300
Message-ID: <1281693667.4160.0.camel@maxim-laptop>
References: <1276809814-28683-1-git-send-email-maximlevitsky@gmail.com>
	 <1281691473-15481-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50223 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761390Ab0HMKB1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Aug 2010 06:01:27 -0400
In-Reply-To: <1281691473-15481-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2010-08-13 at 11:24 +0200, Uwe Kleine-K=C3=B6nig wrote:=20
> This fixes a build breakage introduced by
>=20
> 	4c2ef25 (mmc: fix all hangs related to mmc/sd card insert/removal du=
ring suspend/resume)
>=20
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: David Brownell <david-b@pacbell.net>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-mmc@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mmc/core/host.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 0efe631..d80cfdc 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct d=
evice *dev)
>  	init_waitqueue_head(&host->wq);
>  	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
>  	INIT_DELAYED_WORK_DEFERRABLE(&host->disable, mmc_host_deeper_disabl=
e);
> +#ifdef CONFIG_PM
>  	host->pm_notify.notifier_call =3D mmc_pm_notify;
> +#endif
> =20
>  	/*
>  	 * By default, hosts do not support SGIO or large requests.

Hi,

Sorry about that!

Best regards,
Maxim Levitsky

