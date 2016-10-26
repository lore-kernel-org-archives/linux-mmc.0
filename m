From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] mmc: s3cmci: Use DMA slave map rather than exported DMA
 filter
Date: Wed, 26 Oct 2016 14:49:44 +0200
Message-ID: <11c41f92-5591-dd45-816f-6740da76b91f@samsung.com>
References: <1477472907-5932-1-git-send-email-s.nawrocki@samsung.com>
 <CGME20161026092144epcas4p1f31b92b88c17d45837f3f072dee3a6c8@epcas4p1.samsung.com>
 <4067826.3L3geWCA41@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4067826.3L3geWCA41@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: ulf.hansson@linaro.org, linux-samsung-soc@vger.kernel.org, sam.van.den.berge@telenet.be, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 10/26/2016 11:21 AM, Arnd Bergmann wrote:
> On Wednesday, October 26, 2016 11:08:27 AM CEST Sylwester Nawrocki wrote:
>> > @@ -1685,13 +1684,7 @@ static int s3cmci_probe(struct platform_device *pdev)
>> >         /* depending on the dma state, get a dma channel to use. */
>> >  
>> >         if (s3cmci_host_usedma(host)) {
>> > -               dma_cap_mask_t mask;
>> > -
>> > -               dma_cap_zero(mask);
>> > -               dma_cap_set(DMA_SLAVE, mask);
>> > -
>> > -               host->dma = dma_request_slave_channel_compat(mask,
>> > -                       s3c24xx_dma_filter, (void *)DMACH_SDI, &pdev->dev, "rx-tx");
>> > +               host->dma = dma_request_slave_channel(&pdev->dev, "rx-tx");
>> >                 if (!host->dma) {
>> >                         dev_err(&pdev->dev, "cannot get DMA channel.\n");
>> >                         ret = -EBUSY;
>
> Can you convert it to use dma_request_chan()+PTR_ERR_OR_ZERO() instead?

Thanks for your review. dma_request_chan() seems to be returning 
either valid pointer or ERR_PTR(), so it would be sufficient 
to use just PTR_ERR(host->dma) on error path?
