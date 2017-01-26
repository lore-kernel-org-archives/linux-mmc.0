From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 06/12] mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
Date: Thu, 26 Jan 2017 11:50:38 +0100
Message-ID: <CAPDyKFrwxix4zY4a1x9u6jh_gPfKTsaLnD8b8crum=pc5CN3AA@mail.gmail.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <3546f143091c121face8ecbcbf7f6a4c41d2cec7.1484154449.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <3546f143091c121face8ecbcbf7f6a4c41d2cec7.1484154449.git-series.gregory.clement@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj>
List-Id: linux-mmc@vger.kernel.org

On 11 January 2017 at 18:19, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> From: Hu Ziji <huziji@marvell.com>
>
> Add Xenon eMMC/SD/SDIO host controller core functionality.
> Add Xenon specific intialization process.
> Add Xenon specific mmc_host_ops APIs.
> Add Xenon specific register definitions.
>
> Add CONFIG_MMC_SDHCI_XENON support in drivers/mmc/host/Kconfig.
>
> Marvell Xenon SDHC conforms to SD Physical Layer Specification
> Version 3.01 and is designed according to the guidelines provided
> in the SD Host Controller Standard Specification Version 3.00.
>
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Tested-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/mmc/host/Kconfig       |   9 +-
>  drivers/mmc/host/Makefile      |   3 +-
>  drivers/mmc/host/sdhci-xenon.c | 631 ++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-xenon.h |  70 ++++-
>  4 files changed, 713 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>  create mode 100644 drivers/mmc/host/sdhci-xenon.h
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2eb97014dc3f..8d2d08de14a0 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -819,3 +819,12 @@ config MMC_SDHCI_BRCMSTB
>           Broadcom STB SoCs.
>
>           If unsure, say Y.
> +
> +config MMC_SDHCI_XENON
> +       tristate "Marvell Xenon eMMC/SD/SDIO SDHCI driver"
> +       depends on MMC_SDHCI && MMC_SDHCI_PLTFM

Depending on MMC_SDHCI_PLTFM is enough.

[...]

> +
> +static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
> +                                            struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +       /*
> +        * Before SD/SDIO set signal voltage, SD bus clock should be
> +        * disabled. However, sdhci_set_clock will also disable the Internal
> +        * clock in mmc_set_signal_voltage().
> +        * If Internal clock is disabled, the 3.3V/1.8V bit can not be updated.
> +        * Thus here manually enable internal clock.
> +        *
> +        * After switch completes, it is unnecessary to disable internal clock,
> +        * since keeping internal clock active obeys SD spec.
> +        */
> +       enable_xenon_internal_clk(host);
> +
> +       if (priv->init_card_type == MMC_TYPE_MMC)

So, you need a specific voltage switch for eMMC.

For that, I don't think you need to implement ->init_card(), as to set
priv->init_card_type and then check it here.

Instead you should be able to find out whether the card is an eMMC,
only by the parsing of the child node for the "mmc-card" compatible.
More about this below.

> +               return xenon_emmc_signal_voltage_switch(mmc, ios);
> +
> +       return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
> +
> +/*

[...]

> + */
> +static int xenon_child_node_of_parse(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct mmc_host *mmc = host->mmc;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       struct device_node *child;
> +       int nr_child;
> +
> +       priv->init_card_type = XENON_CARD_TYPE_UNKNOWN;
> +
> +       nr_child = of_get_child_count(np);
> +       if (!nr_child)
> +               return 0;
> +
> +       for_each_child_of_node(np, child) {
> +               if (of_device_is_compatible(child, "mmc-card")) {

To avoid code from being duplicated, I would rather see the DT parsing
of the child nodes for "mmc-card", to be done by the mmc core.

As a matter of fact it is already being done, but perhaps we need to
change that a bit as to fit your case.

I suggest you have a look and see how to update this in the core,
instead of doing it here in the host driver.

> +                       priv->init_card_type = MMC_TYPE_MMC;
> +                       mmc->caps |= MMC_CAP_NONREMOVABLE;
> +
> +                       /*
> +                        * Force to clear BUS_TEST to
> +                        * skip bus_test_pre and bus_test_post
> +                        */
> +                       mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
> +                       mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |

This cap is a bit strange. It was added several years ago by Adrian
Hunter, but I am wondering about the reason to why it's needed.

Should it be removed and instead enabled per default? If not, should
we invent a new specific DT binding for it?

I need Adrian's help here to understand the options.

> +                                     MMC_CAP2_PACKED_CMD |

The MMC_CAP2_PACKED_CMD cap has be removed.

> +                                     MMC_CAP2_NO_SD |
> +                                     MMC_CAP2_NO_SDIO;

I think we need to update the DT documentation for mmc-card.
Typically, we should explicitly state what kind of other existing mmc
DT properties that will be automatically selected, when the mmc-card
is specified.

Can you please look into updating this DT doc as well.

[...]

> +       priv->sdhc_id = 0x0;
> +       if (!of_property_read_u32(np, "marvell,xenon-sdhc-id", &sdhc_id)) {
> +               nr_sdhc = sdhci_readl(host, XENON_SYS_CFG_INFO);
> +               nr_sdhc &= XENON_NR_SUPPORTED_SLOT_MASK;
> +               if (unlikely(sdhc_id > nr_sdhc)) {
> +                       dev_err(mmc_dev(mmc), "SDHC Index %d exceeds Number of SDHCs %d\n",
> +                               sdhc_id, nr_sdhc);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       tuning_count = XENON_DEF_TUNING_COUNT;
> +       if (!of_property_read_u32(np, "marvell,xenon-tun-count",
> +                                 &tuning_count)) {
> +               if (unlikely(tuning_count >= XENON_TMR_RETUN_NO_PRESENT)) {
> +                       dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
> +                               XENON_DEF_TUNING_COUNT);
> +                       tuning_count = XENON_DEF_TUNING_COUNT;
> +               }
> +       }

I suggest you move the parsing of the xenon specific bindings into a
separate function.

> +       priv->tuning_count = tuning_count;
> +
> +       return err;
> +}
> +

[...]

Kind regards
Uffe
