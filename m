From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-pltfm: Add structure for host-specific
 data
Date: Tue, 21 Sep 2010 17:01:55 +0400
Message-ID: <20100921130155.GA30150@oksana.dev.rtsoft.ru>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
 <1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59854 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab0IUNCB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 09:02:01 -0400
Received: by ewy23 with SMTP id 23so1890207ewy.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2010 06:02:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

On Tue, Sep 21, 2010 at 02:30:07PM +0200, Wolfram Sang wrote:
> We need to carry some information per host, e.g. the clock. Add a
> structure for it and initialize it in the generic part.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
[...]
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 900f329..c393289 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -13,6 +13,11 @@
>  
>  #include <linux/sdhci-pltfm.h>
>  
> +struct sdhci_pltfm_host {
> +	struct clk *clk;

Forward decl for struct clk is needed.

> +	u32 scratchpad; /* to handle quirks across io-accessor calls */

#include <linux/types.h> is needed for u32.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
