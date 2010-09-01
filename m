From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 3/3] omap3/omap4 hsmmc: Register offset handling
Date: Wed, 01 Sep 2010 15:26:40 +0300
Message-ID: <4C7E4680.1060208@nokia.com>
References: <23570.10.24.255.18.1283190527.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27987 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0IAM05 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2010 08:26:57 -0400
In-Reply-To: <23570.10.24.255.18.1283190527.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "madhu.cr@ti.com" <madhu.cr@ti.com>

kishore kadiyala wrote:
> OMAP4 not only have newly added hsmmc registers but also
> have registers which were there in OMAP3 and which doesn't
> have a common offset deviation compared to OMAP3.
> 
> For generic handling, OMAP3 and OMAP4 has different array's of
> register offset maintained and right one is choosen during run time.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c         |   30 +++--
>  arch/arm/mach-omap2/hsmmc.c           |    6 +
>  arch/arm/plat-omap/include/plat/mmc.h |   78 ++++++++++-
>  drivers/mmc/host/omap_hsmmc.c         |  251 +++++++++++++++------------------
>  4 files changed, 218 insertions(+), 147 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 2dbb265..03add6e 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -506,6 +506,8 @@ static inline void omap_init_sham(void) { }
>  #define MMCHS_SYSCONFIG_SWRESET                (1 << 1)
>  #define MMCHS_SYSSTATUS                        0x0014
>  #define MMCHS_SYSSTATUS_RESETDONE      (1 << 0)
> +#define OMAP4_MMCHS_SYSCONFIG_SWRESET  (1 << 0)
> +#define OMAP4_MMCHS_OFFSET             0x100
> 
>  static struct platform_device dummy_pdev = {
>         .dev = {
> @@ -528,6 +530,8 @@ static struct platform_device dummy_pdev = {
>  static void __init omap_hsmmc_reset(void)
>  {
>         u32 i, nr_controllers;
> +       u32 reg_val = 0;
> +       u32 reg_off = 0;
> 
>         if (cpu_is_omap242x())
>                 return;
> @@ -562,9 +566,6 @@ static void __init omap_hsmmc_reset(void)
>                         break;
>                 }
> 
> -               if (cpu_is_omap44xx())
> -                       base += OMAP4_MMC_REG_OFFSET;
> -
>                 dummy_pdev.id = i;
>                 dev_set_name(&dummy_pdev.dev, "mmci-omap-hs.%d", i);
>                 iclk = clk_get(dev, "ick");
> @@ -582,9 +583,18 @@ static void __init omap_hsmmc_reset(void)
>                         break;
>                 }
> 
> -               omap_writel(MMCHS_SYSCONFIG_SWRESET, base + MMCHS_SYSCONFIG);
> -               v = omap_readl(base + MMCHS_SYSSTATUS);
> -               while (!(omap_readl(base + MMCHS_SYSSTATUS) &
> +               if (cpu_is_omap44xx())
> +                       reg_val = MMCHS_SYSCONFIG_SWRESET;

Should this be OMAP4_MMCHS_SYSCONFIG_SWRESET?


> +               else
> +                       reg_val = MMCHS_SYSCONFIG_SWRESET;
> +               omap_writel(reg_val, base + MMCHS_SYSCONFIG);
> +
> +               reg_off = MMCHS_SYSSTATUS;
> +               if (cpu_is_omap44xx())
> +                       reg_off += OMAP4_MMCHS_OFFSET;
> +               v = omap_readl(base + reg_off);
> +
> +               while (!(omap_readl(base + reg_off) &
>                          MMCHS_SYSSTATUS_RESETDONE))
>                         cpu_relax();
> 
> @@ -745,13 +755,13 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
>                 case 3:
>                         if (!cpu_is_omap44xx())
>                                 return;
> -                       base = OMAP4_MMC4_BASE + OMAP4_MMC_REG_OFFSET;
> +                       base = OMAP4_MMC4_BASE;
>                         irq = OMAP44XX_IRQ_MMC4;
>                         break;
>                 case 4:
>                         if (!cpu_is_omap44xx())
>                                 return;
> -                       base = OMAP4_MMC5_BASE + OMAP4_MMC_REG_OFFSET;
> +                       base = OMAP4_MMC5_BASE;
>                         irq = OMAP44XX_IRQ_MMC5;
>                         break;
>                 default:
> @@ -762,10 +772,8 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
>                         size = OMAP2420_MMC_SIZE;
>                         name = "mmci-omap";
>                 } else if (cpu_is_omap44xx()) {
> -                       if (i < 3) {
> -                               base += OMAP4_MMC_REG_OFFSET;
> +                       if (i < 3)
>                                 irq += OMAP44XX_IRQ_GIC_START;
> -                       }
>                         size = OMAP4_HSMMC_SIZE;
>                         name = "mmci-omap-hs";
>                 } else {
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index c8f647b..d93b704 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -262,6 +262,12 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>                 mmc->slots[0].internal_clock = !c->ext_clock;
>                 mmc->dma_mask = 0xffffffff;
> 
> +               /* Register offset Mapping */
> +               if (cpu_is_omap44xx())
> +                       mmc->regs_map = (u16 *) omap4_mmc_reg_map;
> +               else
> +                       mmc->regs_map = (u16 *) omap3_mmc_reg_map;
> +
>                 mmc->get_context_loss_count = hsmmc_get_context_loss;
> 
>                 mmc->slots[0].switch_pin = c->gpio_cd;
> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
> index 9b89ec6..a85f91c 100644
> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -34,7 +34,6 @@
>  #define OMAP3_MMC3_BASE                0x480ad000
>  #define OMAP4_MMC4_BASE                0x480d1000
>  #define OMAP4_MMC5_BASE                0x480d5000
> -#define OMAP4_MMC_REG_OFFSET   0x100
>  #define HSMMC5                 (1 << 4)
>  #define HSMMC4                 (1 << 3)
>  #define HSMMC3                 (1 << 2)
> @@ -43,6 +42,80 @@
> 
>  #define OMAP_MMC_MAX_SLOTS     2
> 
> +enum {
> +       OMAP_HSMMC_SYSCONFIG = 0,
> +       OMAP_HSMMC_SYSSTATUS,
> +       OMAP_HSMMC_CON,
> +       OMAP_HSMMC_BLK,
> +       OMAP_HSMMC_ARG,
> +       OMAP_HSMMC_CMD,
> +       OMAP_HSMMC_RSP10,
> +       OMAP_HSMMC_RSP32,
> +       OMAP_HSMMC_RSP54,
> +       OMAP_HSMMC_RSP76,
> +       OMAP_HSMMC_DATA,
> +       OMAP_HSMMC_PSTATE,
> +       OMAP_HSMMC_HCTL,
> +       OMAP_HSMMC_SYSCTL,
> +       OMAP_HSMMC_STAT,
> +       OMAP_HSMMC_IE,
> +       OMAP_HSMMC_ISE,
> +       OMAP_HSMMC_CAPA,
> +       OMAP_HSMMC_REV,
> +       OMAP_HSMMC_CUR_CAPA,
> +       OMAP_HSMMC_FE,
> +       OMAP_HSMMC_ADMA_ES,
> +       OMAP_HSMMC_ADMA_SAL,
> +};
> +
> +static const u16 omap3_mmc_reg_map[] = {
> +       [OMAP_HSMMC_SYSCONFIG] = 0x0010,
> +       [OMAP_HSMMC_SYSSTATUS] = 0x0014,
> +       [OMAP_HSMMC_CON] = 0x002C,
> +       [OMAP_HSMMC_BLK] = 0x0104,
> +       [OMAP_HSMMC_ARG] = 0x0108,
> +       [OMAP_HSMMC_CMD] = 0x010C,
> +       [OMAP_HSMMC_RSP10] = 0x0110,
> +       [OMAP_HSMMC_RSP32] = 0x0114,
> +       [OMAP_HSMMC_RSP54] = 0x0118,
> +       [OMAP_HSMMC_RSP76] = 0x011C,
> +       [OMAP_HSMMC_DATA] = 0x0120,
> +       [OMAP_HSMMC_PSTATE] = 0x0124,
> +       [OMAP_HSMMC_HCTL] = 0x0128,
> +       [OMAP_HSMMC_SYSCTL] = 0x012C,
> +       [OMAP_HSMMC_STAT] = 0x0130,
> +       [OMAP_HSMMC_IE] = 0x0134,
> +       [OMAP_HSMMC_ISE] = 0x0138,
> +       [OMAP_HSMMC_CAPA] = 0x0140,
> +       [OMAP_HSMMC_REV] = 0x01FC,
> +};
> +
> +static const u16 omap4_mmc_reg_map[] = {
> +       [OMAP_HSMMC_SYSCONFIG] = 0x0010,        /* Use Highlander Version */
> +       [OMAP_HSMMC_SYSSTATUS] = 0x0114,
> +       [OMAP_HSMMC_CON] = 0x012C,
> +       [OMAP_HSMMC_BLK] = 0x0204,
> +       [OMAP_HSMMC_ARG] = 0x0208,
> +       [OMAP_HSMMC_CMD] = 0x020C,
> +       [OMAP_HSMMC_RSP10] = 0x0210,
> +       [OMAP_HSMMC_RSP32] = 0x0214,
> +       [OMAP_HSMMC_RSP54] = 0x0218,
> +       [OMAP_HSMMC_RSP76] = 0x021C,
> +       [OMAP_HSMMC_DATA] = 0x0220,
> +       [OMAP_HSMMC_PSTATE] = 0x0224,
> +       [OMAP_HSMMC_HCTL] = 0x0228,
> +       [OMAP_HSMMC_SYSCTL] = 0x022C,
> +       [OMAP_HSMMC_STAT] = 0x0230,
> +       [OMAP_HSMMC_IE] = 0x0234,
> +       [OMAP_HSMMC_ISE] = 0x0238,
> +       [OMAP_HSMMC_CAPA] = 0x0240,
> +       [OMAP_HSMMC_REV] = 0x0000,      /* Use Highlander Version */
> +       [OMAP_HSMMC_CUR_CAPA] = 0x0248,
> +       [OMAP_HSMMC_FE] = 0x0250,
> +       [OMAP_HSMMC_ADMA_ES] = 0x0254,
> +       [OMAP_HSMMC_ADMA_SAL] = 0x0258,
> +};
> +
>  struct omap_mmc_platform_data {
>         /* back-link to device */
>         struct device *dev;
> @@ -50,6 +123,9 @@ struct omap_mmc_platform_data {
>         /* number of slots per controller */
>         unsigned nr_slots:2;
> 
> +       /* Register Offset Map */
> +       u16 *regs_map;
> +
>         /* set if your board has components or wiring that limits the
>          * maximum frequency on the MMC bus */
>         unsigned int max_freq;
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index caa0163..ca9b054 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -39,25 +39,6 @@
>  #include <plat/mmc.h>
>  #include <plat/cpu.h>
> 
> -/* OMAP HSMMC Host Controller Registers */
> -#define OMAP_HSMMC_SYSCONFIG   0x0010
> -#define OMAP_HSMMC_SYSSTATUS   0x0014
> -#define OMAP_HSMMC_CON         0x002C
> -#define OMAP_HSMMC_BLK         0x0104
> -#define OMAP_HSMMC_ARG         0x0108
> -#define OMAP_HSMMC_CMD         0x010C
> -#define OMAP_HSMMC_RSP10       0x0110
> -#define OMAP_HSMMC_RSP32       0x0114
> -#define OMAP_HSMMC_RSP54       0x0118
> -#define OMAP_HSMMC_RSP76       0x011C
> -#define OMAP_HSMMC_DATA                0x0120
> -#define OMAP_HSMMC_HCTL                0x0128
> -#define OMAP_HSMMC_SYSCTL      0x012C
> -#define OMAP_HSMMC_STAT                0x0130
> -#define OMAP_HSMMC_IE          0x0134
> -#define OMAP_HSMMC_ISE         0x0138
> -#define OMAP_HSMMC_CAPA                0x0140
> -
>  #define VS18                   (1 << 26)
>  #define VS30                   (1 << 25)
>  #define SDVS18                 (0x5 << 9)
> @@ -135,11 +116,11 @@
>  /*
>   * MMC Host controller read/write API's
>   */
> -#define OMAP_HSMMC_READ(base, reg)     \
> -       __raw_readl((base) + OMAP_HSMMC_##reg)
> +#define OMAP_HSMMC_READ(host, reg) \
> +       __raw_readl((host->base) + (host->regs[OMAP_HSMMC_##reg]))
> 
> -#define OMAP_HSMMC_WRITE(base, reg, val) \
> -       __raw_writel((val), (base) + OMAP_HSMMC_##reg)
> +#define OMAP_HSMMC_WRITE(host, reg, val) \
> +       __raw_writel((val), (host->base) + (host->regs[OMAP_HSMMC_##reg]))
> 
>  struct omap_hsmmc_host {
>         struct  device          *dev;
> @@ -168,6 +149,7 @@ struct omap_hsmmc_host {
>         unsigned int            dma_sg_idx;
>         unsigned char           bus_mode;
>         unsigned char           power_mode;
> +       u16                     *regs;
>         u32                     *buffer;
>         u32                     bytesleft;
>         int                     suspended;
> @@ -517,9 +499,9 @@ static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
>   */
>  static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
>  {
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL,
> -               OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
> -       if ((OMAP_HSMMC_READ(host->base, SYSCTL) & CEN) != 0x0)
> +       OMAP_HSMMC_WRITE(host, SYSCTL,
> +               OMAP_HSMMC_READ(host, SYSCTL) & ~CEN);
> +       if ((OMAP_HSMMC_READ(host, SYSCTL) & CEN) != 0x0)
>                 dev_dbg(mmc_dev(host->mmc), "MMC Clock is not stoped\n");
>  }
> 
> @@ -537,16 +519,16 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
>         if (cmd->opcode == MMC_ERASE)
>                 irq_mask &= ~DTO_ENABLE;
> 
> -       OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> -       OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
> -       OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
> +       OMAP_HSMMC_WRITE(host, STAT, STAT_CLEAR);
> +       OMAP_HSMMC_WRITE(host, ISE, irq_mask);
> +       OMAP_HSMMC_WRITE(host, IE, irq_mask);
>  }
> 
>  static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
>  {
> -       OMAP_HSMMC_WRITE(host->base, ISE, 0);
> -       OMAP_HSMMC_WRITE(host->base, IE, 0);
> -       OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +       OMAP_HSMMC_WRITE(host, ISE, 0);
> +       OMAP_HSMMC_WRITE(host, IE, 0);
> +       OMAP_HSMMC_WRITE(host, STAT, STAT_CLEAR);
>  }
> 
>  #ifdef CONFIG_PM
> @@ -577,19 +559,19 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
> 
>         /* Wait for hardware reset */
>         timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> -       while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
> +       while ((OMAP_HSMMC_READ(host, SYSSTATUS) & RESETDONE) != RESETDONE
>                 && time_before(jiffies, timeout))
>                 ;
> 
>         /* Do software reset */
> -       OMAP_HSMMC_WRITE(host->base, SYSCONFIG, SOFTRESET);
> +       OMAP_HSMMC_WRITE(host, SYSCONFIG, SOFTRESET);
>         timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> -       while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
> +       while ((OMAP_HSMMC_READ(host, SYSSTATUS) & RESETDONE) != RESETDONE
>                 && time_before(jiffies, timeout))
>                 ;
> 
> -       OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
> -                       OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
> +       OMAP_HSMMC_WRITE(host, SYSCONFIG,
> +                       OMAP_HSMMC_READ(host, SYSCONFIG) | AUTOIDLE);
> 
>         if (host->id == OMAP_MMC1_DEVID) {
>                 if (host->power_mode != MMC_POWER_OFF &&
> @@ -603,17 +585,17 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
>                 capa = VS18;
>         }
> 
> -       OMAP_HSMMC_WRITE(host->base, HCTL,
> -                       OMAP_HSMMC_READ(host->base, HCTL) | hctl);
> +       OMAP_HSMMC_WRITE(host, HCTL,
> +                       OMAP_HSMMC_READ(host, HCTL) | hctl);
> 
> -       OMAP_HSMMC_WRITE(host->base, CAPA,
> -                       OMAP_HSMMC_READ(host->base, CAPA) | capa);
> +       OMAP_HSMMC_WRITE(host, CAPA,
> +                       OMAP_HSMMC_READ(host, CAPA) | capa);
> 
> -       OMAP_HSMMC_WRITE(host->base, HCTL,
> -                       OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
> +       OMAP_HSMMC_WRITE(host, HCTL,
> +                       OMAP_HSMMC_READ(host, HCTL) | SDBP);
> 
>         timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> -       while ((OMAP_HSMMC_READ(host->base, HCTL) & SDBP) != SDBP
> +       while ((OMAP_HSMMC_READ(host, HCTL) & SDBP) != SDBP
>                 && time_before(jiffies, timeout))
>                 ;
> 
> @@ -623,20 +605,20 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
>         if (host->power_mode == MMC_POWER_OFF)
>                 goto out;
> 
> -       con = OMAP_HSMMC_READ(host->base, CON);
> +       con = OMAP_HSMMC_READ(host, CON);
>         switch (ios->bus_width) {
>         case MMC_BUS_WIDTH_8:
> -               OMAP_HSMMC_WRITE(host->base, CON, con | DW8);
> +               OMAP_HSMMC_WRITE(host, CON, con | DW8);
>                 break;
>         case MMC_BUS_WIDTH_4:
> -               OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
> -               OMAP_HSMMC_WRITE(host->base, HCTL,
> -                       OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
> +               OMAP_HSMMC_WRITE(host, CON, con & ~DW8);
> +               OMAP_HSMMC_WRITE(host, HCTL,
> +                       OMAP_HSMMC_READ(host, HCTL) | FOUR_BIT);
>                 break;
>         case MMC_BUS_WIDTH_1:
> -               OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
> -               OMAP_HSMMC_WRITE(host->base, HCTL,
> -                       OMAP_HSMMC_READ(host->base, HCTL) & ~FOUR_BIT);
> +               OMAP_HSMMC_WRITE(host, CON, con & ~DW8);
> +               OMAP_HSMMC_WRITE(host, HCTL,
> +                       OMAP_HSMMC_READ(host, HCTL) & ~FOUR_BIT);
>                 break;
>         }
> 
> @@ -652,25 +634,23 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
>                         dsor = 250;
>         }
> 
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL,
> -               OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL, (dsor << 6) | (DTO << 16));
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL,
> -               OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
> +       OMAP_HSMMC_WRITE(host, SYSCTL, OMAP_HSMMC_READ(host, SYSCTL) & ~CEN);
> +       OMAP_HSMMC_WRITE(host, SYSCTL, (dsor << 6) | (DTO << 16));
> +       OMAP_HSMMC_WRITE(host, SYSCTL, OMAP_HSMMC_READ(host, SYSCTL) | ICE);
> 
>         timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> -       while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) != ICS
> +       while ((OMAP_HSMMC_READ(host, SYSCTL) & ICS) != ICS
>                 && time_before(jiffies, timeout))
>                 ;
> 
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL,
> -               OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
> +       OMAP_HSMMC_WRITE(host, SYSCTL,
> +               OMAP_HSMMC_READ(host, SYSCTL) | CEN);
> 
> -       con = OMAP_HSMMC_READ(host->base, CON);
> +       con = OMAP_HSMMC_READ(host, CON);
>         if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
> -               OMAP_HSMMC_WRITE(host->base, CON, con | OD);
> +               OMAP_HSMMC_WRITE(host, CON, con | OD);
>         else
> -               OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
> +               OMAP_HSMMC_WRITE(host, CON, con & ~OD);
>  out:
>         host->context_loss = context_loss;
> 
> @@ -721,20 +701,20 @@ static void send_init_stream(struct omap_hsmmc_host *host)
> 
>         disable_irq(host->irq);
> 
> -       OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> -       OMAP_HSMMC_WRITE(host->base, CON,
> -               OMAP_HSMMC_READ(host->base, CON) | INIT_STREAM);
> -       OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);
> +       OMAP_HSMMC_WRITE(host, IE, INT_EN_MASK);
> +       OMAP_HSMMC_WRITE(host, CON,
> +               OMAP_HSMMC_READ(host, CON) | INIT_STREAM);
> +       OMAP_HSMMC_WRITE(host, CMD, INIT_STREAM_CMD);
> 
>         timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
>         while ((reg != CC) && time_before(jiffies, timeout))
> -               reg = OMAP_HSMMC_READ(host->base, STAT) & CC;
> +               reg = OMAP_HSMMC_READ(host, STAT) & CC;
> 
> -       OMAP_HSMMC_WRITE(host->base, CON,
> -               OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
> +       OMAP_HSMMC_WRITE(host, CON,
> +               OMAP_HSMMC_READ(host, CON) & ~INIT_STREAM);
> 
> -       OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> -       OMAP_HSMMC_READ(host->base, STAT);
> +       OMAP_HSMMC_WRITE(host, STAT, STAT_CLEAR);
> +       OMAP_HSMMC_READ(host, STAT);
> 
>         enable_irq(host->irq);
>  }
> @@ -823,8 +803,8 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
> 
>         host->req_in_progress = 1;
> 
> -       OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
> -       OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
> +       OMAP_HSMMC_WRITE(host, ARG, cmd->arg);
> +       OMAP_HSMMC_WRITE(host, CMD, cmdreg);
>  }
> 
>  static int
> @@ -898,13 +878,13 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136) {
>                         /* response type 2 */
> -                       cmd->resp[3] = OMAP_HSMMC_READ(host->base, RSP10);
> -                       cmd->resp[2] = OMAP_HSMMC_READ(host->base, RSP32);
> -                       cmd->resp[1] = OMAP_HSMMC_READ(host->base, RSP54);
> -                       cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP76);
> +                       cmd->resp[3] = OMAP_HSMMC_READ(host, RSP10);
> +                       cmd->resp[2] = OMAP_HSMMC_READ(host, RSP32);
> +                       cmd->resp[1] = OMAP_HSMMC_READ(host, RSP54);
> +                       cmd->resp[0] = OMAP_HSMMC_READ(host, RSP76);
>                 } else {
>                         /* response types 1, 1b, 3, 4, 5, 6 */
> -                       cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP10);
> +                       cmd->resp[0] = OMAP_HSMMC_READ(host, RSP10);
>                 }
>         }
>         if ((host->data == NULL && !host->response_busy) || cmd->error)
> @@ -977,14 +957,14 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host
> *host,
>         unsigned long limit = (loops_per_jiffy *
>                                 msecs_to_jiffies(MMC_TIMEOUT_MS));
> 
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL,
> -                        OMAP_HSMMC_READ(host->base, SYSCTL) | bit);
> +       OMAP_HSMMC_WRITE(host, SYSCTL,
> +                        OMAP_HSMMC_READ(host, SYSCTL) | bit);
> 
> -       while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) &&
> +       while ((OMAP_HSMMC_READ(host, SYSCTL) & bit) &&
>                 (i++ < limit))
>                 cpu_relax();
> 
> -       if (OMAP_HSMMC_READ(host->base, SYSCTL) & bit)
> +       if (OMAP_HSMMC_READ(host, SYSCTL) & bit)
>                 dev_err(mmc_dev(host->mmc),
>                         "Timeout waiting on controller reset in %s\n",
>                         __func__);
> @@ -997,9 +977,9 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
> 
>         if (!host->req_in_progress) {
>                 do {
> -                       OMAP_HSMMC_WRITE(host->base, STAT, status);
> +                       OMAP_HSMMC_WRITE(host, STAT, status);
>                         /* Flush posted write */
> -                       status = OMAP_HSMMC_READ(host->base, STAT);
> +                       status = OMAP_HSMMC_READ(host, STAT);
>                 } while (status & INT_EN_MASK);
>                 return;
>         }
> @@ -1056,7 +1036,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>                 }
>         }
> 
> -       OMAP_HSMMC_WRITE(host->base, STAT, status);
> +       OMAP_HSMMC_WRITE(host, STAT, status);
> 
>         if (end_cmd || ((status & CC) && host->cmd))
>                 omap_hsmmc_cmd_done(host, host->cmd);
> @@ -1072,11 +1052,11 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>         struct omap_hsmmc_host *host = dev_id;
>         int status;
> 
> -       status = OMAP_HSMMC_READ(host->base, STAT);
> +       status = OMAP_HSMMC_READ(host, STAT);
>         do {
>                 omap_hsmmc_do_irq(host, status);
>                 /* Flush posted write */
> -               status = OMAP_HSMMC_READ(host->base, STAT);
> +               status = OMAP_HSMMC_READ(host, STAT);
>         } while (status & INT_EN_MASK);
> 
>         return IRQ_HANDLED;
> @@ -1086,10 +1066,10 @@ static void set_sd_bus_power(struct omap_hsmmc_host *host)
>  {
>         unsigned long i;
> 
> -       OMAP_HSMMC_WRITE(host->base, HCTL,
> -                        OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
> +       OMAP_HSMMC_WRITE(host, HCTL,
> +                        OMAP_HSMMC_READ(host, HCTL) | SDBP);
>         for (i = 0; i < loops_per_jiffy; i++) {
> -               if (OMAP_HSMMC_READ(host->base, HCTL) & SDBP)
> +               if (OMAP_HSMMC_READ(host, HCTL) & SDBP)
>                         break;
>                 cpu_relax();
>         }
> @@ -1128,9 +1108,9 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
>         if (ret != 0)
>                 goto err;
> 
> -       OMAP_HSMMC_WRITE(host->base, HCTL,
> -               OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
> -       reg_val = OMAP_HSMMC_READ(host->base, HCTL);
> +       OMAP_HSMMC_WRITE(host, HCTL,
> +               OMAP_HSMMC_READ(host, HCTL) & SDVSCLR);
> +       reg_val = OMAP_HSMMC_READ(host, HCTL);
> 
>         /*
>          * If a MMC dual voltage card is detected, the set_ios fn calls
> @@ -1152,7 +1132,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
>         else
>                 reg_val |= SDVS30;
> 
> -       OMAP_HSMMC_WRITE(host->base, HCTL, reg_val);
> +       OMAP_HSMMC_WRITE(host, HCTL, reg_val);
>         set_sd_bus_power(host);
> 
>         return 0;
> @@ -1248,12 +1228,12 @@ static void omap_hsmmc_config_dma_params(struct omap_hsmmc_host *host,
>         dma_ch = host->dma_ch;
>         if (data->flags & MMC_DATA_WRITE) {
>                 omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
> -                       (host->mapbase + OMAP_HSMMC_DATA), 0, 0);
> +                       (host->mapbase + host->regs[OMAP_HSMMC_DATA]), 0, 0);
>                 omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
>                         sg_dma_address(sgl), 0, 0);
>         } else {
>                 omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
> -                       (host->mapbase + OMAP_HSMMC_DATA), 0, 0);
> +                       (host->mapbase + host->regs[OMAP_HSMMC_DATA]), 0, 0);
>                 omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
>                         sg_dma_address(sgl), 0, 0);
>         }
> @@ -1369,7 +1349,7 @@ static void set_data_timeout(struct omap_hsmmc_host *host,
>         unsigned int timeout, cycle_ns;
>         uint32_t reg, clkd, dto = 0;
> 
> -       reg = OMAP_HSMMC_READ(host->base, SYSCTL);
> +       reg = OMAP_HSMMC_READ(host, SYSCTL);
>         clkd = (reg & CLKD_MASK) >> CLKD_SHIFT;
>         if (clkd == 0)
>                 clkd = 1;
> @@ -1396,7 +1376,7 @@ static void set_data_timeout(struct omap_hsmmc_host *host,
> 
>         reg &= ~DTO_MASK;
>         reg |= dto << DTO_SHIFT;
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL, reg);
> +       OMAP_HSMMC_WRITE(host, SYSCTL, reg);
>  }
> 
>  /*
> @@ -1409,7 +1389,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
>         host->data = req->data;
> 
>         if (req->data == NULL) {
> -               OMAP_HSMMC_WRITE(host->base, BLK, 0);
> +               OMAP_HSMMC_WRITE(host, BLK, 0);
>                 /*
>                  * Set an arbitrary 100ms data timeout for commands with
>                  * busy signal.
> @@ -1419,7 +1399,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
>                 return 0;
>         }
> 
> -       OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
> +       OMAP_HSMMC_WRITE(host, BLK, (req->data->blksz)
>                                         | (req->data->blocks << 16));
>         set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
> 
> @@ -1510,20 +1490,20 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> 
>         /* FIXME: set registers based only on changes to ios */
> 
> -       con = OMAP_HSMMC_READ(host->base, CON);
> +       con = OMAP_HSMMC_READ(host, CON);
>         switch (mmc->ios.bus_width) {
>         case MMC_BUS_WIDTH_8:
> -               OMAP_HSMMC_WRITE(host->base, CON, con | DW8);
> +               OMAP_HSMMC_WRITE(host, CON, con | DW8);
>                 break;
>         case MMC_BUS_WIDTH_4:
> -               OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
> -               OMAP_HSMMC_WRITE(host->base, HCTL,
> -                       OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
> +               OMAP_HSMMC_WRITE(host, CON, con & ~DW8);
> +               OMAP_HSMMC_WRITE(host, HCTL,
> +                       OMAP_HSMMC_READ(host, HCTL) | FOUR_BIT);
>                 break;
>         case MMC_BUS_WIDTH_1:
> -               OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
> -               OMAP_HSMMC_WRITE(host->base, HCTL,
> -                       OMAP_HSMMC_READ(host->base, HCTL) & ~FOUR_BIT);
> +               OMAP_HSMMC_WRITE(host, CON, con & ~DW8);
> +               OMAP_HSMMC_WRITE(host, HCTL,
> +                       OMAP_HSMMC_READ(host, HCTL) & ~FOUR_BIT);
>                 break;
>         }
> 
> @@ -1531,7 +1511,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 /* Only MMC1 can interface at 3V without some flavor
>                  * of external transceiver; but they all handle 1.8V.
>                  */
> -               if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
> +               if ((OMAP_HSMMC_READ(host, HCTL) & SDVSDET) &&
>                         (ios->vdd == DUAL_VOLT_OCR_BIT)) {
>                                 /*
>                                  * The mmc_select_voltage fn of the core does
> @@ -1557,30 +1537,30 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                         dsor = 250;
>         }
>         omap_hsmmc_stop_clock(host);
> -       regval = OMAP_HSMMC_READ(host->base, SYSCTL);
> +       regval = OMAP_HSMMC_READ(host, SYSCTL);
>         regval = regval & ~(CLKD_MASK);
>         regval = regval | (dsor << 6) | (DTO << 16);
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL,
> -               OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
> +       OMAP_HSMMC_WRITE(host, SYSCTL, regval);
> +       OMAP_HSMMC_WRITE(host, SYSCTL,
> +               OMAP_HSMMC_READ(host, SYSCTL) | ICE);
> 
>         /* Wait till the ICS bit is set */
>         timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> -       while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) != ICS
> +       while ((OMAP_HSMMC_READ(host, SYSCTL) & ICS) != ICS
>                 && time_before(jiffies, timeout))
>                 msleep(1);
> 
> -       OMAP_HSMMC_WRITE(host->base, SYSCTL,
> -               OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
> +       OMAP_HSMMC_WRITE(host, SYSCTL,
> +               OMAP_HSMMC_READ(host, SYSCTL) | CEN);
> 
>         if (do_send_init_stream)
>                 send_init_stream(host);
> 
> -       con = OMAP_HSMMC_READ(host->base, CON);
> +       con = OMAP_HSMMC_READ(host, CON);
>         if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
> -               OMAP_HSMMC_WRITE(host->base, CON, con | OD);
> +               OMAP_HSMMC_WRITE(host, CON, con | OD);
>         else
> -               OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
> +               OMAP_HSMMC_WRITE(host, CON, con & ~OD);
> 
>         if (host->power_mode == MMC_POWER_OFF)
>                 mmc_host_disable(host->mmc);
> @@ -1627,15 +1607,15 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>                 capa = VS18;
>         }
> 
> -       value = OMAP_HSMMC_READ(host->base, HCTL) & ~SDVS_MASK;
> -       OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl);
> +       value = OMAP_HSMMC_READ(host, HCTL) & ~SDVS_MASK;
> +       OMAP_HSMMC_WRITE(host, HCTL, value | hctl);
> 
> -       value = OMAP_HSMMC_READ(host->base, CAPA);
> -       OMAP_HSMMC_WRITE(host->base, CAPA, value | capa);
> +       value = OMAP_HSMMC_READ(host, CAPA);
> +       OMAP_HSMMC_WRITE(host, CAPA, value | capa);
> 
>         /* Set the controller to AUTO IDLE mode */
> -       value = OMAP_HSMMC_READ(host->base, SYSCONFIG);
> -       OMAP_HSMMC_WRITE(host->base, SYSCONFIG, value | AUTOIDLE);
> +       value = OMAP_HSMMC_READ(host, SYSCONFIG);
> +       OMAP_HSMMC_WRITE(host, SYSCONFIG, value | AUTOIDLE);
> 
>         /* Set SD bus power bit */
>         set_sd_bus_power(host);
> @@ -1932,19 +1912,19 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
>         }
> 
>         seq_printf(s, "SYSCONFIG:\t0x%08x\n",
> -                       OMAP_HSMMC_READ(host->base, SYSCONFIG));
> +                       OMAP_HSMMC_READ(host, SYSCONFIG));
>         seq_printf(s, "CON:\t\t0x%08x\n",
> -                       OMAP_HSMMC_READ(host->base, CON));
> +                       OMAP_HSMMC_READ(host, CON));
>         seq_printf(s, "HCTL:\t\t0x%08x\n",
> -                       OMAP_HSMMC_READ(host->base, HCTL));
> +                       OMAP_HSMMC_READ(host, HCTL));
>         seq_printf(s, "SYSCTL:\t\t0x%08x\n",
> -                       OMAP_HSMMC_READ(host->base, SYSCTL));
> +                       OMAP_HSMMC_READ(host, SYSCTL));
>         seq_printf(s, "IE:\t\t0x%08x\n",
> -                       OMAP_HSMMC_READ(host->base, IE));
> +                       OMAP_HSMMC_READ(host, IE));
>         seq_printf(s, "ISE:\t\t0x%08x\n",
> -                       OMAP_HSMMC_READ(host->base, ISE));
> +                       OMAP_HSMMC_READ(host, ISE));
>         seq_printf(s, "CAPA:\t\t0x%08x\n",
> -                       OMAP_HSMMC_READ(host->base, CAPA));
> +                       OMAP_HSMMC_READ(host, CAPA));
> 
>         clk_disable(host->fclk);
> 
> @@ -2028,6 +2008,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>         host->slot_id   = 0;
>         host->mapbase   = res->start;
>         host->base      = ioremap(host->mapbase, SZ_4K);
> +       host->regs      = (u16 *) pdata->regs_map;
>         host->power_mode = MMC_POWER_OFF;
> 
>         platform_set_drvdata(pdev, host);
> @@ -2328,8 +2309,8 @@ static int omap_hsmmc_suspend(struct device *dev)
>                 ret = mmc_suspend_host(host->mmc);
>                 if (ret == 0) {
>                         omap_hsmmc_disable_irq(host);
> -                       OMAP_HSMMC_WRITE(host->base, HCTL,
> -                               OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
> +                       OMAP_HSMMC_WRITE(host, HCTL,
> +                               OMAP_HSMMC_READ(host, HCTL) & ~SDBP);
>                         mmc_host_disable(host->mmc);
>                         clk_disable(host->iclk);
>                         if (host->got_dbclk)
> --
> 1.7.0.4
> 
> 
> 

