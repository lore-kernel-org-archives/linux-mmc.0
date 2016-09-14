From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Initialize dma_slave_config to avoid
 random data
Date: Wed, 14 Sep 2016 13:59:31 +0300
Message-ID: <f91f1192-f501-ad51-77d5-59d50f48069c@ti.com>
References: <20160914101048.1061-1-peter.ujfalusi@ti.com>
 <3300411.hNyGPzA0ak@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:49091 "EHLO bear.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756072AbcINK7l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Sep 2016 06:59:41 -0400
In-Reply-To: <3300411.hNyGPzA0ak@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: ulf.hansson@linaro.org, tony@atomide.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/14/16 13:23, Arnd Bergmann wrote:
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
> 	struct dma_slave_config cfg = {
> 		  .src_addr = host->mapbase + OMAP_HSMMC_DATA;
>         .dst_addr = host->mapbase + OMAP_HSMMC_DATA;
>         .src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>         .dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>         .src_maxburst = data->blksz / 4;
>         .dst_maxburst = data->blksz / 4;

I opted to not do this because the data->blksz is validated later in the
function (twice).

It is not a big issue, but looks a bit odd.

-- 
Péter
