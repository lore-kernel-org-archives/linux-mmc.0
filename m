From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/2] dt: bindings: Add binding for ESP8089 wifi chips
Date: Mon, 08 Aug 2016 11:24:23 +0200
Message-ID: <52721384.ieJe1WiAoe@wuerfel>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com> <2936779.FAiO1bqUWV@wuerfel> <CAGb2v67+QrOxPd4KeLb9F67A0mSaBqn14PynzCyK=ovRnKA6EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGb2v67+QrOxPd4KeLb9F67A0mSaBqn14PynzCyK=ovRnKA6EQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Monday, August 8, 2016 11:59:25 AM CEST Chen-Yu Tsai wrote:
> Hi Arnd,
> 
> On Mon, Aug 8, 2016 at 3:59 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > On Sunday, August 7, 2016 8:57:49 PM CEST Hans de Goede wrote:
> >> +Espressif ESP8089 wireless SDIO devices
> >> +
> >> +This node provides properties for controlling the ESP8089 wireless device.
> >> +The node is expected to be specified as a child node to the SDIO controller
> >> +that connects the device to the system.
> >> +
> >> +Required properties:
> >> +
> >> + - compatible : Should be "esp,esp8089".
> >
> > I think it would be good to standardize a compatible string for sdio
> > like we have it for other discoverable buses, based on the
> > vendor/device ID (or whatever this uses), using something like
> >
> > compatible = "sdio1234,5678", "esp,esp8089";
> 
> Is there a central repository for SDIO vendor/device IDs similar to
> PCI or USB IDs?

No idea. I believe the existing repositories for PCI and USB are not
public either, there is just the information at http://pcidatabase.com/,
http://pci-ids.ucw.cz/ or http://www.linux-usb.org/usb.ids that
are maintained by volunteers and that are not authoritarive.

I found one list at https://github.com/systemd/systemd/blob/master/hwdb/sdio.ids
but it's probably very incomplete.

> The vendor ID Espressif uses is 0x6666, which seems kind of bogus to me.

It probably is, but that's not important as long as nothing else uses
that ID.

	Arnd

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
