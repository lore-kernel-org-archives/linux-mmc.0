From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v5 3/7] wireless: wl12xx: add platform data passing
	support
Date: Mon, 6 Sep 2010 13:07:16 +0100
Message-ID: <20100906120716.GE20903@n2100.arm.linux.org.uk>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com> <1283376410-9999-4-git-send-email-ohad@wizery.com> <AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Sep 04, 2010 at 02:23:19PM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> 2010/9/1 Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>:
> > Add a simple mechanism to pass platform data to the
> > SDIO instances of wl12xx.
> >
> > This way there is no confusion over who owns the 'embedded data',
> > typechecking is preserved, and no possibility for the wrong driver =
to
> > pick up the data.
> >
> > Originally proposed by Russell King.
> >
> > Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> > ---
> > =C2=A0drivers/net/wireless/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +
> > =C2=A0drivers/net/wireless/wl12xx/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A05 ++-
> > =C2=A0drivers/net/wireless/wl12xx/wl12xx_platform_data.c | =C2=A0 3=
1 ++++++++++++++++++++
> > =C2=A0include/linux/wl12xx.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A03 ++
> > =C2=A04 files changed, 40 insertions(+), 1 deletions(-)
> > =C2=A0create mode 100644 drivers/net/wireless/wl12xx/wl12xx_platfor=
m_data.c
> >
> > diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/M=
akefile
> > index 5d4ce4d..85af697 100644
> > --- a/drivers/net/wireless/Makefile
> > +++ b/drivers/net/wireless/Makefile
> > @@ -50,5 +50,7 @@ obj-$(CONFIG_ATH_COMMON) =C2=A0 =C2=A0 =C2=A0+=3D=
 ath/
> > =C2=A0obj-$(CONFIG_MAC80211_HWSIM) =C2=A0 +=3D mac80211_hwsim.o
> >
> > =C2=A0obj-$(CONFIG_WL12XX) =C2=A0 +=3D wl12xx/
> > +# small builtin driver bit
> > +obj-$(CONFIG_WL12XX_PLATFORM_DATA) =C2=A0 =C2=A0 +=3D wl12xx/wl12x=
x_platform_data.o
> >
> > =C2=A0obj-$(CONFIG_IWM) =C2=A0 =C2=A0 =C2=A0+=3D iwmc3200wifi/
> > diff --git a/drivers/net/wireless/wl12xx/Kconfig b/drivers/net/wire=
less/wl12xx/Kconfig
> > index 2f98058..4a8bb25 100644
> > --- a/drivers/net/wireless/wl12xx/Kconfig
> > +++ b/drivers/net/wireless/wl12xx/Kconfig
> > @@ -74,4 +74,7 @@ config WL1271_SDIO
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you choose to build a module, =
it'll be called
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wl1271_sdio. Say N if unsure.
> >
> > -
> > +config WL12XX_PLATFORM_DATA
> > + =C2=A0 =C2=A0 =C2=A0 bool
> > + =C2=A0 =C2=A0 =C2=A0 depends on WL1271_SDIO !=3D n
> > + =C2=A0 =C2=A0 =C2=A0 default y
> > diff --git a/drivers/net/wireless/wl12xx/wl12xx_platform_data.c b/d=
rivers/net/wireless/wl12xx/wl12xx_platform_data.c
> > new file mode 100644
> > index 0000000..e00973b
> > --- /dev/null
> > +++ b/drivers/net/wireless/wl12xx/wl12xx_platform_data.c
> > @@ -0,0 +1,31 @@
> > +#include <linux/module.h>
> > +#include <linux/wl12xx.h>
> > +
> > +static struct wl12xx_platform_data *platform_data;
> > +
> > +int __init wl12xx_set_platform_data(const struct wl12xx_platform_d=
ata *data)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 if (platform_data)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;
> > + =C2=A0 =C2=A0 =C2=A0 if (!data)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 platform_data =3D kmemdup(data, sizeof(*data=
), GFP_KERNEL);
> > + =C2=A0 =C2=A0 =C2=A0 if (!platform_data)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +int wl12xx_get_platform_data(struct wl12xx_platform_data *data)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 if (!platform_data)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> > + =C2=A0 =C2=A0 =C2=A0 if (!data)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 memcpy(data, platform_data, sizeof(*data));
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +EXPORT_SYMBOL(wl12xx_get_platform_data);
> > diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
> > index 137ac89..3e33ae1 100644
> > --- a/include/linux/wl12xx.h
> > +++ b/include/linux/wl12xx.h
> > @@ -31,4 +31,7 @@ struct wl12xx_platform_data {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0bool use_eeprom;
> > =C2=A0};
> >
> > +int wl12xx_set_platform_data(const struct wl12xx_platform_data *da=
ta);
> > +int wl12xx_get_platform_data(struct wl12xx_platform_data *data);
> > +
> > =C2=A0#endif
>=20
> Why do you need all that copying? Isn't the data constant?

The first copy is to allow platforms to have their data marked with
__initdata.  The second copy probably isn't necessary, but avoids
problems where the driver may decide to modify the platform data.

We could instead make wl12xx_get_platform_data() return a const pointer
to its own internal storage instead, or ERR pointers for the various
failure cases.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
