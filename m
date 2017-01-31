From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
Date: Tue, 31 Jan 2017 13:59:37 +0100
Message-ID: <CACRpkda+2tnuO=AcN=HAD+YoaM4eEgnyjju7ioJL1op7+jFtqA@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net> <20170122144947.16158-2-paul@crapouillou.net>
 <CACRpkdZFRH84c4x7HBwgmY3fH+=Qq4q167c9oPhvrJ70MQkjaA@mail.gmail.com> <08e9505d2d366557950f8e6a4e81f57a@mail.crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <08e9505d2d366557950f8e6a4e81f57a-p8hskv8pF7lEPksTRSfcJOTW4wlIGRCZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-p
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 27, 2017 at 4:27 PM, Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org> wrote:
> [Me]:
>> In the former case, if this pertains to the *inside* of the SoC:
>> is it just different between jz4740 and jz4780?
>> In that case, just code this into the driver as .data to the .compatible
>> in the DT match. No special DT properties needed.
>
> Well, I've been taught that devicetree is for describing the hardware, and
> the driver code is for functionality. So that's why I put it in devicetree.

This is a gray area.

But as GPIO maintainer I'm not happy about encoding information
about the hardware, that can be deducted from the compatible-string,
into the devicetree.

I prefer to encode per-compatible hardware information tables into
the driver, as structs, and pick the right table based on the compatible
string as .data in the of match entry.

It's simple to retrieve into the driver using of_device_get_match_data()
these days.

> That's also the reason why I put the list of functions and groups in
> devicetree and not in the driver code.

I'm not super-happy about that either, and it's not the way I would
have done it but the argument has been made
that it is a lot of opaque data and people prefer to maintain it
in the device tree.

I accept it for functions and groups, but I don't like it.

I will not fold to any consistency arguments of the type "now
you allowed this one thing, so you must allow this other thing
so you are consistent", just no. I didn't like it the first time, so I'm
not liking it anymore the second time.

I guess if the DT people tell me it has to be done this way I would
accept it. After a lot of discussion. But noone has.

Please make it a table and put it in the driver instead.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
