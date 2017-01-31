From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
Date: Tue, 31 Jan 2017 15:16:37 +0100
Message-ID: <CACRpkdbzzF7jSHZZD2dCixeVZDLVa3R7-1avXwyKc1-RQDK9jw@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-7-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20170125185207.23902-7-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-p
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 25, 2017 at 7:51 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> For a description of the pinctrl devicetree node, please read
> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>
> For a description of the gpio devicetree nodes, please read
> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/jz4740.dtsi | 194 +++++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
>
> v2: Changed the devicetree bindings to match the new driver
> v3: No changes

This looks good to me, except the use of ingenic,pins instead
of just pins and the GPIO base property
which needs to be removed from the DT bindings and
the driver alike.

But now we're discussing where to put these GPIO controllers
in the device tree in another thread. Maybe as subnodes of the
pin controller...

Yours,
Linus Walleij
