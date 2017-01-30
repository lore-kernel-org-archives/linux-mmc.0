From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 02/14] Documentation: dt/bindings: Document
 pinctrl-gpio
Date: Mon, 30 Jan 2017 14:33:12 -0600
Message-ID: <20170130203312.xsvu6rk2sz66m43a@rob-hp-laptop>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-3-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33640 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbdA3UdO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 15:33:14 -0500
Content-Disposition: inline
In-Reply-To: <20170125185207.23902-3-paul@crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com

On Wed, Jan 25, 2017 at 07:51:55PM +0100, Paul Cercueil wrote:
> This commit adds documentation for the devicetree bidings of the

s/biding/bindings/

> pinctrl-gpio driver, which handles GPIOs of the Ingenic SoCs
> currently supported by the Linux kernel.

The subject makes no reference that this binding is for Ingenic GPIO. 
Also, drop the "Documentation: " part. It's redundant.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/gpio/ingenic,gpio.txt      | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> 
> v2: New patch
> v3: No changes
> 
> diff --git a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> new file mode 100644
> index 000000000000..b2eb20494365
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> @@ -0,0 +1,45 @@
> +Ingenic jz47xx GPIO controller
> +
> +Required properties:
> +  - compatible:
> +    - "ingenic,jz4740-gpio" for the JZ4740 SoC
> +    - "ingenic,jz4780-gpio" for the JZ4780 SoC
> +
> +  - reg: Base address and length of each memory resource used by the GPIO
> +    controller hardware module.
> +
> +  - gpio-controller: Marks the device node as a GPIO controller.
> +  - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
> +    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
> +    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
> +  - gpio-ranges: Range of pins managed by the GPIO controller.
> +
> +Optional properties:
> +  - base: The GPIO number to use as the base for this driver.

Drop this please. This is a Linuxism.

> +  - interrupt-controller: Marks the device node as an interrupt controller.
> +  - interrupts: Interrupt specifier for the controllers interrupt.
> +    Required if 'interrupt-controller' is specified.

Some h/w doesn't have interrupt capability? If not, this should not be 
optional.

> +
> +Please refer to gpio.txt in this directory for details of gpio-ranges property
> +and the common GPIO bindings used by client devices.
> +
> +The GPIO controller also acts as an interrupt controller. It uses the default
> +two cells specifier as described in Documentation/devicetree/bindings/
> +interrupt-controller/interrupts.txt.

Just document #interrupt-cells and its value and drop this paragraph.

> +
> +Example:
> +
> +gpa: gpio-controller@10010000 {
> +	compatible = "ingenic,jz4740-gpio";
> +	reg = <0x10010000 0x100>;
> +
> +	gpio-controller;
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +	#gpio-cells = <2>;
> +
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +
> +	interrupt-parent = <&intc>;
> +	interrupts = <28>;
> +};
> -- 
> 2.11.0
> 
