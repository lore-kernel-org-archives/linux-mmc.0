From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific
 data
Date: Tue, 28 Sep 2010 16:57:58 +0400
Message-ID: <20100928125758.GA32038@oksana.dev.rtsoft.ru>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
 <1285677406-3359-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44855 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab0I1M6F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 08:58:05 -0400
Received: by ewy23 with SMTP id 23so1735966ewy.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 05:58:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285677406-3359-2-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, zhangfei gao <zhangfei.gao@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>

On Tue, Sep 28, 2010 at 02:36:41PM +0200, Wolfram Sang wrote:
> We need to carry some information per host, e.g. the clock. Add a
> structure for it and initialize it in the generic part.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
[...]
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -11,8 +11,14 @@
>  #ifndef _DRIVERS_MMC_SDHCI_PLTFM_H
>  #define _DRIVERS_MMC_SDHCI_PLTFM_H
>  
> +#include <linux/clk.h>
>  #include <linux/sdhci-pltfm.h>
>  
> +struct sdhci_pltfm_host {
> +	struct clk *clk;
> +	u32 scratchpad; /* to handle quirks across io-accessor calls */

#include <linux/types.h> for u32.

Otherwise, looks good.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
