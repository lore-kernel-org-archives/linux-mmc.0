From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v6 2/4] ARM: pxa168: Add SDHCI support
Date: Mon, 18 Mar 2013 09:13:39 +0800
Message-ID: <CAN1soZzbr_9KJqBXxw99X4Psr6zhqSWYckLiKtC1Y7dEJade0w@mail.gmail.com>
References: <1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<1363544333-3755-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:41229 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3CRBNk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Mar 2013 21:13:40 -0400
Received: by mail-ea0-f172.google.com with SMTP id d10so2356958eaj.31
        for <linux-mmc@vger.kernel.org>; Sun, 17 Mar 2013 18:13:39 -0700 (PDT)
In-Reply-To: <1363544333-3755-1-git-send-email-tanmay.upadhyay@einfochips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Cc: Miao Eric <eric.y.miao@gmail.com>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Mar 18, 2013 at 2:18 AM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
> v2 - clock register for SDHCI are not common across all MMP SoCs.
>      So, move PXA168 implementation to pxa168.c
>
> v3 - sdhci-pxav1 driver code is merged with sdhci-pxav2. So, change
>      the device name accordingly
>    - start sdhci device numbering from 1 as other PXA168 devices
>      does that
>
> v4 - Use different names for SD clock registers for PXA168 instead
>      of redefining them in pxa168.c. Suggested by Haojian Zhuang
>
> v5 - Have two different clock enable functions for clock block 1 & 2
>      & don't change indentation in regs-apmu.h as suggested by Haojian
>      Zhuang
>    - Use device name while adding clock as suggested by Russell King
>
> v6 - Rebase for Linux v3.8; de-select COMMON_CLK for PXA168 as its
>      SDHCI clocks should be handled differently than others
> ---
>  arch/arm/mach-mmp/Kconfig               |    1 -
>  arch/arm/mach-mmp/clock-pxa168.c        |   47 +++++++++++++++++++++++++++++++
>  arch/arm/mach-mmp/include/mach/pxa168.h |   20 +++++++++++++
>  arch/arm/mach-mmp/pxa168.c              |    4 +++
>  4 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index ebdda83..530245c 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -111,7 +111,6 @@ endmenu
>
>  config CPU_PXA168
>         bool
> -       select COMMON_CLK
>         select CPU_MOHAWK
>         help
>           Select code specific to PXA168
> diff --git a/arch/arm/mach-mmp/clock-pxa168.c b/arch/arm/mach-mmp/clock-pxa168.c
> index 5e6c18c..65ea00e 100644
> --- a/arch/arm/mach-mmp/clock-pxa168.c
> +++ b/arch/arm/mach-mmp/clock-pxa168.c
> @@ -31,11 +31,49 @@
>  #define APBC_SSP4      APBC_REG(0x858)
>  #define APBC_SSP5      APBC_REG(0x85c)
>
> +#define APMU_SDH0      APMU_REG(0x054)
> +#define APMU_SDH1      APMU_REG(0x058)
>  #define APMU_NAND      APMU_REG(0x060)
>  #define APMU_LCD       APMU_REG(0x04c)
> +#define APMU_SDH2      APMU_REG(0x0e0)
> +#define APMU_SDH3      APMU_REG(0x0e4)
>  #define APMU_ETH       APMU_REG(0x0fc)
>  #define APMU_USB       APMU_REG(0x05c)
>
> +static void sdh1_clk_enable(struct clk *clk)
> +{
> +       /* Bits 3 & 0 in registers for host 0 should be set for host 1 also */
> +       __raw_writel(__raw_readl(APMU_SDH0) | 0x9, APMU_SDH0);
> +
> +       __raw_writel(__raw_readl(clk->clk_rst) | clk->enable_val, clk->clk_rst);
> +}
> +
> +static void sdh2_clk_enable(struct clk *clk)
> +{
> +       /* Bits 3 & 0 in registers for host 2 should be set for host 3 also */
> +       __raw_writel(__raw_readl(APMU_SDH2) | 0x9, APMU_SDH2);
> +
> +       __raw_writel(__raw_readl(clk->clk_rst) | clk->enable_val, clk->clk_rst);
> +}
> +
> +static void sdh_clk_disable(struct clk *clk)
> +{
> +       __raw_writel(__raw_readl(clk->clk_rst) & ~clk->enable_val,
> +                       clk->clk_rst);
> +}
> +
> +/* Block 1 for controller 0 & 1 */
> +struct clkops sdh1_clk_ops = {
> +       .enable         = sdh1_clk_enable,
> +       .disable        = sdh_clk_disable,
> +};
> +
> +/* Block 2 for controller 2 & 3 */
> +struct clkops sdh2_clk_ops = {
> +       .enable         = sdh2_clk_enable,
> +       .disable        = sdh_clk_disable,
> +};
> +
>  /* APB peripheral clocks */
>  static APBC_CLK(uart1, UART1, 1, 14745600);
>  static APBC_CLK(uart2, UART2, 1, 14745600);
> @@ -60,6 +98,11 @@ static APMU_CLK(lcd, LCD, 0x7f, 312000000);
>  static APMU_CLK(eth, ETH, 0x09, 0);
>  static APMU_CLK(usb, USB, 0x12, 0);
>
> +static APMU_CLK_OPS(sdh1, SDH0, 0x12, 48000000, &sdh1_clk_ops);
> +static APMU_CLK_OPS(sdh2, SDH1, 0x12, 48000000, &sdh1_clk_ops);
> +static APMU_CLK_OPS(sdh3, SDH2, 0x12, 48000000, &sdh2_clk_ops);
> +static APMU_CLK_OPS(sdh4, SDH3, 0x12, 48000000, &sdh2_clk_ops);
> +
>  /* device and clock bindings */
>  static struct clk_lookup pxa168_clkregs[] = {
>         INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
> @@ -83,6 +126,10 @@ static struct clk_lookup pxa168_clkregs[] = {
>         INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
>         INIT_CLKREG(&clk_usb, NULL, "PXA168-USBCLK"),
>         INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
> +       INIT_CLKREG(&clk_sdh1, "sdhci-pxav2.0", "PXA-SDHCLK"),
> +       INIT_CLKREG(&clk_sdh2, "sdhci-pxav2.1", "PXA-SDHCLK"),
> +       INIT_CLKREG(&clk_sdh3, "sdhci-pxav2.2", "PXA-SDHCLK"),
> +       INIT_CLKREG(&clk_sdh4, "sdhci-pxav2.3", "PXA-SDHCLK"),
>  };
>
>  void __init pxa168_clk_init(void)
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
> index 37632d9..805117e 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -17,6 +17,7 @@ extern void pxa168_clear_keypad_wakeup(void);
>  #include <mach/cputype.h>
>  #include <linux/pxa168_eth.h>
>  #include <linux/platform_data/mv_usb.h>
> +#include <linux/platform_data/pxa_sdhci.h>
>
>  extern struct pxa_device_desc pxa168_device_uart1;
>  extern struct pxa_device_desc pxa168_device_uart2;
> @@ -36,6 +37,10 @@ extern struct pxa_device_desc pxa168_device_nand;
>  extern struct pxa_device_desc pxa168_device_fb;
>  extern struct pxa_device_desc pxa168_device_keypad;
>  extern struct pxa_device_desc pxa168_device_eth;
> +extern struct pxa_device_desc pxa168_device_sdh1;
> +extern struct pxa_device_desc pxa168_device_sdh2;
> +extern struct pxa_device_desc pxa168_device_sdh3;
> +extern struct pxa_device_desc pxa168_device_sdh4;
>
>  /* pdata can be NULL */
>  extern int __init pxa168_add_usb_host(struct mv_usb_platform_data *pdata);
> @@ -133,4 +138,19 @@ static inline int pxa168_add_eth(struct pxa168_eth_platform_data *data)
>  {
>         return pxa_register_device(&pxa168_device_eth, data, sizeof(*data));
>  }
> +
> +static inline int pxa168_add_sdh(int id, struct sdhci_pxa_platdata *data)
> +{
> +       struct pxa_device_desc *d = NULL;
> +
> +       switch (id) {
> +       case 1: d = &pxa168_device_sdh1; break;
> +       case 2: d = &pxa168_device_sdh2; break;
> +       case 3: d = &pxa168_device_sdh3; break;
> +       case 4: d = &pxa168_device_sdh4; break;
> +       default:
> +               return -EINVAL;
> +       }
> +       return pxa_register_device(d, data, sizeof(*data));
> +}
>  #endif /* __ASM_MACH_PXA168_H */
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index b7f074f..ab5f273 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -114,6 +114,10 @@ PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
>  PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
>  PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
>  PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
> +PXA168_DEVICE(sdh1, "sdhci-pxav2", 0, SDH1, 0xd4280000, 0x100);
> +PXA168_DEVICE(sdh2, "sdhci-pxav2", 1, SDH1, 0xd4281000, 0x100);
> +PXA168_DEVICE(sdh3, "sdhci-pxav2", 2, SDH2, 0xd427e000, 0x100);
> +PXA168_DEVICE(sdh4, "sdhci-pxav2", 3, SDH2, 0xd427f000, 0x100);
>
>  struct resource pxa168_resource_gpio[] = {
>         {
> --
> 1.7.9.5
>

No, we shouldn't drop COMMON_CLK. Now you're using legacy code that
isn't our goal.

You should enable DT mode. Please refer to drivers/clk/mmp/clk-pxa168.c.
I think that SD clocks are already considered.

Regards
Haojian
