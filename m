From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: Call mmc_pwrseq_alloc()
Date: Wed, 8 Apr 2015 11:52:39 +0200
Message-ID: <CAPDyKFodxVuT_dh4oRHRXndQq0X06j=nr2g6mEYSxL-orNBNNw@mail.gmail.com>
References: <1428368010-10094-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32817 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbDHJwk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2015 05:52:40 -0400
Received: by qkx62 with SMTP id 62so79024569qkx.0
        for <linux-mmc@vger.kernel.org>; Wed, 08 Apr 2015 02:52:39 -0700 (PDT)
In-Reply-To: <1428368010-10094-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Otavio Salvador <otavio@ossystems.com.br>, Fabio Estevam <fabio.estevam@freescale.com>

On 7 April 2015 at 02:53, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Currently it is not possible to use 'mmc-pwrseq-simple' property with
> this driver because mmc_pwrseq_alloc() is never called.
>
> Call mmc_pwrseq_alloc so that we enable the support for providing a
> reset GPIO to the Wifi/BT chipset.
>
> Tested on a imx6sl-warp board:
>
> root@imx6sl-warp:~# hciattach /dev/ttymxc1 3wire
> Device setup complete
> root@imx6sl-warp:~# hciconfig hci0 up
> root@imx6sl-warp:~# hciconfig
> hci0:   Type: BR/EDR  Bus: UART
>         BD Address: 2A:23:AA:6E:C7:A0  ACL MTU: 1021:8  SCO MTU: 64:1
>         UP RUNNING
>         RX bytes:795 acl:0 sco:0 events:29 errors:0
>         TX bytes:613 acl:0 sco:0 commands:29 errors:0
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Calling mmc_of_parse() breaks some boards due to bad card detect parsing.
> Call only mmc_pwrseq_alloc() instead, which what we really need.

Why can't we fix the card detect parsing instead?

>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7ee8312..5bcabdc 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -31,6 +31,8 @@
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>
> +#include "../core/pwrseq.h"

The pwrseq API was intentionally not exported. This is not the way to
include header files.

> +
>  #define        ESDHC_CTRL_D3CD                 0x08
>  /* VENDOR SPEC register */
>  #define ESDHC_VENDOR_SPEC              0xc0
> @@ -1079,6 +1081,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>         }
>
> +       err = mmc_pwrseq_alloc(host->mmc);
> +       if (err)
> +               goto disable_clk;
> +
>         err = sdhci_add_host(host);
>         if (err)
>                 goto disable_clk;
> --
> 1.9.1
>

Kind regards
Uffe
