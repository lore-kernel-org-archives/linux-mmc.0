From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 14/18] mmc: meson-gx: remove unneeded devm_kstrdup in
 meson_mmc_clk_init
Date: Wed, 15 Feb 2017 20:35:16 +0100
Message-ID: <7c928597-e710-35ea-413d-4146f743942c@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
 <04781c15-b543-337c-d6d4-8378bd558cf7@gmail.com>
 <m27f4r8d6h.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34737 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBOTqQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 14:46:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so9854683wmi.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 11:46:15 -0800 (PST)
In-Reply-To: <m27f4r8d6h.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 15.02.2017 um 20:30 schrieb Kevin Hilman:
> Heiner Kallweit <hkallweit1@gmail.com> writes:
> 
>> MMC core does a deep copy of init.name, therefore it's fully ok to
> 
> I assume you mean the clock framework, not the MMC core, right?
> 
Uups, of course.

>> provide a local variable.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> With the changelog fixed,
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> 
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 39904fb5..806554b1 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -276,7 +276,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>  
>>  	/* create the divider */
>>  	snprintf(clk_name, sizeof(clk_name), "%s#div", dev_name(host->dev));
>> -	init.name = devm_kstrdup(host->dev, clk_name, GFP_KERNEL);
>> +	init.name = clk_name;
>>  	init.ops = &clk_divider_ops;
>>  	init.flags = CLK_SET_RATE_PARENT;
>>  	clk_div_parents[0] = __clk_get_name(host->mux_clk);
> 

