From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 04/23] mmc: sdhci: re-factor sdhci_start_signal_voltage()
Date: Sun, 24 Apr 2016 17:14:50 +0800
Message-ID: <CAA+hA=SygBBr+-C_r4Geodni+hj2Mg71o+ecVq_AD8vv22=UPA@mail.gmail.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
	<1460741387-23815-5-git-send-email-aisheng.dong@nxp.com>
	<571A0E5E.4090904@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35482 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbcDXJOv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Apr 2016 05:14:51 -0400
Received: by mail-qg0-f66.google.com with SMTP id b14so10650354qge.2
        for <linux-mmc@vger.kernel.org>; Sun, 24 Apr 2016 02:14:50 -0700 (PDT)
In-Reply-To: <571A0E5E.4090904@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

Hi Adrian,

Thanks for the review first.

On Fri, Apr 22, 2016 at 7:43 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
>> Handle host and regulator signal voltage switch separately.
>> Move host signal voltage switch code into a separated function
>> sdhci_do_signal_voltage_switch() first, the following patches will
>> remove the regulator voltage switch code and use the common
>> mmc_regulator_set_vqmmc() instead.
>
> You have changed the order that things are done.

Yes, the oder changes a bit that we always do controller voltage switch first.
I suppose the order is irrelevant here since i don't recall any
requirement from card.

Actually the original order is also a bit mass.
e.g.
For MMC_SIGNAL_VOLTAGE_330, switch controller first, then vqmmc.
But for MMC_SIGNAL_VOLTAGE_180, switch vqmmc first, then controller.
It looks to us the original one also order irrelevant.

> There is no way to know
> what that will break, so let's not do that.  What about just changing
> regulator_set_voltage() to mmc_regulator_set_vqmmc()?
>

Currently what i can think out VIO switch using are three cases: (Pls
help add if any)
1) Both host IO and card IO use external vqmmc to do switch
(e.g eMMC 1.8V DDR/HS200/HS400 mode)

eMMC has no IO voltage switch protocol and requirement, so usually
board designed
using fixed 1.8V for eMMC and host IO.
Event it's switchable, it should be done in the first mmc_power_up().
Dynamical switch later may cause eMMC unable to work properly.
(We have been confirmed about this issue by many eMMC vendors
like Micron and Sandisk. I'm not sure if any exceptions in the community
still doing VIO dynamical switch for eMMC, if yes, please help share
the experience!).

Event some people still do dynamical IO switch for eMMC, since eMMC
spec has no requirement, so the order should also not care.

2) Host using controller IO switch while card using standard CMD (SD/SDIO3.0)

SD/SDIO 3.0 spec defines the standard IO switch process and using it's internal
regulator to do card IO voltage switch. It does not use external vqmmc
regulator.
So order irrelevant too.

3) Host using controller IO switch while card using external vqmmc
(special SDIO3.0 or eMMC)
I have met some special SDIO3.0 card like Broadcom WiFi which does not follow
the spec and using external regulator for card IO voltage.
Usually it's required to fix to 1.8v and also not order irrelevant.

For eMMC, refer to case 1), it should be fixed to 1.8v at power up.

So it looks all cases seems are not order required.

Furthermore, i think sdhci_start_signal_voltage_switch() interface should not
be order dependant, if yes, then the issue should be fixed at a higher level.

The main purpose of this patch and next patch is to make
sdhci_signal_voltage_swithc()
more clear since we already have a more robust mmc_regulator_set_vqmmc()
and for host without vqmmc, we event do not need run that part of code.

BTW changing regulator_set_voltage() to mmc_regulator_set_vqmmc()
is the same situation here.

Anyway, more test from others will be a great help and appreciated.

Regards
Dong Aisheng

>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 97 ++++++++++++++++++++++++++++--------------------
>>  1 file changed, 57 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 839aa4c..7f63f5d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1657,19 +1657,10 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>       spin_unlock_irqrestore(&host->lock, flags);
>>  }
>>
>> -static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>> -                                          struct mmc_ios *ios)
>> +static int sdhci_do_signal_voltage_switch(struct sdhci_host *host,
>> +                                       struct mmc_ios *ios)
>>  {
>> -     struct sdhci_host *host = mmc_priv(mmc);
>>       u16 ctrl;
>> -     int ret;
>> -
>> -     /*
>> -      * Signal Voltage Switching is only applicable for Host Controllers
>> -      * v3.00 and above.
>> -      */
>> -     if (host->version < SDHCI_SPEC_300)
>> -             return 0;
>>
>>       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>
>> @@ -1679,15 +1670,6 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>               ctrl &= ~SDHCI_CTRL_VDD_180;
>>               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>> -             if (!IS_ERR(mmc->supply.vqmmc)) {
>> -                     ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
>> -                                                 3600000);
>> -                     if (ret) {
>> -                             pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>> -                                     mmc_hostname(mmc));
>> -                             return -EIO;
>> -                     }
>> -             }
>>               /* Wait for 5ms */
>>               usleep_range(5000, 5500);
>>
>> @@ -1697,20 +1679,10 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>                       return 0;
>>
>>               pr_warn("%s: 3.3V regulator output did not became stable\n",
>> -                     mmc_hostname(mmc));
>> +                     mmc_hostname(host->mmc));
>>
>>               return -EAGAIN;
>>       case MMC_SIGNAL_VOLTAGE_180:
>> -             if (!IS_ERR(mmc->supply.vqmmc)) {
>> -                     ret = regulator_set_voltage(mmc->supply.vqmmc,
>> -                                     1700000, 1950000);
>> -                     if (ret) {
>> -                             pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>> -                                     mmc_hostname(mmc));
>> -                             return -EIO;
>> -                     }
>> -             }
>> -
>>               /*
>>                * Enable 1.8V Signal Enable in the Host Control2
>>                * register
>> @@ -1728,18 +1700,63 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>                       return 0;
>>
>>               pr_warn("%s: 1.8V regulator output did not became stable\n",
>> -                     mmc_hostname(mmc));
>> +                     mmc_hostname(host->mmc));
>>
>>               return -EAGAIN;
>> +     default:
>> +             /* No signal voltage switch required */
>> +             return 0;
>> +     }
>> +}
>> +
>> +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>> +                                          struct mmc_ios *ios)
>> +{
>> +     struct sdhci_host *host = mmc_priv(mmc);
>> +     int ret;
>> +
>> +     /*
>> +      * Signal Voltage Switching is only applicable for Host Controllers
>> +      * v3.00 and above.
>> +      */
>> +     if (host->version < SDHCI_SPEC_300)
>> +             return 0;
>> +
>> +     ret = sdhci_do_signal_voltage_switch(host, ios);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (IS_ERR(mmc->supply.vqmmc))
>> +             return 0;
>> +
>> +     switch (ios->signal_voltage) {
>> +     case MMC_SIGNAL_VOLTAGE_330:
>> +             ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
>> +                                         3600000);
>> +             if (ret) {
>> +                     pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>> +                             mmc_hostname(mmc));
>> +                     return -EIO;
>> +             }
>> +
>> +             return 0;
>> +     case MMC_SIGNAL_VOLTAGE_180:
>> +             ret = regulator_set_voltage(mmc->supply.vqmmc,
>> +                             1700000, 1950000);
>> +             if (ret) {
>> +                     pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>> +                             mmc_hostname(mmc));
>> +                     return -EIO;
>> +             }
>> +
>> +             return 0;
>>       case MMC_SIGNAL_VOLTAGE_120:
>> -             if (!IS_ERR(mmc->supply.vqmmc)) {
>> -                     ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
>> -                                                 1300000);
>> -                     if (ret) {
>> -                             pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
>> -                                     mmc_hostname(mmc));
>> -                             return -EIO;
>> -                     }
>> +             ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
>> +                                         1300000);
>> +             if (ret) {
>> +                     pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
>> +                             mmc_hostname(mmc));
>> +                     return -EIO;
>>               }
>>               return 0;
>>       default:
>>
>
