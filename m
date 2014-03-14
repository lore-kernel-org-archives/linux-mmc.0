From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/6] mmc: slot-gpio: Add GPIO descriptor based CD GPIO API
Date: Fri, 14 Mar 2014 10:07:53 +0100
Message-ID: <CACRpkdYmqOQQm9zJSCC=Riq4zKsPyYOJN+ffEY-9Uc73=zZcuQ@mail.gmail.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
	<1394456564-13783-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:33034 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743AbaCNJHy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Mar 2014 05:07:54 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so2278185oag.7
        for <linux-mmc@vger.kernel.org>; Fri, 14 Mar 2014 02:07:53 -0700 (PDT)
In-Reply-To: <1394456564-13783-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ulf Hansson <ulf.hansson@linaro.org>

On Mon, Mar 10, 2014 at 2:02 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add functions to request a CD GPIO using the GPIO
> descriptor API.  Note that the new request function
> is paired with mmc_gpiod_free_cd() not mmc_gpio_free_cd().
> Note also that it must be called prior to mmc_add_host()
> otherwise the caller must also call mmc_gpiod_request_cd_irq().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This is very helpful.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
