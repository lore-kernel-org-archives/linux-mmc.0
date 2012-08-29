From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 2/2] mmc: omap_hsmmc: cleanup the bitmap definitions of
 Interrupt Register
Date: Wed, 29 Aug 2012 12:29:19 +0530
Message-ID: <CANrkHUYa-56TvFtYR5WTjYXt9J8s90L0nXueioGZsOyVsa-jbw@mail.gmail.com>
References: <1346159947-3194-1-git-send-email-svenkatr@ti.com>
	<1346159947-3194-2-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1346159947-3194-2-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balbi@ti.com
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 28, 2012 at 6:49 PM, Venkatraman S <svenkatr@ti.com> wrote:
> Define the most frequently used bitmasks of the Interrupt Enable /
> Interrupt Status register with consistent naming ( with _EN suffix).
>
> Use meaningful concatenation of bitfields for INT_EN_MASK, which shows
> which interrupts are enabled by default.
> No functional changes.
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 51 ++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 57e86a4..03c2362 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -79,28 +79,16 @@
>  #define CLKD_SHIFT             6
>  #define DTO_MASK               0x000F0000
>  #define DTO_SHIFT              16
> -#define INT_EN_MASK            0x306E0033
> -#define BWR_ENABLE             (1 << 4)
> -#define BRR_ENABLE             (1 << 5)
> -#define DTO_ENABLE             (1 << 20)
>  #define INIT_STREAM            (1 << 1)
>  #define DP_SELECT              (1 << 21)
>  #define DDIR                   (1 << 4)
> -#define DMA_EN                 0x1
> +#define DMAE                   0x1

This change is not needed or may not be part of this patch

>  #define MSBS                   (1 << 5)
>  #define BCE                    (1 << 1)
>  #define FOUR_BIT               (1 << 1)
>  #define DDR                    (1 << 19)
>  #define DW8                    (1 << 5)
> -#define CC                     0x1
> -#define TC                     0x02
>  #define OD                     0x1
> -#define ERR                    (1 << 15)
> -#define CMD_TIMEOUT            (1 << 16)
> -#define DATA_TIMEOUT           (1 << 20)
> -#define CMD_CRC                        (1 << 17)
> -#define DATA_CRC               (1 << 21)
> -#define CARD_ERR               (1 << 28)
>  #define STAT_CLEAR             0xFFFFFFFF
>  #define INIT_STREAM_CMD                0x00000000
>  #define DUAL_VOLT_OCR_BIT      7
> @@ -109,6 +97,25 @@
>  #define SOFTRESET              (1 << 1)
>  #define RESETDONE              (1 << 0)
>
> +/* Interrupt masks for IE and ISE register */
> +#define CC_EN                  (1 << 0)
> +#define TC_EN                  (1 << 1)

Minor comment:
You might want to retain CC, TC...  instead of CC_EN as before.
CC_EN is not mentioned in TRM. It would be better to reuse CC
(similarly for other bits fields too) for MMCHS_IE, MMCHS_ISE
inorder to reduce the number of #define's

> +#define BWR_EN                 (1 << 4)
> +#define BRR_EN                 (1 << 5)
> +#define ERR_EN                 (1 << 15)

ERR_EN is not applicable for Interrupt masks for IE and ISE register

> +#define CTO_EN                 (1 << 16)
> +#define CCRC_EN                (1 << 17)
> +#define CEB_EN                 (1 << 18)
> +#define CIE_EN                 (1 << 19)
> +#define DTO_EN                 (1 << 20)
> +#define DCRC_EN                (1 << 21)
> +#define DEB_EN                 (1 << 22)
> +#define CERR_EN                (1 << 28)
> +#define BADA_EN                (1 << 29)
> +
> +#define INT_EN_MASK            (BADA_EN | CERR_EN | DEB_EN | DCRC_EN | \
> +               CIE_EN | CEB_EN | CCRC_EN | BRR_EN | BWR_EN | TC_EN | CC_EN)
> +
>  #define MMC_AUTOSUSPEND_DELAY  100
>  #define MMC_TIMEOUT_MS         20
>  #define OMAP_MMC_MIN_CLOCK     400000
> @@ -453,7 +460,7 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
>         unsigned int irq_mask;
>
>         if (host->use_dma)
> -               irq_mask = INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
> +               irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
>         else
>                 irq_mask = INT_EN_MASK;
>
> @@ -673,8 +680,8 @@ static void send_init_stream(struct omap_hsmmc_host *host)
>         OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);
>
>         timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> -       while ((reg != CC) && time_before(jiffies, timeout))
> -               reg = OMAP_HSMMC_READ(host->base, STAT) & CC;
> +       while ((reg != CC_EN) && time_before(jiffies, timeout))
> +               reg = OMAP_HSMMC_READ(host->base, STAT) & CC_EN;
>
>         OMAP_HSMMC_WRITE(host->base, CON,
>                 OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
> @@ -765,7 +772,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
>         }
>
>         if (host->use_dma)
> -               cmdreg |= DMA_EN;
> +               cmdreg |= DMAE;

In that case, this change can be avoided and in couple of other places too ...

>
>         host->req_in_progress = 1;
>
> @@ -988,11 +995,11 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>         data = host->data;
>         dev_vdbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>
> -       if (status & ERR) {
> +       if (status & ERR_EN) {
>                 omap_hsmmc_dbg_report_irq(host, status);
> -               if (status & (CMD_TIMEOUT | DATA_TIMEOUT))
> +               if (status & (CTO_EN | DTO_EN))
>                         hsmmc_command_incomplete(host, -ETIMEDOUT);
> -               else if (status & (CMD_CRC | DATA_CRC))
> +               else if (status & (CCRC_EN | DCRC_EN))
>                         hsmmc_command_incomplete(host, -EILSEQ);
>
>                 end_cmd = 1;
> @@ -1002,9 +1009,9 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>                 }
>         }
>
> -       if (end_cmd || ((status & CC) && host->cmd))
> +       if (end_cmd || ((status & CC_EN) && host->cmd))
>                 omap_hsmmc_cmd_done(host, host->cmd);
> -       if ((end_trans || (status & TC)) && host->mrq)
> +       if ((end_trans || (status & TC_EN)) && host->mrq)
>                 omap_hsmmc_xfer_done(host, data);
>  }
>
> --
> 1.7.11.1.25.g0e18bef
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
