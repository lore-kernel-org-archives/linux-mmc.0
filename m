From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 3/7] wireless: wl12xx: add platform data passing support
Date: Sat, 4 Sep 2010 14:23:19 +0200
Message-ID: <AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
	<1283376410-9999-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283376410-9999-4-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

2010/9/1 Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>:
> Add a simple mechanism to pass platform data to the
> SDIO instances of wl12xx.
>
> This way there is no confusion over who owns the 'embedded data',
> typechecking is preserved, and no possibility for the wrong driver to
> pick up the data.
>
> Originally proposed by Russell King.
>
> Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> ---
> =A0drivers/net/wireless/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +
> =A0drivers/net/wireless/wl12xx/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A05 ++-
> =A0drivers/net/wireless/wl12xx/wl12xx_platform_data.c | =A0 31 ++++++=
++++++++++++++
> =A0include/linux/wl12xx.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A03 ++
> =A04 files changed, 40 insertions(+), 1 deletions(-)
> =A0create mode 100644 drivers/net/wireless/wl12xx/wl12xx_platform_dat=
a.c
>
> diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Mak=
efile
> index 5d4ce4d..85af697 100644
> --- a/drivers/net/wireless/Makefile
> +++ b/drivers/net/wireless/Makefile
> @@ -50,5 +50,7 @@ obj-$(CONFIG_ATH_COMMON) =A0 =A0 =A0+=3D ath/
> =A0obj-$(CONFIG_MAC80211_HWSIM) =A0 +=3D mac80211_hwsim.o
>
> =A0obj-$(CONFIG_WL12XX) =A0 +=3D wl12xx/
> +# small builtin driver bit
> +obj-$(CONFIG_WL12XX_PLATFORM_DATA) =A0 =A0 +=3D wl12xx/wl12xx_platfo=
rm_data.o
>
> =A0obj-$(CONFIG_IWM) =A0 =A0 =A0+=3D iwmc3200wifi/
> diff --git a/drivers/net/wireless/wl12xx/Kconfig b/drivers/net/wirele=
ss/wl12xx/Kconfig
> index 2f98058..4a8bb25 100644
> --- a/drivers/net/wireless/wl12xx/Kconfig
> +++ b/drivers/net/wireless/wl12xx/Kconfig
> @@ -74,4 +74,7 @@ config WL1271_SDIO
> =A0 =A0 =A0 =A0 =A0If you choose to build a module, it'll be called
> =A0 =A0 =A0 =A0 =A0wl1271_sdio. Say N if unsure.
>
> -
> +config WL12XX_PLATFORM_DATA
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on WL1271_SDIO !=3D n
> + =A0 =A0 =A0 default y
> diff --git a/drivers/net/wireless/wl12xx/wl12xx_platform_data.c b/dri=
vers/net/wireless/wl12xx/wl12xx_platform_data.c
> new file mode 100644
> index 0000000..e00973b
> --- /dev/null
> +++ b/drivers/net/wireless/wl12xx/wl12xx_platform_data.c
> @@ -0,0 +1,31 @@
> +#include <linux/module.h>
> +#include <linux/wl12xx.h>
> +
> +static struct wl12xx_platform_data *platform_data;
> +
> +int __init wl12xx_set_platform_data(const struct wl12xx_platform_dat=
a *data)
> +{
> + =A0 =A0 =A0 if (platform_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 if (!data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 platform_data =3D kmemdup(data, sizeof(*data), GFP_KERN=
EL);
> + =A0 =A0 =A0 if (!platform_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int wl12xx_get_platform_data(struct wl12xx_platform_data *data)
> +{
> + =A0 =A0 =A0 if (!platform_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 if (!data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 memcpy(data, platform_data, sizeof(*data));
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(wl12xx_get_platform_data);
> diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
> index 137ac89..3e33ae1 100644
> --- a/include/linux/wl12xx.h
> +++ b/include/linux/wl12xx.h
> @@ -31,4 +31,7 @@ struct wl12xx_platform_data {
> =A0 =A0 =A0 =A0bool use_eeprom;
> =A0};
>
> +int wl12xx_set_platform_data(const struct wl12xx_platform_data *data=
);
> +int wl12xx_get_platform_data(struct wl12xx_platform_data *data);
> +
> =A0#endif

Why do you need all that copying? Isn't the data constant?

Best Regards,
Micha=B3 Miros=B3aw
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
