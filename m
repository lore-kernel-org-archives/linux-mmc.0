From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 6/10] mmc: meson-gx: fix error path in
 meson_mmc_clk_init / meson_mmc_probe
Date: Sat, 18 Feb 2017 16:22:25 +0100
Message-ID: <f152d90b-5105-82b5-c7ec-f1868741739b@gmail.com>
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
 <8419d592-1338-d7eb-3a75-342b64897922@gmail.com>
 <eac9af68-425a-0c05-8f9f-fac7418cf900@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36641 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdBRPYK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Feb 2017 10:24:10 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so7195822wmd.3
        for <linux-mmc@vger.kernel.org>; Sat, 18 Feb 2017 07:22:39 -0800 (PST)
In-Reply-To: <eac9af68-425a-0c05-8f9f-fac7418cf900@poczta.onet.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 18.02.2017 um 14:57 schrieb Michał Zegan:
> 
> 
> W dniu 18.02.2017 o 14:19, Heiner Kallweit pisze:
>> The condition should be "if (ret)" as the disable/unprepare is
>> supposed to be executed if the previous command fails.
>> In addition adjust the error path in probe to properly deal
>> with the case that cfg_div_clk can be registered successfully
>> but enable/prepare fails.
>> In this case we shouldn't call clk_disable_unprepare.
>>
>> Reported-by: Michał Zegan <webczat_200@poczta.onet.pl>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> v2:
>> - extended commit message
>> v3:
>> - adjust error path in probe
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 68e76fa8..002e4aac 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -321,7 +321,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>  	host->mmc->f_min = clk_round_rate(host->cfg_div_clk, 400000);
>>  
>>  	ret = meson_mmc_clk_set(host, host->mmc->f_min);
>> -	if (!ret)
>> +	if (ret)
>>  		clk_disable_unprepare(host->cfg_div_clk);
>>  
>>  	return ret;
>> @@ -771,7 +771,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>  					meson_mmc_irq_thread, IRQF_SHARED,
>>  					DRIVER_NAME, host);
>>  	if (ret)
>> -		goto free_host;
>> +		goto err_div_clk;
>>  
>>  	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
>>  	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
>> @@ -784,7 +784,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>  	if (host->bounce_buf == NULL) {
>>  		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
>>  		ret = -ENOMEM;
>> -		goto free_host;
>> +		goto err_div_clk;
>>  	}
>>  
>>  	mmc->ops = &meson_mmc_ops;
>> @@ -792,8 +792,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>  
>>  	return 0;
>>  
>> -free_host:
>> +err_div_clk:
>>  	clk_disable_unprepare(host->cfg_div_clk);
>> +free_host:
>>  	clk_disable_unprepare(host->core_clk);
>>  	mmc_free_host(mmc);
>>  	return ret;
>>
> Doesn't the same problem exist with a core clock? It also could error
> when being enabled, and it will be disabled even if not enabled before...
> 
Yes, there it's basically the same issue. Feel free to submit a patch.

