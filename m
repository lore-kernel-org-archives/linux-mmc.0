From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Convert to using %pOFn instead of device_node.name
Date: Tue, 28 Aug 2018 13:41:43 +0200
Message-ID: <CAPDyKFqojsx5Dp1McG+9i=RThCGwoyzjU0zSYB0dybbQ9H-5JQ@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-32-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-32-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 August 2018 at 03:52, Rob Herring <robh@kernel.org> wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Hu Ziji <huziji@marvell.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index c335052d0c02..5956e90380e8 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -660,8 +660,8 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
>                 return 0;
>
>         if (of_address_to_resource(np, 1, &iomem)) {
> -               dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %s\n",
> -                       np->name);
> +               dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %pOFn\n",
> +                       np);
>                 return -EINVAL;
>         }
>
> --
> 2.17.1
>
