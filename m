From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCHv2 05/10] mmc: dw_mmc: call the dw_mci_prep_stop_abort() by
 default
Date: Thu, 17 Nov 2016 15:49:55 +0800
Message-ID: <d4b0cab4-8db3-052b-13aa-ecd5765aef97@rock-chips.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <20161115101232.3854-6-jh80.chung@samsung.com>
 <CGME20161116091850epcas5p43ee5a8003c36321f4266c5942bd42060@epcas5p4.samsung.com>
 <6d7625c0-8588-5d11-7475-38fa611d8614@rock-chips.com>
 <868dbb62-4b0d-3492-0b13-093ce63c5cde@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <868dbb62-4b0d-3492-0b13-093ce63c5cde-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

在 2016/11/17 13:05, Jaehoon Chung 写道:
> On 11/16/2016 06:16 PM, Shawn Lin wrote:
>> 在 2016/11/15 18:12, Jaehoon Chung 写道:
>>> stop_cmdr should be set to values relevant to stop command.
>>> It migth be assigned to values whatever there is mrq->stop or not.
>>> Then it doesn't need to use dw_mci_prepare_command().
>>> It's enough to use the prep_stop_abort for preparing stop command.
>>>
>>
>> Have you considered to clean up the logic of preparing abort cmd
>> within dw_mci_prepare_command?
>
> I have considered this..but i didn't check fully for this logic.
> I think it's possible to clean and make more simpler than now.
>
> how about thinking more after applying these patch-set? :)

it's okay :)

>
> Best Regards,
> Jaehoon Chung
>
>>
>>
>>         if (cmd->opcode == MMC_STOP_TRANSMISSION ||
>>             cmd->opcode == MMC_GO_IDLE_STATE ||
>>             cmd->opcode == MMC_GO_INACTIVE_STATE ||
>>             (cmd->opcode == SD_IO_RW_DIRECT &&
>>              ((cmd->arg >> 9) & 0x1FFFF) == SDIO_CCCR_ABORT))
>>                 cmdr |= SDMMC_CMD_STOP;
>>
>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>> Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c | 15 +++++----------
>>>  1 file changed, 5 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 3cda68c..12e1107 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -385,7 +385,7 @@ static void dw_mci_start_command(struct dw_mci *host,
>>>
>>>  static inline void send_stop_abort(struct dw_mci *host, struct mmc_data *data)
>>>  {
>>> -    struct mmc_command *stop = data->stop ? data->stop : &host->stop_abort;
>>> +    struct mmc_command *stop = &host->stop_abort;
>>>
>>>      dw_mci_start_command(host, stop, host->stop_cmdr);
>>>  }
>>> @@ -1277,10 +1277,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>>>          spin_unlock_irqrestore(&host->irq_lock, irqflags);
>>>      }
>>>
>>> -    if (mrq->stop)
>>> -        host->stop_cmdr = dw_mci_prepare_command(slot->mmc, mrq->stop);
>>> -    else
>>> -        host->stop_cmdr = dw_mci_prep_stop_abort(host, cmd);
>>> +    host->stop_cmdr = dw_mci_prep_stop_abort(host, cmd);
>>>  }
>>>
>>>  static void dw_mci_start_request(struct dw_mci *host,
>>> @@ -1890,8 +1887,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>>>              if (test_and_clear_bit(EVENT_DATA_ERROR,
>>>                             &host->pending_events)) {
>>>                  dw_mci_stop_dma(host);
>>> -                if (data->stop ||
>>> -                    !(host->data_status & (SDMMC_INT_DRTO |
>>> +                if (!(host->data_status & (SDMMC_INT_DRTO |
>>>                                 SDMMC_INT_EBE)))
>>>                      send_stop_abort(host, data);
>>>                  state = STATE_DATA_ERROR;
>>> @@ -1927,8 +1923,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>>>              if (test_and_clear_bit(EVENT_DATA_ERROR,
>>>                             &host->pending_events)) {
>>>                  dw_mci_stop_dma(host);
>>> -                if (data->stop ||
>>> -                    !(host->data_status & (SDMMC_INT_DRTO |
>>> +                if (!(host->data_status & (SDMMC_INT_DRTO |
>>>                                 SDMMC_INT_EBE)))
>>>                      send_stop_abort(host, data);
>>>                  state = STATE_DATA_ERROR;
>>> @@ -2004,7 +1999,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>>>              host->cmd = NULL;
>>>              host->data = NULL;
>>>
>>> -            if (mrq->stop)
>>> +            if (!mrq->sbc && mrq->stop)
>>>                  dw_mci_command_complete(host, mrq->stop);
>>>              else
>>>                  host->cmd_status = 0;
>>>
>>
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
