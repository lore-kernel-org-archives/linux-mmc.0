From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-cadence: override spec version
Date: Thu, 29 Aug 2019 15:34:04 +0200
Message-ID: <CAPDyKFrcvVKXmLpMdjtkX+OZ=VfyYa0hS_dStEiawUN3zMtbvA@mail.gmail.com>
References: <20190829104928.27404-1-yamada.masahiro@socionext.com> <20190829104928.27404-3-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829104928.27404-3-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Piotr Sroka <piotrs@cadence.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 12:49, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The datasheet of the IP (sd4hc) says it is compiatible with SDHCI v4,
> but the spec version field in the version register is read as 2
> (i.e. SDHCI_SPEC_300) based on the RTL provided by Cadence.
>
> Socionext did not fix it up when it integrated the IP into the SoCs.
> So, it is working as SDHCI v3.
>
> It is not a real problem because there is no difference in the program
> flow in sdhci.c between SDHCI_SPEC_300/400, but set the real version
> just in case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 44139fceac24..9837214685b6 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -341,6 +341,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         unsigned int nr_phy_params;
>         int ret;
>         struct device *dev = &pdev->dev;
> +       static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
>
>         clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(clk))
> @@ -370,6 +371,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                 sdhci_cdns_hs400_enhanced_strobe;
>         sdhci_enable_v4_mode(host);
> +       __sdhci_read_caps(host, &version, NULL, NULL);
>
>         sdhci_get_of_property(pdev);
>
> --
> 2.17.1
>
