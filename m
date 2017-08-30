From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/5] mmc: sdhci: Tidy reading 136-bit responses
Date: Wed, 30 Aug 2017 15:13:12 +0200
Message-ID: <CAPDyKFqF0TsCBj-GQnWsH3huxWMCuJnmCgbOWZ0nE88d6pCwnA@mail.gmail.com>
References: <20170821074132.4622-1-kishon@ti.com> <20170821074132.4622-2-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821074132.4622-2-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 21 August 2017 at 09:41, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> From: Adrian Hunter <adrian.hunter@intel.com>
>
> Read each register only once and move the code to a separate function so
> that it is not jammed against the 80 column margin.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a1ad2ddadca1..ba639b7851cb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1173,24 +1173,32 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_send_command);
>
> +static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +       int i, reg;
> +
> +       for (i = 0; i < 4; i++) {
> +               reg = SDHCI_RESPONSE + (3 - i) * 4;
> +               cmd->resp[i] = sdhci_readl(host, reg);
> +       }
> +
> +       /* CRC is stripped so we need to do some shifting */
> +       for (i = 0; i < 4; i++) {
> +               cmd->resp[i] <<= 8;
> +               if (i != 3)
> +                       cmd->resp[i] |= cmd->resp[i + 1] >> 24;
> +       }
> +}
> +
>  static void sdhci_finish_command(struct sdhci_host *host)
>  {
>         struct mmc_command *cmd = host->cmd;
> -       int i;
>
>         host->cmd = NULL;
>
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136) {
> -                       /* CRC is stripped so we need to do some shifting. */
> -                       for (i = 0;i < 4;i++) {
> -                               cmd->resp[i] = sdhci_readl(host,
> -                                       SDHCI_RESPONSE + (3-i)*4) << 8;
> -                               if (i != 3)
> -                                       cmd->resp[i] |=
> -                                               sdhci_readb(host,
> -                                               SDHCI_RESPONSE + (3-i)*4-1);
> -                       }
> +                       sdhci_read_rsp_136(host, cmd);
>                 } else {
>                         cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
>                 }
> --
> 2.11.0
>
