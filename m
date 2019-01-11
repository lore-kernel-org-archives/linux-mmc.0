From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1] mmc: core: don't override the CD GPIO level when
 "cd-inverted" is set
Date: Fri, 11 Jan 2019 15:28:44 +0100
Message-ID: <CACRpkdYTQjiPbLGQ8E_mByAY0e_byN8iW=jBVPw3QRxh4_fB_A@mail.gmail.com>
References: <20190101194414.24766-1-martin.blumenstingl@googlemail.com> <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 1, 2019 at 8:44 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> Since commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> tree") gpiolib-of parses the "cd-gpios" property and flips the polarity
> if "cd-inverted" is also set. This results in the "cd-inverted" property
> being evaluated twice, which effectively makes it a no-op:
> - first in drivers/gpio/gpiolib-of.c (of_xlate_and_get_gpiod_flags) when
>   setting up the CD GPIO
> - then again in drivers/mmc/core/slot-gpio.c (mmc_gpio_get_cd) when
>   reading the CD GPIO value at runtime
>
> On boards which are using device-tree with the "cd-inverted" property
> being set any inserted card are not detected anymore. This is due to the
> MMC core treating the CD GPIO with the wrong polarity.
>
> Disable "override_cd_active_level" for the card detection GPIO which is
> parsed using mmc_of_parse. This fixes SD card detection on the boards
> which are currently using the "cd-inverted" device-tree property (tested
> on Meson8b Odroid-C1 and Meson8b EC-100).
>
> This does not remove the CD GPIO inversion logic from the MMC core
> because there's at least one driver (sdhci-pci-core for Intel BayTrail
> based boards) which still passes "override_cd_active_level = true" to
> mmc_gpiod_request_cd(). Due to lack of hardware for testing this is left
> untouched.
> In the future the GPIO inversion logic for both, card and read-only
> detection can be removed once no driver is using it anymore.
>
> Fixes: 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I applied this to the GPIO fixes with the ACKs.

Ulf is on vacation but I managed to get his ACK over chat,
so I will try to get this upstream ASAP.

Yours,
Linus Walleij
