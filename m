From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] sdhci-esdhc-imx: Correct two register accesses
Date: Sat, 8 Oct 2016 21:10:37 +0800
Message-ID: <CAA+hA=Sm_KLxahjrF5C2Mir7=SE8Kb9uoQoisdO8KpcLnJQOow@mail.gmail.com>
References: <1475794457-17993-1-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475794457-17993-1-git-send-email-aaron.brice@datasoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Brice <aaron.brice@datasoft.com>
Cc: david.russell@datasoft.com, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 7, 2016 at 6:54 AM, Aaron Brice <aaron.brice@datasoft.com> wrote:
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
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 1f54fd8..d61ef16 100644
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
> +       u32 long_val;
> +
> +       switch (reg) {
> +       case SDHCI_HOST_CONTROL:
> +               long_val = readl(host->ioaddr + reg);
> +
> +               ret = long_val & SDHCI_CTRL_LED;
> +               ret |= (long_val >> 5) & SDHCI_CTRL_DMA_MASK;
> +               ret |= (long_val & ESDHC_CTRL_4BITBUS);
> +               ret |= (long_val & ESDHC_CTRL_8BITBUS) << 3;
> +               return ret;

Thanks for the effort.

One nitpick: would be more like to use 'val' instead of 'long_val' to
be consistent with exist using.
(i saw a few 'new_val' as well, maybe we could clean up them in the future,
but at least we could avoid inventing more from now)

Otherwise,
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

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
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
