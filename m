From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Thu, 13 Jun 2013 14:39:53 +0200
Message-ID: <CACRpkdbQPqbMdFo6kTEriY4DhLcyZBA7Umxjvdh9OGVHJJe4dw@mail.gmail.com>
References: <20130523184045.GD13507@atomide.com>
	<1370546059-24181-1-git-send-email-balajitk@ti.com>
	<1370546059-24181-7-git-send-email-balajitk@ti.com>
	<CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
	<20130613095353.GX8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34316 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab3FMMjy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2013 08:39:54 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so8419295iec.22
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jun 2013 05:39:53 -0700 (PDT)
In-Reply-To: <20130613095353.GX8164@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Balaji T K <balajitk@ti.com>, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Jun 13, 2013 at 11:53 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [130613 02:42]:
>> On Thu, Jun 6, 2013 at 9:14 PM, Balaji T K <balajitk@ti.com> wrote:
>> > +       /* 100ms delay required for PBIAS configuration */
>> > +       msleep(100);
>> > +       if (!vdd && host->pinctrl && host->pbias_off) {
>> > +               ret = pinctrl_select_state(host->pinctrl, host->pbias_off);
>> > +               if (ret < 0)
>> > +                       dev_err(host->dev, "pinctrl pbias_off select error\n");
>> > +       } else if (((1 << vdd) <= MMC_VDD_165_195) && host->pinctrl &&
>> > +                       host->pbias_1v8) {
>> > +               ret = pinctrl_select_state(host->pinctrl, host->pbias_1v8);
>> > +               if (ret < 0)
>> > +                       dev_err(host->dev, "pinctrl pbias_1v8 select error\n");
>> > +       } else if (((1 << vdd) > MMC_VDD_165_195) && host->pinctrl &&
>> > +                       host->pbias_3v) {
>> > +               ret = pinctrl_select_state(host->pinctrl, host->pbias_3v);
>> > +               if (ret < 0)
>> > +                       dev_err(host->dev, "pinctrl pbias_3v select error\n");
>> > +       }
>>
>> So why does the pin control API control bias voltage?
>
> I agree, it should be a regulator for the MMC driver and that's what I
> already suggested earlier. Having it as a regulator allows us to get
> rid of all the non-standard before and after calls in the omap_hsmmc.c.
> This way the omap_hsmmc.c code can handle the internal and external
> voltages the same way.

So someone is not taking the OMAP maintainers word for it and
instead trying to push this past the pinctrl maintainer?

Grrr.... OK I'll assume good faith and I therefore conclude that
this must have been just some kind of mistake in the act.

Yours,
Linus Walleij
