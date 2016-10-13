From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] sdhci-esdhc-imx: Correct two register accesses
Date: Thu, 13 Oct 2016 09:01:29 +0200
Message-ID: <CAPDyKFpxi0yLSjdSFQSJarBssFyBZ0JDQ518ACLtpfUB3Wp1wA@mail.gmail.com>
References: <1476124792-18441-1-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35197 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750976AbcJMHCE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2016 03:02:04 -0400
Received: by mail-lf0-f43.google.com with SMTP id l131so84989823lfl.2
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2016 00:01:32 -0700 (PDT)
In-Reply-To: <1476124792-18441-1-git-send-email-aaron.brice@datasoft.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Brice <aaron.brice@datasoft.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <aisheng.dong@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dave Russell <david.russell@datasoft.com>

On 10 October 2016 at 20:39, Aaron Brice <aaron.brice@datasoft.com> wrote:
>
>  - The DMA error interrupt bit is in a different position as
>    compared to the sdhci standard.  This is accounted for in
>    many cases, but not handled in the case of clearing the
>    INT_STATUS register by writing a 1 to that location.
>  - The HOST_CONTROL register is very different as compared to
>    the sdhci standard.  This is accounted for in the write
>    case, but not when read back out (which it is in the sdhci
>    code).
>
> Signed-off-by: Dave Russell <david.russell@datasoft.com>
> Signed-off-by: Aaron Brice <aaron.brice@datasoft.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Thanks, applied for fixes!

Kind regards
Uffe

>
> v1 -> v2:
> - rename long_val to val
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 1f54fd8..7123ef9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -346,7 +346,8 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         u32 data;
>
> -       if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
> +       if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE ||
> +                       reg == SDHCI_INT_STATUS)) {
>                 if ((val & SDHCI_INT_CARD_INT) && !esdhc_is_usdhc(imx_data)) {
>                         /*
>                          * Clear and then set D3CD bit to avoid missing the
> @@ -555,6 +556,25 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>         esdhc_clrset_le(host, 0xffff, val, reg);
>  }
>
> +static u8 esdhc_readb_le(struct sdhci_host *host, int reg)
> +{
> +       u8 ret;
> +       u32 val;
> +
> +       switch (reg) {
> +       case SDHCI_HOST_CONTROL:
> +               val = readl(host->ioaddr + reg);
> +
> +               ret = val & SDHCI_CTRL_LED;
> +               ret |= (val >> 5) & SDHCI_CTRL_DMA_MASK;
> +               ret |= (val & ESDHC_CTRL_4BITBUS);
> +               ret |= (val & ESDHC_CTRL_8BITBUS) << 3;
> +               return ret;
> +       }
> +
> +       return readb(host->ioaddr + reg);
> +}
> +
>  static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -947,6 +967,7 @@ static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  static struct sdhci_ops sdhci_esdhc_ops = {
>         .read_l = esdhc_readl_le,
>         .read_w = esdhc_readw_le,
> +       .read_b = esdhc_readb_le,
>         .write_l = esdhc_writel_le,
>         .write_w = esdhc_writew_le,
>         .write_b = esdhc_writeb_le,
> --
> 2.7.4
>
