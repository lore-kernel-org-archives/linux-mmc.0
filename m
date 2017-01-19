From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 09/13] mmc: jz4740: Let the pinctrl driver configure the pins
Date: Thu, 19 Jan 2017 11:55:41 +0100
Message-ID: <CAPDyKFp4idZx+ynQByz22zwsiK+reBcvt3OdHm1kR2QUy+sUhw@mail.gmail.com>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-10-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33596 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbdASKzn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 05:55:43 -0500
Received: by mail-wm0-f52.google.com with SMTP id d140so4867035wmd.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 02:55:43 -0800 (PST)
In-Reply-To: <20170117231421.16310-10-paul@crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, Linux

[...]

>
> -#ifdef CONFIG_PM_SLEEP
> -
> -static int jz4740_mmc_suspend(struct device *dev)
> -{
> -       struct jz4740_mmc_host *host = dev_get_drvdata(dev);
> -
> -       jz_gpio_bulk_suspend(jz4740_mmc_pins, jz4740_mmc_num_pins(host));
> -

Shouldn't this be replaced with a call to:
pinctrl_pm_select_sleep_state();

> -       return 0;
> -}
> -
> -static int jz4740_mmc_resume(struct device *dev)
> -{
> -       struct jz4740_mmc_host *host = dev_get_drvdata(dev);
> -
> -       jz_gpio_bulk_resume(jz4740_mmc_pins, jz4740_mmc_num_pins(host));

Shouldn't this be replaced with a call to:
pinctrl_pm_select_default_state();

[...]

Kind regards
Uffe
