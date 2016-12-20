From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/4] mmc: mmc: Add change to set controller to HS400
 frequency in enhanced strobe
Date: Tue, 20 Dec 2016 19:03:21 +0800
Message-ID: <1419cbfe-5f37-f300-ca6e-7ee39c1d1e29@rock-chips.com>
References: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
 <1482213199-29152-3-git-send-email-riteshh@codeaurora.org>
 <5a9ad9e8-6fc5-1a33-6119-7c411df4b6e0@rock-chips.com>
 <1412bf82-6292-20a5-3086-c8dccae930a4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:41027 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbcLTLDu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 06:03:50 -0500
In-Reply-To: <1412bf82-6292-20a5-3086-c8dccae930a4@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org

On 2016/12/20 18:33, Ritesh Harjani wrote:
> Hi Shawn,
>
> On 12/20/2016 12:59 PM, Shawn Lin wrote:
>> On 2016/12/20 13:53, Ritesh Harjani wrote:
>>> Currently mmc_select_hs400es is not setting the desired frequency
>>> before sending switch command. This makes CMD13 to timeout on
>>> some controllers.
>>> Thus add a change to set the desired HS400 frequency
>>> in mmc_select_hs400es when the timing is switched to HS400.
>>
>> What is the desired HS400 freq? I guess it is 200MHz, right?
>>
>> Well, per the spec, it just say "host *may* changes frequency to
>> <= 200Mhz". So before setting timing to MMC_TIMING_MMC_HS400, we
>> already reach ext_csd.hs_max_dtr. So it should meet the spec. If
>> the fact that some controllers would see CMD13 timeout here, I guess
>> you wouldn't let folks add max-frequency to the DT as if the max freq
>> is set to just lower than your *desired HS400 freq* , it the same
>> failure result even you add this patch, right?
>>
>> the root cause the controllers see failure for CMD13 is it didn't
>> configure the right delay phase or something similar to fit the timing
>> under the freq of hs_max_dtr, I guess.
> Actually this may be limitation of sdhc msm controller that it cannot
> work at lower frequency while in HS400 mode. I would have to see more on
> this to confirm on why this limitation is there (mostly it was with some
> DLL limitation).
> In that case maybe I should not generalize this for other controllers.
>
>
> But still the below code change to set the bus_speed after setting the
> timing should be fine right ? Since host controller may as well change
> the frequency to 200MHz.

maybe not, I was guessing what would happend when folks add
max-frequency = <100000000> as well as mmc-hs400-enhanced-strobe in
the DT? It won't work for your case. So the question is how you would
make that case work?

>
> Do you think the below change is fine in this sense? I can change the
> commit message to just -
> "set both timing mode and frequency before sending CMD13 in
> mmc_select_hs400es."
>
> Or do you see any other approach to this ?
>

I haven't had clear thought about how to deal with it but
I guess you are not alone for this case maybe. Now there
will be more and more mmc controllers using PHY or DLL and
some more special limitions is ineluctable, so we need to
discuss a more general/legit way to make it work.

Your patch is a good begin to open this topic. :)
I would like to hear some input from Ulf and Adian.

>
> Regards
> Ritesh
>
>>
>>>
>>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>>> ---
>>>  drivers/mmc/core/mmc.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index b61b52f9..eb69497 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1329,6 +1329,7 @@ static int mmc_select_hs400es(struct mmc_card
>>> *card)
>>>
>>>      /* Set host controller to HS400 timing and frequency */
>>>      mmc_set_timing(host, MMC_TIMING_MMC_HS400);
>>> +    mmc_set_bus_speed(card);
>>>
>>>      /* Controller enable enhanced strobe function */
>>>      host->ios.enhanced_strobe = true;
>>>
>>
>>
>


-- 
Best Regards
Shawn Lin

