From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 1/4] mmc: slot-gpio: switch to use flags when getting GPIO
Date: Thu, 14 Aug 2014 07:28:14 -0700
Message-ID: <CAAVeFuLxb+UhVT6xU5Wmuvo8pavEFi-Cdr4BEOb=uzeWnXrfBA@mail.gmail.com>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 12, 2014 at 10:25 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> When the slot GPIO driver gets the GPIO to be used for card
> detect, it is now possible to specify a flag to have the line
> set up as input. Get rid of the explicit setup call for input
> and use the flag.
>
> The extra argument works as there are transition varargs
> macros in place in the <linux/gpio/consumer.h> header, in
> the future we will make the flags argument compulsory.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks - I actually have a bunch of patches that update some other
drivers, will try to send them shortly...
