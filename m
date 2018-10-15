From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFT PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO bitmap
Date: Mon, 15 Oct 2018 16:27:10 +0200
Message-ID: <CACRpkdYB1Wz8VC3aDpB_4KQcdbE-_Fy48zF_idKDM0pqiOEnXg@mail.gmail.com>
References: <20180925192433.1377-1-jmkrzyszt@gmail.com> <20181012190901.1243-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012190901.1243-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Kukjin Kim <kgene@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, ext Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 12, 2018 at 9:07 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
> get/set array") changed the way GPIO values are passed to
> gpiod_get/set_array_value() and friends.  The new code introduced into
> mmc_pwrseq_simple_set_gpios_value() incorrectly interpretes the 'value'
> argument as a bitmap of GPIO values and assigns it directly to the
> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
> instead of filling that bitmap with bits equal to the 'value' argument.
> As a result, only member 0 of the array is handled correctly.
>
> Moreover, wrong assumption is taken about the 'values' bitmap size not
> exceding the number of bits of the 'value' argument type.
>
> Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied with Ulf's and Marek's tags!

Yours,
Linus Walleij
