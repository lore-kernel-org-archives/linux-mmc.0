From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: pxa168: Add SDHCI support
Date: Fri, 11 Nov 2011 09:18:32 +0800
Message-ID: <CAMPhdO9EWeXw-XsjQ5x-qcAbjFDxrdz47wirFKWKV=kJFZAKiw@mail.gmail.com>
References: <1319546069-31742-1-git-send-email-tanmay.upadhyay@einfochips.com> <1320399547-2374-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37077 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1KKBSy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2011 20:18:54 -0500
Received: by vws1 with SMTP id 1so2999987vws.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Nov 2011 17:18:53 -0800 (PST)
In-Reply-To: <1320399547-2374-1-git-send-email-tanmay.upadhyay@einfochips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Cc: jason.chagas@marvell.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, cjb@laptop.org

On Fri, Nov 4, 2011 at 5:39 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
> v2 - clock register for SDHCI are not common across all MMP SoCs.
> So, move PXA168 implementation to pxa168.c
>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> ---
> =C2=A0arch/arm/mach-mmp/clock.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0arch/arm/mach-mmp/clock.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0arch/arm/mach-mmp/include/mach/pxa168.h | =C2=A0 20 +++++++++++=
++
> =C2=A0arch/arm/mach-mmp/pxa168.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 46 +++++++++++++++++++++++++++++++
> =C2=A04 files changed, 68 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
> index 7c6f95f..eefefea 100644
> --- a/arch/arm/mach-mmp/clock.c
> +++ b/arch/arm/mach-mmp/clock.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/io.h>
>
> =C2=A0#include <mach/regs-apbc.h>
> +#include <mach/regs-apmu.h>
> =C2=A0#include "clock.h"
>
> =C2=A0static void apbc_clk_enable(struct clk *clk)
> diff --git a/arch/arm/mach-mmp/clock.h b/arch/arm/mach-mmp/clock.h
> index 3143e99..1243e4d 100644
> --- a/arch/arm/mach-mmp/clock.h
> +++ b/arch/arm/mach-mmp/clock.h
> @@ -27,6 +27,7 @@ struct clk {
>
> =C2=A0extern struct clkops apbc_clk_ops;
> =C2=A0extern struct clkops apmu_clk_ops;
> +extern struct clkops sdh_clk_ops;
>
> =C2=A0#define APBC_CLK(_name, _reg, _fnclksel, _rate) =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0struct clk clk_##_name =3D { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-=
mmp/include/mach/pxa168.h
> index 7f00584..390a550 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -15,6 +15,7 @@ extern void pxa168_clear_keypad_wakeup(void);
> =C2=A0#include <plat/pxa27x_keypad.h>
> =C2=A0#include <mach/cputype.h>
> =C2=A0#include <linux/pxa168_eth.h>
> +#include <linux/platform_data/pxa_sdhci.h>
>
> =C2=A0extern struct pxa_device_desc pxa168_device_uart1;
> =C2=A0extern struct pxa_device_desc pxa168_device_uart2;
> @@ -34,6 +35,10 @@ extern struct pxa_device_desc pxa168_device_nand;
> =C2=A0extern struct pxa_device_desc pxa168_device_fb;
> =C2=A0extern struct pxa_device_desc pxa168_device_keypad;
> =C2=A0extern struct pxa_device_desc pxa168_device_eth;
> +extern struct pxa_device_desc pxa168_device_sdh0;
> +extern struct pxa_device_desc pxa168_device_sdh1;
> +extern struct pxa_device_desc pxa168_device_sdh2;
> +extern struct pxa_device_desc pxa168_device_sdh3;
>
> =C2=A0static inline int pxa168_add_uart(int id)
> =C2=A0{
> @@ -125,4 +130,19 @@ static inline int pxa168_add_eth(struct pxa168_e=
th_platform_data *data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return pxa_register_device(&pxa168_device_=
eth, data, sizeof(*data));
> =C2=A0}
> +
> +static inline int pxa168_add_sdh(int id, struct sdhci_pxa_platdata *=
data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct pxa_device_desc *d =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (id) {
> + =C2=A0 =C2=A0 =C2=A0 case 0: d =3D &pxa168_device_sdh0; break;
> + =C2=A0 =C2=A0 =C2=A0 case 1: d =3D &pxa168_device_sdh1; break;
> + =C2=A0 =C2=A0 =C2=A0 case 2: d =3D &pxa168_device_sdh2; break;
> + =C2=A0 =C2=A0 =C2=A0 case 3: d =3D &pxa168_device_sdh3; break;
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return pxa_register_device(d, data, sizeof(*da=
ta));
> +}
> =C2=A0#endif /* __ASM_MACH_PXA168_H */
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index 0156f53..868605d 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -43,6 +43,14 @@ static struct mfp_addr_map pxa168_mfp_addr_map[] _=
_initdata =3D
>
> =C2=A0#define APMASK(i) =C2=A0 =C2=A0 =C2=A0(GPIO_REGS_VIRT + BANK_OF=
=46(i) + 0x09c)
>
> +/* Offset defined in arch/arm/mach-mmp/include/mach/regs-apmu.h are =
for MMP2
> + * PXA168 has different offset */
> +#undef APMU_SDH2
> +#undef APMU_SDH3
> +
> +#define APMU_SDH2 =C2=A0 =C2=A0 =C2=A0APMU_REG(0xe0)
> +#define APMU_SDH3 =C2=A0 =C2=A0 =C2=A0APMU_REG(0xe4)
> +
> =C2=A0static void __init pxa168_init_gpio(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> @@ -63,6 +71,31 @@ void __init pxa168_init_irq(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa168_init_gpio();
> =C2=A0}
>
> +static void sdh_clk_enable(struct clk *clk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long clk_reg_offset =3D (unsigned lon=
g) clk->clk_rst;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Can't see any clean way to do this: Bits 3 =
& 0 in registers
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* for host 0 & 2 should be set for host =
1 & 3 also */
> + =C2=A0 =C2=A0 =C2=A0 if (clk_reg_offset =3D=3D APMU_SDH0 || clk_reg=
_offset =3D=3D APMU_SDH1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(__raw=
_readl(APMU_SDH0) | 0x9, APMU_SDH0);
> + =C2=A0 =C2=A0 =C2=A0 if (clk_reg_offset =3D=3D APMU_SDH2 || clk_reg=
_offset =3D=3D APMU_SDH3)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(__raw=
_readl(APMU_SDH2) | 0x9, APMU_SDH2);
> +
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(__raw_readl(clk->clk_rst) | clk->=
enable_val, clk->clk_rst);
> +}
> +
> +static void sdh_clk_disable(struct clk *clk)
> +{
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(__raw_readl(clk->clk_rst) & ~(clk=
->enable_val),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 clk->clk_rst);
> +}
> +
> +struct clkops sdh_clk_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 .enable =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D sdh_cl=
k_enable,
> + =C2=A0 =C2=A0 =C2=A0 .disable =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D sdh_cl=
k_disable,
> +};
> +
> =C2=A0/* APB peripheral clocks */
> =C2=A0static APBC_CLK(uart1, PXA168_UART1, 1, 14745600);
> =C2=A0static APBC_CLK(uart2, PXA168_UART2, 1, 14745600);
> @@ -84,6 +117,11 @@ static APMU_CLK(nand, NAND, 0x19b, 156000000);
> =C2=A0static APMU_CLK(lcd, LCD, 0x7f, 312000000);
> =C2=A0static APMU_CLK(eth, ETH, 0x09, 0);
>
> +static APMU_CLK_OPS(sdh0, SDH0, 0x12, 48000000, &sdh_clk_ops);
> +static APMU_CLK_OPS(sdh1, SDH1, 0x12, 48000000, &sdh_clk_ops);
> +static APMU_CLK_OPS(sdh2, SDH2, 0x12, 48000000, &sdh_clk_ops);
> +static APMU_CLK_OPS(sdh3, SDH3, 0x12, 48000000, &sdh_clk_ops);
> +
> =C2=A0/* device and clock bindings */
> =C2=A0static struct clk_lookup pxa168_clkregs[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", N=
ULL),
> @@ -104,6 +142,10 @@ static struct clk_lookup pxa168_clkregs[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_CLKREG(&clk_keypad, "pxa27x-keypad", =
NULL),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCL=
K"),
> + =C2=A0 =C2=A0 =C2=A0 INIT_CLKREG(&clk_sdh0, "sdhci-pxav1.0", "PXA-S=
DHCLK"),
> + =C2=A0 =C2=A0 =C2=A0 INIT_CLKREG(&clk_sdh1, "sdhci-pxav1.1", "PXA-S=
DHCLK"),
> + =C2=A0 =C2=A0 =C2=A0 INIT_CLKREG(&clk_sdh2, "sdhci-pxav1.2", "PXA-S=
DHCLK"),
> + =C2=A0 =C2=A0 =C2=A0 INIT_CLKREG(&clk_sdh3, "sdhci-pxav1.3", "PXA-S=
DHCLK"),
> =C2=A0};
>
> =C2=A0static int __init pxa168_init(void)
> @@ -169,3 +211,7 @@ PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd402=
1000, 0x40, 60, 61);
> =C2=A0PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
> =C2=A0PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, =
0x4c);
> =C2=A0PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
> +PXA168_DEVICE(sdh0, "sdhci-pxav1", 0, SDH1, 0xd4280000, 0x100);
> +PXA168_DEVICE(sdh1, "sdhci-pxav1", 1, SDH1, 0xd4281000, 0x100);
> +PXA168_DEVICE(sdh2, "sdhci-pxav1", 2, SDH2, 0xd427e000, 0x100);
> +PXA168_DEVICE(sdh3, "sdhci-pxav1", 3, SDH2, 0xd427f000, 0x100);

Sorry Tanmay for late response.

The problem is that I didn't seem to find sdhci-pxav1 though in drivers=
/mmc.
