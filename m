From: Yasushi SHOJI <yashi@atmark-techno.com>
Subject: Re: [PATCH] mmc: tmio: use SDIO master interrupt bit only when allowed
Date: Thu, 18 May 2017 14:09:39 +0900
Message-ID: <CAKntEQ5OGSLUaBCFf-GY44K65q9seCgroNE_6mx5gPnKm25aYg@mail.gmail.com>
References: <20161209165141.26599-1-wsa+renesas@sang-engineering.com> <TY1PR06MB099248E104D6762E9E860BF3D8E70@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <TY1PR06MB099248E104D6762E9E860BF3D8E70@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, May 17, 2017 at 4:47 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>>
>>  drivers/mmc/host/tmio_mmc_pio.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
>> index 7ef24ec620b542..526e52719f81b9 100644
>> --- a/drivers/mmc/host/tmio_mmc_pio.c
>> +++ b/drivers/mmc/host/tmio_mmc_pio.c
>> @@ -140,12 +140,10 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>
>>               host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
>>                                       ~TMIO_SDIO_STAT_IOIRQ;
>> -             sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
>>               sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
>>       } else if (!enable && host->sdio_irq_enabled) {
>>               host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
>>               sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
>> -             sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
>>
>>               host->sdio_irq_enabled = false;
>>               pm_runtime_mark_last_busy(mmc_dev(mmc));
>> @@ -1203,7 +1201,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>>       if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
>>               _host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
>>               sd_ctrl_write16(_host, CTL_SDIO_IRQ_MASK, _host->sdio_irq_mask);
>> -             sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0000);
>> +             sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0001);
>>       }
>
> I'm afraid but I would like to confirm about this 6 month ago's patch :)
>
> This patch enables CTL_TRANSACTION_CTL to 0x0001 in tmio_mmc_host_probe().
> But, I have a concern we have to disable/enable the register in suspend/resume()
> because registers setting is possible to be cleared after resume.
> What do you think?

That's a good catch.
I suppose we need that.  I didn't check it for suspend/resume at
thattime. My bad.

Thanks,
-- 
            yashi
