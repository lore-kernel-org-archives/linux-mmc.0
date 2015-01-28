From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/7] mmc: sdhci-pxav3: Fix SDR50 and DDR50 capabilities
 for the Armada 38x flavor
Date: Wed, 28 Jan 2015 21:36:32 +0100
Message-ID: <CAPDyKFp=TxkL4BPMxVU+pMPoCQ1xPq0XZ+ZPpBFFaDnNtFjynw@mail.gmail.com>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
 <1422010594-1735-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422010594-1735-2-git-send-email-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, stable@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 23 January 2015 at 11:56, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> According to erratum 'FE-2946959' both SDR50 and DDR50 modes require
> specific clock adjustments in SDIO3 Configuration register. However,
> this register was not part of the device tree binding. Even if the
> binding can (and will) be extended we still need handling the case
> where this register was not available. In this case we use the
> SDHCI_QUIRK_MISSING_CAPS quirk remove them from the capabilities.
>
> This commit is based on the work done by Marcin Wojtas<mw@semihalf.com>
>
> Fixes: 5491ce3f79ee ("mmc: sdhci-pxav3: add support for the Armada 38x SDHCI controller")
> Cc: <stable@vger.kernel.org> # v3.15+
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index ca3424e7ef71..7b07325b4fba 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -118,6 +118,20 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>         return 0;
>  }
>
> +static int armada_38x_quirks(struct sdhci_host *host)

Seems like this function can be void instead of always returning 0.

> +{
> +       host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
> +       /*
> +        * According to erratum 'FE-2946959' both SDR50 and DDR50
> +        * modes require specific clock adjustments in SDIO3
> +        * Configuration register, if the adjustment is not done,
> +        * remove them from the capabilities.
> +        */
> +       host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> +       host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
> +       return 0;
> +}
> +
>  static void pxav3_reset(struct sdhci_host *host, u8 mask)
>  {
>         struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> @@ -319,6 +333,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>                 clk_prepare_enable(pxa->clk_core);
>
>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
> +               ret = armada_38x_quirks(host);
> +               if (ret < 0)
> +                       goto err_quirks;
>                 ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>                 if (ret < 0)
>                         goto err_mbus_win;
> @@ -400,6 +417,7 @@ err_mbus_win:
>         if (!IS_ERR(pxa->clk_core))
>                 clk_disable_unprepare(pxa->clk_core);
>  err_clk_get:
> +err_quirks:
>         sdhci_pltfm_free(pdev);
>         return ret;
>  }
> --
> 2.1.0
>

Kind regards
Uffe
