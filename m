From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 06/23] mmc: sdhci: using common mmc_regulator_set_vqmmc()
Date: Sun, 24 Apr 2016 17:25:17 +0800
Message-ID: <CAA+hA=T-KoDhQj5YaTif1UtNRDk0H_4wsYAsER+EC_tzSfMNPg@mail.gmail.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
	<1460741387-23815-7-git-send-email-aisheng.dong@nxp.com>
	<571A0F99.20802@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33707 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbcDXJZS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Apr 2016 05:25:18 -0400
Received: by mail-qk0-f194.google.com with SMTP id q184so8703519qkf.0
        for <linux-mmc@vger.kernel.org>; Sun, 24 Apr 2016 02:25:17 -0700 (PDT)
In-Reply-To: <571A0F99.20802@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

On Fri, Apr 22, 2016 at 7:48 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
>> Instead of using private VCCQ regulator signal voltage switch code,
>> we switch to use the more robust common function mmc_regulator_set_vqmmc()
>> in MMC core which set the target voltage as close as possible to target
>> voltage.
>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> ---
>> Don't have a board to test mmc_regulator_set_vqmmc() switch way,
>> need others to help verify.
>
> So was there a reason you wanted to change it?
>

Yes, main reason is we already have common mmc_regulator_set_vqmmc(),
we don't want to maintain two copies of it. And the common one is more robust.

The original one is more error prone since it may set a margine IO voltage
which may more easy to lead an potential IO error.
e.g. if vqmmc is capable of 1.7V, then our host will set to 1.7v
rather than 1.8v
which is a mininum allowed IO voltage range(1.7v ~ 1.95v) defined by spec.

> I agree mmc_regulator_set_vqmmc() looks superior, but we really need
> feedback from people using this code..
>

Yes, although from code inspection, there's no functionality change,
but tests from others using it will be appreciated.

Regards
Dong Aisheng

>> ---
>>  drivers/mmc/host/sdhci.c | 39 ++-------------------------------------
>>  1 file changed, 2 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 7f63f5d..2338aab 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1726,43 +1726,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>       if (ret)
>>               return ret;
>>
>> -     if (IS_ERR(mmc->supply.vqmmc))
>> -             return 0;
>> -
>> -     switch (ios->signal_voltage) {
>> -     case MMC_SIGNAL_VOLTAGE_330:
>> -             ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
>> -                                         3600000);
>> -             if (ret) {
>> -                     pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>> -                             mmc_hostname(mmc));
>> -                     return -EIO;
>> -             }
>> -
>> -             return 0;
>> -     case MMC_SIGNAL_VOLTAGE_180:
>> -             ret = regulator_set_voltage(mmc->supply.vqmmc,
>> -                             1700000, 1950000);
>> -             if (ret) {
>> -                     pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>> -                             mmc_hostname(mmc));
>> -                     return -EIO;
>> -             }
>> -
>> -             return 0;
>> -     case MMC_SIGNAL_VOLTAGE_120:
>> -             ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
>> -                                         1300000);
>> -             if (ret) {
>> -                     pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
>> -                             mmc_hostname(mmc));
>> -                     return -EIO;
>> -             }
>> -             return 0;
>> -     default:
>> -             /* No signal voltage switch required */
>> -             return 0;
>> -     }
>> +     /* do regulator signal voltage switch if exist */
>> +     return mmc_regulator_set_vqmmc(mmc, ios);
>>  }
>>
>>  static int sdhci_card_busy(struct mmc_host *mmc)
>>
>
