From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Fri, 9 Sep 2011 18:07:01 +0400
Message-ID: <20110909140701.GA9258@oksana.dev.rtsoft.ru>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40387 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1IIOHH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2011 10:07:07 -0400
Received: by wyh22 with SMTP id 22so1602974wyh.19
        for <linux-mmc@vger.kernel.org>; Fri, 09 Sep 2011 07:07:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, Xu lei <B33228@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

On Fri, Sep 09, 2011 at 08:05:46PM +0800, Roy Zang wrote:
> From: Xu lei <B33228@freescale.com>
> 
> Freescale eSDHC registers only support 32-bit accesses,
> this patch ensures that all Freescale eSDHC register accesses
> are 32-bit.
> 
> Signed-off-by: Xu lei <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---

The patch looks OK.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

[...]
> +static u8 esdhc_readb(struct sdhci_host *host, int reg)
> +{
> +	int base = reg & ~0x3;
> +	int shift = (reg & 0x3) * 8;
> +	u8 ret = (in_be32(host->ioaddr + base) >> shift) & 0xff;
>  	return ret;
>  }

Though, I wonder if we could change sdhci_be32bs_read{b,w}, instead
of making this local to eSDHC.

The thing is: sdhci_be32bs_writeb() is using clrsetbits_be32,
so the write variant already uses 32-bit accessors, so nothing should
break if we switch sdhci_be32bs_readb() to in_be32().

But maybe it's safer if we do this in a separate patch, so that it
could be easily reverted without impacting eSDHC if something actually
breaks.

You decide. :-)

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
