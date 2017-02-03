From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 04/14] GPIO: Add gpio-ingenic driver
Date: Fri, 3 Feb 2017 14:58:50 +0100
Message-ID: <CACRpkdZNodsRJ33wTJGgrAJpSs=_bXa0yv5ate_7XwjKR0xEnw@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-5-paul@crapouillou.net>
 <CACRpkdbcO+1c7izYpn0sb1mkE1ORFETMq=xtzVi1hKbJz0EWfw@mail.gmail.com> <699f0c63e95ecdafe6946fdcdbb97a37@mail.crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <699f0c63e95ecdafe6946fdcdbb97a37-p8hskv8pF7lEPksTRSfcJOTW4wlIGRCZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-p
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 31, 2017 at 4:29 PM, Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org> wrote=
:
> Le 2017-01-31 15:20, Linus Walleij a =C3=A9crit :
>
>>> + of_property_read_u32(dev->of_node, "base", &jzgc->gc.base);
>>
>>
>> Remove this. Dynamic allocation should be fine, if you're using the
>> new userspace ABI like tools/gpio/* or libgpiod and only that and
>> in-kernel
>> consumers, dynamic numbers are just fine.
>
>
> The problem is that the QI_LB60 board code still have a lot of references
> to global GPIO numbers. Just grep for JZ_GPIO_PORT in
> arch/mips/jz4740/board-qi_lb60.c to see what I mean...

OK I understand we might need a compromise here to get the code moving.

But we need to keep it out of the device tree.

I think it's better to put a base table relative to the memory base in
the driver in that case:

unsigned int gpio_global_base;

switch (memory_base_address) {
case 0x41000000:
    gpio_global_base =3D 0x00;
    break;
case 0x42000000:
    gpio_global_base =3D 0x20;

(...)

etc. (Those are not your base addresses but you get the idea).

Include a few comments like:

/*
 * DO NOT EXPAND THIS: FOR BACKWARD GPIO NUMBERSPACE
 * COMPATIBIBILITY ONLY: WORK TO TRANSITION CONSUMERS TO
 * USE THE GPIO DESCRIPTOR API IN <linux/gpio/consumer.h> INSTEAD.
 */

Then I'll be happy :)

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
