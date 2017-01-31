From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
Date: Tue, 31 Jan 2017 14:09:54 +0100
Message-ID: <CACRpkdbAgy4sh6NT5DdQD6EQtOZEwevohEA6OGRcVz98yqS52Q@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop> <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <12dc62a7255bd453ff4e5e89f93ebc58-p8hskv8pF7lEPksTRSfcJOTW4wlIGRCZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pwm-u79uwXL29TY@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 31, 2017 at 11:31 AM, Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org> wrote:
> [Rob]:
>> From the overlapping register addresses in the examples and this
>> description, it looks like the pinctrlr and gpio controller are 1 block.
>> If so, then there should only be 1 node.
>
> Well, that's what I had until Linus W. just told me to do the opposite:
>
>> Just pull all these down two levels and make them one device
>> each instead of having them inside the pin controller node
>> like this.

I guess the argument is that they are in the same coherent memory
range so they should be one device node. That is how we handle
e.g. system controllers so it makes some sense.

So can the two GPIO controllers be modeled as two subnodes of
the pin controller then?

Subnodes are certainly OK, we have that for many other devices
such as interrupt controllers on PCI bridges and what not.

So when the probing of the pin controller is ready it can just
walk down and populate the GPIO subdevices with
of_platform_default_populate() or simply by registering the
device directly with platform_device_add_data() just like an
MFD device does?

This is nice because we want to use the standard gpio ranges
to map pins to GPIO lines.

I'm sorry about the unclarities here, but it's essentially an intrinsic
problem with GPIO that has been with us for years: do we model
each "bank" as a device or do we just register each bank as a
gpiochip, or do we even make one gpiochip to cover all the banks.
All solutions can be found in the kernel... also the different DT bindings:
one node for a whole slew of GPIO controllers, or seveal nodes
and I bet also several nodes for memory ranges in close proximity.

I don't know for sure what is the most elegant solution, we might
need to build some consensus here for the future so it doesn't
get to heterogeneous.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
