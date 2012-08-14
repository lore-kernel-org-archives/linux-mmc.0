From: Dmitry Rozhkov <dmitry.rozhkov@jollamobile.com>
Subject: Re: [PATCH] mmc: Adjust timings for power ramping up
Date: Tue, 14 Aug 2012 18:59:29 +0300
Message-ID: <502A75E1.7040709@jollamobile.com>
References: <20120813161921.GA5022@x230> <CAGxe1ZGcfMQXMSZ_a5BqKoEEmr48AD01NU6LGtZEWCiktCnnXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp174.iad.emailsrvr.com ([207.97.245.174]:45815 "EHLO
	smtp174.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab2HNP7c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Aug 2012 11:59:32 -0400
In-Reply-To: <CAGxe1ZGcfMQXMSZ_a5BqKoEEmr48AD01NU6LGtZEWCiktCnnXQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 08/14/2012 04:58 PM, Girish K S wrote:
> On 13 August 2012 11:19, Dmitry Rozhkov <dmitry.rozhkov@jollamobile.com> wrote:
>> According to p6.4.1.1 of the Physical Layer Simplified Specification
>> Ver3.01 the "host needs to keep power line level less than 0.5V and
>> more than 1ms before power ramp up". This patch adds an explicit delay
>> of 10ms just before power rump up.
>>
>> Without this patch some microSD cards (e.g. Kingston 8G Class 10) can't be
>> used as bootable media on some TI OMAP chips at least.
>> See https://bugs.nemomobile.org/show_bug.cgi?id=92 for details.
>>
>> Signed-off-by: Dmitry Rozhkov <dmitry.rozhkov@jollamobile.com>
>> ---
>>   drivers/mmc/core/core.c |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 0b6141d..22b0eb2 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1163,6 +1163,13 @@ static void mmc_power_up(struct mmc_host *host)
>>
>>          mmc_host_clk_hold(host);
>>
>> +       /*
>> +        * According to p6.4.1.1 of the Physical Layer Simplified Specification
>> +        * Ver3.01 the "host needs to keep power line level less than 0.5V and
>> +        * more than 1ms before power ramp up".
>> +        */
>> +       mmc_delay(10);
> can you instead just try giving this delay in mmc_start_host as a
> parameter to mmc_detect_change.
It would be too late. Here is the theory.

The function mmc_power_up currently controls the process of powering up 
as a two-phases process:

0V (initial state) => apply MMC_POWER_UP => delay 10ms until Vdd is 
reached  (first phase) => apply MMC_POWER_ON => delay 10ms for 
initialization sequence to complete (second phase).

It perfectly conforms to the spec V2.00

But the spec V3.01 clarifies now that the process consists of three 
phases actually:
1. keeping reset level voltage (>1ms)
2. power ramp up phase (from 0.1ms to 35ms)
3. initialization sequence (1ms)

See the figure 6-2 on the page 111.

If I add the delay as a parameter to mmc_detect_change in mmc_start_host 
it'd be equal to extending the third phase to 20ms though even 10ms is 
more than enough.

The second things is that it's better to keep this sequence in one 
function for the sake of maintainability.

