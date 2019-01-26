From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] mmc: jz4740: Remove platform data and use standard APIs
Date: Sat, 26 Jan 2019 13:10:37 +0100
Message-ID: <CACRpkdbhgpkEJ2B2bEDpmM9WLHxUxM8SWhWw28Of5ZRcZ7okSA@mail.gmail.com>
References: <20190125200927.21045-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125200927.21045-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-mips@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 25, 2019 at 9:09 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Drop the custom code to get the 'cd' and 'wp' GPIOs. The driver now
> calls mmc_of_parse() which will init these from devicetree or
> device properties.
>
> Also drop the custom code to get the 'power' GPIO. The MMC core
> provides us with the means to power the MMC card through an external
> regulator.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Execellent patching!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

For all three patches.

Yours,
Linus Walleij
