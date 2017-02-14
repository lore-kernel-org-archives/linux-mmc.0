From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4] mmc: sdio: check the buffer address for sdio API
Date: Tue, 14 Feb 2017 11:45:31 -0800
Message-ID: <20170214194531.GA21773@infradead.org>
References: <1486428890-28187-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdBNTpd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 14:45:33 -0500
Content-Disposition: inline
In-Reply-To: <1486428890-28187-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On Tue, Feb 07, 2017 at 08:54:50AM +0800, Shawn Lin wrote:
> It's fine if the host driver use PIO mode to transfer the
> vmalloc area buffer but not for DMA mode. The sdio APIs haven't
> provide the capability to tell the caller whether it will use DMA
> to finish the IO transfer or not,

Wether you dma or pio does not matter.  Addressability requirements
are slightly different, but it's nothing your patch is going to help
with.

> so don't give the randomly
> insmoded sdio function driver the possibility to break the kernel.
> Also the APIs shouldn't take the liberty to do a copy for these
> cases and just kick out these requests should be enough.
> 
> This issue is observed by doing insmod a downloaded wifi module
> driver and the kernel panic right away. Unfortunately we don't have
> the source code but adding this patch that it proves that the module
> driver was passing on a vmalloc area buffer for sdio APIs.

So don't use that illegally redistributed driver.  Working around it
is certainly nothing the upstream kernel cares about at all.
