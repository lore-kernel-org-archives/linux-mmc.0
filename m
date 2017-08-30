From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/5] mmc: sdhci: Add quirk to indicate MMC_RSP_136 has CRC
Date: Wed, 30 Aug 2017 15:13:17 +0200
Message-ID: <CAPDyKFqM96Ts2w6ESvCp75Kw+i91Cwr2EX39Xs9og0nUBTRLsA@mail.gmail.com>
References: <20170821074132.4622-1-kishon@ti.com> <20170821074132.4622-3-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821074132.4622-3-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 21 August 2017 at 09:41, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> TI's implementation of sdhci controller used in DRA7 SoC's has
> CRC in responses with length 136 bits. Add quirk to indicate
> the controller has CRC in MMC_RSP_136. If this quirk is
> set sdhci library shouldn't shift the response present in
> SDHCI_RESPONSE register.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ba639b7851cb..9c8d7428df3c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1182,6 +1182,9 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
>                 cmd->resp[i] = sdhci_readl(host, reg);
>         }
>
> +       if (host->quirks2 & SDHCI_QUIRK2_RSP_136_HAS_CRC)
> +               return;
> +
>         /* CRC is stripped so we need to do some shifting */
>         for (i = 0; i < 4; i++) {
>                 cmd->resp[i] <<= 8;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 399edc681623..54bc444c317f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -435,6 +435,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_ACMD23_BROKEN                     (1<<14)
>  /* Broken Clock divider zero in controller */
>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN             (1<<15)
> +/* Controller has CRC in 136 bit Command Response */
> +#define SDHCI_QUIRK2_RSP_136_HAS_CRC                   (1<<16)
>
>         int irq;                /* Device IRQ */
>         void __iomem *ioaddr;   /* Mapped address */
> --
> 2.11.0
>
