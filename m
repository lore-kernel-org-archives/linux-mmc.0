From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/4] mmc: pwrseq: Document DT bindings for the simple
 MMC power sequence
Date: Fri, 16 Jan 2015 09:47:26 +0100
Message-ID: <CAPDyKFpZb+2fmjmRnNMLPUQKSNJkzRAdHVXUtoLSYtg+-UCifg@mail.gmail.com>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
	<1421240530-7971-3-git-send-email-ulf.hansson@linaro.org>
	<20150115165825.GL16217@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150115165825.GL16217@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 15 January 2015 at 17:58, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Ulf,
>
> On Wed, Jan 14, 2015 at 01:02:08PM +0000, Ulf Hansson wrote:
>> The simple MMC power sequence provider, intends to supports a set of
>> common properties between SOC designs. It thus enables us to re-use the
>> same provider for several SOCs.
>>
>> In this initial step, let's add the top level description of the MMC
>> power sequence and describe the compatible string for the simple MMC
>> power sequence provider.
>>
>> Following patches will step by step add support for new properties to
>> the simple MMC power sequence provider.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>
>> Changes in v2:
>>       - None.
>>
>> ---
>>  .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt      | 18 ++++++++++++++++++
>>  Documentation/devicetree/bindings/mmc/mmc.txt          |  5 +++++
>>  2 files changed, 23 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> new file mode 100644
>> index 0000000..e1b7f9c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> @@ -0,0 +1,18 @@
>> +* The simple MMC power sequence provider
>> +
>> +System on chip designs may specify a specific MMC power sequence. To
>> +successfully detect an (e)MMC/SD/SDIO card, that power sequence must be
>> +maintained while initializing the card.
>> +
>> +The simple MMC power sequence provider, intends to supports a set of common
>> +properties between SOC designs. It thus enables us to re-use the same provider
>> +for several SOC designs.
>> +
>> +Required properties:
>> +- compatible : contains "mmc,pwrseq-simple".
>
> Nit: "mmc" is not a vendor prefix.
>
>> +
>> +Example:
>> +
>> +     sdhci0_pwrseq {
>> +             compatible = "mmc,pwrseq-simple";
>> +     }
>
> I'm a little confused here. What specific sequence is described by this
> node? We don't appear to have referred to any resources used as part of
> that sequence, and the description above only mentions that there could
> be a specific sequence, not what that sequence is.
>
> So I don't think this makes sense on its own, and should probably be
> folded with patches adding the initial support for the resources used as
> part of the sequence (e.g. the GPIOs added in a later patch).

You are absolutely right. I fix it.

Again, thanks for reviewing.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
