Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69622C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Jan 2022 12:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbiAKMfX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Jan 2022 07:35:23 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42343 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238836AbiAKMfX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jan 2022 07:35:23 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 172D25804F8;
        Tue, 11 Jan 2022 07:35:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jan 2022 07:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=+g8MROAFWKKWljH7HkMr8srRpBC
        tz9vVOfQF57J74Z8=; b=CbElEry1nte+noZrHKNi0/e0mWc8VC47NT2pD8xfDNU
        WUMX6IRWRnzjDY/NR06OZoBYLLGpqXYfWvXCHyJ8epXgk9HdkhPLvTJ67CWiEd/W
        O+kWBPChGPZeKtfYrwz8bxT9E2hkBBxpgnaikH3lPcnJKz7UiYqtq4JyAmE3qE1E
        8F9kkc5SySvIBC4X+6tiw055jFujUDhBeXAQwEOW0ABntmfFuDb0TfHKW0sDucUX
        y2UwhYxSclzp/z52eEOaQDHG3oIv7zo4s7Ld/949SUhhprO1poBqXfXNNFAvIDV2
        QldiUJ2r2ClOQmK+d8Dsmoi1wIz+wh3qp9JF9YHoOjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+g8MRO
        AFWKKWljH7HkMr8srRpBCtz9vVOfQF57J74Z8=; b=EBzlhIOo3RX35RxdrjKZfL
        mNU71r+nwas1VHyW2y5ZxzdxO7/pWtgPFOR7EtYE/5kGasjfFe7PFbtTj5J1eCNn
        6He/+/mc5IcgyWxyl+lByIR4uMYk7Z2rpvluZf5rz1W8bgwOz6Zr8bsm2R+t/B2T
        KNzC54dnmPb7JIBH39NzmBUKAUMuSkwJiOTrB0suoaHkn/1j6yhb9Juo7r5cGFWM
        dV6sMSINEj5lzDz1udYmQ2SkgRSL5BbvdK2kBIbZYyxBqJN9XYTUXIzzcBzm74Ng
        V7dDHhmVmyd+RqB4KS10nUadBaPzMaGaY/vzmtd7DVsS/jZ13jE34CzCUvElRGhA
        ==
X-ME-Sender: <xms:iXndYcJ__YmPPBQd9GFHC4COFg82UBdfwjUD0K9PM5_AZ55nBpe4UA>
    <xme:iXndYcLNhcy1PGfqzMHYh2wPDVNt6GZaUGflYvW5sOmbO2fMvJ-lQU6hddfxbdUlR
    riERUPxojzLWQ>
X-ME-Received: <xmr:iXndYcs_DS6W_ddzqSTJ3htSZnRDuHVEXsLCoS_he9MNKPeLJj6KGsc_lk4G8HBiPYVGA9nbzSQN1LlwnyOvK2-nUzKQ05GF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeeuge
    ffgeefudejhfffieeufffflefhjeffteffffelkeeiuedtfeffueefueenucffohhmrghi
    nhepshhushgvrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:iXndYZb3-6Asd9vn6d2643Ol9rC60OiA292zUwx5FRkSLWYC4zoE0g>
    <xmx:iXndYTbzRHrAknXFmopx8nIyCWt-PSIrCprAGQTpUjTNoAkMsZkrBQ>
    <xmx:iXndYVCujIylAayHB-We0SXWSDMcgxqcLIXBP40hO-GDYezmTFt79w>
    <xmx:i3ndYdZI0s7nLhldLHNPESQyKwqZOTgBqWVpIfDkFN4JWE2qFntelw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jan 2022 07:35:21 -0500 (EST)
Date:   Tue, 11 Jan 2022 13:35:19 +0100
From:   Greg KH <greg@kroah.com>
To:     Marcus Meissner <meissner@suse.de>,
        whitehat002 whitehat002 <hackyzh002@gmail.com>,
        security@kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, xiyuyang19@fudan.edu.cn, tony@atomide.com,
        yang.lee@linux.alibaba.com, colin.king@intel.com,
        xiongx18@fudan.edu.cn, security@suse.com
Subject: Re: UAF in moxart_remove
Message-ID: <Yd15h1ifACm8zyI/@kroah.com>
References: <CAF6NKdZ6FOhJAXkFMgcr-+UcnfxoDc_p69nFxABHu+7b=FW36A@mail.gmail.com>
 <20220111083511.GA12379@suse.de>
 <Yd1zy5wUnrFp7xic@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd1zy5wUnrFp7xic@kroah.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 11, 2022 at 01:10:51PM +0100, Greg KH wrote:
> On Tue, Jan 11, 2022 at 09:35:11AM +0100, Marcus Meissner wrote:
> > Hi whitehat002,
> > 
> > SUSE currently does not build the moxart driver, let me defer you to
> > security@kernel.org and the MMC maintainers.
> > 
> > i also opened a bug in our bugzilla just for tracking
> > https://bugzilla.suse.com/show_bug.cgi?id=1194516
> > 
> > Ciao, Marcus
> > On Tue, Jan 11, 2022 at 02:30:32PM +0800, whitehat002 whitehat002 wrote:
> > > Hello suse security team,
> > > 
> > > There is a UAF in drivers/mmc/host/moxart-mmc.c
> > > This is similar with
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42933c8aa14be1caa9eda41f65cde8a3a95d3e39
> > > 
> > > 
> > > 
> > > static int moxart_remove(struct platform_device *pdev)
> > > {
> > > struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
> > > struct moxart_host *host = mmc_priv(mmc);
> > > 
> > > dev_set_drvdata(&pdev->dev, NULL);
> > > 
> > > if (!IS_ERR_OR_NULL(host->dma_chan_tx))
> > > dma_release_channel(host->dma_chan_tx);
> > > if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> > > dma_release_channel(host->dma_chan_rx);
> > > mmc_remove_host(mmc);
> > > mmc_free_host(mmc);   //[0] free
> > > 
> > > writel(0, host->base + REG_INTERRUPT_MASK); //[1] host is private data from
> > > mmc_host UAF
> > > writel(0, host->base + REG_POWER_CONTROL);
> > > writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
> > >        host->base + REG_CLOCK_CONTROL);
> > > 
> > > return 0;
> > > }
> > > 
> 
> Can you write a patch to fix this so that you can get proper credit for
> fixing it as well as finding it?

Here's a untested patch that "should" be correct, can someone test it
please?

thanks,

greg k-h


diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 16d1c7a43d33..fe05ae81afd9 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -704,14 +704,14 @@ static int moxart_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma_chan_tx);
 	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
 		dma_release_channel(host->dma_chan_rx);
-	mmc_remove_host(mmc);
-	mmc_free_host(mmc);
-
 	writel(0, host->base + REG_INTERRUPT_MASK);
 	writel(0, host->base + REG_POWER_CONTROL);
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
 
+	mmc_remove_host(mmc);
+	mmc_free_host(mmc);
+
 	return 0;
 }
 
