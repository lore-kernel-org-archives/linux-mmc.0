From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: sdhci: Allow CAPABILITY_1 Register to be overridden
Date: Tue, 5 Jun 2012 20:37:10 -0700
Message-ID: <1F24854E-BA06-4BF2-90C6-4E19CDD4A686@marvell.com>
References: <prakity@marvell.com>
 <1338669006-2611-1-git-send-email-prakity@marvell.com>
 <CACwGpOA=wEVAdzBK9a1DsbO01OLQWRnBY0a-yfh8RJUjiq2jEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:42481 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753648Ab2FFDjZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Jun 2012 23:39:25 -0400
In-Reply-To: <CACwGpOA=wEVAdzBK9a1DsbO01OLQWRnBY0a-yfh8RJUjiq2jEQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Mark F. Brown" <mark.brown314@gmail.com>
Cc: "philipspatches@gmail.com" <philipspatches@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



On Jun 5, 2012, at 7:11 PM, Mark F. Brown wrote:

> Hi Philip,
> 
> Minor nitpicks: You should reuse SDHCI_QUIRK_MISSING_CAPS rather than
> adding SDHCI_QUIRK2_MISSING_CAPS2. The less quirks the better IMHO.

I am not sure that this is a good idea.  It breaks the existing code for people using quirks
for capability register 1.

> 
> Also add an initializer for caps array rather than having an else statement:
> 
> Instead of this:
> +       } else
> +               caps[1] = 0;
> 
> Do this:
> u32 caps[2] = { 0, 0 };

okay

> 
> -- Mark
> 
> On Sat, Jun 2, 2012 at 4:30 PM,  <philipspatches@gmail.com> wrote:
>> From: Philip Rakity <prakity@marvell.com>
>> 
>> CAPABILITY_1 can be changed by the platform code using a quirk
>> CAPALBILTY_2 should also be allowed to be redefined.
>> 
>> This is useful if UHS or other modes are not supported that
>> are defined in the the register but the platform code has
>> specific information that these value should be changed.
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>>  drivers/mmc/host/sdhci.c  |    7 +++++--
>>  include/linux/mmc/sdhci.h |    4 +++-
>>  2 files changed, 8 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index e626732..0fec448 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2614,8 +2614,11 @@ int sdhci_add_host(struct sdhci_host *host)
>>        caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
>>                sdhci_readl(host, SDHCI_CAPABILITIES);
>> 
>> -       caps[1] = (host->version >= SDHCI_SPEC_300) ?
>> -               sdhci_readl(host, SDHCI_CAPABILITIES_1) : 0;
>> +       if (host->version >= SDHCI_SPEC_300) {
>> +               caps[1] = (host->quirks & SDHCI_QUIRK2_MISSING_CAPS1) ?
>> +               host->caps1 : sdhci_readl(host, SDHCI_CAPABILITIES_1);
>> +       } else
>> +               caps[1] = 0;
>> 
>>        if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>                host->flags |= SDHCI_USE_SDMA;
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index e9051e1..560fe22 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -91,6 +91,7 @@ struct sdhci_host {
>>        unsigned int quirks2;   /* More deviations from spec. */
>> 
>>  #define SDHCI_QUIRK2_HOST_OFF_CARD_ON                  (1<<0)
>> +#define SDHCI_QUIRK2_MISSING_CAPS1                     (1<<1)
>> 
>>        int irq;                /* Device IRQ */
>>        void __iomem *ioaddr;   /* Mapped address */
>> @@ -155,7 +156,8 @@ struct sdhci_host {
>> 
>>        struct timer_list timer;        /* Timer for timeouts */
>> 
>> -       unsigned int caps;      /* Alternative capabilities */
>> +       unsigned int caps;      /* replace capability register 1 */
>> +       unsigned int caps1;     /* replace capability register 2 */
>> 
>>        unsigned int            ocr_avail_sdio; /* OCR bit masks */
>>        unsigned int            ocr_avail_sd;
>> --
>> 1.7.0.4
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

