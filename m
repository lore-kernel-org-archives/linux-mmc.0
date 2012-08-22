From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 09/10] mmc: omap_hsmmc: convert from IP timer to hrtimer
Date: Wed, 22 Aug 2012 16:08:17 +0530
Message-ID: <CANfBPZ-VbkDRADNgecyXSqj3YH-mAZcihEm2YRrMW8_RWpORyQ@mail.gmail.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
 <1345229550-8672-10-git-send-email-svenkatr@ti.com> <20120821104248.GR10347@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120821104248.GR10347@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, vishp@ti.com
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 21, 2012 at 4:12 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Sat, Aug 18, 2012 at 12:22:29AM +0530, Venkatraman S wrote:
>> omap hsmmc controller IP has an inbuilt timer that can be programmed to
>                                   ^^^^^^^
>                                   built-in
>> guard against unresponsive operations. But it's range is very narrow,
>                                              ^^^^
>                                              its
>
>
>> and it's maximum countable time is a few seconds.
>       ^^^^
>       its
>

Will fix.

>
>> Card maintenance operations like BKOPS and SECURE DISCARD and long
>> stream writes like packed command require timers of order of
>> several minutes.
>> So get rid of using the IP timer entirely and use kernel's hrtimer
>> functionality for guarding the device operations.
>> As part of this change, a workaround that disabled timeouts for
>> MMC_ERASE commands is removed, and the arbitary timing of 100ms
>> is used only when the timeout is not explicitly specified by core.
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> ---
>>  drivers/mmc/host/omap_hsmmc.c | 96 ++++++++++++++++++++++---------------------
>>  1 file changed, 50 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 9afdd20..8f7cebc 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -79,7 +79,7 @@
>>  #define CLKD_SHIFT           6
>>  #define DTO_MASK             0x000F0000
>>  #define DTO_SHIFT            16
>> -#define INT_EN_MASK          0x307F0033
>> +#define INT_EN_MASK          0x306E0033
>
> not related to this patch in particular, but it would be nice if this
> was converted to something more meaningfull, like ORing a bunch of bit
> defines.
>

Sure. Good to do now as part of the change.

>>  #define BWR_ENABLE           (1 << 4)
>>  #define BRR_ENABLE           (1 << 5)
>>  #define DTO_ENABLE           (1 << 20)
>> @@ -160,6 +160,7 @@ struct omap_hsmmc_host {
>>       unsigned int            dma_sg_idx;
>>       unsigned char           bus_mode;
>>       unsigned char           power_mode;
>> +     unsigned int            ns_per_clk_cycle;
>>       int                     suspended;
>>       int                     irq;
>>       int                     use_dma, dma_ch;
>> @@ -172,6 +173,7 @@ struct omap_hsmmc_host {
>>       int                     reqs_blocked;
>>       int                     use_reg;
>>       int                     req_in_progress;
>> +     struct hrtimer  guard_timer;
>>       struct omap_hsmmc_next  next_data;
>>
>>       struct  omap_mmc_platform_data  *pdata;
>> @@ -455,10 +457,6 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
>>       else
>>               irq_mask = INT_EN_MASK;
>>
>> -     /* Disable timeout for erases */
>> -     if (cmd->opcode == MMC_ERASE)
>> -             irq_mask &= ~DTO_ENABLE;
>> -
>>       OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>       OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>>       OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
>> @@ -508,6 +506,9 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
>>               && time_before(jiffies, timeout))
>>               cpu_relax();
>>
>> +     if (ios->clock)
>> +             host->ns_per_clk_cycle = DIV_ROUND_UP(NSEC_PER_SEC, ios->clock);
>> +
>>       omap_hsmmc_start_clock(host);
>>  }
>>
>> @@ -824,7 +825,7 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
>>               omap_hsmmc_request_done(host, mrq);
>>               return;
>>       }
>> -
>> +     hrtimer_cancel(&host->guard_timer);
>>       host->data = NULL;
>>
>>       if (!data->error)
>> @@ -859,8 +860,11 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
>>                       cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP10);
>>               }
>>       }
>> -     if ((host->data == NULL && !host->response_busy) || cmd->error)
>> +     if ((host->data == NULL && !host->response_busy) || cmd->error) {
>
> could just go ahead and make this check uniform by:
>
> if ((!host->data && !host->response_busy)) || cmd->error)
>

Ok.

>> +             if (cmd->error != -ETIMEDOUT)
>> +                     hrtimer_cancel(&host->guard_timer);
>>               omap_hsmmc_request_done(host, cmd->mrq);
>> +     }
>>  }
>>
>>  /*
>> @@ -992,7 +996,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>>                       hsmmc_command_incomplete(host, -EILSEQ);
>>
>>               end_cmd = 1;
>> -             if (host->data || host->response_busy) {
>> +             if (data || host->response_busy) {
>
> This doesn't seem like it belongs to $SUBJECT...
>
I thought is was a small fix which didn't warrant a separate patch though.

>>                       end_trans = 1;
>>                       host->response_busy = 0;
>>               }
>> @@ -1292,41 +1296,35 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
>>       return 0;
>>  }
>>
>> -static void set_data_timeout(struct omap_hsmmc_host *host,
>> -                          unsigned int timeout_ns,
>> -                          unsigned int timeout_clks)
>> +static void set_guard_timer(struct omap_hsmmc_host *host,
>> +             unsigned long timeout_ms, unsigned long timeout_ns,
>> +             unsigned int timeout_clks)
>>  {
>> -     unsigned int timeout, cycle_ns;
>> -     uint32_t reg, clkd, dto = 0;
>> +     ktime_t gtime;
>> +     unsigned int sec, nsec;
>>
>> -     reg = OMAP_HSMMC_READ(host->base, SYSCTL);
>> -     clkd = (reg & CLKD_MASK) >> CLKD_SHIFT;
>> -     if (clkd == 0)
>> -             clkd = 1;
>> +     sec = timeout_ms / MSEC_PER_SEC;
>> +     nsec = (timeout_ms % MSEC_PER_SEC) * NSEC_PER_MSEC + timeout_ns;
>>
>> -     cycle_ns = 1000000000 / (clk_get_rate(host->fclk) / clkd);
>> -     timeout = timeout_ns / cycle_ns;
>> -     timeout += timeout_clks;
>> -     if (timeout) {
>> -             while ((timeout & 0x80000000) == 0) {
>> -                     dto += 1;
>> -                     timeout <<= 1;
>> -             }
>> -             dto = 31 - dto;
>> -             timeout <<= 1;
>> -             if (timeout && dto)
>> -                     dto += 1;
>> -             if (dto >= 13)
>> -                     dto -= 13;
>> -             else
>> -                     dto = 0;
>> -             if (dto > 14)
>> -                     dto = 14;
>> -     }
>> +     nsec += timeout_clks * host->ns_per_clk_cycle;
>> +     gtime = ktime_set(sec, nsec);
>>
>> -     reg &= ~DTO_MASK;
>> -     reg |= dto << DTO_SHIFT;
>> -     OMAP_HSMMC_WRITE(host->base, SYSCTL, reg);
>> +     hrtimer_start(&host->guard_timer, gtime, HRTIMER_MODE_REL);
>> +}
>> +
>> +enum hrtimer_restart omap_hsmmc_timedout(struct hrtimer *gtimer)
>
> static ?
>

Right!
