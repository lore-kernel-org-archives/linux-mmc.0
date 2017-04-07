From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
Date: Fri, 7 Apr 2017 11:44:31 +0200
Message-ID: <CACRpkdbXe1Xxk93jqLXBdEDwWOnWD+CkZrqvok-PcmWxzBbSZA@mail.gmail.com>
References: <20170125185207.23902-2-paul@crapouillou.net> <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170402204244.14216-7-paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <li>
List-Id: linux-mmc@vger.kernel.org

On Sun, Apr 2, 2017 at 10:42 PM, Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org> wrote:

> For a description of the pinctrl devicetree node, please read
> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>
> For a description of the gpio devicetree nodes, please read
> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>
> Signed-off-by: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
> ---
>  arch/mips/boot/dts/ingenic/jz4740.dtsi | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
>  v2: Changed the devicetree bindings to match the new driver
>  v3: No changes
>  v4: Update the bindings for the v4 version of the drivers
(...)

> +       pinctrl: ingenic-pinctrl@10010000 {
> +               compatible = "ingenic,jz4740-pinctrl";
> +               reg = <0x10010000 0x400>;
> +
> +               gpa: gpio-controller@0 {
> +                       compatible = "ingenic,gpio-bank-a", "ingenic,jz4740-gpio";

As Sergei and Rob notes, the bank compatible properties look
a bit strange. Especially if they are all the same essentially.

I like Sergei's idea to simply use the reg property if what you want
is really a unique ID number. What do you think about this?

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
