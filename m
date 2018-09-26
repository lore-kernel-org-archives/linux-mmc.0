From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO bitmap
Date: Wed, 26 Sep 2018 09:50:18 +0200
Message-ID: <CACRpkdaXE7Me8Q0Rrcooo_v_2oBJN1RSGUNHYudtTGQY7x8kqg@mail.gmail.com>
References: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
 <20180925192433.1377-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925192433.1377-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 25, 2018 at 9:23 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
> get/set array") changed the way GPIO values are passed to
> gpiod_get/set_array_value() and friends.  The updated code of
> mmc_pwrseq_simple_set_gpios_value() incorrectly uses the 'value'
> argument as a bitmap of GPIO values and assigns it directly to the
> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
> instead of filling that bitmap with bits equal to the 'value' argument.
> As a result, boot hanging caused by incorrectly handled MMC device
> has been observed.
>
> As a side effect of that incorrect interpreation of the 'value'
> argument, wrong assumption is taken about the 'values' bitmap size
> never exceding the number of bits of the 'value' argument type.
>
> Fix it.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Nice!

Provided this works, Ulf can I have your ACK so I can queue this
with the rest of the gpio array rework in the GPIO tree?

Yours,
Linus Walleij
