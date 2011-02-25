From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2 2/3] mmc: cb710: Return err value in
	cb710_wait_while_busy()
Date: Fri, 25 Feb 2011 19:22:23 +0100
Message-ID: <20110225182223.GB26137@rere.qmqm.pl>
References: <1298500153-28081-1-git-send-email-cjb@laptop.org> <1298500153-28081-2-git-send-email-cjb@laptop.org> <20110223230309.GB15104@pengutronix.de> <20110223231743.GA30908@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:37057 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932601Ab1BYSWZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Feb 2011 13:22:25 -0500
Content-Disposition: inline
In-Reply-To: <20110223231743.GA30908@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

On Wed, Feb 23, 2011 at 11:17:43PM +0000, Chris Ball wrote:
> Fixes:
>=20
> drivers/mmc/host/cb710-mmc.c: In function =E2=80=98cb710_wait_while_b=
usy=E2=80=99:
> drivers/mmc/host/cb710-mmc.c:182:6: warning: variable =E2=80=98err=E2=
=80=99 set but not
> used [-Wunused-but-set-variable]
>=20
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
> Hi Wolfram,
>=20
> > What about changing return 0 into return err? It gets checked in
> > cb710_mmc_powerup().
>=20
> Thanks, good idea.
>=20
> - Chris.
>=20
>  drivers/mmc/host/cb710-mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mm=
c.c
> index 66b4ce5..ce2a47b 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -205,7 +205,7 @@ static int cb710_wait_while_busy(struct cb710_slo=
t *slot, uint8_t mask)
>  			"WAIT12: waited %d loops, mask %02X, entry val %08X, exit val %08=
X\n",
>  			limit, mask, e, x);
>  #endif
> -	return 0;
> +	return err;
>  }
> =20
>  static void cb710_mmc_set_transfer_size(struct cb710_slot *slot,

This patch is good. This part is not completely demystified though, and=
 some
parts of the code don't care about this function's return value.

Acked-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

