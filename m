From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 5/5] mmc: sdhci: Tidy together LED code
Date: Wed, 13 Apr 2016 15:36:25 +0300
Message-ID: <570E3D49.9030204@intel.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
 <1460460309-13619-6-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFoi-3oLK90Bk68wfccF+D6P3gJq_jUZupR66abQ-wPaZg@mail.gmail.com>
 <570E316C.3010305@intel.com>
 <CAPDyKFqjY+qcie7mCJx-mmzO+rXgQPZZtBLY71gz=2Fh9op7OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56651 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbcDMMkt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Apr 2016 08:40:49 -0400
In-Reply-To: <CAPDyKFqjY+qcie7mCJx-mmzO+rXgQPZZtBLY71gz=2Fh9op7OQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 13/04/16 15:15, Ulf Hansson wrote:
> On 13 April 2016 at 13:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 13/04/16 14:42, Ulf Hansson wrote:
>>> On 12 April 2016 at 13:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> ifdef's make the code more complicated and harder to read.
>>>> Move all the LED code together to reduce the ifdef's to
>>>> one place.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c | 96 +++++++++++++++++++++++++++++++-----------------
>>>>  1 file changed, 63 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index be5b5c95138c..13f3dd8992d5 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -38,11 +38,6 @@
>>>>  #define DBG(f, x...) \
>>>>         pr_debug(DRIVER_NAME " [%s()]: " f, __func__,## x)
>>>>
>>>> -#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>>>> -       defined(CONFIG_MMC_SDHCI_MODULE))
>>>> -#define SDHCI_USE_LEDS_CLASS
>>>> -#endif
>>>> -
>>>>  #define MAX_TUNING_LOOP 40
>>>>
>>>>  static unsigned int debug_quirks = 0;
>>>> @@ -246,7 +241,7 @@ static void sdhci_reinit(struct sdhci_host *host)
>>>>         sdhci_enable_card_detection(host);
>>>>  }
>>>>
>>>> -static void sdhci_activate_led(struct sdhci_host *host)
>>>> +static void __sdhci_led_activate(struct sdhci_host *host)
>>>
>>> The renaming here seems a bit unnecessary, but more importantly why
>>> can't you move these functions within the "if def sdhci leds" instead?
>>
>> They get used either way.  Either we use the LEDS subsystem (and mmc core
>> controls them) or we turn them on/off directly from sdhci_request() etc.
> 
> That seems wrong. Moreover it changes the current behaviour.

How does it change the current behaviour?  It was meant to be exactly the
same.  Perhaps looking closely at whether the original code was 'ifdef' or
'ifndef' will help.

> 
> I am not sure why you want to use the leds in case of when the LED
> subsystem isn't available?

I am attempting to preserve the existing behaviour, so that is just how it was.

