From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-sirf: fix 8bit width enable by overwriting set_bus_width
Date: Fri, 29 Aug 2014 13:48:32 +0200
Message-ID: <CAPDyKFr1xWnFXd8YdLhmUausGqGC4yruqZC+LQz_TV=TPyNa=w@mail.gmail.com>
References: <1409021442-4105-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:62015 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbaH2Lsd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Aug 2014 07:48:33 -0400
Received: by mail-la0-f42.google.com with SMTP id mc6so2575812lab.29
        for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2014 04:48:32 -0700 (PDT)
In-Reply-To: <1409021442-4105-1-git-send-email-Barry.Song@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Romain Izard <romain.izard.pro@gmail.com>, workgroup.linux@csr.com, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 26 August 2014 04:50, Barry Song <Barry.Song@csr.com> wrote:
> From: Minda Chen <Minda.Chen@csr.com>
>
> the implementation of CSR SDHCI controller is a modified version of
> the one described in the 1.0 specification, and not a normal 3.0
> controller.
> and 8bit-width enable bit of CSR MMC hosts is 3, while stardard hosts
> use bit 5.
> this patch fixes the functionality of 8bit transfer in mmc controllers
> and improve performance for mmc0 a lot.
>
> Signed-off-by: Minda Chen <Minda.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Reviewed-by: Romain Izard <romain.izard.pro@gmail.com>

Thanks! Applied for next!

Kind regards
Uffe

> ---
>  -v3:fix the HW version check according to Romain's feedback
>
>  drivers/mmc/host/sdhci-sirf.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
> index 1700453..d7b02e5 100644
> --- a/drivers/mmc/host/sdhci-sirf.c
> +++ b/drivers/mmc/host/sdhci-sirf.c
> @@ -15,6 +15,8 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include "sdhci-pltfm.h"
>
> +#define SDHCI_SIRF_8BITBUS BIT(3)
> +
>  struct sdhci_sirf_priv {
>         struct clk *clk;
>         int gpio_cd;
> @@ -27,10 +29,30 @@ static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
>         return clk_get_rate(priv->clk);
>  }
>
> +static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
> +{
> +       u8 ctrl;
> +
> +       ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +       ctrl &= ~(SDHCI_CTRL_4BITBUS | SDHCI_SIRF_8BITBUS);
> +
> +       /*
> +        * CSR atlas7 and prima2 SD host version is not 3.0
> +        * 8bit-width enable bit of CSR SD hosts is 3,
> +        * while stardard hosts use bit 5
> +        */
> +       if (width == MMC_BUS_WIDTH_8)
> +               ctrl |= SDHCI_SIRF_8BITBUS;
> +       else if (width == MMC_BUS_WIDTH_4)
> +               ctrl |= SDHCI_CTRL_4BITBUS;
> +
> +       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +}
> +
>  static struct sdhci_ops sdhci_sirf_ops = {
>         .set_clock = sdhci_set_clock,
>         .get_max_clock  = sdhci_sirf_get_max_clk,
> -       .set_bus_width = sdhci_set_bus_width,
> +       .set_bus_width = sdhci_sirf_set_bus_width,
>         .reset = sdhci_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
> --
> 2.1.0
>
>
>
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
> New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
