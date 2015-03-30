From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH RESEND 5/7] mmc: host: dw_mmc make IO accessors endian
 agnostic
Date: Mon, 30 Mar 2015 09:48:40 +0900
Message-ID: <55189D68.3060900@samsung.com>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427282872-10563-6-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42379 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbC3Asn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Mar 2015 20:48:43 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NM0009GL2955Q10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 30 Mar 2015 09:48:41 +0900 (KST)
In-reply-to: <1427282872-10563-6-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@lists.codethink.co.uk, marc.dunford@codethink.co.uk, sam.bishop@codethink.co.uk, Dinh Nguyen <dinguyen@opensource.altera.com>, Linux MMC <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi, Ben.

Your patches (5/7~7/7) looks good to me..I will pick them..
But could you fix the checkpatch warning?
Or if you're ok. i will fix the checkpatch warning..then will apply them.

Best Regards,
Jaehoon Chung

On 03/25/2015 08:27 PM, Ben Dooks wrote:
> The dw_mmc driver does not use endian agnostic IO accessors, so fix
> the use of __raw reads and writes to be the relaxed versions.
> 
> This fixes the dw_mmc driver initialisation on Altera socfpga in big endian.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> CC: Linux MMC <linux-mmc@vger.kernel.org>
> CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> CC: Dinh Nguyen <dinguyen@opensource.altera.com>
> CC: Chris Ball <chris@printf.net>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Jaehoon Chung <jh80.chung@samsung.com>
> CC: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 18c4afe..46efdc5 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -171,22 +171,22 @@
>  
>  /* Register access macros */
>  #define mci_readl(dev, reg)			\
> -	__raw_readl((dev)->regs + SDMMC_##reg)
> +	readl_relaxed((dev)->regs + SDMMC_##reg)
>  #define mci_writel(dev, reg, value)			\
> -	__raw_writel((value), (dev)->regs + SDMMC_##reg)
> +	writel_relaxed((value), (dev)->regs + SDMMC_##reg)
>  
>  /* 16-bit FIFO access macros */
>  #define mci_readw(dev, reg)			\
> -	__raw_readw((dev)->regs + SDMMC_##reg)
> +	readw_relaxed((dev)->regs + SDMMC_##reg)
>  #define mci_writew(dev, reg, value)			\
> -	__raw_writew((value), (dev)->regs + SDMMC_##reg)
> +	writew_relaxed((value), (dev)->regs + SDMMC_##reg)
>  
>  /* 64-bit FIFO access macros */
>  #ifdef readq
>  #define mci_readq(dev, reg)			\
> -	__raw_readq((dev)->regs + SDMMC_##reg)
> +	readq_relaxed((dev)->regs + SDMMC_##reg)
>  #define mci_writeq(dev, reg, value)			\
> -	__raw_writeq((value), (dev)->regs + SDMMC_##reg)
> +	writeq_relaxed((value), (dev)->regs + SDMMC_##reg)
>  #else
>  /*
>   * Dummy readq implementation for architectures that don't define it.
> 

