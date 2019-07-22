From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxs: use devm_platform_ioremap_resource() to
 simplify code
Date: Mon, 22 Jul 2019 15:43:09 +0200
Message-ID: <CAPDyKFqfhk6S0gN-eN5ozYKZPBWb8+gC2A_vy55gYOx7dOKQ-w@mail.gmail.com>
References: <20190717085259.31235-1-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717085259.31235-1-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Stefan Wahren <stefan.wahren@i2se.com>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <Linux-imx@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 17 Jul 2019 at 11:02, <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index b334e81..78e7e35 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -571,7 +571,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         struct device_node *np = pdev->dev.of_node;
>         struct mxs_mmc_host *host;
>         struct mmc_host *mmc;
> -       struct resource *iores;
>         int ret = 0, irq_err;
>         struct regulator *reg_vmmc;
>         struct mxs_ssp *ssp;
> @@ -587,8 +586,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         host = mmc_priv(mmc);
>         ssp = &host->ssp;
>         ssp->dev = &pdev->dev;
> -       iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       ssp->base = devm_ioremap_resource(&pdev->dev, iores);
> +       ssp->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(ssp->base)) {
>                 ret = PTR_ERR(ssp->base);
>                 goto out_mmc_free;
> --
> 2.7.4
>
