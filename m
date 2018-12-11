From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix DMA API warning
Date: Tue, 11 Dec 2018 07:04:12 -0800
Message-ID: <20181211150412.GP6707@atomide.com>
References: <E1gWjE3-0006mG-2S@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

* Russell King <rmk+kernel@armlinux.org.uk> [181211 14:41]:
> @@ -1939,6 +1938,17 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  		goto err_irq;
>  	}
>  
> +	/*
> +	 * Limit the maximum segment size to the lower of the request size
> +	 * and the DMA engine device segment size limits.  In reality, with
> +	 * 32-bit transfers, the DMA engine can do longer segments than this
> +	 * but there is no way to represent that in the DMA model - if we
> +	 * increase this figure here, we get warnings from the DMA API debug.
> +	 */
> +	mmc->max_seg_size = min(mmc->max_req_size,
> +				min(dma_get_max_seg_size(host->rx_chan->device->dev),
> +				    dma_get_max_seg_size(host->tx_chan->device->dev)));
> +

Looks like using min3() here would be handy?

Regards,

Tony
