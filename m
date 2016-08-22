From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: correct the max timeout count
Date: Mon, 22 Aug 2016 15:40:11 +0200
Message-ID: <CAPDyKFpSQf=Aa1Tso+ogED1J7sYR7A0xFu9R_EYnoK76pSaf-w@mail.gmail.com>
References: <1471249893-32345-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36117 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755352AbcHVNkN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2016 09:40:13 -0400
Received: by mail-wm0-f51.google.com with SMTP id q128so121519645wma.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2016 06:40:13 -0700 (PDT)
In-Reply-To: <1471249893-32345-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <aisheng.dong@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 15 August 2016 at 10:31, Haibo Chen <haibo.chen@nxp.com> wrote:
> i.MX USDHC Reference Manual has a mistake, for the register SYS_CTRL,
> the DTOCV(bit 19~16) means the data timeout counter value. When DTOCV
> is set to 0xF, it means SDCLK << 29, not SDCLK << 28.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Thanks, applied for next - and by adding the comment as proposed by Dong.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 437c448..ea7d086 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -929,7 +929,7 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>
> -       return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
> +       return esdhc_is_usdhc(imx_data) ? 1 << 29 : 1 << 27;
>  }
>
>  static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> --
> 1.9.1
>
