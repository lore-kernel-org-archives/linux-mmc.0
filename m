From: "Wladimir J. van der Laan" <laanwj@gmail.com>
Subject: Re: 4.15.0-rc5 fails boot on MX53 LOCO board due to MMC (clock?)
 issue
Date: Fri, 12 Jan 2018 11:42:55 +0100
Message-ID: <20180112104255.GA28577@amethyst.visucore.com>
References: <20180111171538.GA32086@amethyst.visucore.com>
 <CA+sos79yU=eQAoJnmwjiwc-h7ZEB14NhMtO8i8EMX5wO1y57xw@mail.gmail.com>
 <CA+sos7_y76fz5kLEhudeS7cp2AvzcGfgpEMJjTO+PyVif3=AvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:44000 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754835AbeALKm7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jan 2018 05:42:59 -0500
Received: by mail-wm0-f50.google.com with SMTP id g1so11107926wmg.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jan 2018 02:42:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+sos7_y76fz5kLEhudeS7cp2AvzcGfgpEMJjTO+PyVif3=AvA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
Cc: linux-mmc@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Healy <cphealy@gmail.com>

> Can you please try the change below? If it works and everyone is fine
> with it, I will send a proper patch.

Thank you! That fixed the problem.

Tested-by: Wladimir J. van der Laan <laanwj@gmail.com>

> ---
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -687,6 +687,20 @@ static inline void esdhc_pltfm_set_clock(struct
> sdhci_host *host,
>          return;
>      }
> 
> +    /* For i.MX53 eSDHCv3, SYSCTL.SDCLKFS may not be set to 0. */
> +    if (is_imx53_esdhc(imx_data)) {
> +        /*
> +         * According to the i.MX53 reference manual, if DLLCTRL[10] can
> +         * be set, then the controller is eSDHCv3, else it is eSDHCv2.
> +         */
> +        val = readl(host->ioaddr + ESDHC_DLL_CTRL);
> +        writel(val | BIT(10), host->ioaddr + ESDHC_DLL_CTRL);
> +        temp = readl(host->ioaddr + ESDHC_DLL_CTRL);
> +        writel(val, host->ioaddr + ESDHC_DLL_CTRL);
> +        if (temp & BIT(10))
> +            pre_div = 2;
> +    }
> +
>      temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
>      temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
>          | ESDHC_CLOCK_MASK);
