From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Thu, 13 Jun 2013 11:37:01 +0200
Message-ID: <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
References: <20130523184045.GD13507@atomide.com>
	<1370546059-24181-1-git-send-email-balajitk@ti.com>
	<1370546059-24181-7-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:63892 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758386Ab3FMJhD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2013 05:37:03 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so8424922oag.6
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jun 2013 02:37:02 -0700 (PDT)
In-Reply-To: <1370546059-24181-7-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, ext Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Jun 6, 2013 at 9:14 PM, Balaji T K <balajitk@ti.com> wrote:

> PBIAS register configuration is based on the regulator voltage
> which supplies these pbias cells, sd i/o pads.
> With PBIAS register address and bit definitions different across
> omap[3,4,5], Simplify PBIAS configuration under three different
> regulator voltage levels - O V, 1.8 V, 3 V. Corresponding pinctrl states
> are defined as pbias_off, pbias_1v8, pbias_3v.
>
> pinctrl state mmc_init is used for configuring speed mode, loopback clock
> (in devconf0/devconf1/prog_io1 register for omap3) and pull strength
> configuration (in control_mmc1 for omap4)
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

You *need* Lee Jones and Mark Brown to review this.
Maybe Laurent has something to add too.

Ux500 had the very same thing, and there this was solved using
a GPIO regulator for "vqmmc" a level-shifter. I vaguely remember
Laurent doing something similar with the SH stuff.

> +       /* 100ms delay required for PBIAS configuration */
> +       msleep(100);
> +       if (!vdd && host->pinctrl && host->pbias_off) {
> +               ret = pinctrl_select_state(host->pinctrl, host->pbias_off);
> +               if (ret < 0)
> +                       dev_err(host->dev, "pinctrl pbias_off select error\n");
> +       } else if (((1 << vdd) <= MMC_VDD_165_195) && host->pinctrl &&
> +                       host->pbias_1v8) {
> +               ret = pinctrl_select_state(host->pinctrl, host->pbias_1v8);
> +               if (ret < 0)
> +                       dev_err(host->dev, "pinctrl pbias_1v8 select error\n");
> +       } else if (((1 << vdd) > MMC_VDD_165_195) && host->pinctrl &&
> +                       host->pbias_3v) {
> +               ret = pinctrl_select_state(host->pinctrl, host->pbias_3v);
> +               if (ret < 0)
> +                       dev_err(host->dev, "pinctrl pbias_3v select error\n");
> +       }

So why does the pin control API control bias voltage?

This seem so intuitively wrong as it can possibly get, clearly this
is regulator territory.

This also looks strange from an MMC point of view.

It just seems these bits in these registers should be poked at
by the regulator world, not the pinctrl world. That the bits are
in the middle of pinctrl things does not really matter.

> +       usleep_range(350, 400);

And the regulator framework supports power-on delays.

Yours,
Linus Walleij
