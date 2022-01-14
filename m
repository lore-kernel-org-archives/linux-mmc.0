Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B553C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Jan 2022 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiANICP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Jan 2022 03:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiANICO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jan 2022 03:02:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F052C061574
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jan 2022 00:02:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A2261DEC
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jan 2022 08:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971ADC36AEA;
        Fri, 14 Jan 2022 08:02:12 +0000 (UTC)
Date:   Fri, 14 Jan 2022 09:02:10 +0100
From:   Greg KH <greg@kroah.com>
To:     Marcus Meissner <meissner@suse.de>,
        whitehat002 whitehat002 <hackyzh002@gmail.com>,
        security@kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, xiyuyang19@fudan.edu.cn, tony@atomide.com,
        yang.lee@linux.alibaba.com, colin.king@intel.com,
        xiongx18@fudan.edu.cn, security@suse.com
Subject: Re: UAF in moxart_remove
Message-ID: <YeEuAiUuwyBpdx60@kroah.com>
References: <CAF6NKdZ6FOhJAXkFMgcr-+UcnfxoDc_p69nFxABHu+7b=FW36A@mail.gmail.com>
 <20220111083511.GA12379@suse.de>
 <Yd1zy5wUnrFp7xic@kroah.com>
 <Yd15h1ifACm8zyI/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd15h1ifACm8zyI/@kroah.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 11, 2022 at 01:35:19PM +0100, Greg KH wrote:
> On Tue, Jan 11, 2022 at 01:10:51PM +0100, Greg KH wrote:
> > On Tue, Jan 11, 2022 at 09:35:11AM +0100, Marcus Meissner wrote:
> > > Hi whitehat002,
> > > 
> > > SUSE currently does not build the moxart driver, let me defer you to
> > > security@kernel.org and the MMC maintainers.
> > > 
> > > i also opened a bug in our bugzilla just for tracking
> > > https://bugzilla.suse.com/show_bug.cgi?id=1194516
> > > 
> > > Ciao, Marcus
> > > On Tue, Jan 11, 2022 at 02:30:32PM +0800, whitehat002 whitehat002 wrote:
> > > > Hello suse security team,
> > > > 
> > > > There is a UAF in drivers/mmc/host/moxart-mmc.c
> > > > This is similar with
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42933c8aa14be1caa9eda41f65cde8a3a95d3e39
> > > > 
> > > > 
> > > > 
> > > > static int moxart_remove(struct platform_device *pdev)
> > > > {
> > > > struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
> > > > struct moxart_host *host = mmc_priv(mmc);
> > > > 
> > > > dev_set_drvdata(&pdev->dev, NULL);
> > > > 
> > > > if (!IS_ERR_OR_NULL(host->dma_chan_tx))
> > > > dma_release_channel(host->dma_chan_tx);
> > > > if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> > > > dma_release_channel(host->dma_chan_rx);
> > > > mmc_remove_host(mmc);
> > > > mmc_free_host(mmc);   //[0] free
> > > > 
> > > > writel(0, host->base + REG_INTERRUPT_MASK); //[1] host is private data from
> > > > mmc_host UAF
> > > > writel(0, host->base + REG_POWER_CONTROL);
> > > > writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
> > > >        host->base + REG_CLOCK_CONTROL);
> > > > 
> > > > return 0;
> > > > }
> > > > 
> > 
> > Can you write a patch to fix this so that you can get proper credit for
> > fixing it as well as finding it?
> 
> Here's a untested patch that "should" be correct, can someone test it
> please?
> 
> thanks,
> 
> greg k-h
> 
> 
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 16d1c7a43d33..fe05ae81afd9 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -704,14 +704,14 @@ static int moxart_remove(struct platform_device *pdev)
>  		dma_release_channel(host->dma_chan_tx);
>  	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
>  		dma_release_channel(host->dma_chan_rx);
> -	mmc_remove_host(mmc);
> -	mmc_free_host(mmc);
> -
>  	writel(0, host->base + REG_INTERRUPT_MASK);
>  	writel(0, host->base + REG_POWER_CONTROL);
>  	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
>  	       host->base + REG_CLOCK_CONTROL);
>  
> +	mmc_remove_host(mmc);
> +	mmc_free_host(mmc);
> +
>  	return 0;
>  }
>  

I've sent a "better" version of this patch upstream for inclusion now:
	https://lore.kernel.org/all/20220114075934.302464-1-gregkh@linuxfoundation.org/

As this path can only be hit if you have root privileges to unload the
module, it's not really that much of a "security" issue.

thanks,

greg k-h
