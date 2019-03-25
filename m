From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-arasan: Add DTS property to disable DCMDs.
Date: Mon, 25 Mar 2019 14:27:18 +0100
Message-ID: <CAPDyKFrDq-zBsqqe23hj4ynfYnrGxAr0tWxvYEJu8Kvh0i=h9A@mail.gmail.com>
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com> <20190322113808.16858-2-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322113808.16858-2-christoph.muellner@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Matthias Brugger <matthias.bgg@gmail.com>, Douglas Anderson <dianders@chromium.org>, Tony Xie <tony.xie@rock-chips.com>, Randy Li <ayaka@soulik.info>, Vicente Bergas <vicencb@gmail.com>, Ezequiel Garcia <ezequiel@collabora.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux
List-Id: linux-mmc@vger.kernel.org

On Fri, 22 Mar 2019 at 12:39, Christoph Muellner
<christoph.muellner@theobroma-systems.com> wrote:
>
> Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
> queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
> which exposes a control register bit to enable the feature.
> The current implementation sets this bit unconditionally.
>
> This patch allows to suppress the feature activation,
> by specifying the property disable-cqe-dcmd.
>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Perhaps both patch1 and patch2 should be tagged for stable? Then
please tell me and I can add a tag.

Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c9e3e050ccc8..88dc3f00a5be 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -832,7 +832,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 host->mmc_host_ops.start_signal_voltage_switch =
>                                         sdhci_arasan_voltage_switch;
>                 sdhci_arasan->has_cqe = true;
> -               host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +               host->mmc->caps2 |= MMC_CAP2_CQE;
> +
> +               if (!of_property_read_bool(np, "disable-cqe-dcmd"))
> +                       host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>         }
>
>         ret = sdhci_arasan_add_host(sdhci_arasan);
> --
> 2.11.0
>
