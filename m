From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio: devm_gpio_* support should not depend on GPIOLIB
Date: Thu, 17 Jan 2013 14:31:06 +0100
Message-ID: <CACRpkdZ+L6GN_1_wSkckZY553jsG3wTEdwM27dp+cyCAjH5tpA@mail.gmail.com>
References: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
	<1358239056-703-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:39035 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab3AQNbH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jan 2013 08:31:07 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so4717742iej.4
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jan 2013 05:31:07 -0800 (PST)
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

Fair enough, but I need the first patch in an applicable for first...

Yours,
Linus Walleij
