From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 03/14] mmc: dw_mmc: exynos: adjust the clock rate with
 speed mode
Date: Thu, 22 Aug 2013 11:24:23 +0900
Message-ID: <000901ce9ede$b7356060$25a02120$%jun@samsung.com>
References: <002801ce9e75$53f265c0$fbd73140$%jun@samsung.com>
 <CANEJEGvkY4ymiXT-K=6rG+MWin9Bm8y70T1yZ16gcDYak3C=Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51312 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab3HVCYa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 22:24:30 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRW0069VUON3O20@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Aug 2013 11:24:23 +0900 (KST)
In-reply-to: <CANEJEGvkY4ymiXT-K=6rG+MWin9Bm8y70T1yZ16gcDYak3C=Vg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Grant Grundler' <grundler@chromium.org>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

On Thursday, August 22, 2013, Grant Grundler wrote:
> On Wed, Aug 21, 2013 at 6:49 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Exynos's host has divider logic before 'cclk_in' to controller core.
> > It means that actual clock rate of ciu clock comes from this divider
> > value. So, source clock should be adjusted along with 'ciu_div' which
> > indicates the host's divider ratio. Setting clock rate basically fits
> > the required speed. Specially, 'cclk_in' should have double rate of
> > target speed in case of DDR 8-bit mode.
> 
> I've refactored this code in ChromeOS-3.4 kernel.
> Please see references to dw_mci_exynos_set_bus_hz() in:
>     https://gerrit.chromium.org/gerrit/#/c/57861/9/drivers/mmc/host/dw_mmc-exynos.c
> 
> Have you considered using that code? Perhaps Alim didn't point out
> this work to you?
> 
> It might be easier to read here:
> 
> http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=blob;f=drivers/mmc/host/dw_mmc.c
> ;h=41ff5a0d79dffb488a413c51ba14024d4dda1275;hb=refs/heads/chromeos-3.4
> 
> The same code was adopted for ChromeOS-3.8 kernel tree:
>     http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel-
> next.git;a=commitdiff;h=39ae94e55a0ad4584b5ff85e2a342a5f867c4d21
> 
>     http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel-
> next.git;a=history;f=drivers/mmc/host/dw_mmc-
> exynos.c;h=a8288d4c9fac8b89dadff5d4bde469c43171c9cf;hb=refs/heads/chromeos-3.8

The codes related to tuning feature have been introduced and opened already in Android kernel from our side.
Basically this changes are based on below and updated with latest kernel:

@ mmc: dw_mmc: add support of tuning feature
https://android.googlesource.com/kernel/exynos/+/016ebd43ab27cf8b0258d1e7d3e3288d7f7aab6a%5E%21/#F0

@ ARM: EXYNOS: adjust the clock rate for mmcx
https://android.googlesource.com/kernel/exynos/+/13afd72b983cc0438a295fa827ff1246fed148b2%5E%21/#F0

Thanks,
Seungwon Jeon

> thanks,
> grant
> 
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc-exynos.c |   44 ++++++++++++++++++++++++++++---------
> >  1 files changed, 33 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> > index 90f9335..f16e2fc 100644
> > --- a/drivers/mmc/host/dw_mmc-exynos.c
> > +++ b/drivers/mmc/host/dw_mmc-exynos.c
> > @@ -49,6 +49,7 @@ struct dw_mci_exynos_priv_data {
> >         u8                              ciu_div;
> >         u32                             sdr_timing;
> >         u32                             ddr_timing;
> > +       u32                             cur_speed;
> >  };
> >
> >  static struct dw_mci_exynos_compatible {
> > @@ -91,14 +92,9 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
> >  static int dw_mci_exynos_setup_clock(struct dw_mci *host)
> >  {
> >         struct dw_mci_exynos_priv_data *priv = host->priv;
> > +       unsigned long rate = clk_get_rate(host->ciu_clk);
> >
> > -       if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250)
> > -               host->bus_hz /= (priv->ciu_div + 1);
> > -       else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
> > -               host->bus_hz /= EXYNOS4412_FIXED_CIU_CLK_DIV;
> > -       else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
> > -               host->bus_hz /= EXYNOS4210_FIXED_CIU_CLK_DIV;
> > -
> > +       host->bus_hz = rate / (priv->ciu_div + 1);
> >         return 0;
> >  }
> >
> > @@ -118,11 +114,31 @@ static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
> >  static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >  {
> >         struct dw_mci_exynos_priv_data *priv = host->priv;
> > +       unsigned int wanted = ios->clock;
> > +       unsigned long actual;
> > +       u8 div = priv->ciu_div + 1;
> > +
> >
> > -       if (ios->timing == MMC_TIMING_UHS_DDR50)
> > +       if (ios->timing == MMC_TIMING_UHS_DDR50) {
> >                 mci_writel(host, CLKSEL, priv->ddr_timing);
> > -       else
> > +               /* Should be double rate for DDR mode */
> > +               if (ios->bus_width == MMC_BUS_WIDTH_8)
> > +                       wanted <<= 1;
> > +       } else {
> >                 mci_writel(host, CLKSEL, priv->sdr_timing);
> > +       }
> > +
> > +       if (wanted && (priv->cur_speed != wanted)) {
> > +               int ret = clk_set_rate(host->ciu_clk, wanted * div);
> > +               if (ret)
> > +                       dev_warn(host->dev,
> > +                               "failed to set clk-rate %u error: %d\n",
> > +                                wanted * div, ret);
> > +               actual = clk_get_rate(host->ciu_clk);
> > +               host->bus_hz = actual / div;
> > +               priv->cur_speed = wanted;
> > +               host->current_speed = 0;
> > +       }
> >  }
> >
> >  static int dw_mci_exynos_parse_dt(struct dw_mci *host)
> > @@ -133,8 +149,14 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
> >         u32 div = 0;
> >         int ret;
> >
> > -       of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
> > -       priv->ciu_div = div;
> > +       if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
> > +               priv->ciu_div = EXYNOS4412_FIXED_CIU_CLK_DIV - 1;
> > +       else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
> > +               priv->ciu_div = EXYNOS4210_FIXED_CIU_CLK_DIV - 1;
> > +       else {
> > +               of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
> > +               priv->ciu_div = div;
> > +       }
> >
> >         ret = of_property_read_u32_array(np,
> >                         "samsung,dw-mshc-sdr-timing", timing, 2);
> > --
> > 1.7.0.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

