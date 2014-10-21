From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/15] mmc: sdhci-acpi: Add 64-bit DMA support
Date: Tue, 21 Oct 2014 11:33:12 +0200
Message-ID: <2094662.tX3Mh5xduV@wuerfel>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com> <1413883585-16299-14-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53282 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaJUJdZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 05:33:25 -0400
In-Reply-To: <1413883585-16299-14-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On Tuesday 21 October 2014 12:26:23 Adrian Hunter wrote:
> +               return 0;
> +
> +       if (host->flags & SDHCI_USE_64_BIT_DMA) {
> +               if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA) {
> +                       host->flags &= ~SDHCI_USE_64_BIT_DMA;
> +               } else {
> +                       err = dma_coerce_mask_and_coherent(dev,
> +                                                          DMA_BIT_MASK(64));
> +                       if (err)
> +                               dev_warn(dev, "Failed to set 64-bit DMA mask\n");
> +               }
> +       }
> +
> +       if (err)
> +               err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +
> +       c->dma_setup = !err;
> 

Never use dma_coerce_mask_and_coherent(), it will ignore limitations of
the upstream bus. Use dma_set_mask_and_coherent instead. If it fails,
I think you need to clear the SDHCI_USE_64_BIT_DMA flag.

	Arnd
