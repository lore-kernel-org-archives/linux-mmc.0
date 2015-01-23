From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO pin
Date: Fri, 23 Jan 2015 16:56:12 +0100
Message-ID: <CABxcv=nGWPnkNz1tXJpaTUkroucDgVYzeCrEmZvA8xfzHzROvg@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:41007 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbbAWP4O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jan 2015 10:56:14 -0500
Received: by mail-wg0-f53.google.com with SMTP id a1so8217152wgh.12
        for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2015 07:56:13 -0800 (PST)
In-Reply-To: <1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Rutland <mark.rutland@arm.com>

Hello Ulf,

On Mon, Jan 19, 2015 at 10:13 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>  int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>  {
>         struct mmc_pwrseq_simple *pwrseq;
> +       int ret = 0;
>
>         pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
>         if (!pwrseq)
>                 return -ENOMEM;
>
> +       pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);

Any reason to not use the devm_gpiod_get_index() managed version instead?

AFAICT mmc_free_host() will free the device so in that case you won't
need to call gpiod_put() in mmc_pwrseq_simple_free().

This will also make easier to extend pwrseq_simple to support multiple
GPIOs like the DT binding implies.

Best regards,
Javier
