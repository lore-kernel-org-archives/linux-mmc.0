From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-sirf: fix 8bit width enable by overwriting set_bus_width
Date: Tue, 19 Aug 2014 13:22:59 +0200
Message-ID: <CAPDyKFopDVmcvSe1yqGwSkxHGY4100mnidVhfkcdo_VftZEy7A@mail.gmail.com>
References: <1408432067-5257-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:63192 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbaHSLXA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Aug 2014 07:23:00 -0400
Received: by mail-qc0-f177.google.com with SMTP id x13so6119842qcv.36
        for <linux-mmc@vger.kernel.org>; Tue, 19 Aug 2014 04:22:59 -0700 (PDT)
In-Reply-To: <1408432067-5257-1-git-send-email-Barry.Song@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, workgroup.linux@csr.com, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 19 August 2014 09:07, Barry Song <Barry.Song@csr.com> wrote:
> From: Minda Chen <Minda.Chen@csr.com>
>
> 8bit-width enable bit of CSR MMC hosts is 3, while stardard hosts use
> bit 5. this patch fixes the functionality of 8bit transfer in CSR mmc
> controllers and improve performance for mmc0 a lot.
>
> Signed-off-by: Minda Chen <Minda.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/mmc/host/sdhci-sirf.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
> index 1700453..376f45f 100644
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
> @@ -27,10 +29,33 @@ static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
>         return clk_get_rate(priv->clk);
>  }
>
> +static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
> +{
> +        u8 ctrl;
> +
> +        ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +        if (width == MMC_BUS_WIDTH_8) {
> +                ctrl &= ~SDHCI_CTRL_4BITBUS;
> +                /*
> +                 * 8bit-width enable bit of CSR MMC hosts is 3,
> +                 * while stardard hosts use bit 5
> +                 */

Don't you need to check for host->version >= SDHCI_SPEC_300 here as well?

> +                ctrl |= SDHCI_SIRF_8BITBUS;
> +        } else {
> +                if (host->version >= SDHCI_SPEC_300)
> +                        ctrl &= ~SDHCI_SIRF_8BITBUS;
> +                if (width == MMC_BUS_WIDTH_4)
> +                        ctrl |= SDHCI_CTRL_4BITBUS;
> +                else
> +                        ctrl &= ~SDHCI_CTRL_4BITBUS;
> +        }
> +        sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
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
> 2.0.4
>

Kind regards
Uffe
