From: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/15] wireless: wl1271: make wl12xx.h common to both
 spi and sdio
Date: Tue, 06 Jul 2010 10:08:28 +0300
Message-ID: <1278400108.18287.14.camel@chilepepper>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	 <1278376666-3509-9-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278376666-3509-9-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Ohad Ben-Cohen <ohadb-l0cyMroinI0@public.gmane.org>, kalle.valo-X3B1VOXEql0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2010-07-06 at 02:37 +0200, ext Ohad Ben-Cohen wrote:
> From: Ohad Ben-Cohen <ohadb-l0cyMroinI0@public.gmane.org>
> 
> Move wl12xx.h outside of the spi-specific location,
> so it can be shared with both spi and sdio solutions.
> 
> Signed-off-by: Ohad Ben-Cohen <ohadb-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/net/wireless/wl12xx/wl1251_sdio.c |    2 +-
>  drivers/net/wireless/wl12xx/wl1251_spi.c  |    2 +-
>  drivers/net/wireless/wl12xx/wl1271_spi.c  |    2 +-
>  include/linux/spi/wl12xx.h                |   34
> -----------------------------
>  include/linux/wl12xx.h                    |   34
> +++++++++++++++++++++++++++++
>  5 files changed, 37 insertions(+), 37 deletions(-)
>  delete mode 100644 include/linux/spi/wl12xx.h
>  create mode 100644 include/linux/wl12xx.h 

For the wl1271 part:

Acked-by: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

For the wl12xx.h and wl1251 parts, this needs to be acked by Kalle Valo.


-- 
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
