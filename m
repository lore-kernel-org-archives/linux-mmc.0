From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from
 fdt in sdhci-pltm.c
Date: Mon, 27 Apr 2015 20:33:25 +0530
Message-ID: <CAOHikRDkQwG+7EUddXmx427ZpEOjqTt22H_zzozABOE3a963tQ@mail.gmail.com>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com>
	<1429630959-32649-3-git-send-email-stripathi@apm.com>
	<8525627.D1S9aInyMV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og125.obsmtp.com ([64.18.0.245]:54043 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964932AbbD0PD2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2015 11:03:28 -0400
Received: by wgso17 with SMTP id o17so119378238wgs.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Apr 2015 08:03:26 -0700 (PDT)
In-Reply-To: <8525627.D1S9aInyMV@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>

On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
> index bef250e..9f6a4b9 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *pdev)
>
>                 if (of_get_property(np, "broken-cd", NULL))
>                         host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
> +               if (of_get_property(np, "delay-after-power", NULL))
> +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> +
> +               if (of_get_property(np, "no-hispd", NULL))
> +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +
> +               if (of_get_property(np, "broken-adma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +
> +               if (of_get_property(np, "broken-dma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +
> +               if (of_get_property(np, "no-cmd23", NULL))
> +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>
>                 if (of_get_property(np, "no-1-8-v", NULL))
>                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>

Any property you add needs to be documented in the DT binding.

If possible, add generic properties for each bug you have mmc.txt
rather than the driver specific sdhci.txt, and implement the
I will add the binding in mmc.txt. I thought this was present but not.

parsing in a common function that is used for all mmc hosts.
As per mine understanding the sdhci_get_of_porperty is a common
parsing function  . Am I wrong ??

An alternative would be to set all these bits based on the compatible
string of your host, if that is the only one that has all these bugs.

The host driver  (arasan) is reused but this quirks are needed due to
board issues. so I have a control over dtb only to fix this.

On Tue, Apr 21, 2015 at 9:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
>> index bef250e..9f6a4b9 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *pdev)
>>
>>                 if (of_get_property(np, "broken-cd", NULL))
>>                         host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> +
>> +               if (of_get_property(np, "delay-after-power", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
>> +
>> +               if (of_get_property(np, "no-hispd", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>> +
>> +               if (of_get_property(np, "broken-adma", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>> +
>> +               if (of_get_property(np, "broken-dma", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>> +
>> +               if (of_get_property(np, "no-cmd23", NULL))
>> +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>>
>>                 if (of_get_property(np, "no-1-8-v", NULL))
>>                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>
>
> Any property you add needs to be documented in the DT binding.
>
> If possible, add generic properties for each bug you have mmc.txt
> rather than the driver specific sdhci.txt, and implement the
> parsing in a common function that is used for all mmc hosts.
>
> An alternative would be to set all these bits based on the compatible
> string of your host, if that is the only one that has all these bugs.
>
>         Arnd



-- 
Thanks,
with regards,
Suman Tripathi
