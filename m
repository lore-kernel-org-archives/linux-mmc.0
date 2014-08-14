From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 2/4] mmc: slot-gpio: add gpiod variant to get wp GPIO
Date: Thu, 14 Aug 2014 07:32:39 -0700
Message-ID: <CAAVeFuKS=V+du+HEBHikzX6VCjOxJEB_LCbPYthMVNRPSPLQ=g@mail.gmail.com>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org> <1407864355-21545-2-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1407864355-21545-2-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 12, 2014 at 10:25 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This makes it possible to get the write protect (read only)
> GPIO line from a GPIO descriptor. Written to exactly mirror
> the card detect function.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
