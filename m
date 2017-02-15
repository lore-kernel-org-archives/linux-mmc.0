From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 13/18] mmc: meson-gx: remove unneeded meson_mmc_clk_set in meson_mmc_clk_init
Date: Wed, 15 Feb 2017 15:56:06 -0800
Message-ID: <m260kb6max.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <f891a0bd-62f3-8104-5658-5e8fb2d9e070@gmail.com>
        <m2bmu38dag.fsf@baylibre.com>
        <fc32a3da-35d3-1eb6-d88c-75c412508136@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33928 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755342AbdBOX4J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 18:56:09 -0500
Received: by mail-pf0-f172.google.com with SMTP id e4so546768pfg.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 15:56:08 -0800 (PST)
In-Reply-To: <fc32a3da-35d3-1eb6-d88c-75c412508136@gmail.com> (Heiner
        Kallweit's message of "Wed, 15 Feb 2017 20:38:20 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Am 15.02.2017 um 20:27 schrieb Kevin Hilman:
>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>> 
>>> I don't think this clk_disable_unprepare is right here. We do this
>>> in meson_mmc_remove what should be sufficient.
>> 
>> I don't think so, because if _clk_init() fails, then _probe will fail,
>> and the driver's ->remove() will not be called.
>> 
> In general, then the condition should be "if (ret)", not "if (!ret)".
> And if _clk_init() fails, then probe jumps to label free_host,
> where we have exactly this clk_disable_unprepare(host->cfg_div_clk)

Then you need to update the changelog, which refers to remove, not the
cleanup in probe.

Kevin

>> Kevin
>> 
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/mmc/host/meson-gx-mmc.c | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index 74ceda75..39904fb5 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -315,11 +315,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
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
>> 
