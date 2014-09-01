From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 03/12] clk: Add a function to retrieve phase
Date: Mon, 01 Sep 2014 13:27:28 +0200
Message-ID: <54045820.7080102@redhat.com>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com> <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com> <5402F5D6.4080100@redhat.com> <20140901102026.GL15297@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbaIAL2U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Sep 2014 07:28:20 -0400
In-Reply-To: <20140901102026.GL15297@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi,

On 09/01/2014 12:20 PM, Maxime Ripard wrote:
> Hi,
> 
> On Sun, Aug 31, 2014 at 12:15:50PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 08/30/2014 10:03 PM, Maxime Ripard wrote:
>>> The current phase API doesn't look into the actual hardware to get the phase
>>> value, but will rather get it from a variable only set by the set_phase
>>> function.
>>>
>>> This will cause issue when the client driver will never call the set_phase
>>> function, where we can end up having a reported phase that will not match what
>>> the hardware has been programmed to by the bootloader or what phase is
>>> programmed out of reset.
>>>
>>> Add a new get_phase function for the drivers to implement so that we can get
>>> this value.
>>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>  drivers/clk/clk.c            | 17 ++++++++++++++---
>>>  include/linux/clk-provider.h |  5 +++++
>>>  2 files changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index d87661af0c72..7dbceca694f1 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -1797,8 +1797,8 @@ out:
>>>   * clk_get_phase - return the phase shift of a clock signal
>>>   * @clk: clock signal source
>>>   *
>>> - * Returns the phase shift of a clock node in degrees, otherwise returns
>>> - * -EERROR.
>>> + * Returns the phase shift of a clock node in degrees. Any negative
>>> + * values are errors.
>>>   */
>>>  int clk_get_phase(struct clk *clk)
>>>  {
>>> @@ -1808,7 +1808,18 @@ int clk_get_phase(struct clk *clk)
>>>  		goto out;
>>>  
>>>  	clk_prepare_lock();
>>> -	ret = clk->phase;
>>> +
>>> +	if (clk->phase) {
>>> +		ret = clk->phase;
>>> +		goto out_unlock;
>>> +	}
>>
>> 0 is a valid phase, so this will cause the phase to
>> be read from the hardware each time if the phase is 0.
>>
>> Perhaps make clk->phase signed (if it is not already), init it
>> to -1, and check for it not being -1 ?
> 
> Yeah, I'm not really proud of this code either, but yours would expose
> this -1 into debugfs, so I'm not sure it's really better :) 
> 
> (with -1 being a valid phase too)

According to the comments in the patch adding the original phase functions
valid values are 0 - 359. And you could use clk_get_phase from the debugfs
code.

Regards,

Hans
