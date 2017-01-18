From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 05/13] MIPS: jz4740: DTS: Add node for the jz4740-pinctrl driver
Date: Thu, 19 Jan 2017 00:50:29 +0100
Message-ID: <CACRpkdZ-2-mOiEwiRUoMU+X4RG1jik7edPK0nsu_kYy5Pi7N1g@mail.gmail.com>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-6-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170117231421.16310-6-paul@crapouillou.net>
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

On Wed, Jan 18, 2017 at 12:14 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> For a description of the devicetree node, please read
> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

(...)

> +       pinctrl: ingenic-pinctrl@10010000 {
> +               compatible = "ingenic,jz4740-pinctrl";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               gpio-chips {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       gpa: gpa {
> +                               reg = <0x10010000 0x100>;
> +
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +
> +                               interrupt-parent = <&intc>;
> +                               interrupts = <28>;
> +
> +                               ingenic,pull-ups = <0xffffffff>;
> +                       };
> +
> +                       gpb: gpb {
> +                               reg = <0x10010100 0x100>;
> +
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +
> +                               interrupt-parent = <&intc>;
> +                               interrupts = <27>;
> +
> +                               ingenic,pull-ups = <0xffffffff>;
> +                       };
> +
> +                       gpc: gpc {
> +                               reg = <0x10010200 0x100>;
> +
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +
> +                               interrupt-parent = <&intc>;
> +                               interrupts = <26>;
> +
> +                               ingenic,pull-ups = <0xffffffff>;
> +                       };
> +
> +                       gpd: gpd {
> +                               reg = <0x10010300 0x100>;
> +
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +
> +                               interrupt-parent = <&intc>;
> +                               interrupts = <25>;
> +
> +                               ingenic,pull-ups = <0xdfffffff>;
> +                       };
> +               };

Just pull all these down two levels and make them one device
each instead of having them inside the pin controller node
like this.

Then make a pin controller node separately, it can reference the
pin controller by phandles if necessary, and use the standard
gpio-ranges property to cross make GPIO and pin control.

It seems you driver is similar to for example the
drivers/pinctrl/nomadik/* pin controller.

Look in arch/arm/boot/dts/ste-dbx500.dtsi for examples,
NB: I'm not fully using standard bindings in it, because they
were not invented at the time.

Yours,
Linus Walleij
