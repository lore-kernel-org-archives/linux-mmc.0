From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/1] dw_mmc: insmod followed by rmmod will hung for eMMC
Date: Wed, 27 May 2015 10:50:00 +0900
Message-ID: <556522C8.3000605@samsung.com>
References: <705D14B1C7978B40A723277C067CEDE245182CD0@IN01WEMBXB.internal.synopsys.com>
 <CAPDyKFrqsTN50V-WqbPWnYTs3QoWEHz=iBiGpxXAwLwsrS4SQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAPDyKFrqsTN50V-WqbPWnYTs3QoWEHz=iBiGpxXAwLwsrS4SQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Hi, Pradu.

Sorry for late.
I will wait for your next version than i will check yours.

To Ulf.

Thanks for review!

Best Regards,
Jaehoon Chung

On 05/22/2015 10:21 PM, Ulf Hansson wrote:
> On 18 May 2015 at 16:23, Prabu Thangamuthu <Prabu.T@synopsys.com> wrote:
>> Removing dw_mmc driver immediately after inserting the dw_mmc driver is
> 
> I guess it hangs even if you remove it after a couple of days? :-)
> 
> Perhaps makes this a bit more clear?
> 
>> getting hung for eMMC device. Root cause for this issue is, dw_mci_remove
>> will disable all the interrupts then it will call dw_mci_cleanup_slot.
>> dw_mci_cleanup_slot is issuing CMD6 to disable boot partition access and
>> it's waiting for command complete interrupt. Since INTMASK was already
>> cleared by dw_mci_remove, command complete interrupt is not reaching
>> the system. This leads to process hung.
> 
> /s dw_mci_remove / dw_mci_remove()
> 
>>
>> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
> 
> This patch looks good overall, but please send a new version with
> updated changelog. Moreover, please use "mmc: dw_mmc:" as prefix for
> the commit message header.
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/host/dw_mmc.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 5f5adaf..f0a0aff 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2941,15 +2941,15 @@ void dw_mci_remove(struct dw_mci *host)
>>  {
>>         int i;
>>
>> -       mci_writel(host, RINTSTS, 0xFFFFFFFF);
>> -       mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>> -
>>         for (i = 0; i < host->num_slots; i++) {
>>                 dev_dbg(host->dev, "remove slot %d\n", i);
>>                 if (host->slot[i])
>>                         dw_mci_cleanup_slot(host->slot[i], i);
>>         }
>>
>> +       mci_writel(host, RINTSTS, 0xFFFFFFFF);
>> +       mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>> +
>>         /* disable clock to CIU */
>>         mci_writel(host, CLKENA, 0);
>>         mci_writel(host, CLKSRC, 0);
>> --
>> 1.7.6.5
> 
