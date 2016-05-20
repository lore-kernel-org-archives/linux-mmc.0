From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci: fix wakeup configuration
Date: Fri, 20 May 2016 15:39:13 +0200
Message-ID: <CAPDyKFoqG6pYujivi6Rop4orVLViN7Feq+iB7LXkbx6zURZ=Qw@mail.gmail.com>
References: <1463145362-7773-1-git-send-email-ludovic.desroches@atmel.com>
	<573EF90B.7000109@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573EF90B.7000109@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Kevin Liu <kliu5@marvell.com>, Jialing Fu <jlfu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

On 20 May 2016 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 13/05/16 16:16, Ludovic Desroches wrote:
>> Activating wakeup event is not enough to get a wakeup signal. The
>> corresponding events have to be enabled in the Interrupt Status Enable
>> Register too. It follows the specification and is needed at least by
>> sdhci-of-at91.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Is this material for stable and as a fix for 4.6?

Kind regards
Uffe

>
>
>> ---
>>  drivers/mmc/host/sdhci.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> Changes:
>> - v2:
>>   - update commit message and comments
>>   - do not rename val and mask variables
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index e010ea4..e351859 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2605,18 +2605,31 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>>  \*****************************************************************************/
>>
>>  #ifdef CONFIG_PM
>> +/*
>> + * To enable wakeup events, the corresponding events have to be enabled in
>> + * the Interrupt Status Enable register too. See 'Table 1-6: Wakeup Signal
>> + * Table' in the SD Host Controller Standard Specification.
>> + * It is useless to restore SDHCI_INT_ENABLE state in
>> + * sdhci_disable_irq_wakeups() since it will be set by
>> + * sdhci_enable_card_detection() or sdhci_init().
>> + */
>>  void sdhci_enable_irq_wakeups(struct sdhci_host *host)
>>  {
>>       u8 val;
>>       u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
>>                       | SDHCI_WAKE_ON_INT;
>> +     u32 irq_val = SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
>> +                   SDHCI_INT_CARD_INT;
>>
>>       val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
>>       val |= mask ;
>>       /* Avoid fake wake up */
>> -     if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>> +     if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) {
>>               val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
>> +             irq_val &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
>> +     }
>>       sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
>> +     sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
>>  }
>>  EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
>>
>>
>
