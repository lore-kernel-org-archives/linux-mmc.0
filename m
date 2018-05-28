From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-*: Don't emit error msg if sdhci_add_host() fails
Date: Mon, 28 May 2018 13:27:46 +0200
Message-ID: <CAPDyKFoJsMwsBLgX=80QE2k+E+zYQfbNv_TyKqEJAWML5_OnWg@mail.gmail.com>
References: <20180525151509.0270dbe1@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525151509.0270dbe1@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, Viresh Kumar <vireshk@kernel.org>, Patrice Chotard <patrice.chotard@st.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 25 May 2018 at 09:15, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> I noticed below error msg with sdhci-pxav3 on some berlin platforms:
>
> [.....] sdhci-pxav3 f7ab0000.sdhci failed to add host
>
> It is due to getting related vmmc or vqmmc regulator returns
> -EPROBE_DEFER. It doesn't matter at all but it's confusing.
>
> From another side, if driver probing fails and the error number isn't
> -EPROBE_DEFER, the core will tell us something as below:
>
> [.....] sdhci-pxav3: probe of f7ab0000.sdhci failed with error -EXX
>
> So it's not necessary to emit error msg if sdhci_add_host() fails. And
> some other sdhci host drivers also have this issue, let's fix them
> together.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-bcm-kona.c | 4 +---
>  drivers/mmc/host/sdhci-pic32.c    | 4 +---
>  drivers/mmc/host/sdhci-pxav2.c    | 4 +---
>  drivers/mmc/host/sdhci-pxav3.c    | 4 +---
>  drivers/mmc/host/sdhci-s3c.c      | 4 +---
>  drivers/mmc/host/sdhci-spear.c    | 4 +---
>  drivers/mmc/host/sdhci-st.c       | 4 +---
>  7 files changed, 7 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 11ca95c60bcf..bdbd4897c0f7 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -284,10 +284,8 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>         sdhci_bcm_kona_sd_init(host);
>
>         ret = sdhci_add_host(host);
> -       if (ret) {
> -               dev_err(dev, "Failed sdhci_add_host\n");
> +       if (ret)
>                 goto err_reset;
> -       }
>
>         /* if device is eMMC, emulate card insert right here */
>         if (!mmc_card_is_removable(host->mmc)) {
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
> index a6caa49ca25a..a11e6397d4ff 100644
> --- a/drivers/mmc/host/sdhci-pic32.c
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -200,10 +200,8 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
>         }
>
>         ret = sdhci_add_host(host);
> -       if (ret) {
> -               dev_err(&pdev->dev, "error adding host\n");
> +       if (ret)
>                 goto err_base_clk;
> -       }
>
>         dev_info(&pdev->dev, "Successfully added sdhci host\n");
>         return 0;
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index 8986f9d9cf98..2c3827f54927 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -221,10 +221,8 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>         host->ops = &pxav2_sdhci_ops;
>
>         ret = sdhci_add_host(host);
> -       if (ret) {
> -               dev_err(&pdev->dev, "failed to add host\n");
> +       if (ret)
>                 goto disable_clk;
> -       }
>
>         return 0;
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index a34434166ca7..b8e96f392428 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -472,10 +472,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>         pm_suspend_ignore_children(&pdev->dev, 1);
>
>         ret = sdhci_add_host(host);
> -       if (ret) {
> -               dev_err(&pdev->dev, "failed to add host\n");
> +       if (ret)
>                 goto err_add_host;
> -       }
>
>         if (host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ)
>                 device_init_wakeup(&pdev->dev, 1);
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index cda83ccb2702..9ef89d00970e 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -655,10 +655,8 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>                 goto err_req_regs;
>
>         ret = sdhci_add_host(host);
> -       if (ret) {
> -               dev_err(dev, "sdhci_add_host() failed\n");
> +       if (ret)
>                 goto err_req_regs;
> -       }
>
>  #ifdef CONFIG_PM
>         if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index 14511526a3a8..9247d51f2eed 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -126,10 +126,8 @@ static int sdhci_probe(struct platform_device *pdev)
>         }
>
>         ret = sdhci_add_host(host);
> -       if (ret) {
> -               dev_dbg(&pdev->dev, "error adding host\n");
> +       if (ret)
>                 goto disable_clk;
> -       }
>
>         platform_set_drvdata(pdev, host);
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index c32daed0d418..8f95647195d9 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -422,10 +422,8 @@ static int sdhci_st_probe(struct platform_device *pdev)
>         st_mmcss_cconfig(np, host);
>
>         ret = sdhci_add_host(host);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Failed sdhci_add_host\n");
> +       if (ret)
>                 goto err_out;
> -       }
>
>         host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
>
> --
> 2.17.0
>
