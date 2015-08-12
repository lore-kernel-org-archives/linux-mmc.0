From: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: Re: [PATCH resend 1/3] mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
Date: Wed, 12 Aug 2015 14:40:52 +0200
Message-ID: <55CB3ED4.9000201@schinagl.nl>
References: <cover.1439381423.git.hramrach@gmail.com> <7f9c6f99b31702c02436ef3356b3ebffa4754260.1439381423.git.hramrach@gmail.com> <55CB3CD7.2050200@redhat.com>
Reply-To: oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDDZ7YMYRMGBBV75VSXAKGQERDEHT5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <55CB3CD7.2050200-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, michal.suchanek-vlPZI//2HHjtwjQa/ONI9g@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

While I can't speak for Michal obviously,

I left the debugging bit (in my v2 that i sent 2 minutes ago) as both 
you and Hans where content with it back then and both acked it.

Michal, feel free to send the v3 without the debug info, unless you want 
me to do it ;)

Olliver

On 12-08-15 14:32, Hans de Goede wrote:
> Hi,
>
> On 12-08-15 14:23, michal.suchanek-vlPZI//2HHjtwjQa/ONI9g@public.gmane.org wrote:
>> The 250ms timeout is too short.
>>
>> On my system enabling the oclk takes under 50ms and disabling slightly
>> over 100ms when idle. Under load disabling the clock can take over
>> 350ms.
>>
>> This does not make mmc clock gating look like good option to have on
>> sunxi but the system should not crash with mmc clock gating enabled
>> nonetheless.
>>
>> This patch sets the timeout to 750ms and adds debug prints which show
>> how long enabling/disabling the clock took so more data can be collected
>> from other systems.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> This is a big patch for just changing a timeout, most of this is in
> extra verbosity which IMHO has little value, in the error path w
> know we will have waited aprox 750 ms, so printing the waiting
> time there is not worth all the extra code.
>
> As for adding the warning I'm even less of a big fan of that,
> if we need higher timeouts, we need higher timeouts, spamming the
> kernel logs with that we are actually hitting the higher timeouts
> is not productive IMHO.
>
> Can you please resend this as a one-liner just changing the timeout ?
>
> Regards,
>
> Hans
>
>
>>
>> -- 
>>
>>   - fix formatting
>> ---
>>   drivers/mmc/host/sunxi-mmc.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 4d3e1ff..f808a02 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -595,7 +595,7 @@ static irqreturn_t 
>> sunxi_mmc_handle_manual_stop(int irq, void *dev_id)
>>
>>   static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 
>> oclk_en)
>>   {
>> -    unsigned long expire = jiffies + msecs_to_jiffies(250);
>> +    unsigned long start, end;
>>       u32 rval;
>>
>>       rval = mmc_readl(host, REG_CLKCR);
>> @@ -604,6 +604,8 @@ static int sunxi_mmc_oclk_onoff(struct 
>> sunxi_mmc_host *host, u32 oclk_en)
>>       if (oclk_en)
>>           rval |= SDXC_CARD_CLOCK_ON;
>>
>> +    start = jiffies;
>> +    end = start + msecs_to_jiffies(750);
>>       mmc_writel(host, REG_CLKCR, rval);
>>
>>       rval = SDXC_START | SDXC_UPCLK_ONLY | SDXC_WAIT_PRE_OVER;
>> @@ -611,15 +613,29 @@ static int sunxi_mmc_oclk_onoff(struct 
>> sunxi_mmc_host *host, u32 oclk_en)
>>
>>       do {
>>           rval = mmc_readl(host, REG_CMDR);
>> -    } while (time_before(jiffies, expire) && (rval & SDXC_START));
>> +    } while (time_before(jiffies, end) && (rval & SDXC_START));
>> +    end = jiffies;
>>
>>       /* clear irq status bits set by the command */
>>       mmc_writel(host, REG_RINTR,
>>              mmc_readl(host, REG_RINTR) & ~SDXC_SDIO_INTERRUPT);
>>
>>       if (rval & SDXC_START) {
>> -        dev_err(mmc_dev(host->mmc), "fatal err update clk timeout\n");
>> +        dev_err(mmc_dev(host->mmc),
>> +            "fatal err update oclk timeout. Could not %s in %ims.\n",
>> +            oclk_en ? "enable" : "disable",
>> +            jiffies_to_msecs(end - start));
>>           return -EIO;
>> +    } else {
>> +        int msecs = jiffies_to_msecs(end - start);
>> +        const char *ing = oclk_en ? "enabling" : "disabling";
>> +
>> +        if ((msecs > 150) || (oclk_en && (msecs > 50)))
>> +            dev_warn(mmc_dev(host->mmc),
>> +                 "%s oclk took %ims", ing, msecs);
>> +        else
>> +            dev_dbg(mmc_dev(host->mmc),
>> +                 "%s oclk took %ims", ing, msecs);
>>       }
>>
>>       return 0;
>>
>
