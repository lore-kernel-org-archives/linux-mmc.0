From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 24/29] mmc: add a simple generic OF parser
Date: Thu, 10 May 2012 16:51:52 +0900
Message-ID: <CANqRtoQU0100YToWrD1WmSOzDBOth8tyoy1nYSyPPF=uBcbXJg@mail.gmail.com>
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

On Fri, May 4, 2012 at 12:05 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Many MMC host drivers already use OF data to obtain their platform-sp=
ecific
> configuration. Each of them is doing this in its special way, whereas=
 many
> parameters are identical and can easily be generalised. This patch ad=
ds
> such a generic parser. So far it only adds and handles very few basic
> properties. New ones can be added in the future as required.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>

I usually don't say things this loud, but here it is: NAK!

To begin with: this is not what we agreed on earlier. I asked you to
only implement a small subset to begin with. This so we don't end up
supporting a bunch of DT flags forever.

In general it's a good idea to make something generic, but I think now
is too early for our drivers on SH and SH-Mobile ARM. We need to
experiment more with PINCTRL as well as GPIO bindings via DT. When we
have done that I think we should revisit.

Please see below for my reasons:

> + =A0 =A0 =A0 if (of_get_property(node, "mmc,4_bit_data", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
> + =A0 =A0 =A0 if (of_get_property(node, "mmc,8_bit_data", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA;

I suspect that these overlap with PINCTRL. I don't want to add support
for potentially duplicated functionality.

> + =A0 =A0 =A0 gpio =3D of_get_named_gpio_flags(node, "cd-gpios", 0, &=
flags);
> + =A0 =A0 =A0 ret =3D mmc_gpio_request_cd(mmc, gpio);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(mmc->parent, "Failed to obtain=
 CD GPIO: %d\n", ret);
> +
> + =A0 =A0 =A0 gpio =3D of_get_named_gpio_flags(node, "ro-gpios", 0, &=
flags);
> + =A0 =A0 =A0 ret =3D mmc_gpio_request_ro(mmc, gpio);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(mmc->parent, "Failed to obtain=
 RO GPIO: %d\n", ret);
> +}

We want to have stable DT bindings for GPIO and PINCTRL before we let
this loose with DT.

So please ignore this patch for now. Thanks for your efforts anyway.

/ magnus
