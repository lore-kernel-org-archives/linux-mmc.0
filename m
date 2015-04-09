From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [PATCH v2 2/2] mmc: host: Add some quirks to be read from fdt in sdhci-pltm.c
Date: Thu, 9 Apr 2015 21:41:18 +0530
Message-ID: <CAOHikRCD6MfqMmBzQR3XLUj8WSL1H+jH2KZrBXSQSRpTXuz1_g@mail.gmail.com>
References: <1427726768-17233-1-git-send-email-stripathi@apm.com>
	<1427726768-17233-3-git-send-email-stripathi@apm.com>
	<CAPDyKFoc0V5BdKCO8v92Y1qHzEPgwxRdYR3cCj8nCyU-s25NuQ@mail.gmail.com>
	<CAOHikRArf+Fqv0JbQ1jM19zWGj-fBDcPie6apgkydgBLOm=x0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOHikRArf+Fqv0JbQ1jM19zWGj-fBDcPie6apgkydgBLOm=x0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Langsdorf <mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 30 March 2015 at 16:46, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org> wrote:
> This patch adds some quirks support to be read from fdt.
>
> Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
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

Can't at least some of these be distinguished from what sdhci variant
that is being used? Instead of having them in DT...

We are using arasan controller in our SOC. So reusing a the existing
sdhci-of-arasan driver. Due to H/W issues we require this quirks. So
for us only option left to pass the info is DTS or ACPI table.

Kind regards
Uffe

On Thu, Apr 9, 2015 at 9:40 PM, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org> wrote:
> On 30 March 2015 at 16:46, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org> wrote:
>> This patch adds some quirks support to be read from fdt.
>>
>> Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
>> ---
>>  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c
>> b/drivers/mmc/host/sdhci-pltfm.c
>> index bef250e..9f6a4b9 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device
>> *pdev)
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
>
> Can't at least some of these be distinguished from what sdhci variant
> that is being used? Instead of having them in DT...
>
> We are using arasan controller in our SOC. So reusing a the existing
> sdhci-of-arasan driver. Due to H/W issues we require this quirks. So for us
> only option left to pass the info is DTS or ACPI table.
>
> Kind regards
> Uffe
>
> On Wed, Apr 8, 2015 at 3:10 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>
>> On 30 March 2015 at 16:46, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org> wrote:
>> > This patch adds some quirks support to be read from fdt.
>> >
>> > Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
>> > ---
>> >  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
>> >  1 file changed, 15 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-pltfm.c
>> > b/drivers/mmc/host/sdhci-pltfm.c
>> > index bef250e..9f6a4b9 100644
>> > --- a/drivers/mmc/host/sdhci-pltfm.c
>> > +++ b/drivers/mmc/host/sdhci-pltfm.c
>> > @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device
>> > *pdev)
>> >
>> >                 if (of_get_property(np, "broken-cd", NULL))
>> >                         host->quirks |=
>> > SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> > +
>> > +               if (of_get_property(np, "delay-after-power", NULL))
>> > +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
>> > +
>> > +               if (of_get_property(np, "no-hispd", NULL))
>> > +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>> > +
>> > +               if (of_get_property(np, "broken-adma", NULL))
>> > +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>> > +
>> > +               if (of_get_property(np, "broken-dma", NULL))
>> > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>> > +
>> > +               if (of_get_property(np, "no-cmd23", NULL))
>> > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>>
>> Can't at least some of these be distinguished from what sdhci variant
>> that is being used? Instead of having them in DT...
>>
>> Kind regards
>> Uffe
>>
>> >
>> >                 if (of_get_property(np, "no-1-8-v", NULL))
>> >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>> > --
>> > 1.8.2.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> Thanks,
> with regards,
> Suman Tripathi



-- 
Thanks,
with regards,
Suman Tripathi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
