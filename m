From: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat@webczatnet.pl>
Subject: Re: [PATCH 2/2] mmc: meson-gx: remove mmc host on device removal
Date: Fri, 17 Feb 2017 20:50:55 +0100
Message-ID: <171193cd-e82d-695a-22b3-c10d670baad7@webczatnet.pl>
References: <20170216145222.1577-1-webczat@webczatnet.pl>
 <20170216145222.1577-3-webczat@webczatnet.pl> <m2fujc61mu.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webczatnet.pl ([91.121.100.5]:52084 "EHLO webczatnet.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755926AbdBQTvD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Feb 2017 14:51:03 -0500
In-Reply-To: <m2fujc61mu.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org



W dniu 17.02.2017 o 20:47, Kevin Hilman pisze:
> Michał Zegan <webczat@webczatnet.pl> writes:
>
>> The mmc host was added in meson_mmc_probe, but never removed in meson_mmc_remove.
>> Fix that by removing the host before deallocating other resources.
>>
>> Signed-off-by: Michał Zegan <webczat@webczatnet.pl>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
I do not know how the mmc driver looks like after Heiner's cleanup. Does
this patch get obsoleted by the prior cleanup, or conflict with it in
some way?
>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index d444b6bfa02b..bb83446118a3 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -818,6 +818,8 @@ static int meson_mmc_remove(struct platform_device *pdev)
>>  	if (WARN_ON(!host))
>>  		return 0;
>>  
>> +	mmc_remove_host(host->mmc);
>> +
>>  	if (host->bounce_buf)
>>  		dma_free_coherent(host->dev, host->bounce_buf_size,
>>  				  host->bounce_buf, host->bounce_dma_addr);

