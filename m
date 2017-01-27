From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
Date: Fri, 27 Jan 2017 12:18:39 +0100
Message-ID: <CACRpkdZFRH84c4x7HBwgmY3fH+=Qq4q167c9oPhvrJ70MQkjaA@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net> <20170122144947.16158-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170122144947.16158-2-paul@crapouillou.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-p
List-Id: linux-mmc@vger.kernel.org

On Sun, Jan 22, 2017 at 3:49 PM, Paul Cercueil <paul@crapouillou.net> wrote:


> +Required properties:
> +- compatible: One of:
> +  - "ingenic,jz4740-pinctrl"
> +  - "ingenic,jz4780-pinctrl"
> +
> +Optional properties:
> +- ingenic,pull-ups: A list of 32-bit bit fields, where each bit set tells the
> +  driver that a pull-up resistor is available for this pin.
> +  By default, the driver considers that all pins feature a pull-up resistor.
> +- ingenic,pull-downs: A list of 32-bit bit fields, where each bit set tells
> +  the driver that a pull-down resistor is available for this pin.
> +  By default, the driver considers that all pins feature a pull-down
> +  resistor.

So I still don't understand these properties.

Does this mean that there is a pull-up *inside* the SoC or *outside*
on the board where it is mounted?

If it is *outside* the SoC, on the board, the pulls should be set on
the consumers, not on the controller.

In the former case, if this pertains to the *inside* of the SoC:
is it just different between jz4740 and jz4780?
In that case, just code this into the driver as .data to the .compatible
in the DT match. No special DT properties needed.

If it is different between e.g. different versions of jz4740, why not
make different compatible-properties? If there are different versions
of the circuit, with different hard-wired hardware configuration, they
are different devices and should have different compatible strings.

> +                               /* CLK, CMD, D0 */
> +                               ingenic,pins = <0x69 0 0x68 0 0x6a 0>;

Standard bindings use just "pins". Why the custom ingenic,
prefix?

Yours,
Linus Walleij
