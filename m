Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A7C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Jan 2022 08:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348960AbiAKIfP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Jan 2022 03:35:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37568 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348952AbiAKIfO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jan 2022 03:35:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B6CD11F3B1;
        Tue, 11 Jan 2022 08:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641890113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dY536oS0GjnBDhS/kdNM91WvACv4tPV7Yc3+AzaQTb8=;
        b=QVfYUVOEYVgznux9JxYby0TiqCDriscSLC8RWyWG9VqVR7Rry92AWO2TFOb7NJeGy5ysjL
        QbU3ET0Nx7NNGqWfuGXLX6swRqGMCuskpf/ALMUOzRs5rTRpCU+adzbN3VFmniFMreWnk4
        ve1jfrJdqeW/r5QYizAHZ8vg41XhcDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641890113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dY536oS0GjnBDhS/kdNM91WvACv4tPV7Yc3+AzaQTb8=;
        b=jFz2hLGVVGuK9aroU376p99kKOHdxh2lDwLMTRpv7BDjBB2AgdYY4FGWjoPSTW8ahuIqUL
        EgtS42j+bXphwBCQ==
Received: from suse.de (sec-meissner.suse.de [10.160.2.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EDDA9A3B85;
        Tue, 11 Jan 2022 08:35:12 +0000 (UTC)
Date:   Tue, 11 Jan 2022 09:35:11 +0100
From:   Marcus Meissner <meissner@suse.de>
To:     whitehat002 whitehat002 <hackyzh002@gmail.com>,
        security@kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, xiyuyang19@fudan.edu.cn, tony@atomide.com,
        yang.lee@linux.alibaba.com, colin.king@intel.com,
        xiongx18@fudan.edu.cn
Cc:     security@suse.com
Subject: Re: UAF in moxart_remove
Message-ID: <20220111083511.GA12379@suse.de>
References: <CAF6NKdZ6FOhJAXkFMgcr-+UcnfxoDc_p69nFxABHu+7b=FW36A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6NKdZ6FOhJAXkFMgcr-+UcnfxoDc_p69nFxABHu+7b=FW36A@mail.gmail.com>
Organization: SUSE Software Solutions =?iso-8859-1?Q?Ger?=
 =?iso-8859-1?Q?many_GmbH=2C_Maxfeldstr=2E_5=2C_90409_Nuernberg=2C_Germany?=
 =?iso-8859-1?Q?=2C_GF=3A_Ivo_Totev=2C_HRB_36809=2C_AG_N=FCrnberg?=
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi whitehat002,

SUSE currently does not build the moxart driver, let me defer you to
security@kernel.org and the MMC maintainers.

i also opened a bug in our bugzilla just for tracking
https://bugzilla.suse.com/show_bug.cgi?id=1194516

Ciao, Marcus
On Tue, Jan 11, 2022 at 02:30:32PM +0800, whitehat002 whitehat002 wrote:
> Hello suse security team,
> 
> There is a UAF in drivers/mmc/host/moxart-mmc.c
> This is similar with
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42933c8aa14be1caa9eda41f65cde8a3a95d3e39
> 
> 
> 
> static int moxart_remove(struct platform_device *pdev)
> {
> struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
> struct moxart_host *host = mmc_priv(mmc);
> 
> dev_set_drvdata(&pdev->dev, NULL);
> 
> if (!IS_ERR_OR_NULL(host->dma_chan_tx))
> dma_release_channel(host->dma_chan_tx);
> if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> dma_release_channel(host->dma_chan_rx);
> mmc_remove_host(mmc);
> mmc_free_host(mmc);   //[0] free
> 
> writel(0, host->base + REG_INTERRUPT_MASK); //[1] host is private data from
> mmc_host UAF
> writel(0, host->base + REG_POWER_CONTROL);
> writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
>        host->base + REG_CLOCK_CONTROL);
> 
> return 0;
> }
> 
> 
> 
> static inline void *mmc_priv(struct mmc_host *host)
> {
> return (void *)host->private;
> }
> 
> 
> Credit information
> Zhihua Yao of KunLun Lab
