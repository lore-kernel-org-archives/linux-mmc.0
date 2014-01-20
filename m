From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Mon, 20 Jan 2014 11:04:26 -0800
Message-ID: <CAOesGMgMnvFAFiO_K4U5n08Tj+ZPWh656D=vgaQOyYbVCyvSDg@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
	<1390190215-22700-2-git-send-email-olof@lixom.net>
	<201401201958.57997.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201401201958.57997.arnd-r2nGTMty4D4@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ijc+devicetree-KcIKpvwj1kWeLe5EKmSxzQ@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 20, 2014 at 10:58 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Monday 20 January 2014, Olof Johansson wrote:
>>
>> +Card power and reset control:
>> +The following properties can be specified for cases where the MMC
>> +peripheral needs additional reset, regulator and clock lines. It is for
>> +example common for WiFi/BT adapters to have these separate from the main
>> +MMC bus:
>> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
>> +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
>> +  - clock with name "card_ext_clock": External clock provided to the card
>
> I wonder whether the reset line should use the generic reset controller binding
> rather than the gpio binding. There has been a recent discussion about a
> gpio-reset driver, which should generalize this at the reset level, and
> it would make it possible to use reset controllers that are not gpio driven.
> In general, any gpio can be used as a reset, but not every reset line can
> be a gpio. I don't know whether anyone would use an internal reset-controller
> for an external SDIO chip though, so maybe your approach is sufficient.

I'd expect most usage of this to be through gpios, since we're talking
about external independent modules here. I would prefer not to bring
in the reset controller stuff here -- it just adds another layer of
abstraction that seems unnecessary.

I would prefer if the reset framework was contained to only be the
on-chip SoC IP block resets, etc, as originally intended.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
