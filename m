From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v4 2/4] ARM: pxa168: Add SDHCI support
Date: Tue, 20 Dec 2011 21:25:52 +0800
Message-ID: <CAN1soZzzu56SiUa4z2NY0HdqieYTZvM0q-nq1QsnCBLkeD70mg@mail.gmail.com>
References: <CAN1soZxZjdzivfttUhDDvjUDiyiAC5SSKtB0rXR1D=3=q6O0wQ@mail.gmail.com>
	<1324386781-25271-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37472 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab1LTNZx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2011 08:25:53 -0500
Received: by vcbfk14 with SMTP id fk14so4858867vcb.19
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2011 05:25:52 -0800 (PST)
In-Reply-To: <1324386781-25271-1-git-send-email-tanmay.upadhyay@einfochips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Cc: eric.y.miao@gmail.com, jason.chagas@marvell.com, prakity@marvell.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 20, 2011 at 9:13 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
> v2 - clock register for SDHCI are not common across all MMP SoCs.
> =A0 =A0 So, move PXA168 implementation to pxa168.c
>
> v3 - sdhci-pxav1 driver code is merged with sdhci-pxav2. So, change
> =A0 =A0 the device name accordingly
> =A0 - start sdhci device numbering from 1 as other PXA168 devices
> =A0 =A0 does that
>
> v4 - Use different names for SD clock registers for PXA168 instead
> =A0 =A0 of redefining them in pxa168.c. Suggested by Haojian Zhuang
>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> ---
> =A0arch/arm/mach-mmp/include/mach/pxa168.h =A0 =A0| =A0 20 ++++++++++=
++++
> =A0arch/arm/mach-mmp/include/mach/regs-apmu.h | =A0 40 ++++++++++++++=
-------------
> =A0arch/arm/mach-mmp/pxa168.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 3=
9 +++++++++++++++++++++++++++
> =A03 files changed, 80 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-=
mmp/include/mach/pxa168.h
> index 7fb568d..a181608 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -15,6 +15,7 @@ extern void pxa168_clear_keypad_wakeup(void);
> =A0#include <plat/pxa27x_keypad.h>
> =A0#include <mach/cputype.h>
> =A0#include <linux/pxa168_eth.h>
> +#include <linux/platform_data/pxa_sdhci.h>
>
> =A0extern struct pxa_device_desc pxa168_device_uart1;
> =A0extern struct pxa_device_desc pxa168_device_uart2;
> @@ -34,6 +35,10 @@ extern struct pxa_device_desc pxa168_device_nand;
> =A0extern struct pxa_device_desc pxa168_device_fb;
> =A0extern struct pxa_device_desc pxa168_device_keypad;
> =A0extern struct pxa_device_desc pxa168_device_eth;
> +extern struct pxa_device_desc pxa168_device_sdh1;
> +extern struct pxa_device_desc pxa168_device_sdh2;
> +extern struct pxa_device_desc pxa168_device_sdh3;
> +extern struct pxa_device_desc pxa168_device_sdh4;
>
> =A0struct pxa168_usb_pdata {
> =A0 =A0 =A0 =A0/* If NULL, default phy init routine for PXA168 would =
be called */
> @@ -132,4 +137,19 @@ static inline int pxa168_add_eth(struct pxa168_e=
th_platform_data *data)
> =A0{
> =A0 =A0 =A0 =A0return pxa_register_device(&pxa168_device_eth, data, s=
izeof(*data));
> =A0}
> +
> +static inline int pxa168_add_sdh(int id, struct sdhci_pxa_platdata *=
data)
> +{
> + =A0 =A0 =A0 struct pxa_device_desc *d =3D NULL;
> +
> + =A0 =A0 =A0 switch (id) {
> + =A0 =A0 =A0 case 1: d =3D &pxa168_device_sdh1; break;
> + =A0 =A0 =A0 case 2: d =3D &pxa168_device_sdh2; break;
> + =A0 =A0 =A0 case 3: d =3D &pxa168_device_sdh3; break;
> + =A0 =A0 =A0 case 4: d =3D &pxa168_device_sdh4; break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return pxa_register_device(d, data, sizeof(*data));
> +}
> =A0#endif /* __ASM_MACH_PXA168_H */
> diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/ma=
ch-mmp/include/mach/regs-apmu.h
> index 8447ac6..a84de77 100644
> --- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
> +++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
> @@ -17,27 +17,29 @@
> =A0#define APMU_REG(x) =A0 =A0(APMU_VIRT_BASE + (x))
>
> =A0/* Clock Reset Control */
> -#define APMU_IRE =A0 =A0 =A0 APMU_REG(0x048)
> -#define APMU_LCD =A0 =A0 =A0 APMU_REG(0x04c)
> -#define APMU_CCIC =A0 =A0 =A0APMU_REG(0x050)
> -#define APMU_SDH0 =A0 =A0 =A0APMU_REG(0x054)
> -#define APMU_SDH1 =A0 =A0 =A0APMU_REG(0x058)
> -#define APMU_USB =A0 =A0 =A0 APMU_REG(0x05c)
> -#define APMU_NAND =A0 =A0 =A0APMU_REG(0x060)
> -#define APMU_DMA =A0 =A0 =A0 APMU_REG(0x064)
> -#define APMU_GEU =A0 =A0 =A0 APMU_REG(0x068)
> -#define APMU_BUS =A0 =A0 =A0 APMU_REG(0x06c)
> -#define APMU_SDH2 =A0 =A0 =A0APMU_REG(0x0e8)
> -#define APMU_SDH3 =A0 =A0 =A0APMU_REG(0x0ec)
> -#define APMU_ETH =A0 =A0 =A0 APMU_REG(0x0fc)
> -
> -#define APMU_FNCLK_EN =A0(1 << 4)
> -#define APMU_AXICLK_EN (1 << 3)
> -#define APMU_FNRST_DIS (1 << 1)
> -#define APMU_AXIRST_DIS =A0 =A0 =A0 =A0(1 << 0)
> +#define APMU_IRE =A0 =A0 =A0 =A0 =A0 =A0 =A0 APMU_REG(0x048)
> +#define APMU_LCD =A0 =A0 =A0 =A0 =A0 =A0 =A0 APMU_REG(0x04c)
> +#define APMU_CCIC =A0 =A0 =A0 =A0 =A0 =A0 =A0APMU_REG(0x050)
> +#define APMU_SDH0 =A0 =A0 =A0 =A0 =A0 =A0 =A0APMU_REG(0x054)
> +#define APMU_SDH1 =A0 =A0 =A0 =A0 =A0 =A0 =A0APMU_REG(0x058)
> +#define APMU_USB =A0 =A0 =A0 =A0 =A0 =A0 =A0 APMU_REG(0x05c)
> +#define APMU_NAND =A0 =A0 =A0 =A0 =A0 =A0 =A0APMU_REG(0x060)
> +#define APMU_DMA =A0 =A0 =A0 =A0 =A0 =A0 =A0 APMU_REG(0x064)
> +#define APMU_GEU =A0 =A0 =A0 =A0 =A0 =A0 =A0 APMU_REG(0x068)
> +#define APMU_BUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 APMU_REG(0x06c)
> +#define APMU_PXA168_SDH2 =A0 =A0 =A0 APMU_REG(0x0e0)
> +#define APMU_PXA168_SDH3 =A0 =A0 =A0 APMU_REG(0x0e4)
> +#define APMU_SDH2 =A0 =A0 =A0 =A0 =A0 =A0 =A0APMU_REG(0x0e8)
> +#define APMU_SDH3 =A0 =A0 =A0 =A0 =A0 =A0 =A0APMU_REG(0x0ec)
> +#define APMU_ETH =A0 =A0 =A0 =A0 =A0 =A0 =A0 APMU_REG(0x0fc)
> +
> +#define APMU_FNCLK_EN =A0 =A0 =A0 =A0 =A0(1 << 4)
> +#define APMU_AXICLK_EN =A0 =A0 =A0 =A0 (1 << 3)
> +#define APMU_FNRST_DIS =A0 =A0 =A0 =A0 (1 << 1)
> +#define APMU_AXIRST_DIS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>
> =A0/* Wake Clear Register */
> -#define APMU_WAKE_CLR =A0APMU_REG(0x07c)
> +#define APMU_WAKE_CLR =A0 =A0 =A0 =A0 =A0APMU_REG(0x07c)
>
> =A0#define APMU_PXA168_KP_WAKE_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 =
<< 7)
> =A0#define APMU_PXA168_CFI_WAKE_CLR =A0 =A0 =A0 (1 << 6)
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index 76ca15c..023659b 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -65,6 +65,32 @@ void __init pxa168_init_irq(void)
> =A0 =A0 =A0 =A0pxa168_init_gpio();
> =A0}
>
> +static void sdh_clk_enable(struct clk *clk)
> +{
> + =A0 =A0 =A0 void __iomem *reg_offset =3D clk->clk_rst;
> +
> + =A0 =A0 =A0 /* Can't see any clean way to do this: Bits 3 & 0 in re=
gisters
> + =A0 =A0 =A0 =A0* for host 0 & 2 should be set for host 1 & 3 also *=
/
> + =A0 =A0 =A0 if (reg_offset =3D=3D APMU_SDH0 || reg_offset =3D=3D AP=
MU_SDH1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(__raw_readl(APMU_SDH0) | 0=
x9, APMU_SDH0);
> + =A0 =A0 =A0 if (reg_offset =3D=3D APMU_PXA168_SDH2 || reg_offset =3D=
=3D APMU_PXA168_SDH3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(__raw_readl(APMU_PXA168_SD=
H2) | 0x9,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 APMU_PX=
A168_SDH2);
> +
> + =A0 =A0 =A0 __raw_writel(__raw_readl(clk->clk_rst) | clk->enable_va=
l, clk->clk_rst);
> +}
> +
How about use the below code instead? I think we can avoid to check
register offset.

static void sdh0_clk_enable(struct clk *clk)
{
       void __iomem *reg_offset =3D clk->clk_rst;

       __raw_writel(__raw_readl(APMU_SDH0) | 0x9, APMU_SDH0);
       __raw_writel(__raw_readl(clk->clk_rst) | clk->enable_val, clk->c=
lk_rst);
}

static void sdh2_clk_enable(struct clk *clk)
{
       void __iomem *reg_offset =3D clk->clk_rst;
               __raw_writel(__raw_readl(APMU_PXA168_SDH2) | 0x9,
                               APMU_PXA168_SDH2);
       __raw_writel(__raw_readl(clk->clk_rst) | clk->enable_val, clk->c=
lk_rst);

}

struct clkops sdh0_clk_ops =3D {
      .enable         =3D sdh0_clk_enable,
      .disable        =3D sdh_clk_disable,
};

struct clkops sdh2_clk_ops =3D {
      .enable         =3D sdh2_clk_enable,
      .disable        =3D sdh_clk_disable,
};

static APMU_CLK_OPS(sdh1, SDH0, 0x12, 48000000, &sdh0_clk_ops);
static APMU_CLK_OPS(sdh2, SDH1, 0x12, 48000000, &sdh0_clk_ops);
static APMU_CLK_OPS(sdh3, PXA168_SDH2, 0x12, 48000000, &sdh2_clk_ops);
static APMU_CLK_OPS(sdh4, PXA168_SDH3, 0x12, 48000000, &sdh2_clk_ops);

> +static void sdh_clk_disable(struct clk *clk)
> +{
> + =A0 =A0 =A0 __raw_writel(__raw_readl(clk->clk_rst) & ~(clk->enable_=
val),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->clk_rst);
> +}
> +
> +struct clkops sdh_clk_ops =3D {
> + =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D sdh_clk_enable,
> + =A0 =A0 =A0 .disable =A0 =A0 =A0 =A0=3D sdh_clk_disable,
> +};
> +
> =A0/* APB peripheral clocks */
> =A0static APBC_CLK(uart1, PXA168_UART1, 1, 14745600);
> =A0static APBC_CLK(uart2, PXA168_UART2, 1, 14745600);
> @@ -87,6 +113,11 @@ static APMU_CLK(lcd, LCD, 0x7f, 312000000);
> =A0static APMU_CLK(eth, ETH, 0x09, 0);
> =A0static APMU_CLK(usb, USB, 0x12, 0);
>
> +static APMU_CLK_OPS(sdh1, SDH0, 0x12, 48000000, &sdh_clk_ops);
> +static APMU_CLK_OPS(sdh2, SDH1, 0x12, 48000000, &sdh_clk_ops);
> +static APMU_CLK_OPS(sdh3, PXA168_SDH2, 0x12, 48000000, &sdh_clk_ops)=
;
> +static APMU_CLK_OPS(sdh4, PXA168_SDH3, 0x12, 48000000, &sdh_clk_ops)=
;
> +
> =A0/* device and clock bindings */
> =A0static struct clk_lookup pxa168_clkregs[] =3D {
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
> @@ -108,6 +139,10 @@ static struct clk_lookup pxa168_clkregs[] =3D {
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_usb, "pxa168-ehci", "PXA168-USBCLK"),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_sdh1, NULL, "PXA-SDHCLK"),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_sdh2, NULL, "PXA-SDHCLK"),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_sdh3, NULL, "PXA-SDHCLK"),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_sdh4, NULL, "PXA-SDHCLK"),
> =A0};
>
> =A0static int __init pxa168_init(void)
> @@ -173,6 +208,10 @@ PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd40=
21000, 0x40, 60, 61);
> =A0PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
> =A0PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4=
c);
> =A0PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
> +PXA168_DEVICE(sdh1, "sdhci-pxav2", 0, SDH1, 0xd4280000, 0x100);
> +PXA168_DEVICE(sdh2, "sdhci-pxav2", 1, SDH1, 0xd4281000, 0x100);
> +PXA168_DEVICE(sdh3, "sdhci-pxav2", 2, SDH2, 0xd427e000, 0x100);
> +PXA168_DEVICE(sdh4, "sdhci-pxav2", 3, SDH2, 0xd427f000, 0x100);
>
> =A0struct resource pxa168_usb_host_resources[] =3D {
> =A0 =A0 =A0 =A0/* USB Host conroller register base */
> --
> 1.7.0.4
>
