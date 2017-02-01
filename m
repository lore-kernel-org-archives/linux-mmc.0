From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 3/9] mmc: meson-gx: improve meson_mmc_clk_set
Date: Wed, 1 Feb 2017 21:29:17 +0100
Message-ID: <fadf4270-4a64-e853-387f-49008aaacd64@gmail.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
 <CGME20170131210730epcas2p231e0ff8a05a2eb6223f1717d5929635d@epcas2p2.samsung.com>
 <daf8b18a-adf5-7dc1-7b3b-45db83af0af3@gmail.com>
 <92a17f7a-c197-d6ce-a255-0adf9030bb7e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35600 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdBAU3a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 15:29:30 -0500
Received: by mail-wm0-f65.google.com with SMTP id u63so8076250wmu.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2017 12:29:29 -0800 (PST)
In-Reply-To: <92a17f7a-c197-d6ce-a255-0adf9030bb7e@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

Am 01.02.2017 um 13:24 schrieb Jaehoon Chung:
> On 02/01/2017 05:58 AM, Heiner Kallweit wrote:
>> The following changes are quite small, therefore I combined them in
>> one patch.
>>
>> - ret doesn't need to be initialized with 0
>> - use standard !clk_rate notation to check for a zero value
>> - If clk_rate is zero we return here. Therefore all further checks
>>   in this function for clk_rate != 0 are not needed.
>> - switch from dev_warn to dev_err if the clock can't be set
>> - If due to clock source and available divider values the requested
>>   frequency isn't matched exactly (always the case if requested
>>   frequency is 52 MHz), then just print the differing values as
>>   debug message and not as warning.
>> - Also remove ret from the message as it is always 0.
>> - In the case of actual frequency not exactly matching the requested
>>   one set mmc->actual_clock to the requested frequency.
>>   So far mmc->actual_clock wasn't set at all in this case.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 36 +++++++++++++++++++-----------------
>>  1 file changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 38edc60d..529a4f22 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -179,7 +179,7 @@ struct sd_emmc_desc {
>>  static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
>>  {
>>  	struct mmc_host *mmc = host->mmc;
>> -	int ret = 0;
>> +	int ret;
>>  	u32 cfg;
>>  
>>  	if (clk_rate) {
>> @@ -202,29 +202,31 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
>>  	dev_dbg(host->dev, "change clock rate %u -> %lu\n",
>>  		mmc->actual_clock, clk_rate);
>>  
>> -	if (clk_rate == 0) {
>> +	if (!clk_rate) {
>>  		mmc->actual_clock = 0;
>>  		return 0;
>>  	}
>>  
>>  	ret = clk_set_rate(host->cfg_div_clk, clk_rate);
>> -	if (ret)
>> -		dev_warn(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
>> -			 clk_rate, ret);
>> -	else if (clk_rate && clk_rate != clk_get_rate(host->cfg_div_clk))
>> -		dev_warn(host->dev, "divider requested rate %lu != actual rate %lu: ret=%d\n",
>> -			 clk_rate, clk_get_rate(host->cfg_div_clk), ret);
>> -	else
>> -		mmc->actual_clock = clk_rate;
>> -
>> -	/* (re)start clock, if non-zero */
>> -	if (!ret && clk_rate) {
>> -		cfg = readl(host->regs + SD_EMMC_CFG);
>> -		cfg &= ~CFG_STOP_CLOCK;
>> -		writel(cfg, host->regs + SD_EMMC_CFG);
>> +	if (ret) {
>> +		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
>> +			clk_rate, ret);
>> +		return ret;
>>  	}
>>  
>> -	return ret;
>> +	if (clk_rate != clk_get_rate(host->cfg_div_clk))
>> +		dev_dbg(host->dev,
>> +			"divider requested rate %lu != actual rate %lu\n",
>> +			clk_rate, clk_get_rate(host->cfg_div_clk));
>> +
>> +	mmc->actual_clock = clk_rate;
> 
> debug message is described actual_rate as clk_get_rate()..
> What is correct "actual_clock"?
> 
Indeed this might be a little misleading.
"actual_clock" is a member of struct mmc_host and for now we have to live
with this name. However the meaning in our context is: "currently requested
clock rate".
What we call "actual rate" in the message is the effective clock rate and
might differ from the requested one, depending on available parent clocks
and divider values.

Regards, Heiner

> Best Regards,
> Jaehoon Chung
> 
>> +
>> +	/* (re)start clock */
>> +	cfg = readl(host->regs + SD_EMMC_CFG);
>> +	cfg &= ~CFG_STOP_CLOCK;
>> +	writel(cfg, host->regs + SD_EMMC_CFG);
>> +
>> +	return 0;
>>  }
>>  
>>  /*
>>
> 
> 

