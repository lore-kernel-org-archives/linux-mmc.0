From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 07/10] pinctrl: add pinctrl driver for Rockchip SoCs
Date: Tue, 4 Jun 2013 09:08:09 +0200
Message-ID: <CACRpkdbBr7s1NoTQewVOotorHJHLL8Z6-_gAx5GC0x6uNUX0gw@mail.gmail.com>
References: <201306030055.15413.heiko@sntech.de>
	<201306030059.47611.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:60109 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759028Ab3FDHIK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2013 03:08:10 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so8788620obq.21
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2013 00:08:09 -0700 (PDT)
In-Reply-To: <201306030059.47611.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Stephen Warren <swarren@wwwdotorg.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Mon, Jun 3, 2013 at 12:59 AM, Heiko St=FCbner <heiko@sntech.de> wrot=
e:

> This driver adds support the Cortex-A9 based SoCs from Rockchip,
> so at least the RK2928, RK3066 (a and b) and RK3188.
> Earlier Rockchip SoCs seem to use similar mechanics for gpio
> handling so should be supportable with relative small changes.
> Pull handling on the rk3188 is currently a stub, due to it being
> a bit different to the earlier SoCs.
>
> Pinmuxing as well as gpio (and interrupt-) handling tested on
> a rk3066a based machine.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Overall this is looking very good, mainly minor comments.

> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip-pinctrl.txt

Please name this beginning with the vendor and similar to
the compatible string: rockchip,pinctrl or something.
(Check the neighbors.)

(...)
> +Required properties for gpio sub nodes:
> +  - compatible: "rockchip,gpio-bank"
> +  - reg: register of the gpio bank (different than the iomux registe=
rset)
> +  - interrupts: base interrupt of the gpio bank in the interrupt con=
troller
> +  - clocks: clock that drives this bank
> +  - gpio-controller: identifies the node as a gpio controller and pi=
n bank.
> +  - #gpio-cells: number of cells in GPIO specifier. Since the generi=
c GPIO
> +    binding is used, the amount of cells must be specified as 2. See=
 generic
> +    GPIO binding documentation for description of particular cells.
> +  - interrupt-controller: identifies the controller node as interrup=
t-parent.
> +  - #interrupt-cells: the value of this property should be 2.
> +     - First Cell: represents the external gpio interrupt number loc=
al to the
> +       external gpio interrupt space of the controller.
> +     - Second Cell: flags to identify the type of the interrupt
> +       - 1 =3D rising edge triggered
> +       - 2 =3D falling edge triggered
> +       - 3 =3D rising and falling edge triggered
> +       - 4 =3D high level triggered
> +       - 8 =3D low level triggered

Can't you just reference
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt?

> +Required properties for pin configuration node:
> +  - rockchip,pins: 4 integers array, represents a group of pins mux =
and config
> +    setting. The format is rockchip,pins =3D <PIN_BANK PIN_BANK_NUM =
MUX CONFIG>.
> +    The MUX 0 means gpio and MUX 1 to 3 mean the specific device fun=
ction
> +
> +Bits used for CONFIG:
> +PULL_AUTO      (1 << 0): indicate this pin needs a pull setting for =
SoCs
> +                         that determine the pull up or down themself=
s

Hm, never saw that before...

(...)
> +       uart2 {
> +               uart2_xfer: uart2-xfer {
> +                       rockchip,pins =3D <RK_GPIO1 8 1 RK_PINCTRL_PU=
LL_AUTO>,
> +                                       <RK_GPIO1 9 1 RK_PINCTRL_PULL=
_AUTO>;
> +               };

This looks like you're using #include to define these constants,
probably you should include that in the example or mention it?

> +uart2: serial@20064000 {
> +       compatible =3D "snps,dw-apb-uart";
> +       reg =3D <0x20064000 0x400>;
> +       interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;

Using #defines, nice!

(...)
+++ b/drivers/pinctrl/Kconfig
@@ -158,6 +158,12 @@ config PINCTRL_DB8540
        bool "DB8540 pin controller driver"
        depends on PINCTRL_NOMADIK && ARCH_U8500

+config PINCTRL_ROCKCHIP
+       bool
+       select PINMUX
+       select PINCONF
+       select GENERIC_IRQ_CHIP

Why is this super-simple pin config thing not using
GENERIC_PINCONF?

I *know* it is simpler to implement your own thing, but think of the
poor maintainers that have to wade through 50 identical implementations=
=2E
Do this, it pays off.

BTW: it leads to wanting to use generic pinconf DT bindings as experien=
ced
by Laurent and others. We need to fix that too...

(...)
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> +static void rockchip_pin_dbg_show(struct pinctrl_dev *pctldev,
> +                                       struct seq_file *s, unsigned =
offset)
> +{
> +       seq_printf(s, "%s", dev_name(pctldev->dev));
> +}

Nothing else you want to say about the pins here?
(No big deal for sure, but....)

> +static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin=
_num)
> +{
> +       struct rockchip_pinctrl *info =3D bank->drvdata;
> +       void __iomem *reg;
> +       int bit;

Is that really an int? I'd guess more like u8...

> +       u32 data;
> +
> +       /* rk3066b does support any pulls */
> +       if (!info->ctrl->pull_offset)
> +               return 0;
> +
> +       reg =3D info->reg_base + info->ctrl->pull_offset;
> +
> +       if (info->ctrl->pull_auto) {
> +               reg +=3D bank->bank_num * 8;

I'd define some constant like

#define RK_BANK_STRIDE 8
reg +=3D bank->bank_num * RK_BANK_STRIDE;
(Since 8 bytes of stride is no natural law.)

And then use that here and elsewhere.

> +               reg +=3D (pin_num / 16) * 4;
> +               bit =3D pin_num % 16;

This is clear however.

> +
> +               data =3D readl_relaxed(reg);
> +               data >>=3D bit;
> +               data &=3D 1;
> +
> +               return !data;


That's a bit hard to read, I'd just:

#include <linux/bitops.h>
return !(readl_relaxed(reg) & BIT(bit));

And skip the "data" variable. The ! operator will
clamp this to a bool (0/1).

But we all have our habits.

> +static int rockchip_set_pull(struct rockchip_pin_bank *bank,
> +                                       int pin_num, int pull)

Similar comments for this function.

> +static int rockchip_pmx_gpio_set_direction(struct pinctrl_dev *pctld=
ev,
> +                                             struct pinctrl_gpio_ran=
ge *range,
> +                                             unsigned offset, bool i=
nput)
(...)
> +       /* set bit to 1 for output, 0 for input */
> +       if (!input)
> +               data |=3D (1 << pin);
> +       else
> +               data &=3D ~(1 << pin);

Here again I would use <linux/bitops.h> and:

data |=3D BIT(pin);

etc, but it's a matter of taste so if you prefer this, do keep it.

(...)
> +static int rockchip_irq_set_type(struct irq_data *d, unsigned int ty=
pe)
> +{
> +       struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d)=
;
> +       struct rockchip_pin_bank *bank =3D gc->private;
> +       u32 bit =3D (1 << d->hwirq);

Name that something like "mask" to match other naming in the
kernel. "bit" sort of implies a number between 0 and 31 and that
is not the case.

All I could think of right now...

Yours,
Linus Walleij
