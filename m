From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/1] mmc: dw_mmc-bluefield: simplify the probe() function
Date: Wed, 24 Oct 2018 12:59:09 +0200
Message-ID: <CAPDyKFowhnOp+YjXJyBVbxjKgwBfFyC+_5omTeZ4F4QGp6b15g@mail.gmail.com>
References: <d9e592c4b8082f77fc219764a26f50dec434d8fc.1539890997.git.lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d9e592c4b8082f77fc219764a26f50dec434d8fc.1539890997.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, David Woods <dwoods@mellanox.com>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 October 2018 at 16:26, Liming Sun <lsun@mellanox.com> wrote:
> This commit removes the unnecessary of-node check since the
> dw_mci_bluefield_match[] structure has only one entry.
>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

Queued for 4.21, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc-bluefield.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> index 54c3fbb..ed8f225 100644
> --- a/drivers/mmc/host/dw_mmc-bluefield.c
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -52,16 +52,7 @@ static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>
>  static int dw_mci_bluefield_probe(struct platform_device *pdev)
>  {
> -       const struct dw_mci_drv_data *drv_data = NULL;
> -       const struct of_device_id *match;
> -
> -       if (pdev->dev.of_node) {
> -               match = of_match_node(dw_mci_bluefield_match,
> -                                     pdev->dev.of_node);
> -               drv_data = match->data;
> -       }
> -
> -       return dw_mci_pltfm_register(pdev, drv_data);
> +       return dw_mci_pltfm_register(pdev, &bluefield_drv_data);
>  }
>
>  static struct platform_driver dw_mci_bluefield_pltfm_driver = {
> --
> 1.8.3.1
>
