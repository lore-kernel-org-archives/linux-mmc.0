From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc-pltfm: fix the potential NULL pointer
 dereference
Date: Mon, 24 Oct 2016 20:06:06 +0800
Message-ID: <89043543-b179-e7e4-4098-8fba45fe445c@rock-chips.com>
References: <20161021105757.22712-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161021105757.22712-1-jh80.chung@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, ulf.hansson@linaro.org, stable@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-mmc@vger.kernel.org

On 2016/10/21 18:57, Jaehoon Chung wrote:
> platform_get_resource can be returned the NULL pointer.
> Then regs->start should be referred to NULL Pointer.
> devm_ioremap_resource() checks whether res is NULL or not.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Looks good,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index b486fef..1236d49b 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -47,12 +47,13 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>  	host->pdata = pdev->dev.platform_data;
>
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	/* Get registers' physical base address */
> -	host->phy_regs = regs->start;
>  	host->regs = devm_ioremap_resource(&pdev->dev, regs);
>  	if (IS_ERR(host->regs))
>  		return PTR_ERR(host->regs);
>
> +	/* Get registers' physical base address */
> +	host->phy_regs = regs->start;
> +
>  	platform_set_drvdata(pdev, host);
>  	return dw_mci_probe(host);
>  }
>


-- 
Best Regards
Shawn Lin
