From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] sdio: fix suspend/resume regression
Date: Wed, 13 Oct 2010 09:54:29 +0200
Message-ID: <AANLkTiki_Sky6pry+vWAoTtJ5ctVUpawAH6iRYV6L-+z@mail.gmail.com>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286955116-22793-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>, libertas-dev@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Mack <daniel@caiaq.de>, Colin Cross <ccross@android.com>, Chris Ball <cjb@laptop.org>, stable@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Ohad,

On Wed, Oct 13, 2010 at 9:31 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:

> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c94565d..515ff39 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1682,6 +1682,19 @@ int mmc_suspend_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0if (host->bus_ops && !host->bus_dead) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->suspend)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops-=
>suspend(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err =3D=3D -ENOSYS || !host->bus_op=
s->resume) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We simply "remove"=
 the card in this case.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* It will be redetec=
ted on resume.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->remo=
ve)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->b=
us_ops->remove(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detach_bus(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->pm_flags =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mmc_bus_put(host);
>

what about moving this logic to sdio bus_ops as this seems to be
completely specific to sdio right now?

Thanks,
   Vitaly
