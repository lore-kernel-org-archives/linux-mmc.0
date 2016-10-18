From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] MMC: meson: initial support for GXBB platforms
Date: Tue, 18 Oct 2016 12:25:16 +0200
Message-ID: <CAPDyKFo5Anvg8ezcgwRcr0+KLQZ6Cy6KZzN5w1t-pBnafOeVJw@mail.gmail.com>
References: <20160914004314.682-1-khilman@baylibre.com> <20160914004314.682-2-khilman@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34969 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753616AbcJRKZS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 06:25:18 -0400
Received: by mail-qk0-f169.google.com with SMTP id z190so282864817qkc.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2016 03:25:18 -0700 (PDT)
In-Reply-To: <20160914004314.682-2-khilman@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Victor Wan <victor.wan@amlogic.com>, Jerry Cao <jerry.cao@amlogic.com>, Xing Wu <xing.xu@amlogic.com>, yonghui.yu@amlogic.com

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
> +       if (clk_rate == mmc->actual_clock)
> +               return 0;
> +
> +       /* stop clock */
> +       cfg = readl(host->regs + SD_EMMC_CFG);
> +       if (!(cfg & CFG_STOP_CLOCK)) {
> +               cfg |= CFG_STOP_CLOCK;
> +               writel(cfg, host->regs + SD_EMMC_CFG);
> +       }
> +
> +       dev_dbg(host->dev, "change clock rate %u -> %lu\n",
> +               mmc->actual_clock, clk_rate);
> +       ret = clk_set_rate(host->cfg_div_clk, clk_rate);

Shouldn't you check the error before proceeding?

> +       if (clk_rate && clk_rate != clk_get_rate(host->cfg_div_clk))
> +               dev_warn(host->dev, "divider requested rate %lu != actual rate %lu: ret=%d\n",
> +                        clk_rate, clk_get_rate(host->cfg_div_clk), ret);
> +       else
> +               mmc->actual_clock = clk_rate;
> +
> +       /* (re)start clock, if non-zero */
> +       if (clk_rate) {
> +               cfg = readl(host->regs + SD_EMMC_CFG);
> +               cfg &= ~CFG_STOP_CLOCK;
> +               writel(cfg, host->regs + SD_EMMC_CFG);
> +       }
> +
> +       return ret;
> +}
> +
> +/*
> + * The SD/eMMC IP block has an internal mux and divider used for
> + * generating the MMC clock.  Use the clock framework to create and
> + * manage these clocks.
> + */
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
> +       /* get the mux parents */
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
> +       init.flags = 0;
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
> +       if (WARN_ON(IS_ERR(host->mux_clk)))
> +               return PTR_ERR(host->mux_clk);
> +
> +       /* create the divider */
> +       snprintf(clk_name, sizeof(clk_name), "%s#div", dev_name(host->dev));
> +       init.name = devm_kstrdup(host->dev, clk_name, GFP_KERNEL);
> +       init.ops = &clk_divider_ops;
> +       init.flags = CLK_SET_RATE_PARENT;
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
> +       if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
> +               return PTR_ERR(host->cfg_div_clk);
> +
> +       /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> +       clk_reg = 0;
> +       clk_reg |= CLK_PHASE_180 << CLK_PHASE_SHIFT;
> +       clk_reg |= CLK_SRC_XTAL << CLK_SRC_SHIFT;
> +       clk_reg |= CLK_DIV_MAX << CLK_DIV_SHIFT;
> +       clk_reg &= ~CLK_ALWAYS_ON;
> +       writel(clk_reg, host->regs + SD_EMMC_CLOCK);
> +
> +       /* Ensure clock starts in "auto" mode, not "always on" */
> +       cfg = readl(host->regs + SD_EMMC_CFG);
> +       cfg &= ~CFG_CLK_ALWAYS_ON;
> +       cfg |= CFG_AUTO_CLK;
> +       writel(cfg, host->regs + SD_EMMC_CFG);
> +
> +       ret = clk_prepare_enable(host->cfg_div_clk);
> +       if (!ret)
> +               ret = meson_mmc_clk_set(host, f_min);
> +

In case of errors, I guess you should disable/unprepare the clock.

> +       return ret;
> +}
> +

[...]

> +
> +static int meson_mmc_probe(struct platform_device *pdev)
> +{
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
> +               goto free_host;
> +       }
> +
> +       /* Get regulators and the supported OCR mask */
> +       host->vqmmc_enabled = false;
> +       ret = mmc_regulator_get_supply(mmc);
> +       if (ret == -EPROBE_DEFER)
> +               goto free_host;

In free_host you call clk_disable_unprepare(). You don't want to do
that unless you already called clk_prepare_enable().

So, I think you need another label to distinguish between these two cases.

> +
> +       ret = mmc_of_parse(mmc);
> +       if (ret) {
> +               dev_warn(&pdev->dev, "error parsing DT: %d\n", ret);
> +               goto free_host;
> +       }
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
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
> +       ret = clk_prepare_enable(host->core_clk);
> +       if (ret)
> +               goto free_host;
> +
> +       ret = meson_mmc_clk_init(host);
> +       if (ret)
> +               goto free_host;
> +
> +       /* Stop execution */
> +       writel(0, host->regs + SD_EMMC_START);
> +
> +       /* clear, ack, enable all interrupts */
> +       writel(0, host->regs + SD_EMMC_IRQ_EN);
> +       writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
> +
> +       ret = devm_request_threaded_irq(&pdev->dev, host->irq,
> +                                       meson_mmc_irq, meson_mmc_irq_thread,
> +                                       IRQF_SHARED, DRIVER_NAME, host);
> +       if (ret)
> +               goto free_host;

Besides the earlier issue mentiond for the label free_host, here you
also need to consider yet another clock that has be been enabled in
meson_mmc_clk_init(). I assume you want to disable this clock in the
error path.

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
> +       mmc->ops = &meson_mmc_ops;
> +       mmc_add_host(mmc);
> +
> +       return 0;
> +
> +free_host:
> +       dev_dbg(host->dev, "Failed to probe: ret=%d\n", ret);

No need to print this, already managed by driver core.

> +       if (host->core_clk)

No need to check above, already done by the clock framework.

> +               clk_disable_unprepare(host->core_clk);
> +       mmc_free_host(mmc);
> +       return ret;
> +}
> +
> +static int meson_mmc_remove(struct platform_device *pdev)
> +{
> +       struct meson_host *host = dev_get_drvdata(&pdev->dev);
> +
> +       if (WARN_ON(!host))
> +               return 0;
> +
> +       if (host->bounce_buf)
> +               dma_free_coherent(host->dev, host->bounce_buf_size,
> +                                 host->bounce_buf, host->bounce_dma_addr);
> +
> +       if (host->cfg_div_clk)

No need to check this, aleady done by the clock framework.

> +               clk_disable_unprepare(host->cfg_div_clk);
> +
> +       if (host->core_clk)

Ditto.

> +               clk_disable_unprepare(host->core_clk);
> +
> +       mmc_free_host(host->mmc);
> +       return 0;
> +}
> +

[...]

Besides the minor stuff pointed out above, this looks great to me!

Before you re-spin, please drop this series from your branch which is
being integrated into linux-next, as otherwise I can't pick it up.

Kind regards
Uffe
