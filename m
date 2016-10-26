From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: s3cmci: Use DMA slave map rather than exported DMA filter
Date: Wed, 26 Oct 2016 15:31:08 +0200
Message-ID: <5765449.Er1VJf0Pit@wuerfel>
References: <1477472907-5932-1-git-send-email-s.nawrocki@samsung.com> <4067826.3L3geWCA41@wuerfel> <11c41f92-5591-dd45-816f-6740da76b91f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:59312 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935267AbcJZNbT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2016 09:31:19 -0400
In-Reply-To: <11c41f92-5591-dd45-816f-6740da76b91f@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: ulf.hansson@linaro.org, linux-samsung-soc@vger.kernel.org, sam.van.den.berge@telenet.be, linux-mmc@vger.kernel.org

On Wednesday, October 26, 2016 2:49:44 PM CEST Sylwester Nawrocki wrote:
> On 10/26/2016 11:21 AM, Arnd Bergmann wrote:
> > On Wednesday, October 26, 2016 11:08:27 AM CEST Sylwester Nawrocki wrote:
> >> > @@ -1685,13 +1684,7 @@ static int s3cmci_probe(struct platform_device *pdev)
> >> >         /* depending on the dma state, get a dma channel to use. */
> >> >  
> >> >         if (s3cmci_host_usedma(host)) {
> >> > -               dma_cap_mask_t mask;
> >> > -
> >> > -               dma_cap_zero(mask);
> >> > -               dma_cap_set(DMA_SLAVE, mask);
> >> > -
> >> > -               host->dma = dma_request_slave_channel_compat(mask,
> >> > -                       s3c24xx_dma_filter, (void *)DMACH_SDI, &pdev->dev, "rx-tx");
> >> > +               host->dma = dma_request_slave_channel(&pdev->dev, "rx-tx");
> >> >                 if (!host->dma) {
> >> >                         dev_err(&pdev->dev, "cannot get DMA channel.\n");
> >> >                         ret = -EBUSY;
> >
> > Can you convert it to use dma_request_chan()+PTR_ERR_OR_ZERO() instead?
> 
> Thanks for your review. dma_request_chan() seems to be returning 
> either valid pointer or ERR_PTR(), so it would be sufficient 
> to use just PTR_ERR(host->dma) on error path?

Correct. You can use either

	if (IS_ERR(host->dma) {
		ret = PTR_ERR(host->dma);
		goto probe_free_gpio_wp;
	}

or

	ret = PTR_ERR_OR_ZERO(host->dma);
	if (ret)
		goto probe_free_gpio_wp;

The two do exactly the same, I just find the second one slightly more
intuitive, and I've seen a couple of spurious warnings caused by
the first (that won't happen here).

	Arnd
