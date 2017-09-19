From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH/RFT] mmc: meson-gx: include tx phase in the tuning process
Date: Tue, 19 Sep 2017 20:54:01 +0200
Message-ID: <d9c99f1e-bfe4-cdf7-bbfa-fc54837552e2@gmail.com>
References: <b31253d8-38a3-dd25-1d74-6afde6ae8362@gmail.com>
 <20170918134431.17520-1-jbrunet@baylibre.com>
 <3fd34a04-9a22-83e7-fb48-833b72bbea9f@gmail.com>
 <1505819337.2703.40.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35846 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdISSyN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Sep 2017 14:54:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id g50so270916wra.3
        for <linux-mmc@vger.kernel.org>; Tue, 19 Sep 2017 11:54:12 -0700 (PDT)
In-Reply-To: <1505819337.2703.40.camel@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

Am 19.09.2017 um 13:08 schrieb Jerome Brunet:
> On Mon, 2017-09-18 at 21:11 +0200, Heiner Kallweit wrote:
>> Am 18.09.2017 um 15:44 schrieb Jerome Brunet:
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-
>>> mmc.c
>>> index c885c2d4b904..0254d8bfd536 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -717,6 +717,22 @@ static int meson_mmc_clk_phase_tuning(struct mmc_host
>>> *mmc, u32 opcode,
>>>  static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>  {
>>>  	struct meson_host *host = mmc_priv(mmc);
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * If this is the initial tuning, try to get a sane Rx starting
>>> +	 * phase before doing the actual tuning.
>>> +	 */
>>> +	if (!mmc->doing_retune) {
>>> +		ret = meson_mmc_clk_phase_tuning(mmc, opcode, host-
>>>> rx_clk);
>>> +
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->tx_clk);
>>> +	if (ret)
>>> +		return ret;
>>>  
>>>  	return meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
>>>  }
>>> -- 2.13.5
>>
>> Unfortunately this still doesn't fix the issue here.
>> Tuning rx and tx clk sequentially assumes both are independent, what they
>> IMHO are not. So meybe we have to check all combinations of rx/tx clk phase.
> 
> Interesting, I would be curious to know what tuning value you ended with,
> compared to the "hard-coded' working value you have set.
> 
> You can get that fairly easily now, using CCF in debugfs, in
> <debugfs>/clk/clk_summary, the different phase are reported
> 
This gives me:

core phase: 180
rx phase: 0
tx phase: 270

And I end up with a corrupted root file system.

> What makes you think that tx and rx phase depends on one another ?
> I have done a lot of tests on all the phase different settings while working on
> this series and could see that:
> 
> 1) For a fixed Tx and Core phase, Rx phase tuning tends to give a constant
> result
> 2) For a fixed Tx, Rx phase tuning tends to rotate with the core phase
> 3) For a fixed Core phase, Rx phase tuning tends to remain constant for any
> values of Tx phase
> 
>>From what I understand of the HW, this would make sense:
> * Tx phase would be the phase at which the data are sent compared to the core
> clock
> * Rx phase would be the phase at which the data are sampled compared to the core
> clock
> 
> This would make me conclude that both Tx and Rx phases depends on the core phase
> but are independent of one another. Of course, if you have evidence showing
> otherwise, I'm happy to reconsider.
> ATM, I don't see the added value of testing all the combination.
> 
> Another thing to consider is that, with the current driver, we set the Tx and Rx
> with a precision of 30 degrees -> 12 possible phase settings.
> 
> * 2 sequential tuning => 24 test
> * all combination of 2 phases => 144 test
> 
> Also, remember that this tuning is as much based on the working tuning point as
> it is on the failing ones. I looks for the center of the tuning window, so
> failing tests are very valuable. Looking for all the combination, you would have
> you look for this "center" in 2D ... not impossible, but complex and annoying. 
>   
> 
>>
> 
> 

