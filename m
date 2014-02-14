From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/8] mmc: core: add the property for hs200
Date: Fri, 14 Feb 2014 13:30:27 +0100
Message-ID: <CAPDyKFoxqHsurFicOiE=EQV4JoA3Og0_=m9Fr3kG6is1qUX7Qg@mail.gmail.com>
References: <52EF7A57.1020801@samsung.com>
	<CAPDyKFrPGRbqgCb7p_gkSo8fqaXdKkT+zjwrKQpoqyc+O7KFMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:38818 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbaBNMab (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Feb 2014 07:30:31 -0500
Received: by mail-ve0-f178.google.com with SMTP id oy12so9515419veb.23
        for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2014 04:30:29 -0800 (PST)
In-Reply-To: <CAPDyKFrPGRbqgCb7p_gkSo8fqaXdKkT+zjwrKQpoqyc+O7KFMw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Olof Johansson <olof@lixom.net>

On 14 February 2014 12:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 February 2014 12:15, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> mmc-hs200-1.8v and mmc-hs200-1.2v can be used to the general capability.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Hi Jaehoon,

While I was adding some more DT bindings for mmc, I decided to rebase
and fold in this patch into my patchset.

Hope your fine with it, otherwise just let me know.

Kind regards
Ulf Hansson


>
>> ---
>> Changelog V3:
>>         - Use the "len" instead of "NULL"
>> Changelog V2:
>>         - Rename the mmc-hs200-1_8v/1_2v instead of "_caps2_"
>>         - Add the properties into Documentation/devicetree/bindings/mmc/mmc.txt
>>
>>  Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
>>  drivers/mmc/core/host.c                       |    4 ++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>> index 458b57f..4bb3894 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>> @@ -29,6 +29,8 @@ Optional properties:
>>  - cap-power-off-card: powering off the card is safe
>>  - cap-sdio-irq: enable SDIO IRQ signalling on this interface
>>  - full-pwr-cycle: full power cycle of the card is supported
>> +- mmc-hs200-1_8v: HS200 mode(1.8V I/O) is supported
>> +- mmc-hs200-1_2v: HS200 mode(1.2V I/O) is supported
>>
>>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 49bc403..4b81c93 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -429,6 +429,10 @@ int mmc_of_parse(struct mmc_host *host)
>>                 host->pm_caps |= MMC_PM_KEEP_POWER;
>>         if (of_find_property(np, "enable-sdio-wakeup", &len))
>>                 host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>> +       if (of_find_property(np, "mmc-hs200-1_8v", &len))
>> +               host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
>> +       if (of_find_property(np, "mmc-hs200-1_2v", &len))
>> +               host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>>
>>         return 0;
>>
>> --
>> 1.7.9.5
