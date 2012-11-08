From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 4/5] mmc: omap_hsmmc: cleanup the bitmap definitions of
 Interrupt Register
Date: Thu, 8 Nov 2012 14:27:43 +0530
Message-ID: <CAOyx1Lp1nAqWBdzVztNdFazT9f+T7xC16B7JNd8yYBG6i-G8DQ@mail.gmail.com>
References: <1352220737-14071-1-git-send-email-svenkatr@ti.com>
	<1352220737-14071-5-git-send-email-svenkatr@ti.com>
	<509A6113.50005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54862 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab2KHI5p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Nov 2012 03:57:45 -0500
In-Reply-To: <509A6113.50005@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Nov 7, 2012 at 6:54 PM, Balaji T K <balajitk@ti.com> wrote:
> On Tuesday 06 November 2012 10:22 PM, Venkatraman S wrote:
>>
>> Define the most frequently used bitmasks of the Interrupt Enable /
>> Interrupt Status register with consistent naming ( with _EN suffix).
>>
>> Use meaningful concatenation of bitfields for INT_EN_MASK, which shows
>> which interrupts are enabled by default.
>> No functional changes.
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>
>
> Hi Venkat,
> Not sure if you had chance to look into my comments on Version 2 of this
> patch
>
>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c | 54
>> +++++++++++++++++++++++++------------------
>>   1 file changed, 31 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index e91e85a..d16ef0f 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -80,29 +80,17 @@
>>   #define CLKD_SHIFT            6
>>   #define DTO_MASK              0x000F0000
>>   #define DTO_SHIFT             16
>> -#define INT_EN_MASK            0x307F0033
>> -#define BWR_ENABLE             (1 << 4)
>> -#define BRR_ENABLE             (1 << 5)
>> -#define DTO_ENABLE             (1 << 20)
>>   #define INIT_STREAM           (1 << 1)
>>   #define DP_SELECT             (1 << 21)
>>   #define DDIR                  (1 << 4)
>> -#define DMA_EN                 0x1
>> +#define DMAE                   0x1
>
>
> This change is not needed or may not be part of this patch.
>
Actually its about consistency in naming convention. As part of this
patch, the IE, ISE and STAT family of registers all use the _EN suffix
for the bitfields, so this one had to have something different.

>
>>   #define MSBS                  (1 << 5)
>>   #define BCE                   (1 << 1)
>>   #define FOUR_BIT              (1 << 1)
>>   #define HSPE                  (1 << 2)
>>   #define DDR                   (1 << 19)
>>   #define DW8                   (1 << 5)
>> -#define CC                     0x1
>> -#define TC                     0x02
>>   #define OD                    0x1
>> -#define ERR                    (1 << 15)
>> -#define CMD_TIMEOUT            (1 << 16)
>> -#define DATA_TIMEOUT           (1 << 20)
>> -#define CMD_CRC                        (1 << 17)
>> -#define DATA_CRC               (1 << 21)
>> -#define CARD_ERR               (1 << 28)
>>   #define STAT_CLEAR            0xFFFFFFFF
>>   #define INIT_STREAM_CMD               0x00000000
>>   #define DUAL_VOLT_OCR_BIT     7
>> @@ -111,6 +99,26 @@
>>   #define SOFTRESET             (1 << 1)
>>   #define RESETDONE             (1 << 0)
>>
>> +/* Interrupt masks for IE and ISE register */
>> +#define CC_EN                  (1 << 0)
>> +#define TC_EN                  (1 << 1)
>
>
> You might want to retain CC, TC ... which has been defined and already
> used for in many places for MMCHS_STAT instead of CC_EN. CC_EN is not
> mentioned in TRM however CC is defined as bit field in TRM Register spec.
> So It would be better to reuse the previously defined CC, TC (and other bits
> fields) for MMCHS_IE, MMCHS_ISE inorder to reduce the number of #define's.
>
>
Probably yes - One way would be to use TRM fields as is, but sometimes
it leads to conflicts
like the DMAE/DMA_EN case.

Do you think it would be better to switch to _IE suffix instead of _EN ?

>> +#define BWR_EN                 (1 << 4)
>> +#define BRR_EN                 (1 << 5)
>> +#define ERR_EN                 (1 << 15)
>
>
> ERR_EN is not applicable for Interrupt masks for IE and ISE register
>
Ok. The define would still be needed, but probably I shouldn't include
it in INT_EN_MASK then ?

>
>> +#define CTO_EN                 (1 << 16)
>> +#define CCRC_EN                        (1 << 17)
>> +#define CEB_EN                 (1 << 18)
>> +#define CIE_EN                 (1 << 19)
>> +#define DTO_EN                 (1 << 20)
>> +#define DCRC_EN                        (1 << 21)
>> +#define DEB_EN                 (1 << 22)
>> +#define CERR_EN                        (1 << 28)
>> +#define BADA_EN                        (1 << 29)
>> +
>> +#define INT_EN_MASK            (BADA_EN | CERR_EN | DEB_EN | DCRC_EN |\
>> +               DTO_EN | CIE_EN | CEB_EN | CCRC_EN | CTO_EN | ERR_EN |\
>> +               BRR_EN | BWR_EN | TC_EN | CC_EN)
>> +
>>   #define MMC_AUTOSUSPEND_DELAY 100
>>   #define MMC_TIMEOUT_MS                20
>>   #define OMAP_MMC_MIN_CLOCK    400000
>> @@ -458,13 +466,13 @@ static void omap_hsmmc_enable_irq(struct
>> omap_hsmmc_host *host,
>>         unsigned int irq_mask;
>>
>>         if (host->use_dma)
>> -               irq_mask = INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
>> +               irq_mask = INT_EN_MASK & ~(BRR_EN | BWR_EN);
>>         else
>>                 irq_mask = INT_EN_MASK;
>>
>>         /* Disable timeout for erases */
>>         if (cmd->opcode == MMC_ERASE)
>> -               irq_mask &= ~DTO_ENABLE;
>> +               irq_mask &= ~DTO_EN;
>>
>>         OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>>         OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>> @@ -702,8 +710,8 @@ static void send_init_stream(struct omap_hsmmc_host
>> *host)
>>         OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);
>>
>>         timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
>> -       while ((reg != CC) && time_before(jiffies, timeout))
>> -               reg = OMAP_HSMMC_READ(host->base, STAT) & CC;
>> +       while ((reg != CC_EN) && time_before(jiffies, timeout))
>> +               reg = OMAP_HSMMC_READ(host->base, STAT) & CC_EN;
>
>
> By reusing already defined bit fields documented in TRM,
> this change and other changes below will not be needed thereby keeping
> the patch smaller with less changes and yet removing the magic bit mask
> numbers
>
I don't think the size of the patch is a constraint or a limitation. The overall
intent it to move towards a consistent naming that leads to lesser mistakes
when making patches (using the DMAE bit in the wrong register, for example).

>
>>
>>         OMAP_HSMMC_WRITE(host->base, CON,
>>                 OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
>> @@ -794,7 +802,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host,
>> struct mmc_command *cmd,
>>         }
>>
>>         if (host->use_dma)
>> -               cmdreg |= DMA_EN;
>> +               cmdreg |= DMAE;
>
>
> DMA_EN for DMA enable is much more readable than DMAE.
>
I can't challenge or accept this "readability" claim, but as I said above,
consistency wins. _EN is for IE/ISE register, so this one has to change.
If I apply your 'TRM'  rule, then this should be 'DE' then, which is a lot less
readable.

>
>>         host->req_in_progress = 1;
>>
>> @@ -1014,11 +1022,11 @@ static void omap_hsmmc_do_irq(struct
>> omap_hsmmc_host *host, int status)
>>         data = host->data;
>>         dev_vdbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>>
>> -       if (status & ERR) {
>> +       if (status & ERR_EN) {
>
>
> ERR can be retained.
> This change will not be needed.
>
The individual changes are needed if it's agreed that consistent
naming is better,
and if the _EN suffix makes sense.

>
>>                 omap_hsmmc_dbg_report_irq(host, status);
>> -               if (status & (CMD_TIMEOUT | DATA_TIMEOUT))
>> +               if (status & (CTO_EN | DTO_EN))
>
>
> If you really want to use uniform naming you can rename CMD_TIMEOUT,
> DATA_TIMEOUT to CTO, DTO ....
>
>
>>                         hsmmc_command_incomplete(host, -ETIMEDOUT);
>> -               else if (status & (CMD_CRC | DATA_CRC))
>> +               else if (status & (CCRC_EN | DCRC_EN))
>>                         hsmmc_command_incomplete(host, -EILSEQ);
>>
>>                 if (host->cmd)
>> @@ -1029,9 +1037,9 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host
>> *host, int status)
>>                 }
>>         }
>>
>> -       if (end_cmd || ((status & CC) && host->cmd))
>> +       if (end_cmd || ((status & CC_EN) && host->cmd))
>
>
> CC can be retained.
> This change will not be needed.
>
>
>>                 omap_hsmmc_cmd_done(host, host->cmd);
>> -       if ((end_trans || (status & TC)) && host->mrq)
>> +       if ((end_trans || (status & TC_EN)) && host->mrq)
>
>
> TC can be retained.
> This change will not be needed.
>
>>                 omap_hsmmc_xfer_done(host, data);
>>   }
>>
>>
