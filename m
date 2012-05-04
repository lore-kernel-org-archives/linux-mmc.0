From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 24/29] mmc: add a simple generic OF parser
Date: Fri, 4 May 2012 11:26:33 -0700
Message-ID: <CAOesGMg7eUTjX6+DJtd7G5N69yteWMLWPaB0jjaz12_fH7-JEQ@mail.gmail.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
	<1336057558-11031-25-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-25-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-mmc@vger.kernel.org

On Thu, May 3, 2012 at 8:05 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Many MMC host drivers already use OF data to obtain their platform-sp=
ecific
> configuration. Each of them is doing this in its special way, whereas=
 many
> parameters are identical and can easily be generalised. This patch ad=
ds
> such a generic parser. So far it only adds and handles very few basic
> properties. New ones can be added in the future as required.

The bindings need to be documented under Documentation/devicetree/mmc

It's common to use dashes (-) instead of underscores (_) in properties

Also, no need to prefix with mmc. But also:


> + =A0 =A0 =A0 if (of_get_property(node, "mmc,4_bit_data", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
> + =A0 =A0 =A0 if (of_get_property(node, "mmc,8_bit_data", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;

In the device tree, do these encode the capability of the controller,
or how the device under the controller is wired up? It's not uncommon
to have an 4-bit device on a controller that could possibly support
8-bit devices. It needs to be clear from the property name which is
which to not confuse everyone all the time.

> + =A0 =A0 =A0 if (of_get_property(node, "mmc,sdio_irq", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;

"supports-sdio-interrupts"

> + =A0 =A0 =A0 if (of_get_property(node, "mmc,nonremovable", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NONREMOVABLE;

This is a property of the card (well, how the card is connected), not
the controller, right? Again, see above regarding confusion.

> + =A0 =A0 =A0 if (of_get_property(node, "mmc,needs_poll", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NEEDS_POLL;

This should be implicit from lack of interrupt property in the device n=
ode.

> + =A0 =A0 =A0 if (of_get_property(node, "mmc,inverted_cd", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 |=3D MMC_CAP2_INVERTED_CD;
> + =A0 =A0 =A0 if (of_get_property(node, "mmc,inverted_ro", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 |=3D MMC_CAP2_INVERTED_RO;

The GPIO specifiers should be able to encode polarity. Is this needed
for other cases as well?


-Olof
