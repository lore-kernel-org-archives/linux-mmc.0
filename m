Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CDDC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Jan 2022 12:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiAKMK5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Jan 2022 07:10:57 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56603 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239449AbiAKMK4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jan 2022 07:10:56 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id F21605800C9;
        Tue, 11 Jan 2022 07:10:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jan 2022 07:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DjKckX5lWqBt7eLJuLFCRU18tCW
        o8z5Gg5ngVpsQaqI=; b=FyQ2+VX2B9pm0U/FyYPsBQZPh9YHLOUGl/FFm3tTkGY
        deoH8X9Ex0kgKoFJi2Y2Y2FdTUNZF2LCPPscVfyuA18uqLGnyIDoFxhYTgayLlcN
        5hB2i/Geu3F2lWKZ4Edh5ajJSDml+SSe3N+l+pIuNFr7kh8X+3/XTQo68hykID0q
        7tp5mz0pEQD7u5lUiaR6EB95T3E2V6VFYqW52hQRCXEfxeDPnXUQgK/ywBsBULIa
        8cBheqf+Gh8+lGj2FOdjl+t7h9JMNbAJaIbtsyLCfBR9p7BVThbHlUZWKFdVqYLs
        lSr27Z+oGfzIG2srjxBkWsalMp3yBbTF2PAbIt0QEGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DjKckX
        5lWqBt7eLJuLFCRU18tCWo8z5Gg5ngVpsQaqI=; b=lZTmFqwbGvibuSGP6YdPK6
        UYEVZ60aj3+/jADwJmlUAqyh9//uYtrKcHJoUpIvj8gx5A3G47Qxj1yy0keU6qjf
        5S7gV3yzEVzBBnhVl1H3XsebinkxCbBcg68vmAmUlW5Bcknzf1gHUAlLu/WdiMaz
        xi/NSb+P9mxex3kUYUyAiyBFp68IkeAxIVJIiCFFMvI91dR3TiUFtHDSyRpsGw75
        5jS9GBlWokcc7Md4yy01c3kjFaEP1HAXIwKg2KHwkf5TfiVTlTXfAIuB0yFWukJX
        jaFDw1nM/vAl1gx0RyZs9bZ8LQFzl/TPRQbVD8XJQMDCmcCEsa5i06AwqJQZ6SOg
        ==
X-ME-Sender: <xms:znPdYULSLvsqBzBQ_yd-0r9Y7qepTwNBHhXvu8qO6IuBMdTGGTM8aw>
    <xme:znPdYULupFxBrnhEpDz_Eu0qncEMhxYZRgH09xdvvTK5cdwnDCCtNq9wbezqPshRw
    MRi-tZlGKsUDw>
X-ME-Received: <xmr:znPdYUsWgXhJFIsRYmIBWhGQD_54uA0KDTpJotr0d4n1t2B0CO9Kbq4IyFU7mXQNPnNHcgfOZLBpeEmR2XGmQOuByl-ctY2T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeeuge
    ffgeefudejhfffieeufffflefhjeffteffffelkeeiuedtfeffueefueenucffohhmrghi
    nhepshhushgvrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:znPdYRZMBSWiSDoeGF__4txsVnKRLZSckyf8w47neS3mHc7wq2YRig>
    <xmx:znPdYbbtKPqXz4hZqP5eEAOgnr0HWu61o5AAZ6HYO02Do-rLRAC77g>
    <xmx:znPdYdBWrcHOBuaYtf-Ov9IUgTam5HXlmG8N3OwSybXuLyJaMpDi-A>
    <xmx:z3PdYVb3ZjBS__ocvxkeLnazS4PgeNUoLrmwmHYfDUb-uBkjypEIAg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jan 2022 07:10:54 -0500 (EST)
Date:   Tue, 11 Jan 2022 13:10:51 +0100
From:   Greg KH <greg@kroah.com>
To:     Marcus Meissner <meissner@suse.de>
Cc:     whitehat002 whitehat002 <hackyzh002@gmail.com>,
        security@kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, xiyuyang19@fudan.edu.cn, tony@atomide.com,
        yang.lee@linux.alibaba.com, colin.king@intel.com,
        xiongx18@fudan.edu.cn, security@suse.com
Subject: Re: UAF in moxart_remove
Message-ID: <Yd1zy5wUnrFp7xic@kroah.com>
References: <CAF6NKdZ6FOhJAXkFMgcr-+UcnfxoDc_p69nFxABHu+7b=FW36A@mail.gmail.com>
 <20220111083511.GA12379@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111083511.GA12379@suse.de>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 11, 2022 at 09:35:11AM +0100, Marcus Meissner wrote:
> Hi whitehat002,
> 
> SUSE currently does not build the moxart driver, let me defer you to
> security@kernel.org and the MMC maintainers.
> 
> i also opened a bug in our bugzilla just for tracking
> https://bugzilla.suse.com/show_bug.cgi?id=1194516
> 
> Ciao, Marcus
> On Tue, Jan 11, 2022 at 02:30:32PM +0800, whitehat002 whitehat002 wrote:
> > Hello suse security team,
> > 
> > There is a UAF in drivers/mmc/host/moxart-mmc.c
> > This is similar with
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42933c8aa14be1caa9eda41f65cde8a3a95d3e39
> > 
> > 
> > 
> > static int moxart_remove(struct platform_device *pdev)
> > {
> > struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
> > struct moxart_host *host = mmc_priv(mmc);
> > 
> > dev_set_drvdata(&pdev->dev, NULL);
> > 
> > if (!IS_ERR_OR_NULL(host->dma_chan_tx))
> > dma_release_channel(host->dma_chan_tx);
> > if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> > dma_release_channel(host->dma_chan_rx);
> > mmc_remove_host(mmc);
> > mmc_free_host(mmc);   //[0] free
> > 
> > writel(0, host->base + REG_INTERRUPT_MASK); //[1] host is private data from
> > mmc_host UAF
> > writel(0, host->base + REG_POWER_CONTROL);
> > writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
> >        host->base + REG_CLOCK_CONTROL);
> > 
> > return 0;
> > }
> > 

Can you write a patch to fix this so that you can get proper credit for
fixing it as well as finding it?

thanks,

greg k-h
