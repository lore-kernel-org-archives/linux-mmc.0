From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
Date: Sat, 14 Jul 2012 21:57:08 +0200
Message-ID: <CACRpkdYrZizqvZqsocLEGrkY5yPMuYFfmR3UUSFZgPDvEPa0eA@mail.gmail.com>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:45516 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab2GNT5J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Jul 2012 15:57:09 -0400
Received: by qadb17 with SMTP id b17so946419qad.19
        for <linux-mmc@vger.kernel.org>; Sat, 14 Jul 2012 12:57:08 -0700 (PDT)
In-Reply-To: <1340836334-20427-1-git-send-email-stigge@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: cjb@laptop.org, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org

On Thu, Jun 28, 2012 at 12:32 AM, Roland Stigge <stigge@antcom.de> wrote:

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
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

If I understand correctly this relates closely to another patch from Mark Brown
we discussed the other day (sorry for missing this patch, which arrived
earlier, for a while).

Mark/Grant can you look at this patch?

Yours,
Linus Walleij
