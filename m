From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 02/23] mmc: sdhci: move sdhci_get_cd() forward to avoid declaration
Date: Sun, 24 Apr 2016 17:17:36 +0800
Message-ID: <CAA+hA=R_8KfwZutxYp4tBx0bkSrJYsUcR7c1fWjAVFUxqwpByw@mail.gmail.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
	<1460741387-23815-3-git-send-email-aisheng.dong@nxp.com>
	<5719FCAB.1050806@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:34468 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbcDXJRh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Apr 2016 05:17:37 -0400
Received: by mail-qg0-f67.google.com with SMTP id d90so3457901qgd.1
        for <linux-mmc@vger.kernel.org>; Sun, 24 Apr 2016 02:17:37 -0700 (PDT)
In-Reply-To: <5719FCAB.1050806@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

On Fri, Apr 22, 2016 at 6:27 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
>> Move sdhci_get_cd() to avoid needing to declare this function
>> before use.
>
> In fact, we shouldn't be calling host functions directly. i.e. the call
> should be host->mmc->ops->get_cd().
>
> However the caller sdhci_do_reset() is called under spinlock so it should
> not be calling ->get_cd at all.
>
> What that means is that we really need to get rid of
> SDHCI_QUIRK_NO_CARD_NO_RESET, after which this patch wouldn't be needed, so
> let's leave it for now.
>

Yes, i agree we need get rid of SDHCI_QUIRK_NO_CARD_NO_RESET.
However, after that, we still need to remove the sdhci_get_cd
pre-declaration, right?

Regards
Dong Aisheng

>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 55 ++++++++++++++++++++++++------------------------
>>  1 file changed, 27 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index be52a3a..839aa4c 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -53,7 +53,6 @@ static void sdhci_finish_data(struct sdhci_host *);
>>  static void sdhci_finish_command(struct sdhci_host *);
>>  static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>>  static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
>> -static int sdhci_get_cd(struct mmc_host *mmc);
>>
>>  #ifdef CONFIG_PM
>>  static void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
>> @@ -161,6 +160,33 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
>>       sdhci_set_card_detection(host, false);
>>  }
>>
>> +static int sdhci_get_cd(struct mmc_host *mmc)
>> +{
>> +     struct sdhci_host *host = mmc_priv(mmc);
>> +     int gpio_cd = mmc_gpio_get_cd(mmc);
>> +
>> +     if (host->flags & SDHCI_DEVICE_DEAD)
>> +             return 0;
>> +
>> +     /* If nonremovable, assume that the card is always present. */
>> +     if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>> +             return 1;
>> +
>> +     /*
>> +      * Try slot gpio detect, if defined it take precedence
>> +      * over build in controller functionality
>> +      */
>> +     if (!IS_ERR_VALUE(gpio_cd))
>> +             return !!gpio_cd;
>> +
>> +     /* If polling, assume that the card is always present. */
>> +     if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>> +             return 1;
>> +
>> +     /* Host native card detect */
>> +     return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>> +}
>> +
>>  void sdhci_reset(struct sdhci_host *host, u8 mask)
>>  {
>>       unsigned long timeout;
>> @@ -1551,33 +1577,6 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>       spin_unlock_irqrestore(&host->lock, flags);
>>  }
>>
>> -static int sdhci_get_cd(struct mmc_host *mmc)
>> -{
>> -     struct sdhci_host *host = mmc_priv(mmc);
>> -     int gpio_cd = mmc_gpio_get_cd(mmc);
>> -
>> -     if (host->flags & SDHCI_DEVICE_DEAD)
>> -             return 0;
>> -
>> -     /* If nonremovable, assume that the card is always present. */
>> -     if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>> -             return 1;
>> -
>> -     /*
>> -      * Try slot gpio detect, if defined it take precedence
>> -      * over build in controller functionality
>> -      */
>> -     if (!IS_ERR_VALUE(gpio_cd))
>> -             return !!gpio_cd;
>> -
>> -     /* If polling, assume that the card is always present. */
>> -     if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>> -             return 1;
>> -
>> -     /* Host native card detect */
>> -     return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>> -}
>> -
>>  static int sdhci_check_ro(struct sdhci_host *host)
>>  {
>>       unsigned long flags;
>>
>
