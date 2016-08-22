From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: do not touch other bit when config DTOCV
Date: Mon, 22 Aug 2016 15:40:19 +0200
Message-ID: <CAPDyKFrffJTPs046xEXP+8KV=U6CJ5Ng-LVPQefca2tbnXsdng@mail.gmail.com>
References: <1471249178-32204-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37547 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755467AbcHVNkV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2016 09:40:21 -0400
Received: by mail-wm0-f53.google.com with SMTP id i5so145033223wmg.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2016 06:40:21 -0700 (PDT)
In-Reply-To: <1471249178-32204-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <aisheng.dong@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 15 August 2016 at 10:19, Haibo Chen <haibo.chen@nxp.com> wrote:
> Now, when call esdhc_set_timeout() to set the data timeout counter value,
> IPP_RST_N(bit 23) is wrongly affected. This patch add a mask to avoid this.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>'

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 99e0b33..437c448 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -31,6 +31,7 @@
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>
> +#define ESDHC_SYS_CTRL_DTOCV_MASK      0x0f
>  #define        ESDHC_CTRL_D3CD                 0x08
>  #define ESDHC_BURST_LEN_EN_INCR                (1 << 27)
>  /* VENDOR SPEC register */
> @@ -937,7 +938,8 @@ static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>
>         /* use maximum timeout counter */
> -       sdhci_writeb(host, esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
> +       esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
> +                       esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
>                         SDHCI_TIMEOUT_CONTROL);
>  }
>
> --
> 1.9.1
>
