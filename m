From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document
 pinctrl-ingenic
Date: Mon, 30 Jan 2017 14:36:17 -0600
Message-ID: <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20170125185207.23902-2-paul@crapouillou.net>
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
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 25, 2017 at 07:51:54PM +0100, Paul Cercueil wrote:
> This commit adds documentation for the devicetree bidings of the
> pinctrl-ingenic driver, which handles pin configuration and pin
> muxing of the Ingenic SoCs currently supported by the Linux kernel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/pinctrl/ingenic,pinctrl.txt           | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
> 
> v2: Rewrote the documentation for the new pinctrl-ingenic driver
> v3: No changes
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
> new file mode 100644
> index 000000000000..ead5b01ad471
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
> @@ -0,0 +1,77 @@
> +Ingenic jz47xx pin controller
> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices, including the meaning of the
> +phrase "pin configuration node".
> +
> +For the jz47xx SoCs, pin control is tightly bound with GPIO ports. All pins may
> +be used as GPIOs, multiplexed device functions are configured within the
> +GPIO port configuration registers and it is typical to refer to pins using the
> +naming scheme "PxN" where x is a character identifying the GPIO port with
> +which the pin is associated and N is an integer from 0 to 31 identifying the
> +pin within that GPIO port. For example PA0 is the first pin in GPIO port A, and
> +PB31 is the last pin in GPIO port B. The jz4740 contains 4 GPIO ports, PA to
> +PD, for a total of 128 pins. The jz4780 contains 6 GPIO ports, PA to PF, for a
> +total of 192 pins.

>From the overlapping register addresses in the examples and this 
description, it looks like the pinctrlr and gpio controller are 1 block. 
If so, then there should only be 1 node.

Rob
