From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH 1/1] mmc: core: Use delayed work in clock gating framework
Date: Mon, 24 Oct 2011 16:46:15 +0530
Message-ID: <4EA548FF.7070707@codeaurora.org>
References: <1319035713-4979-1-git-send-email-sthumma@codeaurora.org> <CACRpkdY1WE8KrFW1qjLJk_sMivicqwDtBVzNDVN6H-3utw0isw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY1WE8KrFW1qjLJk_sMivicqwDtBVzNDVN6H-3utw0isw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On 10/24/2011 12:53 PM, Linus Walleij wrote:
> On Wed, Oct 19, 2011 at 4:48 PM, Sujit Reddy Thumma
> <sthumma@codeaurora.org>  wrote:
>
>> Current clock gating framework disables the MCI clock as soon as the
>> request is completed and enables it when a request arrives. This aggressive
>> clock gating framework when enabled cause following issues:
>>
>> When there are back-to-back requests from the Queue layer, we unnecessarily
>> end up disabling and enabling the clocks between these requests since 8 MCLK
>> clock cycles is a very short duration compared to the time delay between
>> back to back requests reaching the MMC layer. This overhead can effect the
>> overall performance depending on how long the clock enable and disable
>> calls take which is platform dependent. For example on some platforms we
>> can have clock control not on the local processor, but on a different
>> subsystem and the time taken to perform the clock enable/disable can add
>> significant overhead.
>
> OK I see the problem. At one point it was suggested to use the delayed
> disable facilities in runtime PM for avoiding this, but it never materialized.
>
>> Fix this by delaying turning off the clocks by posting request on
>> delayed workqueue. Also cancel the unscheduled pending work, if any,
>> when there is access to card.
>
> (...)
>> @@ -252,10 +252,11 @@ struct mmc_host {
>>         int                     clk_requests;   /* internal reference counter */
>>         unsigned int            clk_delay;      /* number of MCI clk hold cycles */
>>         bool                    clk_gated;      /* clock gated */
>> -       struct work_struct      clk_gate_work; /* delayed clock gate */
>> +       struct delayed_work     clk_gate_work; /* delayed clock gate */
>>         unsigned int            clk_old;        /* old clock value cache */
>>         spinlock_t              clk_lock;       /* lock for clk fields */
>>         struct mutex            clk_gate_mutex; /* mutex for clock gating */
>> +#define MMC_CLK_GATE_DELAY     50              /* in milliseconds*/
>>   #endif
>
> What's the rationale of having this in the middle of the struct
> in the .h-file?
>
> Move it inside the #ifdef in host.c instead, and also provide
> some rationale about the choice of 50 ms.

With my testing on a MSM platform, round-trip delay of 10ms to turn off 
and on the clocks is seen. So I thought 50ms is a reasonable tradeoff. 
There is no specific calculation behind this delay. We just relied on 
the empirical data which again may vary with different platforms.

If you have any suggestions I would be happy to consider that. I am 
planning to increase this to 200ms, any comments on that?

>
> Maybe we should even provide a sysfs or debugfs entry for
> tweaking that value, as has been suggested in the past.
> However that's no big deal for me...

Adding an entry in sysfs seems to be a good solution to tune the 
required delay. I will add this.

>
> Do you have a patch to your msm_sdcc.c that enables the
> gating to take effect as well? Does it solve the problems
> pointed out by Russell when I tried the same type of patch
> to mmci.c?
> http://marc.info/?l=linux-mmc&m=129146545916794&w=2

Looking at the patch that you pointed out, I don't think it is required 
for msm_sdcc.c to enable clock gating. The current code inherently takes 
care of logic that is needed to ensure that MCLK is not turned off until 
any pending register write in the host driver is completed. You might 
want to have a look at set_ios function in 
https://www.codeaurora.org/gitweb/quic/la/?p=kernel/msm.git;a=blob;f=drivers/mmc/host/msm_sdcc.c;h=b5a08d2b58e0cd6d18a8f1041139b6866c0cdc09;hb=refs/heads/msm-3.0
Please let me know if I am still missing anything.

-- 
Thanks & Regards,
Sujit Reddy Thumma
