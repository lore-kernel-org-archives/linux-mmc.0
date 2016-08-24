From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] MMC: meson: initial support for GXBB platforms
Date: Wed, 24 Aug 2016 13:53:08 +0200
Message-ID: <CAPDyKFpPCkCRB436zdZ664st9xwA6wTWkFtT=U4HTwwAn-_emg@mail.gmail.com>
References: <20160803231843.23012-1-khilman@baylibre.com> <20160803231843.23012-2-khilman@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160803231843.23012-2-khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Xing Wu <xing.xu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 4 August 2016 at 01:18, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> Initial support for the SD/eMMC controller in the Amlogic S905/GXBB
> family of SoCs.
>
> Currently working for the SD and eMMC interfaces, but not yet tested
> for SDIO.
>
> Tested external SD card and internal eMMC on meson-gxbb-p200 and
> meson-gxbb-odroidc2.
>
> Signed-off-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  MAINTAINERS                   |   1 +
>  drivers/mmc/host/Kconfig      |  10 +
>  drivers/mmc/host/Makefile     |   1 +
>  drivers/mmc/host/meson-gxbb.c | 918 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 930 insertions(+)
>  create mode 100644 drivers/mmc/host/meson-gxbb.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7304d2e37a98..3762e46811f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -972,6 +972,7 @@ F:  arch/arm/mach-meson/
>  F:     arch/arm/boot/dts/meson*
>  F:     arch/arm64/boot/dts/amlogic/
>  F:     drivers/pinctrl/meson/
> +F:      drivers/mmc/host/meson*
>  N:     meson
>
>  ARM/Annapurna Labs ALPINE ARCHITECTURE
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0aa484c10c0a..4c3d091f7548 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -332,6 +332,16 @@ config MMC_SDHCI_IPROC
>
>           If unsure, say N.
>
> +config MMC_MESON_GXBB
> +       tristate "Amlogic S905/GXBB SD/MMC Host Controller support"
> +       depends on ARCH_MESON && MMC
> +       help
> +         This selects support for the Amlogic SD/MMC Host Controller
> +         found on the S905/GXBB family of SoCs.  This controller is
> +         MMC 5.1 compliant and support SD, eMMC and SDIO interfaces.
> +
> +         If you have a controller with this interface, say Y here.
> +
>  config MMC_MOXART
>         tristate "MOXART SD/MMC Host Controller support"
>         depends on ARCH_MOXART && MMC
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index af918d261ff9..3e0de57f55b9 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_MMC_JZ4740)      += jz4740_mmc.o
>  obj-$(CONFIG_MMC_VUB300)       += vub300.o
>  obj-$(CONFIG_MMC_USHC)         += ushc.o
>  obj-$(CONFIG_MMC_WMT)          += wmt-sdmmc.o
> +obj-$(CONFIG_MMC_MESON_GXBB)   += meson-gxbb.o
>  obj-$(CONFIG_MMC_MOXART)       += moxart-mmc.o
>  obj-$(CONFIG_MMC_SUNXI)                += sunxi-mmc.o
>  obj-$(CONFIG_MMC_USDHI6ROL0)   += usdhi6rol0.o
> diff --git a/drivers/mmc/host/meson-gxbb.c b/drivers/mmc/host/meson-gxbb.c
> new file mode 100644
> index 000000000000..10eac41cf31a
> --- /dev/null
> +++ b/drivers/mmc/host/meson-gxbb.c
> @@ -0,0 +1,918 @@
> +/*
> + * This file is provided under a dual BSD/GPLv2 license.  When using or
> + * redistributing this file, you may do so under either license.
> + *
> + * GPL LICENSE SUMMARY
> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * The full GNU General Public License is included in this distribution
> + * in the file called COPYING.
> + *
> + * BSD LICENSE
> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + *   * Redistributions of source code must retain the above copyright
> + *     notice, this list of conditions and the following disclaimer.
> + *   * Redistributions in binary form must reproduce the above copyright
> + *     notice, this list of conditions and the following disclaimer in
> + *     the documentation and/or other materials provided with the
> + *     distribution.
> + *   * Neither the name of Intel Corporation nor the names of its
> + *     contributors may be used to endorse or promote products derived
> + *     from this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */

Lots of licence text. Isn't it enough to state dual BSD/GPLv2?

[...]

> +
> +struct meson_host {
> +       struct  device          *dev;
> +       struct  mmc_host        *mmc;
> +       struct  mmc_request     *mrq;
> +       struct  mmc_command     *cmd;
> +
> +       spinlock_t lock;
> +       void __iomem *regs;
> +#ifdef USE_REGMAP
> +       struct regmap *regmap;
> +#endif
> +       int irq;
> +       u32 ocr_mask;
> +       struct clk *core_clk;
> +       struct clk_mux mux;
> +       struct clk *mux_clk;
> +       struct clk *mux_parent[MUX_CLK_NUM_PARENTS];
> +       unsigned long mux_parent_rate[MUX_CLK_NUM_PARENTS];
> +
> +       struct clk_divider cfg_div;
> +       struct clk *cfg_div_clk;
> +
> +       unsigned int bounce_buf_size;
> +       void *bounce_buf;
> +       dma_addr_t bounce_dma_addr;
> +
> +       unsigned long clk_rate;
> +       unsigned long clk_src_rate;
> +       unsigned short clk_src_div;
> +};
> +
> +#define reg_read(host, offset) readl(host->regs + offset)
> +#define reg_write(host, offset, val) writel(val, host->regs + offset)

I am not a fan of macros, especially when I don't think they improves the code.

Could we just stick to use readl/writel() directly instead!?

[...]

> +static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
> +{
> +       struct mmc_host *mmc = host->mmc;
> +       int ret = 0;
> +       u32 cfg;
> +
> +       if (clk_rate) {
> +               if (WARN_ON(clk_rate > mmc->f_max))
> +                       clk_rate = mmc->f_max;
> +               else if (WARN_ON(clk_rate < mmc->f_min))
> +                       clk_rate = mmc->f_min;
> +       }
> +
> +       if (clk_rate == host->clk_rate)
> +               return 0;
> +
> +       /* stop clock */
> +       cfg = reg_read(host, SD_EMMC_CFG);
> +       if (!(cfg & CFG_STOP_CLOCK)) {
> +               cfg |= CFG_STOP_CLOCK;
> +               reg_write(host, SD_EMMC_CFG, cfg);
> +       }
> +
> +       dev_dbg(host->dev, "change clock rate %lu -> %lu\n",
> +               host->clk_rate, clk_rate);
> +       ret = clk_set_rate(host->cfg_div_clk, clk_rate);
> +       if (clk_rate && clk_rate != clk_get_rate(host->cfg_div_clk))
> +               dev_warn(host->dev, "divider requested rate %lu != actual rate %lu: ret=%d\n",
> +                        clk_rate, clk_get_rate(host->cfg_div_clk), ret);
> +       else
> +               host->clk_rate = clk_rate;
> +
> +       /* (re)start clock, if non-zero */
> +       if (clk_rate) {
> +               cfg = reg_read(host, SD_EMMC_CFG);
> +               cfg &= ~CFG_STOP_CLOCK;
> +               reg_write(host, SD_EMMC_CFG, cfg);
> +       }

You probably want to update mmc->actual_clock, which is useful for
debugging purpose.

> +
> +       return ret;
> +}
> +
> +static int meson_mmc_clk_init(struct meson_host *host)
> +{
> +       struct clk_init_data init;
> +       char clk_name[32];
> +       int i, ret = 0;
> +       const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
> +       unsigned int mux_parent_count = 0;
> +       const char *clk_div_parents[1];
> +       unsigned int f_min = UINT_MAX;
> +       u32 clk_reg, cfg;
> +
> +       /* get the mux parents from DT */
> +       for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> +               char name[16];
> +
> +               snprintf(name, sizeof(name), "clkin%d", i);
> +               host->mux_parent[i] = devm_clk_get(host->dev, name);
> +               if (IS_ERR(host->mux_parent[i])) {
> +                       ret = PTR_ERR(host->mux_parent[i]);
> +                       if (PTR_ERR(host->mux_parent[i]) != -EPROBE_DEFER)
> +                               dev_err(host->dev, "Missing clock %s\n", name);
> +                       host->mux_parent[i] = NULL;
> +                       return ret;
> +               }
> +
> +               host->mux_parent_rate[i] = clk_get_rate(host->mux_parent[i]);
> +               mux_parent_names[i] = __clk_get_name(host->mux_parent[i]);
> +               mux_parent_count++;
> +               if (host->mux_parent_rate[i] < f_min)
> +                       f_min = host->mux_parent_rate[i];
> +       }
> +
> +       /* cacluate f_min based on input clocks, and max divider value */
> +       if (f_min != UINT_MAX)
> +               f_min = DIV_ROUND_UP(CLK_SRC_XTAL_RATE, CLK_DIV_MAX);
> +       else
> +               f_min = 4000000;  /* default min: 400 MHz */
> +       host->mmc->f_min = f_min;
> +
> +       /* create the mux */
> +       snprintf(clk_name, sizeof(clk_name), "%s#mux", dev_name(host->dev));
> +       init.name = clk_name;
> +       init.ops = &clk_mux_ops;
> +       init.flags = CLK_IS_BASIC;
> +       init.parent_names = mux_parent_names;
> +       init.num_parents = mux_parent_count;
> +
> +       host->mux.reg = host->regs + SD_EMMC_CLOCK;
> +       host->mux.shift = CLK_SRC_SHIFT;
> +       host->mux.mask = CLK_SRC_MASK;
> +       host->mux.flags = 0;
> +       host->mux.table = NULL;
> +       host->mux.hw.init = &init;
> +
> +       host->mux_clk = devm_clk_register(host->dev, &host->mux.hw);

I think it would make sense to add a comment here to clarify why you
register a clock like this.

I assume it's beacuse you benefit from the clock framwork about
acheiving the best/closest reqeust clockrate, as it take into account
muxes/parent clocks as well!?

> +       if (WARN_ON(PTR_ERR_OR_ZERO(host->mux_clk)))
> +               return PTR_ERR(host->mux_clk);
> +
> +       /* create the divider */
> +       snprintf(clk_name, sizeof(clk_name), "%s#div", dev_name(host->dev));
> +       init.name = devm_kstrdup(host->dev, clk_name, GFP_KERNEL);
> +       init.ops = &clk_divider_ops;
> +       init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
> +       clk_div_parents[0] = __clk_get_name(host->mux_clk);
> +       init.parent_names = clk_div_parents;
> +       init.num_parents = ARRAY_SIZE(clk_div_parents);
> +
> +       host->cfg_div.reg = host->regs + SD_EMMC_CLOCK;
> +       host->cfg_div.shift = CLK_DIV_SHIFT;
> +       host->cfg_div.width = CLK_DIV_WIDTH;
> +       host->cfg_div.hw.init = &init;
> +       host->cfg_div.flags = CLK_DIVIDER_ONE_BASED |
> +               CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ALLOW_ZERO;
> +
> +       host->cfg_div_clk = devm_clk_register(host->dev, &host->cfg_div.hw);

Ditto.

> +       if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
> +               return PTR_ERR(host->cfg_div_clk);
> +
> +       /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> +       clk_reg = 0;
> +       clk_reg |= CLK_PHASE_180 << CLK_PHASE_SHIFT;
> +       clk_reg |= CLK_SRC_XTAL << CLK_SRC_SHIFT;
> +       clk_reg |= CLK_DIV_MAX << CLK_DIV_SHIFT;
> +       clk_reg &= ~CLK_ALWAYS_ON;
> +       reg_write(host, SD_EMMC_CLOCK, clk_reg);
> +
> +       clk_prepare_enable(host->cfg_div_clk);
> +
> +       /* Ensure clock starts in "auto" mode, not "always on" */
> +       cfg = reg_read(host, SD_EMMC_CFG);
> +       cfg &= ~CFG_CLK_ALWAYS_ON;
> +       cfg |= CFG_AUTO_CLK;
> +       reg_write(host, SD_EMMC_CFG, cfg);
> +
> +       meson_mmc_clk_set(host, f_min);
> +
> +       return ret;
> +}
> +
> +static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct meson_host *host = mmc_priv(mmc);
> +       u32 bus_width;
> +       u32 val, orig;
> +
> +       /*
> +        * GPIO regulator, only controls switching between 1v8 and
> +        * 3v3, doesn't support MMC_POWER_OFF, MMC_POWER_ON.
> +        */

I don't follow. Shouldn't you call regulator_enable|disable() for the
above regulator? Why not?

> +       switch (ios->power_mode) {
> +       case MMC_POWER_UP:
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);

The above comment talks about 1v8 and 3v3, which seems to me that you
are changing the I/O voltage, but that's not what *vmmc* should be
used for.

If this is about I/O voltage, you shall instead use *vqmmc* and the
corresponding mmc_regulator_set_vqmmc() to change the voltage level.

This also leaves me to ask, then how do you control the power to the
card? This is actually what the *vmmc* should be used for.

> +       }
> +
> +       meson_mmc_clk_set(host, ios->clock);
> +
> +       /* Bus width */
> +       val = reg_read(host, SD_EMMC_CFG);
> +       switch (ios->bus_width) {
> +       case MMC_BUS_WIDTH_1:
> +               bus_width = CFG_BUS_WIDTH_1;
> +               break;
> +       case MMC_BUS_WIDTH_4:
> +               bus_width = CFG_BUS_WIDTH_4;
> +               break;
> +       case MMC_BUS_WIDTH_8:
> +               bus_width = CFG_BUS_WIDTH_8;
> +               break;
> +       default:
> +               dev_err(host->dev, "Invalid ios->bus_width: %u.  Setting to 4.\n",
> +                       ios->bus_width);
> +               bus_width = CFG_BUS_WIDTH_4;
> +               return;
> +       }
> +
> +       val = reg_read(host, SD_EMMC_CFG);
> +       orig = val;
> +
> +       val &= ~(CFG_BUS_WIDTH_MASK << CFG_BUS_WIDTH_SHIFT);
> +       val |= bus_width << CFG_BUS_WIDTH_SHIFT;
> +
> +       val &= ~(CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
> +       val |= ilog2(SD_EMMC_CFG_BLK_SIZE) << CFG_BLK_LEN_SHIFT;
> +
> +       val &= ~(CFG_RESP_TIMEOUT_MASK << CFG_RESP_TIMEOUT_SHIFT);
> +       val |= ilog2(SD_EMMC_CFG_RESP_TIMEOUT) << CFG_RESP_TIMEOUT_SHIFT;
> +
> +       val &= ~(CFG_RC_CC_MASK << CFG_RC_CC_SHIFT);
> +       val |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
> +
> +       reg_write(host, SD_EMMC_CFG, val);
> +
> +       if (val != orig)
> +               dev_dbg(host->dev, "%s: SD_EMMC_CFG: 0x%08x -> 0x%08x\n",
> +                       __func__, orig, val);
> +}
> +

[...]

> +
> +static int meson_mmc_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct resource *res;
> +       struct meson_host *host;
> +       struct mmc_host *mmc;
> +       int ret;
> +
> +       mmc = mmc_alloc_host(sizeof(struct meson_host), &pdev->dev);
> +       if (!mmc)
> +               return -ENOMEM;
> +       host = mmc_priv(mmc);
> +       host->mmc = mmc;
> +       host->dev = &pdev->dev;
> +       dev_set_drvdata(&pdev->dev, host);
> +
> +       spin_lock_init(&host->lock);
> +
> +       host->core_clk = devm_clk_get(&pdev->dev, "core");
> +       if (IS_ERR(host->core_clk)) {
> +               ret = PTR_ERR(host->core_clk);
> +               if (ret == -EPROBE_DEFER)
> +                       dev_dbg(&pdev->dev,
> +                               "Missing core clock.  EPROBE_DEFER\n");
> +               else
> +                       dev_err(&pdev->dev,
> +                               "Unable to get core clk (ret=%d).\n", ret);

I think these prints are unessarry, they should be printed by other
frameworks already, right!?

> +               goto free_host;
> +       }
> +
> +       /* Voltage supply */
> +       mmc_of_parse_voltage(np, &host->ocr_mask);

This looks odd.

Usally we get "ocr_avail" when asking the vmmc regulator about its
supported voltage range, via calling the below
mmc_regulator_get_supply() API. Can you explain why thay isn't work
for you?

> +       ret = mmc_regulator_get_supply(mmc);
> +       if (ret == -EPROBE_DEFER) {
> +               dev_dbg(&pdev->dev, "Missing regulator: EPROBE_DEFER");

The print shouldn't be needed, please remove.

> +               goto free_host;
> +       }
> +
> +       if (!mmc->ocr_avail)
> +               mmc->ocr_avail = host->ocr_mask;

mmc->ocr_avail needs to be assigned to a valid value. This fallback
doesn't cover that as host->ocr_mask may very well be zero.

> +
> +       ret = mmc_of_parse(mmc);
> +       if (ret) {
> +               dev_warn(&pdev->dev, "error parsing DT: %d\n", ret);
> +               goto free_host;
> +       }
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               ret = -ENODEV;
> +               goto free_host;
> +       }
> +       host->regs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(host->regs)) {
> +               ret = PTR_ERR(host->regs);
> +               goto free_host;
> +       }
> +
> +       host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq == 0) {
> +               dev_err(&pdev->dev, "failed to get interrupt resource.\n");
> +               ret = -EINVAL;
> +               goto free_host;
> +       }
> +
> +       ret = devm_request_threaded_irq(&pdev->dev, host->irq,
> +                                       meson_mmc_irq, meson_mmc_irq_thread,
> +                                       IRQF_SHARED, DRIVER_NAME, host);
> +       if (ret)
> +               goto free_host;
> +
> +       /* data bounce buffer */
> +       host->bounce_buf_size = SZ_512K;
> +       host->bounce_buf =
> +               dma_alloc_coherent(host->dev, host->bounce_buf_size,
> +                                  &host->bounce_dma_addr, GFP_KERNEL);
> +       if (host->bounce_buf == NULL) {
> +               dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
> +               ret = -ENOMEM;
> +               goto free_host;
> +       }
> +
> +       clk_prepare_enable(host->core_clk);
> +
> +       ret = meson_mmc_clk_init(host);
> +       if (ret)
> +               goto free_host;
> +
> +       /* Stop execution */
> +       reg_write(host, SD_EMMC_START, 0);
> +
> +       /* clear, ack, enable all interrupts */
> +       reg_write(host, SD_EMMC_IRQ_EN, 0);
> +       reg_write(host, SD_EMMC_STATUS, IRQ_EN_MASK);
> +
> +       mmc->ops = &meson_mmc_ops;
> +       mmc_add_host(mmc);
> +
> +       return 0;
> +
> +free_host:
> +       dev_dbg(host->dev, "Failed to probe: ret=%d\n", ret);
> +       if (host->core_clk)
> +               clk_disable_unprepare(host->core_clk);
> +       mmc_free_host(mmc);
> +       return ret;
> +}
> +

[...]

> +
> +static const struct of_device_id meson_mmc_of_match[] = {
> +       {
> +               .compatible = "amlogic,meson-gxbb-mmc",

You need to fold in a DT documentation patch, in this series as to
describe all the required/optional resourses for the device. That of
course also includes the compatible string.

> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, meson_mmc_of_match);

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
