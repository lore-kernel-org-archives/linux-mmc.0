From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mmc: mmci.c: Defer probe() in case of yet uninitialized GPIOs
Date: Sat, 16 Jun 2012 17:23:23 +0000
Message-ID: <201206161723.23768.arnd@arndb.de>
References: <1339865375-22314-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61527 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333Ab2FPRXk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jun 2012 13:23:40 -0400
In-Reply-To: <1339865375-22314-1-git-send-email-stigge@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Roland Stigge <stigge@antcom.de>, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, sebastian.rasmussen@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com

On Saturday 16 June 2012, Roland Stigge wrote:
> +       if (of_get_property(np, "wp-gpios", NULL)) {
> +               pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
> +               if (pdata->gpio_wp == -ENODEV)
> +                       pdata->gpio_wp = -EPROBE_DEFER;
> +       } else {
> +               pdata->gpio_wp = -ENODEV;
> +       }

This is still very ugly and there is a certain danfer that we might
have to duplicate this across more drivers. Can't we make
of_get_named_gpio_flags return -EPROBE_DEFER in cases where we can't
find the GPIO number yet but still have a chance of returning it at
a later point?

	Arnd
