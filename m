From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH RFT] mmc: core: use usleep_range rather than HZ magic in
 mmc_delay()
Date: Thu, 16 Nov 2017 15:59:36 +0800
Message-ID: <2b56ea8c-3040-2c47-41e5-ed52f97ff75e@rock-chips.com>
References: <20171114225520.6793-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFrgO0JRatud5JRDONS=VTNef8WS+qvRAUo1AXep9wMpZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrgO0JRatud5JRDONS=VTNef8WS+qvRAUo1AXep9wMpZg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 2017/11/16 15:47, Ulf Hansson wrote:
> On 14 November 2017 at 23:55, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
>> Documentation/timers/timers-howto.txt recommends to use usleep_range for
>> delays 1-20ms. Let's adhere to it. No need for messing with HZ and still
>> do busy looping these days.
>>

Sorry for chime in this topic but I think for some cases, for instance,
mmc_host_set_uhs_voltage calls mmc_delay and it should guarantee the
delay is accurate, especially for the comment"Keep clock gated for at
least 10 ms, though spec only says 5 ms"

But the usleep_range won't guarantee that, see

https://patchwork.kernel.org/patch/9369963/

It wasn't fixed at the end, so you should carefully modify
this fundamentally.

>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>
>> Here is a more detailed test page for this describing my tests:
>>
>> https://elinux.org/Tests:mmc-delay-refactor
>>
>> I did mainly test the insert/eject cycle because powering up the cards
>> seemed to trigger most delays. Transferring data did not cause any calls
>> to mmc_delay() for me. Please let me know if someone knows a test pattern
>> which should be included before applying this change.
>>
>> Works fine for me on Lager (R-Car H2) and Salvator-X (R-Car M3-W). Testing on
>> other platforms very welcome. This should be independent of the IP core.
>>
>>   drivers/mmc/core/core.h | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 71e6c6d7ceb70d..b2877e2d740fa5 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -62,12 +62,10 @@ void mmc_set_initial_state(struct mmc_host *host);
>>
>>   static inline void mmc_delay(unsigned int ms)
>>   {
>> -       if (ms < 1000 / HZ) {
>> -               cond_resched();
>> -               mdelay(ms);
>> -       } else {
>> +       if (ms <= 20)
>> +               usleep_range(ms * 1000, ms * 1250);
> 
> This means we get usleep_range(20000, 25000) for the worst case.
> 
> Perhaps we want "ms <= 16" instead, thus getting usleep
> usleep_range(16000, 20000) for the worst case? No?
> 
>> +       else
>>                  msleep(ms);
>> -       }
>>   }
> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
