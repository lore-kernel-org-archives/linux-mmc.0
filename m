From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 4/4] mmc: atmel-mci: use probe deferring if dma
 controller is not ready yet
Date: Fri, 28 Nov 2014 14:19:03 +0000
Message-ID: <20141128141903.GT3836@n2100.arm.linux.org.uk>
References: <1417183686-31481-1-git-send-email-ludovic.desroches@atmel.com>
 <1417183686-31481-5-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39026 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbaK1OVQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Nov 2014 09:21:16 -0500
Content-Disposition: inline
In-Reply-To: <1417183686-31481-5-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, arnd@arndb.de

Let's look at the resulting code:

On Fri, Nov 28, 2014 at 03:08:06PM +0100, Ludovic Desroches wrote:
> +static int atmci_configure_dma(struct atmel_mci *host)
>  {
> +	int ret = 0;
>  
> +	host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev, "rxtx");
> +	if (IS_ERR(host->dma.chan))
> +		return PTR_ERR(host->dma.chan);
> +
> +	dev_info(&host->pdev->dev, "using %s for DMA transfers\n",
> +		 dma_chan_name(host->dma.chan));
> +
> +	host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
> +	host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	host->dma_conf.src_maxburst = 1;
> +	host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
> +	host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	host->dma_conf.dst_maxburst = 1;
> +	host->dma_conf.device_fc = false;
> +
> +	return ret;
>  }

I think you can clean this up a little further - what do you notice
about the value of "ret" here?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
