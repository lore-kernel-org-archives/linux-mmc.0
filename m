From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci: use lower/upper_32_bits() macros for DMA addresses
Date: Thu, 29 Aug 2019 15:34:08 +0200
Message-ID: <CAPDyKFqrQF8nBfLOHNyqM_LfPx7XjRCHT_PVzDKb98qxVjdSGQ@mail.gmail.com>
References: <20190829112206.22213-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829112206.22213-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Piotr Sroka <piotrs@cadence.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 13:22, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, the DMA addresses are casted to (u64) for the upper 32bits
> to avoid "right shift count >= width of type" warning.
>
> <linux/kernel.h> provides macros to address this, and I like the macro
> names are self-documenting.
>
> I introduced a new helper, sdhci_set_adma_addr() to avoid the code
> duplication.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v2:
>   - Another way to reduce linu wrapping
>
>  drivers/mmc/host/sdhci.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 08cc0792c174..66c2cf89ee22 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -668,10 +668,10 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>         /* 32-bit and 64-bit descriptors have these members in same position */
>         dma_desc->cmd = cpu_to_le16(cmd);
>         dma_desc->len = cpu_to_le16(len);
> -       dma_desc->addr_lo = cpu_to_le32((u32)addr);
> +       dma_desc->addr_lo = cpu_to_le32(lower_32_bits(addr));
>
>         if (host->flags & SDHCI_USE_64_BIT_DMA)
> -               dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
> +               dma_desc->addr_hi = cpu_to_le32(upper_32_bits(addr));
>
>         *desc += host->desc_sz;
>  }
> @@ -816,6 +816,13 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>         }
>  }
>
> +static void sdhci_set_adma_addr(struct sdhci_host *host, dma_addr_t addr)
> +{
> +       sdhci_writel(host, lower_32_bits(addr), SDHCI_ADMA_ADDRESS);
> +       if (host->flags & SDHCI_USE_64_BIT_DMA)
> +               sdhci_writel(host, upper_32_bits(addr), SDHCI_ADMA_ADDRESS_HI);
> +}
> +
>  static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  {
>         if (host->bounce_buffer)
> @@ -826,13 +833,10 @@ static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>
>  static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
>  {
> -       if (host->v4_mode) {
> -               sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
> -               if (host->flags & SDHCI_USE_64_BIT_DMA)
> -                       sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
> -       } else {
> +       if (host->v4_mode)
> +               sdhci_set_adma_addr(host, addr);
> +       else
>                 sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
> -       }
>  }
>
>  static unsigned int sdhci_target_timeout(struct sdhci_host *host,
> @@ -1095,12 +1099,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>                         host->flags &= ~SDHCI_REQ_USE_DMA;
>                 } else if (host->flags & SDHCI_USE_ADMA) {
>                         sdhci_adma_table_pre(host, data, sg_cnt);
> -
> -                       sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
> -                       if (host->flags & SDHCI_USE_64_BIT_DMA)
> -                               sdhci_writel(host,
> -                                            (u64)host->adma_addr >> 32,
> -                                            SDHCI_ADMA_ADDRESS_HI);
> +                       sdhci_set_adma_addr(host, host->adma_addr);
>                 } else {
>                         WARN_ON(sg_cnt != 1);
>                         sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
> --
> 2.17.1
>
