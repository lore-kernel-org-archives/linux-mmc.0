From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Thu, 24 Nov 2016 12:37:32 +0100
Message-ID: <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ziji Hu <huziji@marvell.com>, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, Wei(SOCP) Liu
List-Id: linux-mmc@vger.kernel.org

On 31 October 2016 at 12:09, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> From: Ziji Hu <huziji@marvell.com>
>
> Marvell Xenon eMMC/SD/SDIO Host Controller contains PHY.
> Three types of PHYs are supported.
>
> Add support to multiple types of PHYs init and configuration.
> Add register definitions of PHYs.
>
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  MAINTAINERS                        |    2 +-
>  drivers/mmc/host/Makefile          |    2 +-
>  drivers/mmc/host/sdhci-xenon-phy.c | 1181 +++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-xenon-phy.h |  157 ++++-
>  drivers/mmc/host/sdhci-xenon.c     |    4 +-
>  drivers/mmc/host/sdhci-xenon.h     |   17 +-
>  6 files changed, 1361 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.h

Can you please consider to split this up somehow!? It would make it
easier to review...

Anyway, allow me to provide some initial feedback, particularly around
those things that Adrian and you requested for my input.

[...]

>
> +
> +static int __xenon_emmc_delay_adj_test(struct mmc_card *card)
> +{
> +       int err;
> +       u8 *ext_csd = NULL;
> +
> +       err = mmc_get_ext_csd(card, &ext_csd);
> +       kfree(ext_csd);

Why do you read the ext csd here?

> +
> +       return err;
> +}
> +
> +static int __xenon_sdio_delay_adj_test(struct mmc_card *card)
> +{
> +       struct mmc_command cmd = {0};
> +       int err;
> +
> +       cmd.opcode = SD_IO_RW_DIRECT;
> +       cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
> +
> +       err = mmc_wait_for_cmd(card->host, &cmd, 0);
> +       if (err)
> +               return err;
> +
> +       if (cmd.resp[0] & R5_ERROR)
> +               return -EIO;
> +       if (cmd.resp[0] & R5_FUNCTION_NUMBER)
> +               return -EINVAL;
> +       if (cmd.resp[0] & R5_OUT_OF_RANGE)
> +               return -ERANGE;
> +       return 0;

No thanks! MMC/SD/SDIO protocol code belongs in the core.

> +}
> +
> +static int __xenon_sd_delay_adj_test(struct mmc_card *card)
> +{
> +       struct mmc_command cmd = {0};
> +       int err;
> +
> +       cmd.opcode = MMC_SEND_STATUS;
> +       cmd.arg = card->rca << 16;
> +       cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> +
> +       err = mmc_wait_for_cmd(card->host, &cmd, 0);
> +       return err;

No thanks! MMC/SD/SDIO protocol code belongs in the core.

> +}
> +

[...]

> +int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios)
> +{
> +       struct mmc_host *mmc = host->mmc;
> +       struct mmc_card *card;
> +       int ret = 0;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (!host->clock) {
> +               priv->clock = 0;
> +               return 0;
> +       }
> +
> +       /*
> +        * The timing, frequency or bus width is changed,
> +        * better to set eMMC PHY based on current setting
> +        * and adjust Xenon SDHC delay.
> +        */
> +       if ((host->clock == priv->clock) &&
> +           (ios->bus_width == priv->bus_width) &&
> +           (ios->timing == priv->timing))
> +               return 0;
> +
> +       xenon_phy_set(host, ios->timing);
> +
> +       /* Update the record */
> +       priv->bus_width = ios->bus_width;
> +       /* Temp stage from HS200 to HS400 */
> +       if (((priv->timing == MMC_TIMING_MMC_HS200) &&
> +            (ios->timing == MMC_TIMING_MMC_HS)) ||
> +           ((ios->timing == MMC_TIMING_MMC_HS) &&
> +            (priv->clock > host->clock))) {
> +               priv->timing = ios->timing;
> +               priv->clock = host->clock;
> +               return 0;
> +       }
> +       /*
> +        * Skip temp stages from HS400 t0 HS200:
> +        * from 200MHz to 52MHz in HS400
> +        * from HS400 to HS DDR in 52MHz
> +        * from HS DDR to HS in 52MHz
> +        * from HS to HS200 in 52MHz
> +        */
> +       if (((priv->timing == MMC_TIMING_MMC_HS400) &&
> +            ((host->clock == MMC_HIGH_52_MAX_DTR) ||
> +             (ios->timing == MMC_TIMING_MMC_DDR52))) ||
> +           ((priv->timing == MMC_TIMING_MMC_DDR52) &&
> +            (ios->timing == MMC_TIMING_MMC_HS)) ||
> +           ((ios->timing == MMC_TIMING_MMC_HS200) &&
> +            (ios->clock == MMC_HIGH_52_MAX_DTR))) {
> +               priv->timing = ios->timing;
> +               priv->clock = host->clock;
> +               return 0;
> +       }
> +       priv->timing = ios->timing;
> +       priv->clock = host->clock;
> +
> +       /* Legacy mode is a special case */
> +       if (ios->timing == MMC_TIMING_LEGACY)
> +               return 0;
> +
> +       if (mmc->card)
> +               card = mmc->card;
> +       else
> +               /*
> +                * Only valid during initialization
> +                * before mmc->card is set
> +                */
> +               card = priv->card_candidate;
> +       if (unlikely(!card)) {
> +               dev_warn(mmc_dev(mmc), "card is not present\n");
> +               return -EINVAL;
> +       }

That your host need to hold a copy of the card pointer, tells me that
something is not really correct.

I might be wrong, if this turns out to be a special case, but I doubt
it. Although, if it *is* a special such case, we shall most likely try
to extend the the mmc core layer instead of adding all these hacks in
your host driver.

[...]

Another suggestion of a general improvement; could you perhaps try to
add some brief information about what goes on in function headers.
Perhaps that could help to more easily understand things.

Kind regards
Uffe
