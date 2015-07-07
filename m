From: Fabio Estevam <festevam@gmail.com>
Subject: Re: SDHCI: mdelay() in hot path in esdhc_pltfm_set_clock looses CAN
 (!) frames
Date: Tue, 7 Jul 2015 15:17:08 -0300
Message-ID: <CAOMZO5D02tarn9QrOuS3i1ekn=1Jupngo6RBOfyVm9QASPA23A@mail.gmail.com>
References: <CAOpc7mG7-RyZ2LSX8n1kh_KWaVf6N=Lo0LGt4ckLJWzp541FZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOpc7mG7-RyZ2LSX8n1kh_KWaVf6N=Lo0LGt4ckLJWzp541FZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, open list <linux-kernel@vger.kernel.org>, Dong Aisheng <b29396@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Holger,

Adding some more folks on Cc.

On Tue, Jun 30, 2015 at 10:43 AM, Holger Schurig
<holgerschurig@gmail.com> wrote:
> Hi,
>
> I noticed in a kernel 4.0.7 that I loose CAN packets when an incoming
> rsync transfer changes my eMMC or SD-Card image. I used CONFIG_FRACE
> to find why this is the case, and came to this trace:
>
> # tracer: preemptoff
> #
> # preemptoff latency trace v1.1.5 on 4.0.7
> # --------------------------------------------------------------------
> # latency: 1046 us, #756/756, CPU#2 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:4)
> #    -----------------
> #    | task: mmcqd/0-76 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  => started at: sdhci_do_set_ios
> #  => ended at:   sdhci_do_set_ios
> #
> #
> #                  _------=> CPU#
> #                 / _-----=> irqs-off
> #                | / _----=> need-resched
> #                || / _---=> hardirq/softirq
> #                ||| / _--=> preempt-depth
> #                |||| /     delay
> #  cmd     pid   ||||| time  |   caller
> #     \   /      |||||  \    |   /
> mmcqd/0-76      2d..1    1us : _raw_spin_lock_irq <-sdhci_do_set_ios
> mmcqd/0-76      2d..2    2us : esdhc_writeb_le <-sdhci_do_set_ios
> mmcqd/0-76      2d..2    4us : esdhc_pltfm_set_bus_width <-sdhci_do_set_ios
> mmcqd/0-76      2d..2    5us : l2c210_sync <-esdhc_pltfm_set_bus_width
> mmcqd/0-76      2d..2    7us : esdhc_writeb_le <-sdhci_do_set_ios
> mmcqd/0-76      2d..2    9us : l2c210_sync <-esdhc_writeb_le
> mmcqd/0-76      2d..2   10us : esdhc_readw_le <-sdhci_do_set_ios
> mmcqd/0-76      2d..2   12us : esdhc_writew_le <-sdhci_do_set_ios
> mmcqd/0-76      2d..2   14us : l2c210_sync <-esdhc_writew_le
> mmcqd/0-76      2d..2   16us : l2c210_sync <-esdhc_writew_le
> mmcqd/0-76      2d..2   18us : esdhc_readw_le <-sdhci_do_set_ios
> mmcqd/0-76      2d..2   19us : esdhc_writew_le <-sdhci_do_set_ios
> mmcqd/0-76      2d..2   21us : l2c210_sync <-esdhc_writew_le
> mmcqd/0-76      2d..2   22us : esdhc_set_uhs_signaling <-sdhci_do_set_ios
> mmcqd/0-76      2d..2   24us : pinctrl_select_state <-esdhc_set_uhs_signaling
> mmcqd/0-76      2d..2   26us : esdhc_readl_le <-esdhc_pltfm_set_clock
> mmcqd/0-76      2d..2   28us : esdhc_writel_le <-esdhc_pltfm_set_clock
> mmcqd/0-76      2d..2   29us : l2c210_sync <-esdhc_writel_le
> mmcqd/0-76      2d..2   31us : esdhc_readl_le <-esdhc_pltfm_set_clock
> mmcqd/0-76      2d..2   33us : esdhc_writel_le <-esdhc_pltfm_set_clock
> mmcqd/0-76      2d..2   34us : l2c210_sync <-esdhc_writel_le
> mmcqd/0-76      2d..2   36us : l2c210_sync <-esdhc_pltfm_set_clock
> mmcqd/0-76      2d..2   37us : __timer_const_udelay <-esdhc_pltfm_set_clock
> mmcqd/0-76      2d..2   39us : __timer_delay <-__timer_const_udelay
> mmcqd/0-76      2d..2   40us : read_current_timer <-__timer_delay
> mmcqd/0-76      2d..2   41us : imx_read_current_timer <-read_current_timer
> mmcqd/0-76      2d..2   43us : read_current_timer <-__timer_delay
> mmcqd/0-76      2d..2   44us : imx_read_current_timer <-read_current_timer
> mmcqd/0-76      2d..2   45us : read_current_timer <-__timer_delay
> ....
>
> So it seems that esdhc_pltfm_set_clock() somehow waits. And really
> there is an mdelay(1) there. So it waits a whopping millisecond there!
>
> What's worse: I put a printk() into this function, just before the
> mdelay(). And it get's called hundreds of times when I boot, or when I
> update via rsync. And I believe that for each call the mdelay() kills
> preemption.
>
> This is bad because in the FlexCAN driver the ISR calls
> napi_schedule(), which in turn clears the CAN RxFIFO. And if this
> scheduling is taking too long, CAN packets are dropped. With 50 bits
> per CAN packet anf 500000 bit/s this can happen quite easily (the
> RxFIFO is a hardware component that can hold only 6 CAN frames before
> data is lost).
>
> The mdelay() is also bad because it makes eMMC/SD-Card access WAY
> slower than they could be.
>
> I'm not firm with SDHCI, I only see that esdhc_pltfm_set_clock() is
> all the time called with 0 Hz and then with 20000000 Hz. Any tips on
> how to get rid of this clock-off-clock-on dance?
>
> Holger
