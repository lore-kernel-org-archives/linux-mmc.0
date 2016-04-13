From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 5/5] mmc: sdhci: Tidy together LED code
Date: Wed, 13 Apr 2016 14:45:48 +0300
Message-ID: <570E316C.3010305@intel.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
 <1460460309-13619-6-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFoi-3oLK90Bk68wfccF+D6P3gJq_jUZupR66abQ-wPaZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35170 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031016AbcDMLtd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Apr 2016 07:49:33 -0400
In-Reply-To: <CAPDyKFoi-3oLK90Bk68wfccF+D6P3gJq_jUZupR66abQ-wPaZg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 13/04/16 14:42, Ulf Hansson wrote:
> On 12 April 2016 at 13:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> ifdef's make the code more complicated and harder to read.
>> Move all the LED code together to reduce the ifdef's to
>> one place.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 96 +++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 63 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index be5b5c95138c..13f3dd8992d5 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -38,11 +38,6 @@
>>  #define DBG(f, x...) \
>>         pr_debug(DRIVER_NAME " [%s()]: " f, __func__,## x)
>>
>> -#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>> -       defined(CONFIG_MMC_SDHCI_MODULE))
>> -#define SDHCI_USE_LEDS_CLASS
>> -#endif
>> -
>>  #define MAX_TUNING_LOOP 40
>>
>>  static unsigned int debug_quirks = 0;
>> @@ -246,7 +241,7 @@ static void sdhci_reinit(struct sdhci_host *host)
>>         sdhci_enable_card_detection(host);
>>  }
>>
>> -static void sdhci_activate_led(struct sdhci_host *host)
>> +static void __sdhci_led_activate(struct sdhci_host *host)
> 
> The renaming here seems a bit unnecessary, but more importantly why
> can't you move these functions within the "if def sdhci leds" instead?

They get used either way.  Either we use the LEDS subsystem (and mmc core
controls them) or we turn them on/off directly from sdhci_request() etc.

> 
>>  {
>>         u8 ctrl;
>>
>> @@ -255,7 +250,7 @@ static void sdhci_activate_led(struct sdhci_host *host)
>>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>  }
>>
>> -static void sdhci_deactivate_led(struct sdhci_host *host)
>> +static void __sdhci_led_deactivate(struct sdhci_host *host)
>>  {
>>         u8 ctrl;
>>
>> @@ -264,9 +259,11 @@ static void sdhci_deactivate_led(struct sdhci_host *host)
>>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>  }
>>
>> -#ifdef SDHCI_USE_LEDS_CLASS
>> +#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>> +                                  defined(CONFIG_MMC_SDHCI_MODULE))
>> +
>>  static void sdhci_led_control(struct led_classdev *led,
>> -       enum led_brightness brightness)
>> +                             enum led_brightness brightness)
>>  {
>>         struct sdhci_host *host = container_of(led, struct sdhci_host, led);
>>         unsigned long flags;
>> @@ -277,12 +274,62 @@ static void sdhci_led_control(struct led_classdev *led,
>>                 goto out;
>>
>>         if (brightness == LED_OFF)
>> -               sdhci_deactivate_led(host);
>> +               __sdhci_led_deactivate(host);
>>         else
>> -               sdhci_activate_led(host);
>> +               __sdhci_led_activate(host);
>>  out:
>>         spin_unlock_irqrestore(&host->lock, flags);
>>  }
>> +
>> +static int sdhci_led_register(struct sdhci_host *host)
>> +{
>> +       struct mmc_host *mmc = host->mmc;
>> +
>> +       snprintf(host->led_name, sizeof(host->led_name),
>> +                "%s::", mmc_hostname(mmc));
>> +
>> +       host->led.name = host->led_name;
>> +       host->led.brightness = LED_OFF;
>> +       host->led.default_trigger = mmc_hostname(mmc);
>> +       host->led.brightness_set = sdhci_led_control;
>> +
>> +       return led_classdev_register(mmc_dev(mmc), &host->led);
>> +}
>> +
>> +static void sdhci_led_unregister(struct sdhci_host *host)
>> +{
>> +       led_classdev_unregister(&host->led);
>> +}
>> +
>> +static inline void sdhci_led_activate(struct sdhci_host *host)
>> +{
>> +}
>> +
>> +static inline void sdhci_led_deactivate(struct sdhci_host *host)
>> +{
>> +}
> 
> This seems wrong. I assume you actually want to control the registered
> leds within this ifdef and not have the two functions above being
> stubs?

No, because this is the case where mmc core controls the LED and these are
the functions we call directly.

> 
>> +
>> +#else
>> +
>> +static inline int sdhci_led_register(struct sdhci_host *host)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline void sdhci_led_unregister(struct sdhci_host *host)
>> +{
>> +}
>> +
>> +static inline void sdhci_led_activate(struct sdhci_host *host)
>> +{
>> +       __sdhci_led_activate(host);
>> +}
>> +
>> +static inline void sdhci_led_deactivate(struct sdhci_host *host)
>> +{
>> +       __sdhci_led_deactivate(host);
>> +}
> 
> See my comment above. Shouldn't these two functions be stubs?
> 
>> +
>>  #endif
>>
>>  /*****************************************************************************\
>> @@ -1320,9 +1367,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>
>>         WARN_ON(host->mrq != NULL);
>>
>> -#ifndef SDHCI_USE_LEDS_CLASS
>> -       sdhci_activate_led(host);
>> -#endif
>> +       sdhci_led_activate(host);
>>
>>         /*
>>          * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
>> @@ -2183,9 +2228,7 @@ static void sdhci_tasklet_finish(unsigned long param)
>>         host->cmd = NULL;
>>         host->data = NULL;
>>
>> -#ifndef SDHCI_USE_LEDS_CLASS
>> -       sdhci_deactivate_led(host);
>> -#endif
>> +       sdhci_led_deactivate(host);
>>
>>         mmiowb();
>>         spin_unlock_irqrestore(&host->lock, flags);
>> @@ -3305,21 +3348,12 @@ int sdhci_add_host(struct sdhci_host *host)
>>         sdhci_dumpregs(host);
>>  #endif
>>
>> -#ifdef SDHCI_USE_LEDS_CLASS
>> -       snprintf(host->led_name, sizeof(host->led_name),
>> -               "%s::", mmc_hostname(mmc));
>> -       host->led.name = host->led_name;
>> -       host->led.brightness = LED_OFF;
>> -       host->led.default_trigger = mmc_hostname(mmc);
>> -       host->led.brightness_set = sdhci_led_control;
>> -
>> -       ret = led_classdev_register(mmc_dev(mmc), &host->led);
>> +       ret = sdhci_led_register(host);
>>         if (ret) {
>>                 pr_err("%s: Failed to register LED device: %d\n",
>>                        mmc_hostname(mmc), ret);
>>                 goto unirq;
>>         }
>> -#endif
>>
>>         mmiowb();
>>
>> @@ -3338,10 +3372,8 @@ int sdhci_add_host(struct sdhci_host *host)
>>         return 0;
>>
>>  unled:
>> -#ifdef SDHCI_USE_LEDS_CLASS
>> -       led_classdev_unregister(&host->led);
>> +       sdhci_led_unregister(host);
>>  unirq:
>> -#endif
>>         sdhci_do_reset(host, SDHCI_RESET_ALL);
>>         sdhci_writel(host, 0, SDHCI_INT_ENABLE);
>>         sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
>> @@ -3389,9 +3421,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>>
>>         mmc_remove_host(mmc);
>>
>> -#ifdef SDHCI_USE_LEDS_CLASS
>> -       led_classdev_unregister(&host->led);
>> -#endif
>> +       sdhci_led_unregister(host);
>>
>>         if (!dead)
>>                 sdhci_do_reset(host, SDHCI_RESET_ALL);
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 

