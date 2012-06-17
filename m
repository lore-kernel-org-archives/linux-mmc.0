From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: of_get_named_gpio_flags() return -EPROBE_DEFER if
 GPIO not yet available
Date: Sun, 17 Jun 2012 20:04:47 +0200
Message-ID: <CACRpkdZeBiTX6hOu_PyrhZ8VA0uD3kz47a1p9Uo30S=w7U2O6A@mail.gmail.com>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339927893-8842-1-git-send-email-stigge@antcom.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Jun 17, 2012 at 12:11 PM, Roland Stigge <stigge@antcom.de> wrote:

> of_get_named_gpio_flags() and of_get_named_gpio() return -EPROBE_DEFER if the
> respective GPIO is not (yet) available. This is useful if driver's probe()
> functions try to get a GPIO whose controller isn't probed yet. Thus, the driver
> can be probed again later on.
>
> The function still returns -EINVAL on other errors (parse error or node doesn't
> exist). This way, the case of an optional/intentionally missing GPIO is handled
> appropriately.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This will work, good work!
Yours,
Linus Walleij
