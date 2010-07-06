From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 14/15] omap: zoom: add WLAN device
Date: Tue, 6 Jul 2010 16:47:33 +0300
Message-ID: <AANLkTilARXB6NVMOAC7lW1HSOzDnONveS0oK6MomvDy0@mail.gmail.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-15-git-send-email-ohad@wizery.com> <4C33228D.8000908@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C33228D.8000908-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Ohad Ben-Cohen <ohadb-l0cyMroinI0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Roger,

On Tue, Jul 6, 2010 at 3:33 PM, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>=
 wrote:
>> +static void omap_zoom_wlan_power(bool enable)
>> +{
>> + =A0 =A0 =A0 int val =3D enable ? 1 : 0;
>> +
>> + =A0 =A0 =A0 pr_info("%s: set power %d\n", __func__, val);
>> +
>> + =A0 =A0 =A0 gpio_set_value(OMAP_ZOOM_WLAN_PMENA_GPIO, val);
>> +}
>
> Can we consider that OMAP_ZOOM_WLAN_PMENA_GPIO is equivalent to vmmc =
supply
> or equivalent to supply voltage to the SDIO card?

Not really, this gpio does not supply power to the chip. It's only a
digital indication that instructs the chip to go into on or off mode.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
