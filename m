From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: disable SD clock for clock value 0
Date: Fri, 22 Sep 2017 11:10:42 +0200
Message-ID: <CAPDyKFqCESGkpUAquGMq7qcEpTCpSO6Rr_uyTJc2dvh9CCQrQA@mail.gmail.com>
References: <20170921054238.46666-1-yangbo.lu@nxp.com> <3a6b2d76-3a59-a52e-7ca8-27c39ae1f6e8@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:53172 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbdIVJKo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 05:10:44 -0400
Received: by mail-it0-f52.google.com with SMTP id c195so709652itb.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 02:10:44 -0700 (PDT)
In-Reply-To: <3a6b2d76-3a59-a52e-7ca8-27c39ae1f6e8@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 21 September 2017 at 10:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 21/09/17 08:42, Yangbo Lu wrote:
>> SD clock should be disabled for clock value 0. It's not
>> right to just return. This may cause failure of signal
>> voltage switching.
>>
>> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
>
> Minor comment below, nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
>> ---
>>  drivers/mmc/host/sdhci-of-esdhc.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
>> index d96a057a7db8..b21008729aeb 100644
>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> @@ -36,6 +36,8 @@ struct sdhci_esdhc {
>>       unsigned int peripheral_clock;
>>  };
>>
>> +static void esdhc_clock_enable(struct sdhci_host *host, bool enable);
>
> We usually move functions rather than forward declare them.

I agree, can you please re-spin.

[...]

Kind regards
Uffe
