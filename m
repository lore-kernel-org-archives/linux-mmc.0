From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Where to power on the wifi device before loading the driver.
Date: Mon, 18 Jun 2012 09:01:45 -0600
Message-ID: <4FDF42D9.2050305@wwwdotorg.org>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com> <4FD90352.9090606@wwwdotorg.org> <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de> <20120614121234.GC3913@opensource.wolfsonmicro.com> <4FDA092E.10301@wwwdotorg.org> <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com> <4FDB5976.20809@wwwdotorg.org> <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com> <96C9D994977DD0439FB6D3FE3B13DD907DE14CB4DF@BGMAIL01.nvidia.com> <96C9D994977DD0439FB6D3FE3B13DD907DE14CB4E8@BGMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <96C9D994977DD0439FB6D3FE3B13DD907DE14CB4E8-kdsAE/FnitNDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Rakesh Kumar <krakesh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "'frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org'" <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mursalin Akon <makon-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "'linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "'linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 06/18/2012 02:03 AM, Laxman Dewangan wrote:
> Rakesh Kumar wrote at Monday, June 18, 2012 1:11 PM:
> > Stephen Warren wrote:
> >> Now if this means adding a child node under the SDIO controller
> >> to represent the attached device, and storing any settings
> >> required by that device in that child node, that's probably a
> >> reasonable basic approach.
> >>
> >> BTW, which GPIO is the power GPIO; is it WF_EN on the schematic?
> >> That seems reasonable to represent as a GPIO rather than a
> >> regulator since it connects directly into the WiFi device as a
> >> GPIO, and its use within the WiFi device can indeed be governed
> >> purely internally to the WiFi driver/HW. However, if this is some
> >> GPIO that controls the power to e.g. VBAT3V3_IN_WF, VDDIO_WF, or
> >> other power supply to the WiFi card, then it'd be better
> >> represented as a regulator, since the control point is outside the
> >> WiFi device.
> > 
> > Tegra uses two GPIO (WF_EN and WF_RST) to power on and reset bcm4329
> > card. In case of bcm4329, these two lines are shorted. Tegra does
> > not control VBAT3V3_IN_WF, VDDIO_WF, or other power supply to the
> > WiFi card based on these GPIO. Uses of these GPIO are internal to
> > WiFi HW.  It is reasonable to represent as a GPU rather than
> > regulator.
>
> If it is for power then it has to go via regulator. It does not make
> sense to directly control the gpio inside the wifi driver.

As far as the board goes, WF_EN is just a GPIO signal to the WiFi card;
it doesn't gate power to the card. If it gates power inside the card,
that's an internal implementation detail of the card, and something I'd
be fine with the driver knowing directly, and hence I'm OK with
representing this as a GPIO rather than a regulator - that's what it is
externally to the WiFi device.

(BTW everyone, many of the emails in this thread are awfully formatted -
top-posted and not word-wrapped. It's very hard to read them... I tried
to reformat everything and fix it in this email)
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
