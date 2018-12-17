From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix DMA API warning
Date: Mon, 17 Dec 2018 09:07:24 +0100
Message-ID: <CAPDyKFo3W4Bwe6oVXUQdZvZaMgvmXGK5+hAD8wVfLyEcU4JGvw@mail.gmail.com>
References: <E1gWjE3-0006mG-2S@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1gWjE3-0006mG-2S@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 11 Dec 2018 at 15:41, Russell King <rmk+kernel@armlinux.org.uk> wrote:
>
> While booting with rootfs on MMC, the following warning is encountered
> on OMAP4430:
>
> omap-dma-engine 4a056000.dma-controller: DMA-API: mapping sg segment longer than device claims to support [len=69632] [max=65536]
>
> This is because the DMA engine has a default maximum segment size of 64K
> but HSMMC sets:
>
>         mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
>         mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
>         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>         mmc->max_seg_size = mmc->max_req_size;
>
> which ends up telling the block layer that we support a maximum segment
> size of 65535*512, which exceeds the advertised DMA engine capabilities.
>
> Fix this by clamping the maximum segment size to the lower of the
> maximum request size and of the DMA engine device used for either DMA
> channel.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

I have applied this for fixes, amending the change by modifying the
min-min check to min3 according to the suggestion from Tony.
I assumed adding a stable tag makes sense so I did, however, please
tell if you want me to drop that.

Thanks and kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 467d889a1638..55100974fb95 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1909,7 +1909,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
>         mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
>         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> -       mmc->max_seg_size = mmc->max_req_size;
>
>         mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>                      MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE | MMC_CAP_CMD23;
> @@ -1939,6 +1938,17 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                 goto err_irq;
>         }
>
> +       /*
> +        * Limit the maximum segment size to the lower of the request size
> +        * and the DMA engine device segment size limits.  In reality, with
> +        * 32-bit transfers, the DMA engine can do longer segments than this
> +        * but there is no way to represent that in the DMA model - if we
> +        * increase this figure here, we get warnings from the DMA API debug.
> +        */
> +       mmc->max_seg_size = min(mmc->max_req_size,
> +                               min(dma_get_max_seg_size(host->rx_chan->device->dev),
> +                                   dma_get_max_seg_size(host->tx_chan->device->dev)));
> +
>         /* Request IRQ for MMC operations */
>         ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
>                         mmc_hostname(mmc), host);
> --
> 2.7.4
>
