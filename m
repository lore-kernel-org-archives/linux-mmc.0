From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio: devm_gpio_* support should not depend on GPIOLIB
Date: Thu, 17 Jan 2013 15:11:28 +0100
Message-ID: <CACRpkdYChO_YxXj=QcN6nDQebxuHGTZnX29P=t7F=X72Er=onw@mail.gmail.com>
References: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
	<1358239056-703-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64581 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab3AQOL2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jan 2013 09:11:28 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so4758457iea.35
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jan 2013 06:11:28 -0800 (PST)
In-Reply-To: <1358239056-703-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 15, 2013 at 9:37 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Some architectures (e.g. blackfin) provide gpio API without requiring
> GPIOLIB support (ARCH_WANT_OPTIONAL_GPIOLIB).  devm_gpio_* functions
> should also work for these architectures, since they do not really
> depend on GPIOLIB.
>
> Add a new option GPIO_DEVRES (enabled by default) to control the build
> of devres.c, and move devm_gpio_* function declarations out from #ifdef
> CONFIG_GPIOLIB in include/asm-generic/gpio.h, so that they can be
> available to client drivers without unnecessary dependency on GPIOLIB.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Patch applied, thanks!

Yours,
Linus Walleij
