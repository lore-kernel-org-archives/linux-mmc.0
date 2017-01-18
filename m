From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/13] Documentation: dt/bindings: Document pinctrl-ingenic
Date: Thu, 19 Jan 2017 00:45:19 +0100
Message-ID: <CACRpkdZAGHHpCyR4d8dJv=hTRTS6-zkX-2-GarLXnNf_2QO2UQ@mail.gmail.com>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170117231421.16310-2-paul@crapouillou.net>
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

> From: Paul Burton <paul.burton@imgtec.com>
>
> This commit adds documentation for the devicetree bidings of the
> pinctrl-ingenic driver, which handles pin configuration, pin muxing
> and GPIOs of the Ingenic SoCs currently supported by the Linux kernel.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

(...)

> +##### 'gpio-chips' sub-node #####
> +
> +The gpio-chips node will contain sub-nodes that correspond to GPIO controllers
> +(one sub-node per GPIO controller).
> +
> +Required properties:
> +- #address-cells: Should contain the integer 1.
> +- #size-cells: Should contain the integer 1.
> +- ranges: Should be empty.

I do not see why the GPIO needs a special subnode. Can the pin controller
and the GPIO not simply spawn from a single node?

> +##### GPIO controller node #####
> +
> +Each subnode of the 'gpio-chips' node is a GPIO controller node.
> +
> +Required properties:
> +- gpio-controller: Identifies this node as a GPIO controller.
> +- #gpio-cells: Should contain the integer 2.
> +- reg: Should contain the physical address and length of the GPIO controller's
> +  configuration registers.
> +
> +Optional properties:
> +- interrupt-controller: The GPIO controllers can optionally configure the
> +  GPIOs as interrupt sources. In this case, the 'interrupt-controller'
> +  standalone property should be supplied.
> +- #interrupt-cells: Required if 'interrupt-controller' is also specified.
> +  In that case, it should contain the integer 2.
> +- interrupts: Required if 'interrupt-controller' is also specified.
> +  In that case, it should contain the IRQ number of this GPIO controller.
> +- ingenic,pull-ups: A bit mask identifying the pins associated with this GPIO
> +  port which feature a pull-up resistor. The default mask is 0x0.
> +- ingenic,pull-downs: A bit mask identifying the pins associated with this GPIO
> +  port which feature a pull-down resistor. The default mask is 0x0.

So these bits tell us which lines have a pull up and pull down resistor?

Isn't that readily know from the compatible string? Then just hardcode
that into the driver for each variant, there is no need to define that in
the device tree.

> +##### Pin function node #####
> +
> +Each subnode of the 'functions' node is a pin function node.
> +
> +These subnodes represent a functionality of the SoC which may be exposed
> +through one or more groups of pins, represented as subnodes of the pin
> +function node. For example a function may be uart0, which may be exposed
> +through the group of pins PF0 to PF3.
> +
> +Required pin function node properties:
> +- None.
> +
> +
> +##### Pin group node #####
> +
> +Each subnode of a pin function node is a pin group node.
> +
> +Required pin group node properties:
> +- ingenic,pins: A set of values representing the pins within this pin group and
> +  their configuration.

Look into using the standard pins property from the pinctrl bindings
if yoy want to do this.

> Four values should be provided for each pin:
> +  - The phandle of the GPIO controller node for the GPIO port within which the
> +    pin is found.
> +  - The index of the pin within its GPIO port (an integer in the range 0 to 31
> +    inclusive).

This is already supported by gpio ranges, please do not reimplement
stuff we already have.

> +  - The index of the shared function port to be programmed in the GPIO port
> +    registers for this pin.

I don't see why this can not be stored in the driver.
But some people prefer to shovel everything into the device
tree, I don't know. Can you elaborate why this should be in the
device tree?

> +  - The phandle of a pin configuration node specifying the electrical
> +    configuration that should be applied to the pin.

Why? This is something the standard pin control states handles.
I'm confused.

> +For example the function 'msc0' may be exposed through 2 different pin groups,
> +one in GPIO port A and one in GPIO port E:
> +
> +  bias-configs {
> +    nobias: nobias {
> +      bias-disable;
> +    };
> +  };
> +
> +  functions {
> +    pinfunc_msc0: msc0 {
> +      pins_msc0_pa: msc0-pa {
> +        ingenic,pins = <&gpa  4 1 &nobias   /* d4 */
> +                        &gpa  5 1 &nobias   /* d5 */
> +                        &gpa  6 1 &nobias   /* d6 */
> +                        &gpa  7 1 &nobias   /* d7 */
> +                        &gpa 18 1 &nobias   /* clk */
> +                        &gpa 19 1 &nobias   /* cmd */
> +                        &gpa 20 1 &nobias   /* d0 */
> +                        &gpa 21 1 &nobias   /* d1 */
> +                        &gpa 22 1 &nobias   /* d2 */
> +                        &gpa 23 1 &nobias   /* d3 */
> +                        &gpa 24 1 &nobias>; /* rst */
> +      };

Please look at other bindings and drivers and read pinctrl.txt
closely. This makes no sense to me compared to other
examples.

This is something that seems to cross-mix gpio ranges
and pin config, that doesn't work for me, we can't have an
idiomatic binding like this. I understand that it may fit your
single usecase perfectly but it will be a maintenance nightmare
for me.

Yours,
Linus Walleij
