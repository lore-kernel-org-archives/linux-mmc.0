From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mmc: atmel-mci: use probe deferring if dma controller is not ready yet
Date: Wed, 19 Nov 2014 15:57:56 +0100
Message-ID: <12322299.5p08TVzGz4@wuerfel>
References: <1416408667-4666-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51530 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685AbaKSO6Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 09:58:24 -0500
In-Reply-To: <1416408667-4666-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, nicolas.ferre@atmel.com

On Wednesday 19 November 2014 15:51:07 Ludovic Desroches wrote:
> @@ -2265,37 +2265,39 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
>         mmc_free_host(slot->mmc);
>  }
>  
> -static bool atmci_configure_dma(struct atmel_mci *host)
> +static int atmci_configure_dma(struct atmel_mci *host)
>  {
>         struct mci_platform_data        *pdata;
>         dma_cap_mask_t mask;
> +       int ret = 0;
>  
>         if (host == NULL)
> -               return false;
> +               return -EINVAL;
>  
>         pdata = host->pdev->dev.platform_data;
>  
>         dma_cap_zero(mask);
>         dma_cap_set(DMA_SLAVE, mask);
>  
> 

Host can't be NULL here, the only caller has already checked and dereferenced
the pointer before calling atmci_configure_dma.

The mask variable is now completely unused and can be removed.

	Arnd
