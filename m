From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Wed, 14 Sep 2016 20:20:34 +0530
Message-ID: <1473864634.9913.12.camel@researchut.com>
References: <CAPDyKFpnCXhdoKgoG576teC=y38vbC1x=-ehC_9EWEeKr_K6BQ@mail.gmail.com>
         <Pine.LNX.4.44L0.1609071630350.2115-100000@iolanthe.rowland.org>
         <CAPDyKFr0vEaEbsoPm6YwJD1JOQc=YR=zwi4T6Rr3gCQ4StNuvg@mail.gmail.com>
         <1473426861.9415.2.camel@researchut.com>
         <1473429884.9415.8.camel@researchut.com>
Reply-To: rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473429884.9415.8.camel-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Ulf and Alan,

On Fri, 2016-09-09 at 19:34 +0530, Ritesh Raj Sarraf wrote:
> For #2, I'm building the 4.8-rc5 kernel with the following change. This build
> does not include the previous change you had suggested (related to
> POWER_CYCLE)
> 
> Date:   Fri Sep 9 19:28:03 2016 +0530
> 
>     Disable pm runtime in mmc core
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e55cde6..32388d5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -970,9 +970,6 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t
> *abort)
>         spin_unlock_irqrestore(&host->lock, flags);
>         remove_wait_queue(&host->wq, &wait);
>  
> -       if (pm)
> -               pm_runtime_get_sync(mmc_dev(host));
> -
>         return stop;
>  }
>  EXPORT_SYMBOL(__mmc_claim_host);
> @@ -1000,7 +997,6 @@ void mmc_release_host(struct mmc_host *host)
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 wake_up(&host->wq);
>                 pm_runtime_mark_last_busy(mmc_dev(host));
> -               pm_runtime_put_autosuspend(mmc_dev(host));
>         }
>  }
>  EXPORT_SYMBOL(mmc_release_host);

I tried with these changes on 4.8-rc6 and I only saw 2 resets so far.
I captured the usb trace [1], just in case if you need it.

[1] https://people.debian.org/~rrs/tmp/4.8-rc6-ulf.txt.gz

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX2WO6AAoJEKY6WKPy4XVpfx4P/3VOWgHw87iZxuHlw+vHUVOR
BB8cdQidh6nVba2UcDXb8uw/oYYYEJZ0FYvvdgKwt/14QNaL1L3jwrLpayUC7AAM
wZA8bhESANx/KoJiZH4GuasnkXfmjXVz2XPOIz/b8qfp4jfreFZfZQHgkIY7cEtE
gO9JArpM/e6FZY/5mEYy1bFnvuuyTfI4Wu5Cm6HmyidT1mfhTM7xvyMTLfM+QRUm
VT7pRhS6oujWO7K2KDMTrcZqgs2AVmjCqZW13F4AnMU/owxvRYTpGyW3hDbi9oIg
Z8ZJ5sHT7jpJ4I/FZJxwaSthIN5aF4wG8UjTFr2EIc+W5Xx/xzYpZP3Qm+HkFnej
n8Uyo0ZMN9+CV6VI2Qgzr+pB5LAfYHjIMobGAzaCzN81MWCVmb/GfiLQhpcgOnoK
TMHVqCqWlkF8W0V5ap+Tc4Ce4Wqj/V+RlQpE01GeOg15DUtgqWXCGbYKspnwwRD2
u2Ivso9G4xDd0VOp9x4zpIdfbAqaSP+DuZZ7EnGVfd30j4ENWsrRTDXdWf63uAx6
GMOpAephwUOZo7WFxwd/q19181YM/emSg+weOMcGxwHvpQ+vTEN+JELD0B0Z6PpI
OvaPROIL8bb5SuPKzKJ55ZRLpv40sjWOglZC1oOhtSg2IMFJwjPcqzaO4frIxl4t
3OCttIZYgpp5kIiW8qV1
=KNnj
-----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
