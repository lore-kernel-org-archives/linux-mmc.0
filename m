From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: Initialize dma_slave_config to avoid
 random data
Date: Wed, 14 Sep 2016 12:52:32 +0200
Message-ID: <CAPDyKFoY3Za2cOnmtbdOPY5RQ7pNbSVTxLx98cJ7F0d9S3v8Gw@mail.gmail.com>
References: <20160914101048.1061-1-peter.ujfalusi@ti.com> <3300411.hNyGPzA0ak@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33542 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753245AbcINKwe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2016 06:52:34 -0400
Received: by mail-wm0-f50.google.com with SMTP id b187so5503137wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Sep 2016 03:52:34 -0700 (PDT)
In-Reply-To: <3300411.hNyGPzA0ak@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Kishon <kishon@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 14 September 2016 at 12:23, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, September 14, 2016 1:10:48 PM CEST Peter Ujfalusi wrote:
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 24ebc9a8de89..0a5640156159 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1409,7 +1409,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
>>  static int omap_hsmmc_setup_dma_transfer(struct omap_hsmmc_host *host,
>>                                         struct mmc_request *req)
>>  {
>> -       struct dma_slave_config cfg;
>> +       struct dma_slave_config cfg = {};
>>         struct dma_async_tx_descriptor *tx;
>>         int ret = 0, i;
>>         struct mmc_data *data = req->data;
>>
>
> This change looks correct and is certainly the simplest solution if you want to
> get it into v4.8, but generally speaking, I think it would be nicer to combine
> it with the initialization of the fields:
>
>         struct dma_slave_config cfg = {
>                   .src_addr = host->mapbase + OMAP_HSMMC_DATA;
>         .dst_addr = host->mapbase + OMAP_HSMMC_DATA;
>         .src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>         .dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>         .src_maxburst = data->blksz / 4;
>         .dst_maxburst = data->blksz / 4;
>         };

This seems like a small an easy change as well, so I wouldn't mind
picking up a v2 adopting this pattern instead.

Kind regards
Uffe
