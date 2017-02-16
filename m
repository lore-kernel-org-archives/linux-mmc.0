From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 13/18] mmc: meson-gx: remove unneeded meson_mmc_clk_set in
 meson_mmc_clk_init
Date: Thu, 16 Feb 2017 08:05:00 +0100
Message-ID: <fcfcdd8c-14bb-5e17-3e21-eee7e219259a@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
 <f891a0bd-62f3-8104-5658-5e8fb2d9e070@gmail.com>
 <m2bmu38dag.fsf@baylibre.com>
 <fc32a3da-35d3-1eb6-d88c-75c412508136@gmail.com>
 <m260kb6max.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33522 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbdBPHHi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 02:07:38 -0500
Received: by mail-wr0-f195.google.com with SMTP id i10so898176wrb.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 23:07:37 -0800 (PST)
In-Reply-To: <m260kb6max.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 16.02.2017 um 00:56 schrieb Kevin Hilman:
> Heiner Kallweit <hkallweit1@gmail.com> writes:
> 
>> Am 15.02.2017 um 20:27 schrieb Kevin Hilman:
>>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>>>
>>>> I don't think this clk_disable_unprepare is right here. We do this
>>>> in meson_mmc_remove what should be sufficient.
>>>
>>> I don't think so, because if _clk_init() fails, then _probe will fail,
>>> and the driver's ->remove() will not be called.
>>>
>> In general, then the condition should be "if (ret)", not "if (!ret)".
>> And if _clk_init() fails, then probe jumps to label free_host,
>> where we have exactly this clk_disable_unprepare(host->cfg_div_clk)
> 
> Then you need to update the changelog, which refers to remove, not the
> cleanup in probe.
> 
Sure ..

> Kevin
> 
>>> Kevin
>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  drivers/mmc/host/meson-gx-mmc.c | 6 +-----
>>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>>> index 74ceda75..39904fb5 100644
>>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>>> @@ -315,11 +315,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>>>  	/* Get the nearest minimum clock to 400KHz */
>>>>  	host->mmc->f_min = clk_round_rate(host->cfg_div_clk, 400000);
>>>>  
>>>> -	ret = meson_mmc_clk_set(host, host->mmc->f_min);
>>>> -	if (!ret)
>>>> -		clk_disable_unprepare(host->cfg_div_clk);
>>>> -
>>>> -	return ret;
>>>> +	return meson_mmc_clk_set(host, host->mmc->f_min);
>>>>  }
>>>>  
>>>>  static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>
> 

