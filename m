From: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] mmc: dw_mmc: add quirk for data over interrupt timeout
Date: Thu, 20 Nov 2014 17:33:17 +0800
Message-ID: <546DB55D.90503@rock-chips.com>
References: <1415970338-2637-1-git-send-email-addy.ke@rock-chips.com> <54660120.50305@samsung.com> <546A93B0.1040506@rock-chips.com> <546BF0D2.3000600@samsung.com> <546C310D.5040702@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <546C310D.5040702-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lintao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, chenfen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi, Jaehoon

On 2014/11/19 13:56, addy ke wrote:
> Hi Jaehoon
>=20
> On 2014/11/19 09:22, Jaehoon Chung Wrote:
>> Hi, Addy.
>>
>> On 11/18/2014 09:32 AM, Addy wrote:
>>>
>>> On 2014=E5=B9=B411=E6=9C=8814=E6=97=A5 21:18, Jaehoon Chung wrote:
>>>> Hi, Addy.
>>>>
>>>> Did you use the DW_MCI_QUIRK_IDMAC_DTO?
>>>> I'm not sure, but i wonder if you get what result when you use abo=
ve quirk.
>>>
>>> DW_MCI_QUIRK_IDMAC_DTO is only for version2.0 or below.
>>>         /*
>>>          * DTO fix - version 2.10a and below, and only if internal =
DMA
>>>          * is configured.
>>>          */
>>>         if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO) {
>>>                 if (!pending &&
>>>                     ((mci_readl(host, STATUS) >> 17) & 0x1fff))
>>>                         pending |=3D SDMMC_INT_DATA_OVER;
>>>         }
>>>
>>> It meams that if interrupt comes, but pending =3D 0 && FIFO_COUNT(b=
it17-29) !=3D0,
>>> then force to set SDMMC_INT_DATA_OVER.
>>> But in our case, FIFO_COUNT =3D 0 (STATUS register value is 0xad06)=
=2E This is
>>> because that the card does not send data to host. So there is no in=
terrupts come,
>>> and interrupt handle function(dw_mci_interrupt) will not be called.=
 So we need a
>>> timer to handle this case.
>>>
>>> So I think  SDMMC_INT_DATA_OVER is not suitable for this case, and =
we need a new
>>> quirk.
>>>
>>>>
>>>> And i will check more this patch at next week.
>>>>
>>>> Thanks for your efforts.
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>>>> On 11/14/2014 10:05 PM, Addy Ke wrote:
>>>>> From: Addy <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>>>
>>>>> This patch add a new quirk to notify the driver to teminate
>>>>> current transfer and report a data timeout to the core,
>>>>> if data over interrupt does NOT come within the given time.
>>>>>
>>>>> dw_mmc call mmc_request_done func to finish transfer depends on
>>>>> data over interrupt. If data over interrupt does not come in
>>>>> sending data state, the current transfer will be blocked.
>>>>>
>>>>> But this case really exists, when driver reads tuning data from
>>>>> card on rk3288-pink2 board. I measured waveforms by oscilloscope
>>>>> and found that card clock was always on and data lines were alway=
s
>>>>> holded high level in sending data state. This is the cause that
>>>>> card does NOT send data to host.
>>>>>
>>>>> According to synopsys designware databook, the timeout counter is
>>>>> started only after the card clock is stopped.
>>>>>
>>>>> So if card clock is always on, data read timeout interrupt will N=
OT come,
>>>>> and if data lines are always holded high level, all data-related
>>>>> interrupt such as start-bit error, data crc error, data over inte=
rrupt,
>>>>> end-bit error, and so on, will NOT come too.
>>>>>
>>>>> So driver can't get the current state, it can do nothing but wait=
 for.
>>>>>
>>>>> This patch is based on https://patchwork.kernel.org/patch/5227941=
/
>>>>>
>>>>> Signed-off-by: Addy <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>>> ---
>>>>>   drivers/mmc/host/dw_mmc.c  | 47 +++++++++++++++++++++++++++++++=
++++++++++++++-
>>>>>   include/linux/mmc/dw_mmc.h |  5 +++++
>>>>>   2 files changed, 51 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.=
c
>>>>> index b4c3044..3960fc3 100644
>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>> @@ -1448,6 +1448,17 @@ static int dw_mci_data_complete(struct dw_=
mci *host, struct mmc_data *data)
>>>>>       return data->error;
>>>>>   }
>>>>>   +static inline void dw_mci_dto_start_monitor(struct dw_mci *hos=
t)
>>>>> +{
>>>>> +    unsigned int data_tmout_clks;
>>>>> +    unsigned int data_tmout_ms;
>>>>> +
>>>>> +    data_tmout_clks =3D (mci_readl(host, TMOUT) >> 8);
>>>>> +    data_tmout_ms =3D (data_tmout_clks * 1000 / host->bus_hz) + =
250;
>>
>> What's 250? And how about using the DIV_ROUND_UP?=20
>>
> 250ms is only for more timeout.
> maybe data timeout read from TMOUT register is enough.
> So, I will remove 250.
> new code:
> data_tmout_clks =3D (mci_readl(host, TMOUT) >> 8);
> data_tmout_ms =3D DIV_ROUND_UP(data_tmout_clks * 100, host->bus_hz);
> Is right?
>=20
>>>>> +
>>>>> +    mod_timer(&host->dto_timer, jiffies + msecs_to_jiffies(data_=
tmout_ms));
>>>>> +}
>>>>> +
>>>>>   static void dw_mci_tasklet_func(unsigned long priv)
>>>>>   {
>>>>>       struct dw_mci *host =3D (struct dw_mci *)priv;
>>>>> @@ -1522,8 +1533,11 @@ static void dw_mci_tasklet_func(unsigned l=
ong priv)
>>>>>               }
>>>>>                 if (!test_and_clear_bit(EVENT_XFER_COMPLETE,
>>>>> -                        &host->pending_events))
>>>>> +                        &host->pending_events)) {
>>>>> +                if (host->quirks & DW_MCI_QUIRK_DTO_TIMER)
>>>>> +                    dw_mci_dto_start_monitor(host);
>>
>> if timer is starting at only here, dw_mci_dto_start_monitor() doesn'=
t need.
>>
> Ok, I will change it in the next patch.
>>>>>                   break;
>>>>> +            }
>>>>>                 set_bit(EVENT_XFER_COMPLETE, &host->completed_eve=
nts);
>>>>>   @@ -2115,6 +2129,9 @@ static irqreturn_t dw_mci_interrupt(int i=
rq, void *dev_id)
>>>>>           }
>>>>>             if (pending & SDMMC_INT_DATA_OVER) {
>>>>> +            if (host->quirks & DW_MCI_QUIRK_DTO_TIMER)
>>>>> +                del_timer(&host->dto_timer);
>>>>> +
>>>>>               mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
>>>>>               if (!host->data_status)
>>>>>                   host->data_status =3D pending;
>>>>> @@ -2502,6 +2519,28 @@ ciu_out:
>>>>>       return ret;
>>>>>   }
>>>>>   +static void dw_mci_dto_timer(unsigned long arg)
>>>>> +{
>>>>> +    struct dw_mci *host =3D (struct dw_mci *)arg;
>>
>> I prefer to use the "data" instead of "arg"
>>
> Ok, I will change it in the next patch.
>>>>> +
>>>>> +    switch (host->state) {
>>>>> +    case STATE_SENDING_DATA:
>>>>> +    case STATE_DATA_BUSY:
>>>>> +        /*
>>>>> +        * If data over interrupt does NOT come in sending data s=
tate,
>>>>> +        * we should notify the driver to teminate current transf=
er
>> teminate/terminate?
>>
> Am, I will change it in the next patch.
>>>>> +        * and report a data timeout to the core.
>>>>> +        */
>>>>> +        host->data_status =3D SDMMC_INT_DRTO;
>>>>> +        set_bit(EVENT_DATA_ERROR, &host->pending_events);
>>>>> +        set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
>>
>> Dose it need to set EVENT_DATA_COMPLETE?
>>
> Yes, it is nessarry!
> If not, dw_mci_data_complete function will not be called in my test.
> Analysis as follows:
> After host recevied command response, driver call tasklet_schedule to
> set EVENT_CMD_COMPLETE, change state to STATE_SENDING_DATA, and call
> mod_timer. Because there is no any interrupts come in this case,
> tasklet_schedule function will not be called until dw_mci_timer is ca=
lled.
>=20
> dw_mci_timer-->
> tasklet_schedule-->
> dw_mci_tasklet_func-->
> state =3D=3D STATE_SENDING_DATA  and EVENT_DATA_ERROR-->
> dw_mci_stop_dma, set EVENT_XFER_COMPLETE, send_stop_abort, state =3D =
STATE_DATA_ERROR, and then break;-->
> check state again -->
> state =3D=3D STATE_DATA_ERROR, if it NOT set EVENT_DATA_COMPLETE in d=
w_mci_timer goto 1), else goto 2) -->
>=20
>=20
> 1) in case STATE_DATA_BUSY, there does nothing but break, and dw_mci_=
data_complete and dw_mci_request_end
>    will not be called. then mmc blocks.
>=20
> 2) in case STATE_DATA_BUSY, becase EVENT_DATA_COMPLETE is set, dw_mci=
_data_complete and dw_mci_request_end
>    will be called to report error to the core.
>=20
>=20
>=20
>>>>> +        tasklet_schedule(&host->tasklet);
>>>>> +        break;
>>>>> +    default:
>>>>> +        break;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>   #ifdef CONFIG_OF
>>>>>   static struct dw_mci_of_quirks {
>>>>>       char *quirk;
>>>>> @@ -2513,6 +2552,9 @@ static struct dw_mci_of_quirks {
>>>>>       }, {
>>>>>           .quirk    =3D "disable-wp",
>>>>>           .id    =3D DW_MCI_QUIRK_NO_WRITE_PROTECT,
>>>>> +    }, {
>>>>> +        .quirk    =3D "dto-timer",
>>>>> +        .id    =3D DW_MCI_QUIRK_DTO_TIMER,
>>>>>       },
>>
>> Well, this is s/w timer, so i'm not sure this can be merged into dt-=
file.
>> If this is generic solution, we can add s/w timer by default. how ab=
out?
> ok, I will change it in the next patch.
>=20
We got the reply from synopsys today:
 There are two counters but both use the same value of [31:8] bits.
 Data timeout counter doesn=E2=80=99t wait for stop clock and you shoul=
d get DRTO even when the clock is not stopped.
 Host Starvation timeout counter is triggered with stop clock condition=
=2E

It seems that if card does not send data to host, DRTO interrupt will c=
ome.
But I really have NOT gotten DRTO interrupt and DTO interrupt in RK3X s=
oc.
Is there other SOC which have the same problem?

If not, I think we need a quirk for it.


> And is there somewhere need to call del_timer?
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>>>   };
>>>>>   @@ -2654,6 +2696,9 @@ int dw_mci_probe(struct dw_mci *host)
>>>>>         spin_lock_init(&host->lock);
>>>>>       INIT_LIST_HEAD(&host->queue);
>>>>> +    if (host->quirks & DW_MCI_QUIRK_DTO_TIMER)
>>>>> +        setup_timer(&host->dto_timer,
>>>>> +                dw_mci_dto_timer, (unsigned long)host);
>>>>>         /*
>>>>>        * Get the host data width - this assumes that HCON has bee=
n set with
>>>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mm=
c.h
>>>>> index 42b724e..2477813 100644
>>>>> --- a/include/linux/mmc/dw_mmc.h
>>>>> +++ b/include/linux/mmc/dw_mmc.h
>>>>> @@ -98,6 +98,7 @@ struct mmc_data;
>>>>>    * @irq_flags: The flags to be passed to request_irq.
>>>>>    * @irq: The irq value to be passed to request_irq.
>>>>>    * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
>>>>> + * @dto_timer: Timer for data over interrupt timeout.
>>>>>    *
>>>>>    * Locking
>>>>>    * =3D=3D=3D=3D=3D=3D=3D
>>>>> @@ -196,6 +197,8 @@ struct dw_mci {
>>>>>       int            irq;
>>>>>         int            sdio_id0;
>>>>> +
>>>>> +    struct timer_list    dto_timer;
>>>>>   };
>>>>>     /* DMA ops for Internal/External DMAC interface */
>>>>> @@ -220,6 +223,8 @@ struct dw_mci_dma_ops {
>>>>>   #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION    BIT(3)
>>>>>   /* No write protect */
>>>>>   #define DW_MCI_QUIRK_NO_WRITE_PROTECT        BIT(4)
>>>>> +/* Timer for data over interrupt timeout */
>>>>> +#define DW_MCI_QUIRK_DTO_TIMER            BIT(5)
>>>>>     /* Slot level quirks */
>>>>>   /* This slot has no write protect */
>>>>>
>>>>
>>>>
>>>>
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
