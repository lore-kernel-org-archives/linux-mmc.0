From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 18/20] mmc: sdio: enable a default power off mode of
	the card
Date: Sun, 25 Jul 2010 15:40:35 +0300
Message-ID: <AANLkTimfJnC7onDT83DWLb7sR7+evJB3eymt5Z6JYkAt@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-19-git-send-email-ohad@wizery.com> <4C482D01.1040109@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C482D01.1040109-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 22, 2010 at 2:35 PM, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> On 07/21/2010 08:33 PM, ext Ohad Ben-Cohen wrote:
>>
>> Add support for an SDIO device to stay powered off even without
>> the presence of an SDIO function driver. A host should explicitly
>> ask for it by means of MMC_CAP_DONT_POWER_CARD, and the SDIO
>> function driver should know it needs to call sdio_claim_power
>> before accessing the device.
>>
>> Signed-off-by: Ohad Ben-Cohen<ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
>
> Shouldn't this be the default behaviour? If there is no function driver for
> any of the functions of the card, then sdio core shold power off the card.
>
> I don't see a need for a special capability flag for this.
>
> in fact MMC_CAP_DONT_POWER_CARD does not seem like an mmc host's capability

Totally agree.

I didn't want to change the current behavior of the cards/funcs so I
looked for a way to explicitly power down only specific cards.

Alternatively we could power down all cards at the end
mmc_attach_sdio, and then power them up selectively in sdio_bus_probe,
just before calling probe. If the probe succeeds, the function driver
takes over. If the probe fails, we can power them down again.

Is that what you meant ?

This would work both if the sdio function driver is already loaded, or
will only be loaded at a later time. But I'm not too fond of the extra
power on/off cycles that it will introduce for each card..

Thanks,
Ohad.

> flag, it seems more like a request from the board to keep the card powered
> off.
>
> regards,
> -roger
>
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
