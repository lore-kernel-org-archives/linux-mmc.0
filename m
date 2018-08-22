From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Do now show error message in case
 of deffered probe
Date: Wed, 22 Aug 2018 11:48:08 +0200
Message-ID: <CAPDyKFqS8k53TvQ8ON_+uQ3ynZ0JGGWxv1k9K5pDPMZ4hYkOpg@mail.gmail.com>
References: <c9688c600633ce9f4d7b6319366116e6e7c4b97d.1533544988.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c9688c600633ce9f4d7b6319366116e6e7c4b97d.1533544988.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 6 August 2018 at 10:43, Michal Simek <michal.simek@xilinx.com> wrote:
> When mmc-pwrseq property is passed mmc_pwrseq_alloc() can return
> -EPROBE_DEFER because driver for power sequence provider is not probed
> yet. Do not show error message when this situation happens.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks, queued for v4.20!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index e3332a522a5d..e65f3bce3643 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -772,7 +772,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
> -               dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
>                 goto unreg_clk;
>         }
>
> --
> 1.9.1
>
