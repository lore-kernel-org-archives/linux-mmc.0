From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 07/23] mmc: sdhci: check SDHCI_QUIRK2_NO_1_8_V when do
 voltage switch
Date: Sun, 24 Apr 2016 17:56:06 +0800
Message-ID: <CAA+hA=S4yy8=z3EXS9ZO5V6+WQDV7K0d29vUpcFkB5q6f+Eo8g@mail.gmail.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
	<1460741387-23815-8-git-send-email-aisheng.dong@nxp.com>
	<571A1970.7010800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f68.google.com ([209.85.192.68]:36446 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbcDXJ4I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Apr 2016 05:56:08 -0400
Received: by mail-qg0-f68.google.com with SMTP id f74so11507927qge.3
        for <linux-mmc@vger.kernel.org>; Sun, 24 Apr 2016 02:56:07 -0700 (PDT)
In-Reply-To: <571A1970.7010800@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

On Fri, Apr 22, 2016 at 8:30 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
>> Currently when card type supports EXT_CSD_CARD_TYPE_DDR_1_8V
>> which means it can work on DDR mode with either 3.3v IO or 1.8v
>> IO voltage. MMC core will first try 1.8v then 3.3v if host claims
>> MMC_CAP_1_8V_DDR support.
>> However the host driver voltage switch code does not check NO_1_8_V
>> quirk which may set a wrong 1.8v and causes the card fixed to 3.3v
>> VIO un-work.
>>
>> Checking 1.8V quirk before setting it to avoid such issue.
>
> We need to look forward to when SDHCI_QUIRK2_NO_1_8_V doesn't exist.
>

Yes, i did try to clean up SDHCI_QUIRK2_NO_1_8_V.
However, it seems not that simply.
Currently we may still need it before we got a better way.

My point is whether we should stop fixing the exist issue in SDHCI driver
just caused by we want to clean up it later?

> There are two possibilities:
>
> 1. Add MMC_CAP_3_3V_DDR and support to core and use that instead of
> MMC_CAP_1_8V_DDR.  You'll need Ulf's feedback on that.
>

Yes, we can do it.
But the point is for DDR50/SD3.0/SDIO3.0/HS200/HS400 cards we have
the same situation and still need QUIRK2_NO_1_8_V.

And i somehow a bit wonder whether we should retrieve the speed mode
support from device tree since it's actually controller capability.
IO range capability is another thing.

Probably we may start another topic to discuss it specificly.

> 2. Replace ->start_signal_voltage_switch() i.e.
>
> host->mmc_host_ops.start_signal_voltage_switch =
> esdhci_start_signal_voltage_switch;
>
> You will also need to change all calls to
> sdhci_start_signal_voltage_switch() with
> host->mmc->ops->start_signal_voltage_switch(), but that needs to be done anyway.
>

esdhc can fully use the common sdhci_start_signal_voltag_switch.
Since it's already support QUIRK_NO_1_8_V, we don't want to
invent imx voltage swith currently, but fix and use it first.

Regards
Dong Aisheng

>>
>> CC: stable <stable@vger.kernel.org>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 2338aab..96ccb15 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1683,6 +1683,8 @@ static int sdhci_do_signal_voltage_switch(struct sdhci_host *host,
>>
>>               return -EAGAIN;
>>       case MMC_SIGNAL_VOLTAGE_180:
>> +             if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
>> +                     return -EINVAL;
>>               /*
>>                * Enable 1.8V Signal Enable in the Host Control2
>>                * register
>>
>
