From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] mmc: sdhci: use pr_err for sdhci_dumpregs
Date: Wed, 22 Jun 2016 17:23:58 +0200
Message-ID: <CAPDyKFq2HOP-XhqEOu-AgpkLYuFiit-yMKHFbi44TG0BpSPp+Q@mail.gmail.com>
References: <CC22646CC0522A488A20F7A66BFD619308D491@irsmsx105.ger.corp.intel.com>
 <57613BE9.9060807@intel.com> <576A7911.3040503@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <576A7911.3040503@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Baranowska, BeataX" <beatax.baranowska@intel.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Jarosz, SebastianX" <sebastianx.jarosz@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 22 June 2016 at 13:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>
> sdhci_dumpregs is used to dump registers when error happens. Thus it should
> use pr_err instead of pr_debug to show more information about the hardware.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> [Fix whitespace and checkpatch warnings]
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Changes in V2:
>
>         Fix whitespace and checkpatch warnings
>         Change subject 'host' -> 'sdhci'
>
>  drivers/mmc/host/sdhci.c | 92 ++++++++++++++++++++++++------------------------
>  1 file changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 040af1b6b412..49800d2c69fa 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -52,58 +52,58 @@ static int sdhci_get_cd(struct mmc_host *mmc);
>
>  static void sdhci_dumpregs(struct sdhci_host *host)
>  {
> -       pr_debug(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
> -               mmc_hostname(host->mmc));
> -
> -       pr_debug(DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
> -               sdhci_readl(host, SDHCI_DMA_ADDRESS),
> -               sdhci_readw(host, SDHCI_HOST_VERSION));
> -       pr_debug(DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
> -               sdhci_readw(host, SDHCI_BLOCK_SIZE),
> -               sdhci_readw(host, SDHCI_BLOCK_COUNT));
> -       pr_debug(DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
> -               sdhci_readl(host, SDHCI_ARGUMENT),
> -               sdhci_readw(host, SDHCI_TRANSFER_MODE));
> -       pr_debug(DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
> -               sdhci_readl(host, SDHCI_PRESENT_STATE),
> -               sdhci_readb(host, SDHCI_HOST_CONTROL));
> -       pr_debug(DRIVER_NAME ": Power:    0x%08x | Blk gap:  0x%08x\n",
> -               sdhci_readb(host, SDHCI_POWER_CONTROL),
> -               sdhci_readb(host, SDHCI_BLOCK_GAP_CONTROL));
> -       pr_debug(DRIVER_NAME ": Wake-up:  0x%08x | Clock:    0x%08x\n",
> -               sdhci_readb(host, SDHCI_WAKE_UP_CONTROL),
> -               sdhci_readw(host, SDHCI_CLOCK_CONTROL));
> -       pr_debug(DRIVER_NAME ": Timeout:  0x%08x | Int stat: 0x%08x\n",
> -               sdhci_readb(host, SDHCI_TIMEOUT_CONTROL),
> -               sdhci_readl(host, SDHCI_INT_STATUS));
> -       pr_debug(DRIVER_NAME ": Int enab: 0x%08x | Sig enab: 0x%08x\n",
> -               sdhci_readl(host, SDHCI_INT_ENABLE),
> -               sdhci_readl(host, SDHCI_SIGNAL_ENABLE));
> -       pr_debug(DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
> -               sdhci_readw(host, SDHCI_ACMD12_ERR),
> -               sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
> -       pr_debug(DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
> -               sdhci_readl(host, SDHCI_CAPABILITIES),
> -               sdhci_readl(host, SDHCI_CAPABILITIES_1));
> -       pr_debug(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
> -               sdhci_readw(host, SDHCI_COMMAND),
> -               sdhci_readl(host, SDHCI_MAX_CURRENT));
> -       pr_debug(DRIVER_NAME ": Host ctl2: 0x%08x\n",
> -               sdhci_readw(host, SDHCI_HOST_CONTROL2));
> +       pr_err(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
> +              mmc_hostname(host->mmc));
> +
> +       pr_err(DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
> +              sdhci_readl(host, SDHCI_DMA_ADDRESS),
> +              sdhci_readw(host, SDHCI_HOST_VERSION));
> +       pr_err(DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
> +              sdhci_readw(host, SDHCI_BLOCK_SIZE),
> +              sdhci_readw(host, SDHCI_BLOCK_COUNT));
> +       pr_err(DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
> +              sdhci_readl(host, SDHCI_ARGUMENT),
> +              sdhci_readw(host, SDHCI_TRANSFER_MODE));
> +       pr_err(DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
> +              sdhci_readl(host, SDHCI_PRESENT_STATE),
> +              sdhci_readb(host, SDHCI_HOST_CONTROL));
> +       pr_err(DRIVER_NAME ": Power:    0x%08x | Blk gap:  0x%08x\n",
> +              sdhci_readb(host, SDHCI_POWER_CONTROL),
> +              sdhci_readb(host, SDHCI_BLOCK_GAP_CONTROL));
> +       pr_err(DRIVER_NAME ": Wake-up:  0x%08x | Clock:    0x%08x\n",
> +              sdhci_readb(host, SDHCI_WAKE_UP_CONTROL),
> +              sdhci_readw(host, SDHCI_CLOCK_CONTROL));
> +       pr_err(DRIVER_NAME ": Timeout:  0x%08x | Int stat: 0x%08x\n",
> +              sdhci_readb(host, SDHCI_TIMEOUT_CONTROL),
> +              sdhci_readl(host, SDHCI_INT_STATUS));
> +       pr_err(DRIVER_NAME ": Int enab: 0x%08x | Sig enab: 0x%08x\n",
> +              sdhci_readl(host, SDHCI_INT_ENABLE),
> +              sdhci_readl(host, SDHCI_SIGNAL_ENABLE));
> +       pr_err(DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
> +              sdhci_readw(host, SDHCI_ACMD12_ERR),
> +              sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
> +       pr_err(DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
> +              sdhci_readl(host, SDHCI_CAPABILITIES),
> +              sdhci_readl(host, SDHCI_CAPABILITIES_1));
> +       pr_err(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
> +              sdhci_readw(host, SDHCI_COMMAND),
> +              sdhci_readl(host, SDHCI_MAX_CURRENT));
> +       pr_err(DRIVER_NAME ": Host ctl2: 0x%08x\n",
> +              sdhci_readw(host, SDHCI_HOST_CONTROL2));
>
>         if (host->flags & SDHCI_USE_ADMA) {
>                 if (host->flags & SDHCI_USE_64_BIT_DMA)
> -                       pr_debug(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x%08x\n",
> -                                readl(host->ioaddr + SDHCI_ADMA_ERROR),
> -                                readl(host->ioaddr + SDHCI_ADMA_ADDRESS_HI),
> -                                readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
> +                       pr_err(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x%08x\n",
> +                              readl(host->ioaddr + SDHCI_ADMA_ERROR),
> +                              readl(host->ioaddr + SDHCI_ADMA_ADDRESS_HI),
> +                              readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
>                 else
> -                       pr_debug(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
> -                                readl(host->ioaddr + SDHCI_ADMA_ERROR),
> -                                readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
> +                       pr_err(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
> +                              readl(host->ioaddr + SDHCI_ADMA_ERROR),
> +                              readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
>         }
>
> -       pr_debug(DRIVER_NAME ": ===========================================\n");
> +       pr_err(DRIVER_NAME ": ===========================================\n");
>  }
>
>  /*****************************************************************************\
> --
> 1.9.1
>
