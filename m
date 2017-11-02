From: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] sdhci-fujitsu: add support for setting the CMD_DAT_DELAY attribute
Date: Thu, 2 Nov 2017 00:12:52 +0000
Message-ID: <CAKv+Gu8UPpsobJ_d4+OCdufSkLLhGdRFxPO92X3YKvnyBY5b7w@mail.gmail.com>
References: <20171101002132.13500-1-ard.biesheuvel@linaro.org> <20171102000814.ih2ggtfpmfsx3xap@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171102000814.ih2ggtfpmfsx3xap@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 2 November 2017 at 00:08, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Nov 01, 2017 at 12:21:32AM +0000, Ard Biesheuvel wrote:
>> The Socionext SynQuacer SoC inherits this IP from Fujitsu, but
>> requires the F_SDH30_CMD_DAT_DELAY bit to be set in the
>> F_SDH30_ESD_CONTROL control register.
>>
>> So let's add an optional property to this device's binding, and
>> set the attribute if it is present in the DT node.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt |  2 ++
>>  drivers/mmc/host/sdhci_f_sdh30.c                        | 18 +++++++++++++++++-
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> index de2c53cff4f1..9ad02f743ad0 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> @@ -15,6 +15,8 @@ Required properties:
>>  Optional properties:
>>  - vqmmc-supply: phandle to the regulator device tree node, mentioned
>>    as the VCCQ/VDD_IO supply in the eMMC/SD specs.
>> +- cmd-dat-delay-select: boolean property indicating that this host requires
>> +  the CMD_DAT_DELAY control to be enabled.
>
> Needs a vendor prefix unless this is a standard SDHCI bit (in which
> case it should be documented in a common spot).
>

I suspect this is a non-standard thing, so I'll add the fujitsu prefix. Ulf?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
