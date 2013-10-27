From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: sdhci-sirf: enable dmabounce since SiRFprimaII
	MMC DMA only access up to 256MB
Date: Sun, 27 Oct 2013 22:12:35 +0000
Message-ID: <20131027221235.GF16735@n2100.arm.linux.org.uk>
References: <1382909030-7499-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41752 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab3J0WMu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Oct 2013 18:12:50 -0400
Content-Disposition: inline
In-Reply-To: <1382909030-7499-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Bin Shi <Bin.Shi@csr.com>, Binghua Duan <Binghua.Duan@csr.com>, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>

On Mon, Oct 28, 2013 at 05:23:50AM +0800, Barry Song wrote:
> @@ -92,6 +103,13 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (of_machine_is_compatible("sirf,prima2")) {
> +		if (pdev->dev.dma_mask)
> +			*(pdev->dev.dma_mask) = SZ_256M - 1;
> +		pdev->dev.coherent_dma_mask = SZ_256M - 1;

NAK.  Please do not directly write to the DMA mask; this is not how DMA
masks should be setup.  Please read up on the DMA API and specifically
in this case the dma_set_mask() / dma_set_coherent_mask() functions.

Also note that after the next merge window, those two calls should be
collapsed to dma_set_mask_and_coherent().

Thanks.
