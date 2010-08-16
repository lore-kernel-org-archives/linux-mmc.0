From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] mmc: build fix: mmc_pm_notify is only available with
 CONFIG_PM=y
Date: Mon, 16 Aug 2010 14:28:33 +0900
Message-ID: <003901cb3d03$ec038140$c40a83c0$%kim@samsung.com>
References: <1276809814-28683-1-git-send-email-maximlevitsky@gmail.com>
 <1281691473-15481-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38541 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab0HPF2o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 01:28:44 -0400
In-reply-to: <1281691473-15481-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?'Uwe_Kleine-K=C3=B6nig'?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Cc: 'Maxim Levitsky' <maximlevitsky@gmail.com>, 'David Brownell' <david-b@pacbell.net>, 'Alan Stern' <stern@rowland.harvard.edu>, linux-mmc@vger.kernel.org, 'Andrew Morton' <akpm@linux-foundation.org>

Uwe Kleine-Konig wrote:
>=20
> This fixes a build breakage introduced by
>=20
> 	4c2ef25 (mmc: fix all hangs related to mmc/sd card insert/removal du=
ring
> suspend/resume)
>=20
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: David Brownell <david-b@pacbell.net>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-mmc@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>  drivers/mmc/core/host.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 0efe631..d80cfdc 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct d=
evice
> *dev)
>  	init_waitqueue_head(&host->wq);
>  	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
>  	INIT_DELAYED_WORK_DEFERRABLE(&host->disable,
> mmc_host_deeper_disable);
> +#ifdef CONFIG_PM
>  	host->pm_notify.notifier_call =3D mmc_pm_notify;
> +#endif
>=20
>  	/*
>  	 * By default, hosts do not support SGIO or large requests.
> --
> 1.7.1
>=20

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

