From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [RFC/PATCH 3/3] mmc: sdhci: add asynchronous interrupt support
Date: Thu, 20 Sep 2012 19:33:47 +0800
Message-ID: <CADz5_gJg185MUyNkDt4BfvpWpC8Da3tHrHZYnVwGafk7X7ZAWg@mail.gmail.com>
References: <1348024372-32073-1-git-send-email-keyuan.liu@gmail.com>
	<1348024372-32073-4-git-send-email-keyuan.liu@gmail.com>
	<CAPDyKFqcX7kv2hc7bbpNFBLQzE2T7BGqysrJjns7vN_MEWzppw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:63264 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab2ITLds (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 07:33:48 -0400
Received: by weyx8 with SMTP id x8so1192237wey.19
        for <linux-mmc@vger.kernel.org>; Thu, 20 Sep 2012 04:33:47 -0700 (PDT)
In-Reply-To: <CAPDyKFqcX7kv2hc7bbpNFBLQzE2T7BGqysrJjns7vN_MEWzppw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi, Ulf

2012/9/19 Ulf Hansson <ulf.hansson@linaro.org>:
> Hi Kevin,
>
> On 19 September 2012 05:12, Kevin Liu <keyuan.liu@gmail.com> wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> If host support asynchronous interrupt and sdio device has enabled it,
>> then enable/disable asynchronous interrupt on host when enable/disable
>> sdio irq.
>>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>  drivers/mmc/host/sdhci.c |   16 ++++++++++++++++
>>  drivers/mmc/host/sdhci.h |    2 ++
>>  2 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 0e15c79..f6136e2 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1575,6 +1575,8 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>>
>>  static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>>  {
>> +       u16 ctrl;
>> +
>>         if (host->flags & SDHCI_DEVICE_DEAD)
>>                 goto out;
>>
>> @@ -1583,6 +1585,16 @@ static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>>         else
>>                 host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
>>
>> +       if ((host->mmc->caps2 & MMC_CAP2_ASYNC_INT) &&
>> +               (host->mmc->card->cccr.async_int)) {
>
> It is a quite special card bit value you are checking for. Can you be
> sure that the cccr struct exist here?
>
The bit async_int is added to struct sdio_cccr by my previous patch 0002.
If EAI is enabled, this bit will be set.

> Maybe it could be a good idea to implement something similar as for
> example mmc_card_highspeed | mmc_card_set_highspeed functions.
> Thus add a new card state, which is set accordingly when this bit is
> set and instead check for this state here. In this case you would not
> have to check the caps2 here, since that is already done by the
> protocol layer.
>
I think you want to replace the check for host->mmc->card->cccr.async_int with
mmc_card_xxx, right? It's a good idea.
It's not reasonable to replace caps2 with such function since they are
for card status
rather than host.
How do you think?

Thanks
Kevin
