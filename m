From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Fix init_card in 52Mhz
Date: Wed, 30 Sep 2015 16:01:11 +0300
Message-ID: <560BDD17.4060102@intel.com>
References: <1443583688-1952-1-git-send-email-chaotian.jing@mediatek.com>
 <560B9C24.3090209@intel.com> <1443603781.5148.0.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41340 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521AbbI3NEk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Sep 2015 09:04:40 -0400
In-Reply-To: <1443603781.5148.0.camel@mhfsdcap03>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Rudholm <johan.rudholm@axis.com>, Gwendal Grignou <gwendal@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

On 30/09/15 12:03, Chaotian Jing wrote:
> On Wed, 2015-09-30 at 11:24 +0300, Adrian Hunter wrote:
>> On 30/09/15 06:28, Chaotian Jing wrote:
>>> Suppose that we got a data crc error, and it triggers the mmc_reset.
>>> mmc_reset will call mmc_send_status to see if HW reset was supported.
>>> before issue CMD13, it will do retune, and if EMMC was in HS400 mode,
>>> it will reduce frequency to 52Mhz firstly, that results in card init
>>> was doing at 52Mhz, So need ensure frequency is lower than 400Khz when
>>> re-init card.
>>
>> The call to mmc_send_status() was originally only done for mmc_test and
>> doesn't belong in a real reset.  However the test parameter was removed
>> to simplify the code by:
>>
>> commit 83533ab28380f6957af39a7b322e639e42dbdaf1
>> Author: Johan Rudholm <johan.rudholm@axis.com>
>> Date:   Mon Jan 12 15:38:04 2015 +0100
>>
>>     mmc: core: always check status after reset
>>     
>>     Always check if the card is alive after a successful reset. This allows
>>     us to remove mmc_hw_reset_check(), leaving mmc_hw_reset() as the only
>>     card reset interface.
>>     
>>     Signed-off-by: Johan Rudholm <johanru@axis.com>
>>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> IMHO having a test to check whether hw reset actually did reset the card
>> is useful, so I would suggest putting back mmc_hw_reset_check() and
>> removing the check from the non-test path.
>>
>> An alternative is to recognize that we don't want retuning here, and it is
>> unlikely to be needed in the mmc_test case.  So if retuning is needed, just
>> skip the call to mmc_send_status() i.e.
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f2d0c2ae85b1..c3749ba42739 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1938,7 +1938,7 @@ static int mmc_reset(struct mmc_host *host)
>>  	host->ops->hw_reset(host);
>>  
>>  	/* If the reset has happened, then a status command will fail */
>> -	if (!mmc_send_status(card, &status)) {
>> +	if (!host->need_retune && !mmc_send_status(card, &status)) {
>>  		mmc_host_clk_release(host);
>>  		return -ENOSYS;
>>  	}
>>
>> Could then make mmc_test aware of that:
>>  
> 
>> This solution is better, please help to upstream it. Thx!

Then please, make it a patch, and test it and submit it.  You can add:

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>


>> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
>> index b78cf5d403a3..7b105b97be78 100644
>> --- a/drivers/mmc/card/mmc_test.c
>> +++ b/drivers/mmc/card/mmc_test.c
>> @@ -2272,6 +2272,16 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
>>  	if (!mmc_card_mmc(card) || !mmc_can_reset(card))
>>  		return RESULT_UNSUP_CARD;
>>  
>> +	err = mmc_send_status(card, NULL);
>> +	if (err)
>> +		return err;
>> +
>> +	if (host->need_retune) {
>> +		pr_info("%s: cannot test hw reset because retune needed\n",
>> +			mmc_hostname(test->card->host));
>> +		return RESULT_FAIL;
>> +	}
>> +
>>  	err = mmc_hw_reset(host);
>>  	if (!err)
>>  		return RESULT_OK;
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f2d0c2ae85b1..c3749ba42739 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1938,7 +1938,7 @@ static int mmc_reset(struct mmc_host *host)
>>  	host->ops->hw_reset(host);
>>  
>>  	/* If the reset has happened, then a status command will fail */
>> -	if (!mmc_send_status(card, &status)) {
>> +	if (!host->need_retune && !mmc_send_status(card, &status)) {
>>  		mmc_host_clk_release(host);
>>  		return -ENOSYS;
>>  	}
>>
>>
>>
>>
>>>
>>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>>> ---
>>>  drivers/mmc/core/mmc.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index e726903..f2d0c2a 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1945,6 +1945,7 @@ static int mmc_reset(struct mmc_host *host)
>>>  
>>>  	/* Set initial state and call mmc_set_ios */
>>>  	mmc_set_initial_state(host);
>>> +	mmc_set_clock(host, host->f_init);
>>>  	mmc_host_clk_release(host);
>>>  
>>>  	return mmc_init_card(host, card->ocr, card);
>>>
>>
> 
> 
> 

