From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 03/14] pinctrl-ingenic: add a pinctrl driver for the
 Ingenic jz47xx SoCs
Date: Fri, 7 Apr 2017 11:56:29 +0100
Message-ID: <20170407105629.n6a2cxt3pof66gu2@dell>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-4-paul@crapouillou.net>
 <CACRpkdbeudhXDE8KEgB_kZSAUUwS4Sd3=+GyR0YZ2-PQnEa9zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbeudhXDE8KEgB_kZSAUUwS4Sd3=+GyR0YZ2-PQnEa9zw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 07 Apr 2017, Linus Walleij wrote:

> On Sun, Apr 2, 2017 at 10:42 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> 
> > This driver handles pin configuration and pin muxing for the
> > JZ4740 and JZ4780 SoCs from Ingenic.
> >
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> (...)
> > +       select MFD_CORE
> (...)
> > +#include <linux/mfd/core.h>
> 
> That's unorthodox. Still quite pretty!
> I would nee Lee Jones to say something about this, as it is
> essentially hijacking MFD into the pinctrl subsystem.
> 
> > +static struct mfd_cell ingenic_pinctrl_mfd_cells[] = {
> > +       {
> > +               .id = 0,
> > +               .name = "GPIOA",
> > +               .of_compatible = "ingenic,gpio-bank-a",
> > +       },
> > +       {
> > +               .id = 1,
> > +               .name = "GPIOB",
> > +               .of_compatible = "ingenic,gpio-bank-b",
> > +       },
> > +       {
> > +               .id = 2,
> > +               .name = "GPIOC",
> > +               .of_compatible = "ingenic,gpio-bank-c",
> > +       },
> > +       {
> > +               .id = 3,
> > +               .name = "GPIOD",
> > +               .of_compatible = "ingenic,gpio-bank-d",
> > +       },
> > +       {
> > +               .id = 4,
> > +               .name = "GPIOE",
> > +               .of_compatible = "ingenic,gpio-bank-e",
> > +       },
> > +       {
> > +               .id = 5,
> > +               .name = "GPIOF",
> > +               .of_compatible = "ingenic,gpio-bank-f",
> > +       },
> > +};
> (...)
> > +       err = devm_mfd_add_devices(dev, 0, ingenic_pinctrl_mfd_cells,
> > +                       ARRAY_SIZE(ingenic_pinctrl_mfd_cells), NULL, 0, NULL);
> > +       if (err) {
> > +               dev_err(dev, "Failed to add MFD devices\n");
> > +               return err;
> > +       }
> 
> I guess the alternative would be to reimplement the MFD structure.
> 
> Did you check the approach to use "simple-mfd" and just let the subnodes
> spawn as devices that way? I guess you did and this adds something
> necessary.

I'd like to hear what the OP has to say about why this is necessary.
However, as a first glimpse, I'm dead against exporting MFD
functionality to outside of the subsystem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
