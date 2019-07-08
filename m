From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH RFC v1 2/2] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
Date: Mon, 8 Jul 2019 19:40:19 +0200
Message-ID: <CAFBinCD8UG5PtCLzFDmiK22T03TVgGrgLB1zW3vLOAvXWs3Tvg@mail.gmail.com>
References: <20190708173330.13217-1-martin.blumenstingl@googlemail.com> <20190708173330.13217-3-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708173330.13217-3-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jianxin.pan@amlogic.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hello Jianxin,

I thought I'd put my questions inline again so it's easier to follow me.
I hope you can help clarify some of the questions I have.

On Mon, Jul 8, 2019 at 7:33 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> WiP - only partially working - see performance numbers.
>
> Odroid-C1 eMMC (HS-200):
> Amlogic's vendor driver @ Linux 3.10:
>   7781351936 bytes (7.8 GB) copied, 134.714 s, 57.8 MB/s
> This driver:
>   7781351936 bytes (7.8 GB, 7.2 GiB) copied, 189.02 s, 41.2 MB/s
>
> EC-100 eMMC (HS MMC):
> Amlogic's vendor driver @ Linux 3.10:
>   15762194432 bytes (16 GB) copied, 422.967 s, 37.3 MB/s
> This driver:
>   15762194432 bytes (16 GB, 15 GiB) copied, 9232.65 s, 1.7 MB/s
my EC-100 board uses high-speed MMC (no HS-200) mode only and it's
really bad there
on Odroid-C1 the MMC the performance is at ~70% of the 3.10 kernel driver

my thinking is that phase tuning "fixes" the performance on Odroid-C1
(EC-100 doesn't use tuning because it's not using HS-200 mode).
I could be wrong here though. Please let me know if you have any suggestions


[...]
> +               if (mmc->actual_clock > 100000000) {
> +                       rx_clk_phase = 1;
> +               } else if (mmc->actual_clock > 45000000) {
> +                       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> +                               rx_clk_phase = 15;
> +                       else
> +                               rx_clk_phase = 11;
> +               } else if (mmc->actual_clock >= 25000000) {
> +                       rx_clk_phase = 15;
> +               } else if (mmc->actual_clock > 5000000) {
> +                       rx_clk_phase = 23;
> +               } else if (mmc->actual_clock > 1000000) {
> +                       rx_clk_phase = 55;
> +               } else {
> +                       rx_clk_phase = 1061;
> +               }
this MMC clock frequency to RX clock phase mapping only seems to work
for FCLK_DIV3
how do I calculate this dynamically?

[...]
> +static int meson_mx_sdhc_register_clks(struct meson_mx_sdhc_host *host)
> +{
> +       struct clk *mux_parents[MESON_SDHC_PARENT_CLKS];
> +       struct clk *mux_clk, *div_clk;
> +       int i;
> +
> +       for (i = 0; i < MESON_SDHC_PARENT_CLKS; i++)
> +               mux_parents[i] = host->parent_clks[i].clk;
> +
> +       host->clkc_clk_src_sel.reg = host->base + MESON_SDHC_CLKC;
> +       host->clkc_clk_src_sel.shift = __ffs(MESON_SDHC_CLKC_CLK_SRC_SEL);
> +       host->clkc_clk_src_sel.mask = MESON_SDHC_CLKC_CLK_SRC_SEL >>
> +                                     host->clkc_clk_src_sel.shift;
> +       mux_clk = meson_mx_sdhc_register_clk(mmc_dev(host->mmc),
> +                                            &host->clkc_clk_src_sel.hw,
> +                                            "clk_src_sel",
> +                                            MESON_SDHC_PARENT_CLKS,
> +                                            mux_parents,
> +                                            CLK_SET_RATE_NO_REPARENT,
> +                                            &clk_mux_ops);
> +       if (IS_ERR(mux_clk))
> +               return PTR_ERR(mux_clk);
> +
> +       host->clkc_clk_div.reg = host->base + MESON_SDHC_CLKC;
> +       host->clkc_clk_div.shift = __ffs(MESON_SDHC_CLKC_CLK_DIV);
> +       host->clkc_clk_div.width = fls(MESON_SDHC_CLKC_CLK_DIV) -
> +                                  host->clkc_clk_div.shift;
are there any constraints for the divider?
the driver from the Amlogic kernel sources does this, but I'm not sure
what this is trying to achieve (and why):
       clk_div = input_rate / clk_ios - !(input_rate%clk_ios);
       if (!(clk_div & 0x01)) // if even number, turn it to an odd one
          clk_div++;

[...]
> +       mmc->max_busy_timeout = 0; // TODO: actual value?
do you know the actual busy timeout of this IP block?


Thank you for your time!
Regards
Martin
