From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 3/4] mmc: pwrseq: Initial support for the simple MMC
 power sequence provider
Date: Wed, 11 Feb 2015 13:34:26 +0900
Message-ID: <CAAVeFuLQkNz6x21w8xCM==nwyt0QbYL_uPC9+TdRCj2w+FVu1A@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-4-git-send-email-ulf.hansson@linaro.org>
 <CAAVeFu+ubZZGQd=zPPYm--PVCO9q-A3503Y5g50+sU4ztxU+iA@mail.gmail.com> <CAPDyKFrdpknrMa62Vz4dfKaFMTdF-uXaAz3pkw_3qwNvHy49SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFrdpknrMa62Vz4dfKaFMTdF-uXaAz3pkw_3qwNvHy49SQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Feb 11, 2015 at 1:28 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> [...]
>
>>> +int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>>> +{
>>> +       struct mmc_pwrseq_simple *pwrseq;
>>> +
>>> +       pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
>>> +       if (!pwrseq)
>>> +               return -ENOMEM;
>>> +
>>> +       pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
>>> +       host->pwrseq = &pwrseq->pwrseq;
>>
>> How about making this function return a struct mmc_pwrseq * so this
>> last line can be moved to mmc_pwrseq_alloc() instead of requiring all
>> power sequences to do it?
>>
>> The same applies to
>>
>>     host->pwrseq = NULL;
>>
>> in mmc_pwrseq_simple_free(), which could be done in mmc_pwrseq_free() it seems.
>
> Thanks for reviewing!
>
> I like you suggestion, though $subject patch is already part of the PR for 3.20.
>
> Feel free to send a patch, I would happily apply it.

Damn, why am I always so late to review patches...

I will send a fixup patch - better to have this done early.

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
