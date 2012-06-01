From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2] MMC: core: cap MMC card timeouts at 2 seconds.
Date: Fri, 01 Jun 2012 11:35:54 +0300
Message-ID: <4FC87EEA.5010707@intel.com>
References: <1338226278-13336-1-git-send-email-torne@google.com> <1338258732.20487.171.camel@deadeye>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1338258732.20487.171.camel@deadeye>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: "Torne (Richard Coles)" <torne@google.com>, cjb@laptop.org, linus.walleij@linaro.org, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 29/05/12 05:32, Ben Hutchings wrote:
> On Mon, 2012-05-28 at 18:31 +0100, Torne (Richard Coles) wrote:
>> From: "Torne (Richard Coles)" <torne@google.com>
>>
>> MMC CSD info can specify very large, ridiculous timeouts, big enough to
>> overflow timeout_ns on 32-bit machines. This can result in the card
>> timing out on every operation because the wrapped timeout value is far
>> too small.
>>
>> Fix the overflow by capping the result at 2 seconds.  Cards specifying
>> longer timeouts are almost certainly insane, and host controllers
>> generally cannot support timeouts that long in any case.
>>
>> 2 seconds should be plenty of time for any card to actually function;
>> the timeout calculation code is already using 1 second as a "worst case"
>> timeout for cards running in SPI mode.
> 
> Needs a 'Signed-off-by'.
> 
>> ---
>>  drivers/mmc/core/core.c |   11 ++++++++++-
>>  1 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 0b6141d..3b4a9fc 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -512,7 +512,16 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>>  	if (data->flags & MMC_DATA_WRITE)
>>  		mult <<= card->csd.r2w_factor;
>>  
>> -	data->timeout_ns = card->csd.tacc_ns * mult;
>> +	/*
>> +	 * The timeout in nanoseconds may overflow with some cards. Cap it at
>> +	 * two seconds both to avoid the overflow and also because host
>> +	 * controllers cannot generally generate timeouts that long anyway.
>> +	 */
>> +	if (card->csd.tacc_ns <= (2 * NSEC_PER_SEC) / mult)
>> +		data->timeout_ns = card->csd.tacc_ns * mult;
>> +	else
>> +		data->timeout_ns = 2 * NSEC_PER_SEC;
> 
> We clearly need to guard against overflow here, and this is the correct
> way to clamp the multiplication.  I can't speak as to whether 2 seconds
> is the right limit.

The host controllers I have looked at have a limit of around 2.5 seconds.

But why not just use the size of the type as the limit? e.g.

	if (card->csd.tacc_ns <= UINT_MAX / mult)
		data->timeout_ns = card->csd.tacc_ns * mult;
	else
		data->timeout_ns = UINT_MAX;

> 
> Ben.
> 
>>  	data->timeout_clks = card->csd.tacc_clks * mult;
>>  
>>  	/*
> 
