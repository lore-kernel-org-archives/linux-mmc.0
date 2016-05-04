From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap: Use dma_request_chan() for requesting DMA channel
Date: Wed, 4 May 2016 09:32:02 +0200
Message-ID: <CAPDyKFo1XDQigd+CL6sz0WpyOa2EuYEmW6gDPxab-K1dHQLTWQ@mail.gmail.com>
References: <1461935197-28664-1-git-send-email-peter.ujfalusi@ti.com>
	<CAPDyKFqTsJ3gcDGVWpbmQ4rzM8TQK7km3NTT=d0D9Dt7ydUafg@mail.gmail.com>
	<a7e34ffa-19d4-48fb-8d13-a151fbafd842@ti.com>
	<8797d828-eb71-c747-f63a-e77762c51d82@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37921 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbcEDHcE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 03:32:04 -0400
Received: by mail-wm0-f46.google.com with SMTP id g17so77167680wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2016 00:32:03 -0700 (PDT)
In-Reply-To: <8797d828-eb71-c747-f63a-e77762c51d82@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Kishon <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 4 May 2016 at 05:59, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 05/03/2016 11:00 PM, Peter Ujfalusi wrote:
>>>> @@ -1382,29 +1379,31 @@ static int mmc_omap_probe(struct platform_device *pdev)
>>>>                 goto err_free_iclk;
>>>>         }
>>>>
>>>> -       dma_cap_zero(mask);
>>>> -       dma_cap_set(DMA_SLAVE, mask);
>>>> -
>>>>         host->dma_tx_burst = -1;
>>>>         host->dma_rx_burst = -1;
>>>>
>>>> -       res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
>>>> -       if (res)
>>>> -               sig = res->start;
>>>> -       host->dma_tx = dma_request_slave_channel_compat(mask,
>>>> -                               omap_dma_filter_fn, &sig, &pdev->dev, "tx");
>>>> -       if (!host->dma_tx)
>>>> -               dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
>>>> -                       sig);
>>>> -
>>>> -       res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
>>>> -       if (res)
>>>> -               sig = res->start;
>>>> -       host->dma_rx = dma_request_slave_channel_compat(mask,
>>>> -                               omap_dma_filter_fn, &sig, &pdev->dev, "rx");
>>>> -       if (!host->dma_rx)
>>>> -               dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
>>>> -                       sig);
>>>> +       host->dma_tx = dma_request_chan(&pdev->dev, "tx");
>>>> +       if (IS_ERR(host->dma_tx)) {
>>>> +               ret = PTR_ERR(host->dma_tx);
>>>> +               if (ret == -EPROBE_DEFER)
>>>> +                       goto err_free_iclk;
>>
>> and one clk_put(host->fclk) is missing from here.
>>
>>>> +
>>>> +               host->dma_tx = NULL;
>>>
>>> Instead of setting this to NULL, let's keep its value and later check
>>> it with IS_ERR() when needed.
>>
>> I thought about it, but decided against without need to have changes in other
>> places in the driver.
>
> This sentence does not make too much sense ;) Let's try it again:
> So, I have considered to use PTR_ERR in the driver for the DMA channel, but I
> wanted to avoid too broad changes in the driver. Keeping the ERR_PTR would
> bring no runtime benefit since we only care if we have channel or not.

Okay, so let's deal with that separately instead then.

Kind regards
Uffe
