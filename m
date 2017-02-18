From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 6/9] mmc: meson-gx: remove unneeded meson_mmc_clk_set
 in meson_mmc_clk_init
Date: Sat, 18 Feb 2017 11:49:22 +0100
Message-ID: <b238ee08-66d5-59a1-4e1d-33078103291e@gmail.com>
References: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
 <fc824f91-f686-64ab-83e4-86b04fd512f0@gmail.com>
 <ef2944b5-e04c-780b-6256-31af7ceb87dc@poczta.onet.pl>
 <c8cdaef4-3de2-139d-5339-c5ad5c81fd4b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33417 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbdBRKtz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Feb 2017 05:49:55 -0500
Received: by mail-wr0-f195.google.com with SMTP id g51so368740wrg.0
        for <linux-mmc@vger.kernel.org>; Sat, 18 Feb 2017 02:49:38 -0800 (PST)
In-Reply-To: <c8cdaef4-3de2-139d-5339-c5ad5c81fd4b@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Micha=c5=82_Zegan?= <webczat_200@poczta.onet.pl>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Am 18.02.2017 um 11:37 schrieb Heiner Kallweit:
> Am 18.02.2017 um 04:44 schrieb Michał Zegan:
>> Hello Heiner,
>>
>> W dniu 16.02.2017 o 20:42, Heiner Kallweit pisze:
>>> This clk_disable_unprepare isn't right here. At first the condition
>>> should be "if (ret)" as the disable/unprepare is supposed to be
>>> executed if the previous command fails.
>>> And if the previous command fails and meson_mmc_clk_init returns
>>> an error, then probe jumps to label free_host where we have this
>>> disable/unprepare already.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>> v2:
>>> - extended commit message
>>> ---
>>>  drivers/mmc/host/meson-gx-mmc.c | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index 68e76fa8..850b0152 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -320,11 +320,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>>  	/* Get the nearest minimum clock to 400KHz */
>>>  	host->mmc->f_min = clk_round_rate(host->cfg_div_clk, 400000);
>>>  
>>> -	ret = meson_mmc_clk_set(host, host->mmc->f_min);
>>> -	if (!ret)
>>> -		clk_disable_unprepare(host->cfg_div_clk);
>>> -
>>> -	return ret;
>>> +	return meson_mmc_clk_set(host, host->mmc->f_min);
>>>  }
>>>  
>>>  static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>
>>
>> I see one problem here.
>> As you said, if the previous command (that is the meson_mmc_clk_set
>> function call) fails, then the whole meson_mmc_clk_init returns an error
>> value, and meson_mmc_probe jumps to free_host and disables the clock there.
>> But what happens if the clk_prepare_enable is the line that fails? in
>> this case, the function returns an error value too, and in the free_host
>> meson_mmc_probe tries to disable the clock that is not enabled, and that
>> probably results in a kernel warning because you tried to disable a
>> disabled clock.
>> I was preparing a patch to disable clocks in the probe function only if
>> they were enabled before, but then the meson_mmc_clk_init function
>> remains a problem, because we don't know if the clock was enabled
>> successfully or not when it returns an error.
>>
> Thanks for pointing out, you're right. The solution however should be
> quite easy. I meson_mmc_clk_init we just change the condition of
> the disable/unprepare to "if (ret)" and in probe we remove this
> disable/unprepare from the error path.
> 
This was a little too fast, it's not that easy. But I'll come up with
a changed version.

