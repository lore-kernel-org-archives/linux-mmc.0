From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add quirk for data over interrupt timeout
Date: Wed, 19 Nov 2014 10:22:26 +0900
Message-ID: <546BF0D2.3000600@samsung.com>
References: <1415970338-2637-1-git-send-email-addy.ke@rock-chips.com>
 <54660120.50305@samsung.com> <546A93B0.1040506@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <546A93B0.1040506@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: Addy <addy.ke@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, heiko@sntech.de, olof@lixom.net, dianders@chromium.org, sonnyrao@chromium.org, amstan@chromium.org
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, hl@rock-chips.com, linux-doc@vger.kernel.org, yzq@rock-chips.com, zyw@rock-chips.com, zhangqing@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kever.yang@rock-chips.com, lintao@rock-chips.com, linux-rockchip@lists.infradead.org, xjq@rock-chips.com, zhenfu.fang@rock-chips.com, chenfen@rock-chips.com, cf@rock-chips.com, hj@rock-chips.com, linux-arm-kernel@lists.infradead.org, zyf@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hi, Addy.

On 11/18/2014 09:32 AM, Addy wrote:
>=20
> On 2014=E5=B9=B411=E6=9C=8814=E6=97=A5 21:18, Jaehoon Chung wrote:
>> Hi, Addy.
>>
>> Did you use the DW_MCI_QUIRK_IDMAC_DTO?
>> I'm not sure, but i wonder if you get what result when you use above=
 quirk.
>=20
> DW_MCI_QUIRK_IDMAC_DTO is only for version2.0 or below.
>         /*
>          * DTO fix - version 2.10a and below, and only if internal DM=
A
>          * is configured.
>          */
>         if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO) {
>                 if (!pending &&
>                     ((mci_readl(host, STATUS) >> 17) & 0x1fff))
>                         pending |=3D SDMMC_INT_DATA_OVER;
>         }
>=20
> It meams that if interrupt comes, but pending =3D 0 && FIFO_COUNT(bit=
17-29) !=3D0,
> then force to set SDMMC_INT_DATA_OVER.
> But in our case, FIFO_COUNT =3D 0 (STATUS register value is 0xad06). =
This is
> because that the card does not send data to host. So there is no inte=
rrupts come,
> and interrupt handle function(dw_mci_interrupt) will not be called. S=
o we need a
> timer to handle this case.
>=20
> So I think  SDMMC_INT_DATA_OVER is not suitable for this case, and we=
 need a new
> quirk.
>=20
>>
>> And i will check more this patch at next week.
>>
>> Thanks for your efforts.
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> On 11/14/2014 10:05 PM, Addy Ke wrote:
>>> From: Addy <addy.ke@rock-chips.com>
>>>
>>> This patch add a new quirk to notify the driver to teminate
>>> current transfer and report a data timeout to the core,
>>> if data over interrupt does NOT come within the given time.
>>>
>>> dw_mmc call mmc_request_done func to finish transfer depends on
>>> data over interrupt. If data over interrupt does not come in
>>> sending data state, the current transfer will be blocked.
>>>
>>> But this case really exists, when driver reads tuning data from
>>> card on rk3288-pink2 board. I measured waveforms by oscilloscope
>>> and found that card clock was always on and data lines were always
>>> holded high level in sending data state. This is the cause that
>>> card does NOT send data to host.
>>>
>>> According to synopsys designware databook, the timeout counter is
>>> started only after the card clock is stopped.
>>>
>>> So if card clock is always on, data read timeout interrupt will NOT=
 come,
>>> and if data lines are always holded high level, all data-related
>>> interrupt such as start-bit error, data crc error, data over interr=
upt,
>>> end-bit error, and so on, will NOT come too.
>>>
>>> So driver can't get the current state, it can do nothing but wait f=
or.
>>>
>>> This patch is based on https://patchwork.kernel.org/patch/5227941/
>>>
>>> Signed-off-by: Addy <addy.ke@rock-chips.com>
>>> ---
>>>   drivers/mmc/host/dw_mmc.c  | 47 +++++++++++++++++++++++++++++++++=
++++++++++++-
>>>   include/linux/mmc/dw_mmc.h |  5 +++++
>>>   2 files changed, 51 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index b4c3044..3960fc3 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1448,6 +1448,17 @@ static int dw_mci_data_complete(struct dw_mc=
i *host, struct mmc_data *data)
>>>       return data->error;
>>>   }
>>>   +static inline void dw_mci_dto_start_monitor(struct dw_mci *host)
>>> +{
>>> +    unsigned int data_tmout_clks;
>>> +    unsigned int data_tmout_ms;
>>> +
>>> +    data_tmout_clks =3D (mci_readl(host, TMOUT) >> 8);
>>> +    data_tmout_ms =3D (data_tmout_clks * 1000 / host->bus_hz) + 25=
0;

What's 250? And how about using the DIV_ROUND_UP?=20

>>> +
>>> +    mod_timer(&host->dto_timer, jiffies + msecs_to_jiffies(data_tm=
out_ms));
>>> +}
>>> +
>>>   static void dw_mci_tasklet_func(unsigned long priv)
>>>   {
>>>       struct dw_mci *host =3D (struct dw_mci *)priv;
>>> @@ -1522,8 +1533,11 @@ static void dw_mci_tasklet_func(unsigned lon=
g priv)
>>>               }
>>>                 if (!test_and_clear_bit(EVENT_XFER_COMPLETE,
>>> -                        &host->pending_events))
>>> +                        &host->pending_events)) {
>>> +                if (host->quirks & DW_MCI_QUIRK_DTO_TIMER)
>>> +                    dw_mci_dto_start_monitor(host);

if timer is starting at only here, dw_mci_dto_start_monitor() doesn't n=
eed.

>>>                   break;
>>> +            }
>>>                 set_bit(EVENT_XFER_COMPLETE, &host->completed_event=
s);
>>>   @@ -2115,6 +2129,9 @@ static irqreturn_t dw_mci_interrupt(int irq=
, void *dev_id)
>>>           }
>>>             if (pending & SDMMC_INT_DATA_OVER) {
>>> +            if (host->quirks & DW_MCI_QUIRK_DTO_TIMER)
>>> +                del_timer(&host->dto_timer);
>>> +
>>>               mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
>>>               if (!host->data_status)
>>>                   host->data_status =3D pending;
>>> @@ -2502,6 +2519,28 @@ ciu_out:
>>>       return ret;
>>>   }
>>>   +static void dw_mci_dto_timer(unsigned long arg)
>>> +{
>>> +    struct dw_mci *host =3D (struct dw_mci *)arg;

I prefer to use the "data" instead of "arg"

>>> +
>>> +    switch (host->state) {
>>> +    case STATE_SENDING_DATA:
>>> +    case STATE_DATA_BUSY:
>>> +        /*
>>> +        * If data over interrupt does NOT come in sending data sta=
te,
>>> +        * we should notify the driver to teminate current transfer
teminate/terminate?

>>> +        * and report a data timeout to the core.
>>> +        */
>>> +        host->data_status =3D SDMMC_INT_DRTO;
>>> +        set_bit(EVENT_DATA_ERROR, &host->pending_events);
>>> +        set_bit(EVENT_DATA_COMPLETE, &host->pending_events);

Dose it need to set EVENT_DATA_COMPLETE?

>>> +        tasklet_schedule(&host->tasklet);
>>> +        break;
>>> +    default:
>>> +        break;
>>> +    }
>>> +}
>>> +
>>>   #ifdef CONFIG_OF
>>>   static struct dw_mci_of_quirks {
>>>       char *quirk;
>>> @@ -2513,6 +2552,9 @@ static struct dw_mci_of_quirks {
>>>       }, {
>>>           .quirk    =3D "disable-wp",
>>>           .id    =3D DW_MCI_QUIRK_NO_WRITE_PROTECT,
>>> +    }, {
>>> +        .quirk    =3D "dto-timer",
>>> +        .id    =3D DW_MCI_QUIRK_DTO_TIMER,
>>>       },

Well, this is s/w timer, so i'm not sure this can be merged into dt-fil=
e.
If this is generic solution, we can add s/w timer by default. how about=
?

Best Regards,
Jaehoon Chung

>>>   };
>>>   @@ -2654,6 +2696,9 @@ int dw_mci_probe(struct dw_mci *host)
>>>         spin_lock_init(&host->lock);
>>>       INIT_LIST_HEAD(&host->queue);
>>> +    if (host->quirks & DW_MCI_QUIRK_DTO_TIMER)
>>> +        setup_timer(&host->dto_timer,
>>> +                dw_mci_dto_timer, (unsigned long)host);
>>>         /*
>>>        * Get the host data width - this assumes that HCON has been =
set with
>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.=
h
>>> index 42b724e..2477813 100644
>>> --- a/include/linux/mmc/dw_mmc.h
>>> +++ b/include/linux/mmc/dw_mmc.h
>>> @@ -98,6 +98,7 @@ struct mmc_data;
>>>    * @irq_flags: The flags to be passed to request_irq.
>>>    * @irq: The irq value to be passed to request_irq.
>>>    * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
>>> + * @dto_timer: Timer for data over interrupt timeout.
>>>    *
>>>    * Locking
>>>    * =3D=3D=3D=3D=3D=3D=3D
>>> @@ -196,6 +197,8 @@ struct dw_mci {
>>>       int            irq;
>>>         int            sdio_id0;
>>> +
>>> +    struct timer_list    dto_timer;
>>>   };
>>>     /* DMA ops for Internal/External DMAC interface */
>>> @@ -220,6 +223,8 @@ struct dw_mci_dma_ops {
>>>   #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION    BIT(3)
>>>   /* No write protect */
>>>   #define DW_MCI_QUIRK_NO_WRITE_PROTECT        BIT(4)
>>> +/* Timer for data over interrupt timeout */
>>> +#define DW_MCI_QUIRK_DTO_TIMER            BIT(5)
>>>     /* Slot level quirks */
>>>   /* This slot has no write protect */
>>>
>>
>>
>>
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

