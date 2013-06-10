From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] mmc: omap_hsmmc: Remux pins to support SDIO interrupt
 and PM runtime
Date: Mon, 10 Jun 2013 18:03:15 +0200
Message-ID: <CACRpkdZ5CUvULBFpdHZ_AMotqfUdBcAQ63+8cT+r6TZ77bUWOA@mail.gmail.com>
References: <20130607214557.18581.75288.stgit@localhost>
	<20130607214957.18581.90624.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130607214957.18581.90624.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, Andreas Fenkart <afenkart@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 7, 2013 at 11:49 PM, Tony Lindgren <tony@atomide.com> wrote:

> On some omaps we need to remux MMC pins for PM, and for some omaps
> we need to remux the SDIO IRQ pin.
>
> Based on an earlier patch by Andreas Fenkart <afenkart@gmail.com>.
(...)
> +       host->pinctrl = devm_pinctrl_get(host->dev);
> +       if (IS_ERR(host->pinctrl)) {
> +               dev_dbg(host->dev, "no pinctrl handle\n");
> +               ret = 0;
> +               goto out;
> +       }
> +
> +       host->fixed = pinctrl_lookup_state(host->pinctrl,
> +                                          PINCTRL_STATE_DEFAULT);
> +       if (IS_ERR(host->fixed)) {
> +               dev_dbg(host->dev,
> +                        "pins are not configured from the driver\n");
> +               host->fixed = NULL;
> +               ret = 0;
> +               goto out;
> +       }
> +
> +       ret = pinctrl_select_state(host->pinctrl, host->fixed);
> +       if (ret < 0)
> +               goto err;
> +
> +       /* For most cases we don't have wake-ups, and exit after this */
> +       host->active = pinctrl_lookup_state(host->pinctrl, "active");
> +       if (IS_ERR(host->active)) {
> +               ret = PTR_ERR(host->active);
> +               host->active = NULL;
> +               return 0;
> +       }
> +
> +       host->idle = pinctrl_lookup_state(host->pinctrl,
> +                                         PINCTRL_STATE_IDLE);
> +       if (IS_ERR(host->idle)) {
> +               ret = PTR_ERR(host->idle);
> +               host->idle = NULL;
> +               goto err;
> +       }

You can use the new infrastructure to make the core select:

pinctrl_pm_select_default_state(host->dev);
pinctrl_pm_select_idle_state(host->dev);

What is the semantic difference between "default" and "active"?

If this is something very generic that a lot of platforms will want
to have, why not add it to include/linux/pinctrl/pinctrl-state.h
and augment the core to cache and handle this too?

However in this case I *suspect* that what you really want
to do it to rename the state called "default" to "sleep"
(it appears the default state is sleepy) and then rename
the "active" state to "default" (as this is the defined semantic
meaning of "default" from <linux/pinctrl/pinctrl-state.h>.

But maybe I'm not quite getting the subtle difference between
"default" and "active" here so enlighten me.

Yours,
Linus Walleij
