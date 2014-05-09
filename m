From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: change to use recommended reset procedure
Date: Fri, 09 May 2014 10:15:29 +0900
Message-ID: <536C2C31.8000209@samsung.com>
References: <1395834374-1988-1-git-send-email-yuvaraj.cd@samsung.com>
 <CAKuRcOJYsC9OUOrYrvKg_iC5Z6dZ0mqW3-y=UXHtCr99=gQBXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAKuRcOJYsC9OUOrYrvKg_iC5Z6dZ0mqW3-y=UXHtCr99=gQBXw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar <yuvaraj.cd@gmail.com>, Grant Grundler <grundler@chromium.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.org>
List-Id: linux-mmc@vger.kernel.org

On 05/08/2014 06:40 PM, Yuvaraj Kumar wrote:
> Any comments on this patch?
> 
> On Wed, Mar 26, 2014 at 5:16 PM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>> From: Sonny Rao <sonnyrao@chromium.org>
>>
>> This patch changes the fifo reset code to follow the reset procedure
>> outlined in the documentation of Synopsys  Mobile storage host databook
>> 7.2.13.
>> Without this patch, we could able to see eMMC was not detected after
>> multiple reboots due to driver hangs while eMMC tuning for HS200.
>>
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c |   48 ++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/mmc/host/dw_mmc.h |    1 +
>>  2 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 32dd81d..1d77431 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2220,7 +2220,53 @@ static inline bool dw_mci_fifo_reset(struct dw_mci *host)
>>                 host->sg = NULL;
>>         }
>>
>> -       return dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
>> +       /*
>> +        * The recommended method for resetting is to always reset the
>> +        * controller and the fifo, but differs slightly depending on the mode.
>> +        * Note that this doesn't handle the "generic DMA" (not IDMAC) case.
>> +        */

"not IDMAC" is confused..

>> +       if (dw_mci_ctrl_reset(host, SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET)) {
>> +               unsigned long timeout = jiffies + msecs_to_jiffies(500);
>> +               u32 status, rint;
>> +
>> +               /* if using dma we wait for dma_req to clear */
>> +               if (host->using_dma) {
>> +                       do {
>> +                               status = mci_readl(host, STATUS);
>> +                               if (!(status & SDMMC_STATUS_DMA_REQ))
>> +                                       break;
>> +                               cpu_relax();
>> +                       } while (time_before(jiffies, timeout));
>> +
>> +                       if (status & SDMMC_STATUS_DMA_REQ)
>> +                               dev_err(host->dev,
>> +                                       "%s: Timeout waiting for dma_req to "
>> +                                       "clear during reset", __func__);
>> +
>> +                       /* when using DMA next we reset the fifo again */
>> +                       dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET);
>> +               }
>> +               /*
>> +                * In all cases we clear the RAWINTS register to clear any
>> +                * interrupts.
>> +                */
>> +               rint = mci_readl(host, RINTSTS);
>> +               rint = rint & (~mci_readl(host, MINTSTS));

Just clear the RINTSTS register? why do you add these?

>> +               if (rint)
>> +                       mci_writel(host, RINTSTS, rint);
>> +
>> +       } else
>> +               dev_err(host->dev, "%s: Reset bits didn't clear", __func__);

Just display the error log? I didn't understand this.
If you displayed the error log, then it needs to return the error value.

>> +
>> + #ifdef CONFIG_MMC_DW_IDMAC
>> +       /* It is also recommended that we reset and reprogram idmac */
>> +       dw_mci_idmac_reset(host);
>> + #endif
>> +
>> +       /* After a CTRL reset we need to have CIU set clock registers  */
>> +       mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
>> +
>> +       return true;
>>  }
>>
>>  static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 738fa24..037e47a 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -129,6 +129,7 @@
>>  #define SDMMC_CMD_INDX(n)              ((n) & 0x1F)
>>  /* Status register defines */
>>  #define SDMMC_GET_FCNT(x)              (((x)>>17) & 0x1FFF)
>> +#define SDMMC_STATUS_DMA_REQ           BIT(31)
>>  /* FIFOTH register defines */
>>  #define SDMMC_SET_FIFOTH(m, r, t)      (((m) & 0x7) << 28 | \
>>                                          ((r) & 0xFFF) << 16 | \
>> --
>> 1.7.10.4
>>
> 
