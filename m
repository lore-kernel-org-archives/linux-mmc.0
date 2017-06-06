From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/7] dra7: Fixes for MMC devicetree node
Date: Tue, 6 Jun 2017 03:51:31 -0700
Message-ID: <20170606105131.GZ3730@atomide.com>
References: <20170601143401.16852-1-kishon@ti.com>
 <CAPDyKFqHHjZQnnaGLP=xDj3eYgzADDYoomzBuXRviBgh-n2QFw@mail.gmail.com>
 <f78dd61c-6689-4dbc-d1db-128f92be8e51@ti.com>
 <1d15c9e9-f257-fd97-a9a2-055ee90d7e84@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1d15c9e9-f257-fd97-a9a2-055ee90d7e84-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [170606 03:40]:
> omap3-overo-base.dtsi has the following dt node for mmc.
> /* optional on board WiFi */
> &mmc2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc2_pins>;
>         vmmc-supply = <&w3cbw003c_npoweron>;
>         vqmmc-supply = <&w3cbw003c_bt_nreset>;
>         vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
>         bus-width = <4>;
>         cap-sdio-irq;
>         non-removable;
> };
> 
> It has both "vqmmc-supply" and "vmmc_aux-supply". However omap-hsmmc driver has
> never parsed vqmmc so far. So I'd assume bt was never functional and it's used
> only for wifi.

Hmm yeah the vqmmc-supply probably got copied from some
other SoC for w3cbw003c.

> So for the change suggested by Ulf, Can I do something like below, so that we
> can keep wifi functional (ignoring bt since that was never functional)?
> -       vqmmc-supply = <&w3cbw003c_bt_nreset>;
> -       vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
> +       vqmmc-supply = <&w3cbw003c_wifi_nreset>;

Optional sdio pins 4 - 8 need separate power and that's
why we have the vmmc_aux supply to start with. But here
there are only four pins, so my guess is that only one
regulator is needed and the the other two are gpio pins
for wland and bt that nowadays should be handled by the
mmc power sequence driver.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
