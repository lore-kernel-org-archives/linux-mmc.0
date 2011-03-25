From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v1 1/2] sdio: add power_restore support with
 MMC_PM_KEEP_POWER mode
Date: Fri, 25 Mar 2011 18:18:48 +0200
Message-ID: <AANLkTinhbwsm_wOBDW5-WBrP0tfLUZMmuY18eGTkr4e4@mail.gmail.com>
References: <AANLkTi=CSK8nRF7CTzsq06Bk8Cr74ZcwJBf53_wWbpnv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=CSK8nRF7CTzsq06Bk8Cr74ZcwJBf53_wWbpnv-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wilson Loi <wlsloi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello Wilson,

On Fri, Mar 25, 2011 at 5:58 AM, Wilson Loi <wlsloi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> The current power_restore handler only support cut off mode.
> It is better to support keep power mode too.

This doesn't make much sense really;

mmc_power_save_host() and mmc_power_restore_host() are invoked by
runtime PM when it is time to power off/on the card.

If your driver doesn't want the power to go, it should just maintain a
positive runtime PM usage_count (e.g. in case it's an SDIO driver,
don't call pm_runtime_put{_sync} after being probed).

> =A0static const struct mmc_bus_ops mmc_sdio_ops =3D {
> =A0=A0=A0=A0 .remove =3D mmc_sdio_remove,
> =A0=A0=A0=A0 .detect =3D mmc_sdio_detect,
> =A0=A0=A0=A0 .suspend =3D mmc_sdio_suspend,
> =A0=A0=A0=A0 .resume =3D mmc_sdio_resume,
> -=A0=A0=A0 .power_restore =3D mmc_sdio_power_restore,
> +=A0=A0=A0 .power_save =3D mmc_sdio_suspend,
> +=A0=A0=A0 .power_restore =3D mmc_sdio_resume,

This can break SDIO runtime PM.

While -ENOSYS is a valid return value for mmc_sdio_suspend (it tells
mmc_suspend_host to remove the entire MMC card on system suspend), it
will be treated as an error by runtime PM.

In addition, this can really yield unexpected results, since drivers
do not expect their suspend/resume handlers to be called during
runtime PM transitions.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
