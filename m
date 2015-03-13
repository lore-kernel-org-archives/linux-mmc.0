From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-iproc: fix oops in sdhci_iproc_writew
Date: Fri, 13 Mar 2015 11:15:44 +0100
Message-ID: <CAPDyKFpZQyOC3=TdQe8ymwnzCn0BXFJCgmYBHH+3qhDB_9AXgg@mail.gmail.com>
References: <20150313011101.GA24853@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150313011101.GA24853@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Chris Ball <chris@printf.net>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Corneliu Doban <cdoban@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, bcm-kernel-feedback-list@broadcom.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 13 March 2015 at 02:11, Dmitry Torokhov <dtor@chromium.org> wrote:
> The driver co-allocates sdhci_iproc_host with sdhci_pltfm_host and so to
> access it we need to use sdhci_pltfm_priv() and not pltfm_host->priv.
>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Thanks, applied!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 4139d34..3b423b0 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -97,7 +97,7 @@ static inline void sdhci_iproc_writel(struct sdhci_host *host, u32 val, int reg)
>  static void sdhci_iproc_writew(struct sdhci_host *host, u16 val, int reg)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct sdhci_iproc_host *iproc_host = pltfm_host->priv;
> +       struct sdhci_iproc_host *iproc_host = sdhci_pltfm_priv(pltfm_host);
>         u32 word_shift = REG_OFFSET_IN_BITS(reg);
>         u32 mask = 0xffff << word_shift;
>         u32 oldval, newval;
> --
> 2.2.0.rc0.207.ga3a616c
>
>
> --
> Dmitry
